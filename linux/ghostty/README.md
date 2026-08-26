# Ghostty — Linux (Omarchy)

Config do Ghostty para Linux/Omarchy. A base é o default do Omarchy
(`/usr/share/omarchy/config/ghostty/config`), com fontes personalizadas e
itens mesclados da config do macOS (`macos/ghostty`).

## Tema

**Não** usamos `theme = ...` fixo aqui. O Omarchy injeta o tema do sistema via:

```
config-file = ?"~/.local/state/omarchy/current/theme/ghostty.conf"
```

Assim o terminal segue `omarchy theme set` e o modo claro/escuro do sistema.

## O que foi mesclado do pacote macOS

- `scrollback-limit = 1000000` (limite em bytes, ≈ 10 mil linhas)
- `window-padding-balance = true`
- `copy-on-select = false`
- `background-opacity = 0.95`

## O que NÃO veio do macOS (e por quê)

- `theme = Ultra Dark` → o tema é dinâmico, gerenciado pelo Omarchy.
- `background-blur = true` → no ghostty essa opção só é suportada no
  macOS; no Linux o blur é responsabilidade do compositor (Hyprland).
- `macos-titlebar-style`, `macos-option-as-alt` → específicos de macOS.
- `keybind = super+1..9 = goto_tab:N` → no Omarchy o Hyprland consome
  `Super+1..9` para trocar de workspace (ver `bindings/tiling.lua`), então o
  keybind nunca chegaria ao Ghostty. Seria config morta.

## Recarregar / validar

- Recarregar config: `Ctrl+Shift+,` (ghostty também recarrega sozinho ao salvar).
- Validar: `ghostty +validate-config`
