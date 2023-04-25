import { Denops } from "https://deno.land/x/denops_std@v4.0.0/mod.ts";
import { map } from "https://deno.land/x/denops_std@v4.0.0/mapping/mod.ts";
import * as fn from "https://deno.land/x/denops_std@v4.0.0/function/mod.ts";

export async function main(denops: Denops): Promise<void> {
  if (await fn.has(denops, "wsl")) {
    const clipexe = "/mnt/c/Windows/System32/clip.exe";
    await map(denops, "<space>y", `:'<,'>w !${clipexe}<CR>`, { mode: "x" });
  } else {
    await map(denops, "<space>y", '"+y', { mode: ["x"] });
  }

  await map(denops, "<space>p", '"+p', { mode: ["n", "x"] });
  await map(denops, "<space>P", '"+P', { mode: ["n", "x"] });
}
