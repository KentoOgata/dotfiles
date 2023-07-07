import { Disposable } from "https://deno.land/x/disposable@v1.1.1/mod.ts";

export class CSharpierProcess implements Disposable {
  process: Deno.ChildProcess;
  private writer: WritableStreamDefaultWriter<Uint8Array>;
  private encoder: TextEncoder;

  constructor(
    cwd: string,
    onExit: (
      status: Deno.CommandStatus,
      stderr: ReadableStream<Uint8Array>,
    ) => Promise<void>,
  ) {
    this.process = new Deno.Command("dotnet", {
      args: ["csharpier", "--pipe-multiple-files"],
      stdin: "piped",
      stdout: "piped",
      cwd: cwd,
      env: {
        DOTNET_NOLOGO: "1",
      },
    }).spawn();
    this.process.status.then((status) => onExit(status, this.process.stderr));
    this.writer = this.process.stdin.getWriter();
    this.encoder = new TextEncoder();
  }

  private write = (content: string) => {
    return this.writer.write(this.encoder.encode(content));
  };

  formatFile = async (content: string, filePath: string) => {
    await this.write(filePath);
    await this.write("\u0003");
    await this.write(content);
    await this.write("\u0003");
    return Promise.resolve<string>("");
  };

  dispose = async () => {
    this.writer.releaseLock();
    await this.process.stdin.close();
    await this.process.stdout.cancel();
    this.process.kill();
  };
}
