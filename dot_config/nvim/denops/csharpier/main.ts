import { Denops } from "https://deno.land/x/denops_std@v5.0.1/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v5.0.1/function/mod.ts";
import is from "https://deno.land/x/unknownutil@v3.0.0/is.ts";
import * as autocmd from "https://deno.land/x/denops_std@v5.0.1/autocmd/mod.ts";
import { exists } from "https://deno.land/std@0.192.0/fs/exists.ts";
import {
  echo,
  echoerr,
} from "https://deno.land/x/denops_std@v5.0.1/helper/echo.ts";

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
    await reader.cancel();
    reader.releaseLock();
  }
};

const getCsharpierFormatBufContent = async (
  denops: Denops,
  bufname: string,
) => {
  const bufcontent = (await fn.getbufline(denops, bufname, 1, "$")).join("\n");
  return new TextEncoder().encode(bufname + "\u0003" + bufcontent + "\u0003");
};

export async function main(denops: Denops): Promise<void> {
  if (!await exists([await fn.getcwd(denops), ".csharpierrc.yml"].join("/"))) {
    return Promise.resolve();
  }

  const csharpier = new Deno.Command("dotnet", {
    args: ["csharpier", "--pipe-multiple-files"],
    stdin: "piped",
    stdout: "piped",
    cwd: await fn.getcwd(denops),
    env: {
      DOTNET_NOLOGO: "1",
    },
  }).spawn();

  csharpier.status.then(async (status) => {
    if (!status.success) {
      return echoerr(denops, await readToEof(csharpier.stderr));
    }
    return echo(denops, "csharpier is down");
  });

  denops.dispatcher = {
    "format": async (bufnr: unknown) => {
      if (!is.Number(bufnr)) {
        return echoerr(denops, `${denops.name}: Argument type is invalid.`);
      }

      const bufinfo = await fn.getbufinfo(denops, bufnr);
      if (bufinfo.length === 0) {
        return Promise.resolve();
      }

      const path = await fn.fnamemodify(denops, bufinfo[0].name, ":p");

      const stdin = csharpier.stdin.getWriter();
      try {
        await stdin.write(await getCsharpierFormatBufContent(denops, path));
      } finally {
        await stdin.close();
        stdin.releaseLock();
      }
      const contents = (await readToEof(csharpier.stdout)).split("\n");
      await fn.deletebufline(denops, bufnr, 1, "$");
      await fn.setbufline(denops, bufnr, 1, contents);
    },
    "dispose": () => {
      csharpier.kill();
    },
  };

  await autocmd.group(denops, "csharpier", (helper) => {
    helper.define(
      "VimLeavePre",
      "*",
      `call denops#notify("${denops.name}", "dispose", [])`,
    );
    helper.define(
      "BufWritePre",
      "*.cs",
      `call denops#request("${denops.name}", "format", [expand("<abuf>")->str2nr()])`,
    );
  });
}
