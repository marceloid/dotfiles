# Ghostty config

Arquivo com as configurações do Ghostty — aplicativo de terminal para Linux e
macOS. Este pacote é o substituto do `kitty`.

## Onde o arquivo é lido

O Ghostty procura o arquivo em (nesta ordem):

- `$XDG_CONFIG_HOME/ghostty/config.ghostty` (ou `config`, em versões < 1.2.3)
- se `XDG_CONFIG_HOME` não definido → `~/.config/ghostty/config`
- **macOS também lê o path XDG** além de
  `~/Library/Application Support/com.mitchellh.ghostty/`

Por isso um único `common/ghostty/dot-config/ghostty/config` funciona nos dois
OS — não precisamos de nada em `macos/`.

## Formato do arquivo

Diferente do kitty (`chave valor`), o Ghostty usa `chave = valor` (com `=`) e
nomes em `kebab-case` (`font-family`, `cursor-style`, `font-size`). Comentários
começam com `#`.

## Como recarregar

Pressione `Cmd+Shift+,` (macOS) ou `Ctrl+Shift+,` (Linux). Algumas opções
exigem reiniciar o Ghostty completamente (ex.: `background-opacity` no macOS).

## Notas da migração do kitty → Ghostty

Itens que mudaram de comportamento ou não têm equivalente direto:

| kitty                         | Ghostty                                              |
| ----------------------------- | ---------------------------------------------------- |
| `include themes/...conf`      | `theme = Catppuccin Mocha` (tema **built-in**)       |
| `scrollback_lines 10000`      | `scrollback-limit = 1000000` (limite em **bytes**)   |
| `window_padding_width 15`     | `window-padding-x` + `window-padding-y` (separados)  |
| `cursor_blink_interval 0`     | `cursor-style-blink = false`                         |
| `font_features ...`           | removido (referenciava FiraCode, mas a fonte é outra) |
| `tab_bar_style slant`         | sem equivalente — estilo de aba é `native` ou `tabs` |
| `allow_remote_control yes`    | sem equivalente no Ghostty                           |
| `map cmd+N goto_tab N` (0-based) | `keybind = super+N=goto_tab:N` (índice **1-based**) |

## Validação

Para listar temas disponíveis:

```bash
ghostty +list-themes
```

Para ver a config default completa com documentação:

```bash
ghostty +show-config --default --docs
```

## Referências

- Config (sintaxe e localização): https://ghostty.org/docs/config
- Referência de opções: https://ghostty.org/docs/config/reference
- Temas: https://ghostty.org/docs/features/theme
