class Ccp < Formula
  desc "Headless Claude Code automation without the headless mode"
  homepage "https://github.com/mthli/ccp"
  url "https://github.com/mthli/ccp/archive/refs/tags/v0.1.6.tar.gz"
  sha256 "a7acf1b2c43db0abe5c619607cb592972d92fb12f06318c00a20bb44127fe03e"
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
