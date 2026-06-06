class Ccp < Formula
  desc "Headless Claude Code automation without the headless mode"
  homepage "https://github.com/mthli/ccp"
  url "https://github.com/mthli/ccp/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "026076d4c4d35d9aae64194a76275d9611b7532a47de8f1e20e2f108e95b83af"
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
