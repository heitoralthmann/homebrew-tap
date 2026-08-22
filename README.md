# heitoralthmann/homebrew-tap

Tap do [Homebrew](https://brew.sh) com as ferramentas de linha de comando que eu
publico.

```bash
brew tap heitoralthmann/tap
brew install conta-azul-cli
```

## Fórmulas

| Fórmula | O que é |
|---|---|
| [`conta-azul-cli`](Formula/conta-azul-cli.rb) | CLI não oficial para a API Conta Azul, feito para consumo por agentes de IA — [documentação](https://heitoralthmann.github.io/conta-azul-cli/), [repositório](https://github.com/heitoralthmann/conta-azul-cli) |

### `conta-azul-cli`

Instala dois executáveis, o mesmo wrapper nos dois nomes: **`ca`** (o nome que a
documentação do CLI usa) e **`conta-azul-cli`** (alias, para quando `ca` já
estiver ocupado no seu `PATH` — o `brew` avisa quando esse é o caso).

O artefato distribuído é um PHAR, independente de arquitetura: a mesma fórmula
serve arm64 e x86_64, macOS e Linux. O `depends_on "php"` existe porque o CLI
exige PHP 8.4+; o wrapper invoca o PHP do próprio Homebrew, em vez de confiar no
primeiro `php` do `PATH`.

Depois de instalar:

```bash
ca config init      # cria ~/.config/conta-azul-cli/.env
ca --help
```

A configuração mora em `~/.config/conta-azul-cli/`, resolvida por `HOME` — o
Homebrew não muda esse caminho, então um `brew uninstall` não leva junto as suas
credenciais.

## A fórmula é gerada

**Não edite `Formula/conta-azul-cli.rb` à mão para trocar de versão.** As linhas
`url` e `sha256` são reescritas automaticamente pelo job `homebrew` do
[`release.yml`](https://github.com/heitoralthmann/conta-azul-cli/blob/main/.github/workflows/release.yml)
do CLI a cada tag `v*`, a partir do checksum calculado sobre o artefato que
aquela release acabou de publicar. Um commit manual de versão é sobrescrito na
tag seguinte.

Mudanças na *lógica* da fórmula (o wrapper, as dependências, o bloco `test`) são
normais e bem-vindas por PR — o CI roda `brew audit --strict --online`,
`brew install` e `brew test` num runner macOS limpo.

## Licença

[Apache-2.0](LICENSE), a mesma do CLI empacotado aqui.
