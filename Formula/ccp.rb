class Ccp < Formula
  desc "Headless Claude Code automation without the headless mode"
  homepage "https://github.com/mthli/ccp"
  url "https://github.com/mthli/ccp/archive/refs/tags/v0.1.3.tar.gz"
  sha256 "9f9eed4eb8d448b52de46967e8bb401e07ef085a1a863fe8567f2f9e24e31b20"
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
      ccp drives the `claude` CLI, which is installed separately.
      The easiest way is via Homebrew:
        brew install --cask claude-code
      Then make sure you are logged in. See:
        https://code.claude.com/docs
    EOS
  end

  test do
    assert_match "Usage: ccp.sh", shell_output("#{bin}/ccp --help")
  end
end
