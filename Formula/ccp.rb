class Ccp < Formula
  desc "Headless Claude Code automation without the headless mode"
  homepage "https://github.com/mthli/ccp"
  url "https://github.com/mthli/ccp/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "36780b54269910c7cf5a7675914865288531ab60ba70936eaa7ef2d4e7d4e894"
  license "MIT"

  depends_on "jq"
  depends_on "tmux"

  def install
    # Keep ccp.sh and hooks/ together; ccp.sh resolves symlinks to find hooks/
    # beside its real path, so the bin shim below works.
    libexec.install "ccp.sh", "hooks"
    bin.install_symlink libexec/"ccp.sh" => "ccp"
  end

  def caveats
    <<~EOS
      ccp drives the `claude` CLI, which is NOT distributed via Homebrew.
      Install it separately and make sure you are logged in:
        https://docs.claude.com/en/docs/claude-code
    EOS
  end

  test do
    assert_match "Usage: ccp.sh", shell_output("#{bin}/ccp --help")
  end
end
