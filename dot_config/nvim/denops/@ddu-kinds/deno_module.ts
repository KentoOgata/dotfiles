import {
  ActionArguments,
  ActionFlags,
  Actions,
  BaseKind,
} from "https://deno.land/x/ddu_vim@v3.2.7/types.ts";

type ActionParams = Record<string, unknown>;

export type CompletionContext = {
  mod?: string;
  ver?: string;
  path?: string;
};

export class Kind extends BaseKind<Record<string, unknown>> {
  override actions: Actions<ActionParams> = {
    resolve: async (args: ActionArguments<ActionParams>) => {
      return Promise.resolve(ActionFlags.RestoreCursor);
    },
  };

  params(): Record<string, unknown> {
    return {};
  }
}
