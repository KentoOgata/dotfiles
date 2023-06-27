import { ConfigArguments } from "https://deno.land/x/ddu_vim@v3.2.7/base/config.ts";
import { BaseConfig } from "https://deno.land/x/ddu_vim@v3.2.7/types.ts";

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
          splitDirection: "belowright",
          filterSplitDirection: "floating",
          filterFloatingPosition: "top",
          previewFloating: true,
          previewFloatingBorder: "single",
          previewFloatingTitle: "Preview",
          highlights: {
            floating: "Normal",
            floatingBorder: "Normal",
          },
        },
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
