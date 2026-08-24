class MeetingToPrd < Formula
  desc "Turns meetings into ClickUp tickets: Calendar -> Vexa -> Claude -> PRD -> ClickUp"
  homepage "https://github.com/yashp2303/meeting-to-prd"
  # Fetched over git so the formula works against a private repository using
  # your existing GitHub credentials.
  url "https://github.com/yashp2303/meeting-to-prd.git",
      tag:      "v0.2.0",
      revision: "b54352ad831f230c8d735fa63c2b8616d2fe411b"
  license "MIT"
  head "https://github.com/yashp2303/meeting-to-prd.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  # Runs at login and stays running. On first start it has no credentials yet,
  # so it opens a setup page in the browser and begins polling by itself once
  # the form is filled in — no further commands.
  service do
    run [opt_bin/"meeting-to-prd", "watch"]
    keep_alive true
    run_at_load true
    log_path var/"log/meeting-to-prd.log"
    error_log_path var/"log/meeting-to-prd.log"
    working_dir var
  end

  def caveats
    <<~EOS
      Start it once and you are done:

        brew services start meeting-to-prd

      It opens a setup page at http://127.0.0.1:7717 the first time. Fill in the
      form (Vexa API key, ClickUp token, ClickUp list) and it starts working —
      it then runs at every login with no further commands.

      Same page afterwards shows what has been filed.

      You will need:
        - a Vexa API key: https://vexa.ai/signin  (free $5 of bot credit)
        - a ClickUp API token: ClickUp > Settings > Apps > API Token
        - Anthropic credentials: ANTHROPIC_API_KEY, or run 'ant auth login'

      Logs: #{var}/log/meeting-to-prd.log
    EOS
  end

  test do
    assert_match "meeting-to-prd 0.2.0", shell_output("#{bin}/meeting-to-prd version")
    assert_match "Calendar -> Vexa -> Claude -> ClickUp", shell_output("#{bin}/meeting-to-prd --help")

    # The setup server must come up and answer on loopback.
    port = free_port
    pid = spawn "#{bin}/meeting-to-prd", "setup", "--port", port.to_s, "--no-open"
    begin
      sleep 3
      assert_match "\"ok\":true", shell_output("curl -s http://127.0.0.1:#{port}/health")
    ensure
      Process.kill "TERM", pid
      Process.wait pid
    end
  end
end
