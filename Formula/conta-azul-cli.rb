class ContaAzulCli < Formula
  desc "CLI não oficial para a API Conta Azul, feito para agentes de IA"
  homepage "https://heitoralthmann.github.io/conta-azul-cli/"
  # Sem linha `version`: o Homebrew a extrai do `/vX.Y.Z/` da própria URL, e
  # `brew audit --strict` recusa a duplicata. É também por isso que o job
  # `homebrew` do release.yml reescreve só `url` e `sha256`.
  url "https://github.com/heitoralthmann/conta-azul-cli/releases/download/v0.19.0/conta-azul-cli.phar"
  sha256 "b6258e83c8db55b727addd7d553633d203770c0a0ae5d7c4f91eda36e2d58b05"
  license "Apache-2.0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on "php"

  def install
    libexec.install "conta-azul-cli.phar"

    # Wrapper em vez de symlink para o PHAR: o shebang do artefato é
    # `#!/usr/bin/env php`, que pega o primeiro PHP do PATH — que pode ser velho
    # demais (o CLI exige 8.4+) ou não existir. Apontar para o PHP do Homebrew é
    # apontar para o mesmo PHP que a fórmula declarou como dependência.
    (bin/"ca").write <<~SH
      #!/bin/bash
      exec "#{formula_opt_bin("php")}/php" "#{libexec}/conta-azul-cli.phar" "$@"
    SH
    chmod 0755, bin/"ca"

    # `ca` é curto e genérico; o alias dá uma saída para quem já tem outro `ca`
    # no PATH, e deixa o nome do pacote invocável.
    bin.install_symlink "ca" => "conta-azul-cli"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ca --version")
    assert_match version.to_s, shell_output("#{bin}/conta-azul-cli --version")
  end
end
