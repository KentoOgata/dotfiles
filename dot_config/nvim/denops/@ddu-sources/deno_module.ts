import {
  BaseSource,
  GatherArguments,
} from "https://deno.land/x/ddu_vim@v3.2.7/base/source.ts";
import { Item } from "https://deno.land/x/ddu_vim@v3.2.7/types.ts";
import { CompletionItems } from "https://deno.land/x/apiland@1.7.0/types.d.ts";
import { CompletionContext } from "../@ddu-kinds/deno_module.ts";

type Params = {
  maxVersions: number;
};

const API_ENDPOINT_ORIGIN = "https://apiland.deno.dev";

function gatherModules(
  input: string,
): ReadableStream<Item<unknown>[]> {
  return new ReadableStream({
    async start(controller) {
      try {
        const response = await fetch(
          API_ENDPOINT_ORIGIN + "/completions/items/" + input,
        );
        const items = await response.json() as CompletionItems;
        controller.enqueue(
          items.items.map((mod) => ({
            word: mod,
            action: {
              mod: mod,
            } satisfies CompletionContext,
            treePath: [mod],
          })),
        );
      } finally {
        controller.close();
      }
    },
  });
}

function gatherVersions(
  context: CompletionContext,
  maxVersions: number,
): ReadableStream<Item<unknown>[]> {
  return new ReadableStream({
    async start(controller) {
      const { mod } = context;
      if (mod === undefined) {
        return;
      }

      try {
        const response = await fetch(
          `${API_ENDPOINT_ORIGIN}/completions/items/${mod}/`,
        );
        const items = await response.json() as CompletionItems;
        controller.enqueue(
          items.items.slice(0, maxVersions).map((ver) => ({
            word: `${mod}/${ver}`,
            action: {
              ...context,
              ver: ver,
            } satisfies CompletionContext,
            treePath: [mod, ver],
          })),
        );
      } finally {
        controller.close();
      }
    },
  });
}

function gatherPaths(
  context: CompletionContext,
): ReadableStream<Item<unknown>[]> {
  return new ReadableStream({
    async start(controller) {
      const { mod, ver, path } = context;
      if (mod === undefined || ver === undefined) {
        return;
      }

      try {
        const response = await fetch(
          `${API_ENDPOINT_ORIGIN}/completions/items/${mod}/${ver}/${
            path ?? ""
          }`,
        );
        const items = await response.json() as CompletionItems;
        controller.enqueue(
          items.items.map((path) => ({
            word: `${mod}/${ver}/${path}`,
            action: {
              ...context,
              path: path,
            } satisfies CompletionContext,
            treePath: [mod, ver, path],
          })),
        );
      } finally {
        controller.close();
      }
    },
  });
}

/**
 * A source that gathers ddu items from deno.land
 */
export class Source extends BaseSource<Params> {
  kind: "deno_module" = "deno_module";

  gather(args: GatherArguments<Params>): ReadableStream<Item<unknown>[]> {
    // on expand
    if (args.parent !== undefined) {
      const context = args.parent.action as CompletionContext;
      if (context.ver !== undefined) {
        return gatherPaths(context);
      } else if (context.mod !== undefined) {
        return gatherVersions(context, args.sourceParams.maxVersions);
      }
    }

    const input = args.sourceOptions.volatile ? args.input : "";
    return gatherModules(input);
  }

  params(): Params {
    return {
      maxVersions: 5,
    };
  }
}
