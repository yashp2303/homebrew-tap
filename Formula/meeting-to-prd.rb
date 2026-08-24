class MeetingToPrd < Formula
  desc "Turns meetings into ClickUp tickets: Calendar -> Vexa -> Claude -> PRD -> ClickUp"
  homepage "https://github.com/yashp2303/meeting-to-prd"
  # Fetched over git so the formula works against a private repository using
  # your existing GitHub credentials.
  url "https://github.com/yashp2303/meeting-to-prd.git",
      tag:      "v0.1.0",
      revision: "baf167ba8d8e8a7ce67e0f7d3f766f759fd169b6"
  license "MIT"
  head "https://github.com/yashp2303/meeting-to-prd.git", branch: "main"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  def caveats
    <<~EOS
      Set up credentials before first use:
        meeting-to-prd init
        meeting-to-prd doctor

      You will need a Vexa API key (https://vexa.ai/signin), a ClickUp API
      token, and Anthropic credentials (ANTHROPIC_API_KEY or 'ant auth login').
    EOS
  end

  test do
    assert_match "meeting-to-prd 0.1.0", shell_output("#{bin}/meeting-to-prd version")
    assert_match "Calendar -> Vexa -> Claude -> ClickUp", shell_output("#{bin}/meeting-to-prd --help")
  end
end
