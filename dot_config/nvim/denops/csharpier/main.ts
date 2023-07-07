import { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import is from "https://deno.land/x/unknownutil@v3.0.0/is.ts";
import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import { exists } from "https://deno.land/std@0.192.0/fs/exists.ts";
import { echoerr } from "https://deno.land/x/denops_std@v5.0.1/helper/echo.ts";
import { CSharpierProcess } from "./CShapierProcess.ts";

const readToEof = async (stream: ReadableStream<Uint8Array>) => {
  const reader = stream.getReader();
  try {
    const decoder = new TextDecoder();
    let content = "";
    while (true) {
      const { value, done } = await reader.read();
      const char = decoder.decode(value);
      if (done || char === "\u0003") {
        break;
      }
      content += char;
    }
    return content;
  } finally {
    reader.releaseLock();
  }
};

type Context = {
  process: CSharpierProcess;
};

export async function main(denops: Denops): Promise<void> {
  if (!await exists([await fn.getcwd(denops), ".csharpierrc.yml"].join("/"))) {
    return Promise.resolve();
  }

  denops.context[denops.name] = {
    process: new CSharpierProcess(
      await fn.getcwd(denops),
      async (status, stderr) => {
        if (!status.success) {
          return echoerr(denops, await readToEof(stderr));
        } else {
          return denops.cmd('echomsg "csharpier is down"');
        }
      },
    ),
  } satisfies Context;

  denops.dispatcher = {
    "format": async (bufnr: unknown) => {
      if (!is.Number(bufnr)) {
        return echoerr(denops, `${denops.name}: Argument type is invalid.`);
      }

      const bufinfo = await fn.getbufinfo(denops, bufnr);
      if (bufinfo.length === 0) {
        return echoerr(denops, `${denops.name}: BufNr ${bufnr} is invalid.`);
      }

      const context = denops.context[denops.name] as {
        process: CSharpierProcess;
      };

      const contents = await context.process.formatFile(
        (await fn.getbufline(denops, bufinfo[0].bufnr, 1, "$")).join("\n"),
        bufinfo[0].name,
      );
      await fn.deletebufline(denops, bufnr, 1, "$");
      await fn.setbufline(denops, bufnr, 1, contents);
    },
    "dispose": async () => {
      const context = denops.context[denops.name] as {
        process: CSharpierProcess;
      };
      await context.process.dispose();
    },
  };

  await autocmd.group(denops, "csharpier", (helper) => {
    helper.define(
      "VimLeavePre",
      "*",
      `call denops#notify("${denops.name}", "dispose", [])`,
    );
    /* helper.define(                                                                     */
    /*   "BufWritePre",                                                                   */
    /*   "*.cs",                                                                          */
    /*   `call denops#request("${denops.name}", "format", [expand("<abuf>")->str2nr()])`, */
    /* );                                                                                 */
  });
  denops.cmd(
    `command CshapierFmt call denops#request("${denops.name}", "format", [expand("<abuf>")->str2nr()])`,
  );
}
