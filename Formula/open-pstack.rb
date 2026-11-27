class OpenPstack < Formula
  desc "Install pstack agent skills into Claude Code, Codex, Pi, and other harnesses"
  homepage "https://github.com/michael-denyer/pstack-claude"
  url "https://github.com/michael-denyer/pstack-claude/archive/6d25df69f0baf6600807d82975d75139f3b1ab92.tar.gz"
  version "0.9.159"
  sha256 "76d0bba39a266ce213f996e8c39ef7d1f4a1aee9dc57f609319cd7553117a2d6"
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
