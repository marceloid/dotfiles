# AGENTS.md

Instruções para agentes de IA (como o Pi) que trabalham neste repositório.

## O que é este repositório

Dotfiles pessoais do usuário (`marceloid`), versionados e gerenciados com
[GNU Stow](https://www.gnu.org/software/stow/). Suporta Linux e macOS, com
configurações **comuns** (`common/`) separadas das **específicas por OS**
(`linux/` e `macos/`).

Veja `README.md` para a visão de usuário final; este arquivo foca em **como
editar o repo com segurança**.

---

## ⚠️ Regra de ouro: editar a fonte, nunca o symlink

Stow cria symlinks de `$HOME` apontando para os arquivos deste repo. Por exemplo:

```
~/.tmux.conf               -> ~/dotfiles/common/tmux/dot-tmux.conf
~/.config/kitty/kitty.conf -> ~/dotfiles/common/kitty/dot-config/kitty/kitty.conf
```

- **Sempre edite o arquivo-fonte aqui dentro do repo** (o caminho com prefixo
  `dot-`), nunca o destino em `$HOME`.
- Como os alvos em `~/` são apenas symlinks, a edição da fonte é refletida
  instantaneamente — **não é preciso re-rodar o `stow`** depois de editar
  conteúdo de um arquivo já stowado.

---

## A convenção `dot-` do Stow

O `.stowrc` define `--dotfiles`: todo nome prefixado com `dot-` vira um `.` no
alvo. Exemplos:

| No repo                                        | Alvo em `$HOME`                  |
| ---------------------------------------------- | -------------------------------- |
| `common/tmux/dot-tmux.conf`                    | `~/.tmux.conf`                   |
| `common/kitty/dot-config/kitty/kitty.conf`     | `~/.config/kitty/kitty.conf`     |
| `macos/zsh/dot-zshrc`                          | `~/.zshrc`                       |
| `linux/git/dot-gitconfig`                      | `~/.gitconfig`                   |

- Cada subpasta de `common/`, `linux/` e `macos/` é um **pacote** stow
  independente (stow roda pasta-a-pasta).
- **Ao criar um novo arquivo**, respeite esse prefixo: `dot-foo` → `~/.foo`,
  `dot-config/foo` → `~/.config/foo`.

---

## Estrutura

```
dotfiles/
├── install.sh          # Bootstrap: detecta OS, stowa tudo, ajusta espanso/libsecret
├── .stowrc             # Opções default do stow (--dotfiles, -t ~)
├── .stow-local-ignore  # O que o stow ignora
├── common/             # Configs compartilhadas (Linux + macOS)
│   ├── espanso/        # dot-config/espanso
│   ├── kitty/          # dot-config/kitty
│   ├── nvim/           # dot-config/nvim (LazyVim)
│   └── tmux/           # dot-tmux.conf + dot-config/tmux
├── linux/              # Específico Linux
│   ├── hypr/           # dot-config/hypr (Hyprland — ver skill `omarchy`)
│   ├── waybar/         # dot-config/waybar
│   ├── copyq/          # dot-config/copyq
│   ├── app_launchers/  # dot-local/share/applications
│   └── git/            # dot-gitconfig
└── macos/              # Específico macOS
    ├── git/            # dot-gitconfig
    └── zsh/            # dot-zshrc
```

> **Atenção:** o `linux/hypr/` contém config do Hyprland/Omarchy. Edições
> voltadas ao usuário final nesse diretório exigem carregar a skill `omarchy`
> antes.

---

## Como aplicar / testar mudanças

### Arquivos já stowados
Só editar a fonte. Para configs que são lidas em runtime, recarregue a
ferramenta específica:

| App      | Como recarregar                                  |
| -------- | ------------------------------------------------ |
| tmux     | `tmux source-file ~/.tmux.conf` (ou prefix + `r`) |
| nvim     | `:source %` ou reiniciar o Neovim                 |
| espanso  | `espanso restart`                                 |
| kitty    | `Ctrl+Shift+F5` (ou reiniciar o kitty)            |
| hyprland | `hyprctl reload`                                  |
| waybar   | `killall waybar && waybar &`                      |

### (Re)stowar / criar novos links
- Aplicar tudo (comum + OS): `./install.sh`
- Remover todos os symlinks: `./install.sh --unstow`
- Stowar um pacote isolado:
  ```bash
  stow --dotfiles -v -t ~ -d common/tmux tmux
  ```
- **Preview** sem alterar nada: `stow -n --dotfiles common/<pkg>`

O `install.sh` é idempotente.

---

## Convenções de código e estilo

- **Idioma dos comentários:** os comentários deste repo são em **português**.
  Mantenha esse padrão ao editar.
- **Mensagens de commit:** em português, descritivas, no formato
  `<área>: <ação>`. Ex.: `tmux: usar extended-keys-format csi-u`.
- Cada pacote stow pode ter seu próprio `.gitignore` (ex.: `tmux/.gitignore`
  ignora `dot-tmux/plugins/`, que são baixados pelo TPM).
- Mantenha o `README.md` sincronizado caso adicione/remova um app configurado.

---

## Armadilhas / pegadinhas

1. **macOS vs Linux no espanso:** o `install.sh` cria um symlink
   `~/Library/Application Support/espanso -> ~/.config/espanso` no macOS para
   usar a mesma fonte. Não duplique essa config.
2. **Plugins do tmux (TPM):** vivem em `common/tmux/dot-tmux/plugins/` e estão
   no `.gitignore` do pacote — **não versioná-los**. O `dot-tmux.conf` clona o
   TPM automaticamente se faltar.
3. **git-credential-libsecret (Arch):** o `install.sh` compila o helper no Arch
   via `make`. Não comita binários.
4. **Editar alvo em `~/` em vez da fonte:** faz o symlink virar arquivo comum e
   quebra o gerenciamento pelo stow. Sempre confirme o caminho antes de editar.
5. **`.stow-local-ignore`** exclui `scripts`, `install.sh`, `README.md`, etc. do
   stow — esses arquivos não devem virar links em `$HOME`.

---

## Tarefas comuns

- **Adicionar um novo app compartilhado:** crie `common/<app>/dot-config/<app>/`
  e rode `./install.sh`. Atualize o `README.md`.
- **Adicionar config só de Linux/macOS:** crie `linux/<app>/` ou `macos/<app>/`.
- **Trocar/atualizar um plugin do tmux:** edite a lista de `@plugin` no
  `common/tmux/dot-tmux.conf`; o TPM cuida do resto.
