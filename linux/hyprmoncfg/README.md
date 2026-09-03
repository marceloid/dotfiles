# hyprmoncfg — Linux (Omarchy)

Perfis de monitores do [hyprmoncfg](https://github.com/crmne/hyprmoncfg) —
gerenciador visual de multi-monitores para Hyprland, com daemon
(`hyprmoncfgd`) que troca o perfil ativo automaticamente em hotplug e eventos
de tampa.

## O que vive aqui

`dot-config/hyprmoncfg/profiles/` — os perfis salvos (fonte da verdade do
layout de monitores e workspaces persistentes). Cada perfil tem três formatos
gerados pelo app (`.conf` hyprlang, `.lua`, `.json` interno); os três são
versionados juntos.

## Notas

- O app vem do AUR (`hyprmoncfg-bin`); o painel na barra do Omarchy é o plugin
  `crmne.hyprmoncfg`.
- Perfis são amarrados por **descrição/EDID** do monitor, então sobrevivem à
  troca de conectores (ex.: DP-1 ↔ HDMI-A-1) entre boots.
- Editar perfis pelo TUI (`hyprmoncfg`) ou pelo painel da barra escreve através
  do symlink do stow e já atualiza este repo — commite depois.
- O antigo `hyprmon` (erans) foi removido: o hyprmoncfg é o único gerenciador
  de monitores desta máquina.
- As configs do Hyprland (`~/.config/hypr/*.lua`) continuam fora deste repo,
  gerenciadas pelo Omarchy (ver README raiz, seção "Omarchy 4").
