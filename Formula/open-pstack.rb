class OpenPstack < Formula
  desc "Install pstack agent skills into Claude Code, Codex, Pi, and other harnesses"
  homepage "https://github.com/michael-denyer/pstack-claude"
  url "https://github.com/michael-denyer/pstack-claude/archive/2a06e4b0381860b5f2c6b52cfd6555545bc1d4b6.tar.gz"
  version "0.9.158"
  sha256 "404fbcb53219d350ad5296a7d91ed8f63fd0dfacf04279fd785826fea8ee7e05"
  license "MIT"

  depends_on "node"

  def install
    libexec.install "installer"
    (libexec/"plugins").install "plugins/pstack"
    (bin/"open-pstack").write_env_script libexec/"installer/bin/open-pstack.mjs",
                                         PATH: "#{Formula["node"].opt_bin}:$PATH"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/open-pstack --version")
    output = shell_output("#{bin}/open-pstack --dry-run --only skills")
    assert_match ".agents/skills", output
  end
end
