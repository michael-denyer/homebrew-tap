class OpenPstack < Formula
  desc "Install pstack agent skills into Claude Code, Codex, Pi, and other harnesses"
  homepage "https://github.com/michael-denyer/pstack-claude"
  url "https://github.com/michael-denyer/pstack-claude/archive/refs/tags/v0.9.153.tar.gz"
  sha256 "99016928d24fb14fba313381696c93825792f05dfec7744d88f5ebae990ebfd5"
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
