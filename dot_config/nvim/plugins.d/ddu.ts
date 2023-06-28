import { ConfigArguments } from "https://deno.land/x/ddu_vim@v3.2.7/base/config.ts";
import {
  ActionFlags,
  BaseConfig,
} from "https://deno.land/x/ddu_vim@v3.2.7/types.ts";
import { Params as FfParams } from "https://raw.githubusercontent.com/Shougo/ddu-ui-ff/64167c0fd5fdcacf61bae8652a26f713e53d29a7/denops/%40ddu-uis/ff.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import { Denops } from "https://deno.land/x/denops_core@v5.0.0/mod.ts";
import { ActionData as FileKindActionData } from "https://deno.land/x/ddu_kind_file@v0.5.0/file.ts";

const findRoot = async (denops: Denops, path: string) => {
  const startDir = await fn.isdirectory(denops, path) === 1
    ? path
    : await fn.fnamemodify(denops, path, ":h");

  for (
    let dir = startDir;
    dir !== "/";
    dir = await fn.fnamemodify(denops, dir, ":h")
  ) {
    const files = await fn.readdir(
      denops,
      dir,
      "{ fname -> fname ==# '.git' }",
    );
    if (files.length > 0) {
      return dir;
    }
  }
};

const lcd = async (denops: Denops, dir: string) => {
  await fn.execute(denops, ["lcd", dir]);
  return Promise.resolve();
};

export class Config extends BaseConfig {
  override config(args: ConfigArguments): Promise<void> {
    args.contextBuilder.patchGlobal({
      ui: "ff",
      uiParams: {
        ff: {
          startFilter: true,
          prompt: "> ",
          split: "floating",
          floatingBorder: "single",
          filterSplitDirection: "floating",
          filterFloatingPosition: "top",
          previewFloating: true,
          previewFloatingBorder: "single",
          previewFloatingTitle: "Preview",
          highlights: {
            floating: "Normal",
            floatingBorder: "Normal",
          },
        } satisfies Partial<FfParams>,
      },
      sourceOptions: {
        _: {
          matchers: ["matcher_fzf"],
          sorters: ["sorter_fzf"],
          converters: ["converter_devicon"],
        },
        help: {
          converters: [],
        },
        rg: {
          matchers: [],
          sorters: [],
          converters: ["converter_hl_dir"],
          volatile: true,
        },
        line: {
          matchers: ["matcher_substring"],
          sorters: [],
          converters: [],
        },
        dein: {
          defaultAction: "openProject",
        },
        ghq: {
          defaultAction: "openProject",
        },
        file_external: {
          converters: ["converter_hl_dir"],
        },
      },
      kindOptions: {
        file: {
          defaultAction: "open",
        },
        help: {
          defaultAction: "open",
        },
        lsp: {
          defaultAction: "open",
        },
        lsp_codeAction: {
          defaultAction: "apply",
        },
        ui_select: {
          defaultAction: "select",
        },
        action: {
          defaultAction: "do",
        },
      },
      filterParams: {
        matcher_fzf: {
          highlightMatched: "Search",
        },
        matcher_substring: {
          highlightMatched: "Search",
        },
        converter_hl_dir: {
          hlGroup: "String",
        },
      },
      sourceParams: {
        file_external: {
          cmd: ["fd", "-t", "file"],
        },
        buffer: {
          orderby: "asc",
        },
        lsp_references: {
          includeDeclaration: false,
        },
      },
    });

    return Promise.resolve();
  }
}
