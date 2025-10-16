# Kitty config

Arquivo com as configurações do kitty - aplicativo de terminal para Linux e MacOS.

## Configurações customatizadas

### Barra de título do aplicativo no MacOS

No macOS, ela tem uma opção especial que mantém os botões de "semáforo" (fechar, minimizar, maximizar), que é geralmente o que os usuários de Mac preferem.

```conf
# Esconde apenas a barra de título, mantendo os botões
hide_window_decorations titlebar-only
```

O titlebar-only é a mais recomendada para macOS. Ele esconde a barra de título, mantendo a funcionalidade dos botões de fechar, minimizar e maximizar.

#### Outras opções (para referência)

* `hide_window_decorations no`: O padrão, mostra a barra de título e os botões.
* `hide_window_decorations yes`: Esconde **tudo**, incluindo a barra de título e os botões de fechar/minimizar/maximizar. **Cuidado:** com esta opção, você precisará fechar a janela do kitty usando `⌘ + Q` ou pelo Dock.

A opção `titlebar-only` é a mais recomendada para macOS.

### Dica: Facilitar o arraste da janela

Quando você remove a barra de título, pode ficar mais difícil arrastar a janela com o mouse. Para resolver isso, você pode dizer ao kitty para tratar a área de "padding" (espaçamento interno) no topo como se fosse a barra de título para poder arrastá-la.

Adicione também esta linha ao seu `kitty.conf`:

```conf
macos_titlebar_color background
```

E certifique-se de ter um espaçamento no topo. Se você ainda não tiver um, adicione o padding como mostrado abaixo:

```conf
# Remove a barra de título, mas mantém os botões do macOS
hide_window_decorations titlebar-only

# Permite arrastar a janela pela área superior (padding)
macos_titlebar_color background

# Adiciona um pouco de espaçamento interno para estética e para ter onde clicar
window_padding_width 15
```

Agora, ao reiniciar o kitty, ele estará sem a barra de título, mas você ainda poderá arrastar a janela clicando em qualquer lugar na margem superior.

### Estética e Aparência (Look and Feel)

Aparência é fundamental para o conforto no uso diário.

#### a) Fontes com Ligaduras e Ícones (Nerd Fonts)

Isso transforma a aparência do seu terminal, especialmente se você usa ferramentas como `lsd`, `nvim` com plugins, ou prompts customizados (como Starship).

1. **Instale uma "Nerd Font":** Fontes como **Fira Code**, **JetBrains Mono**, ou **Hack** possuem versões "Nerd Font" que incluem ícones e ligaduras (quando `->` vira `→`). Você pode baixá-las no site [Nerd Fonts](https://www.nerdfonts.com/font-downloads) e instalá-las no seu macOS.
2. **Configure no `kitty.conf`:**

    ```conf
    # Substitua pelo nome exato da fonte que você instalou
    font_family      JetBrainsMono Nerd Font
    bold_font        auto
    italic_font      auto
    bold_italic_font auto

    # Habilita ligaduras da fonte (opcional, mas muito legal)
    font_features FiraCode-Retina +ss01 +ss02 +ss03 +ss04 +ss05 +ss06 +zero +onum
    # (As features acima são um exemplo para Fira Code, ajuste para a sua fonte)
    ```

#### b) Esquemas de Cores (Themes)

O kitty vem com vários temas embutidos e é fácil adicionar outros.

1. **Listar temas existentes:** Abra o kitty e rode o comando:

    ```bash
    kitty +list-themes
    ```

2. **Aplicar um tema:** Adicione uma linha `include` no seu `kitty.conf`. Por exemplo, para usar o popular tema "Dracula":

    ```conf
    # Inclui um tema. Kitty irá procurar por Catppuccin-Mocha.conf na sua pasta de config
    include ./themes/Catppuccin-Mocha.conf
    ```

    Você pode visualizar e baixar centenas de temas do repositório [kitty-themes](https://github.com/dexpota/kitty-themes). Basta baixar o arquivo `.conf` do tema que você quer e colocá-lo na pasta `~/.config/kitty/themes/`.

#### c) Transparência e Fundo

```conf
# Nível de transparência (de 0.0 a 1.0)
# Um pouco de transparência pode ser elegante. Use com moderação para não afetar a legibilidade.
background_opacity 0.9

# Você também pode usar uma imagem de fundo
# background_image /path/to/your/image.png
# background_image_layout scaled
```

#### d) Cursor

```conf
# Formato do cursor (block, beam, underline)
cursor_shape block

# Para o cursor parar de piscar
cursor_blink_interval 0
```

### Funcionalidade e Fluxo de Trabalho

Essas configurações aceleram suas tarefas diárias.

#### a) Integração com o Shell (Shell Integration)

**Essa é uma das melhores funcionalidades do kitty!** Ela permite que o kitty "entenda" onde começa e termina o output de um comando.

* **Navegação Rápida:** Pule entre os prompts de comando com `⌘ + shift + G` (anterior) e `⌘ + shift + H` (próximo).
* **Comando Anterior no Pager:** Pressione `⌘ + shift + P` para abrir o output do comando anterior em um `less` (ótimo para saídas longas).

Para ativar, adicione ao `kitty.conf`:

```conf
shell_integration enabled
```

E reinicie seu shell (ou o kitty).

#### b) Gerenciamento de Janelas e Abas (Splits e Tabs)

O kitty é excelente para gerenciar múltiplas sessões. Aprender alguns atalhos muda o jogo.

**Atalhos Padrão (macOS):**

* `⌘ + T`: Nova aba
* `⌘ + D`: Dividir a janela verticalmente
* `⌘ + shift + D`: Dividir a janela horizontalmente
* `⌘ + [` ou `]`: Navegar entre abas
* `⌘ + option + setas`: Navegar entre painéis (splits)

Você pode customizar tudo isso com a diretiva `map`. Exemplo:

```conf
# Mapeia cmd+enter para criar uma nova janela do OS (em vez de um split)
map cmd+enter new_os_window_with_cwd
```

#### c) Scrollback

Aumente o número de linhas que você pode rolar para trás.

```conf
# Guarda 10000 linhas de histórico no buffer
scrollback_lines 10000
```

#### d) Copiar ao Selecionar

Uma configuração muito amada por usuários de Linux.

```conf
# Copia o texto para o clipboard assim que você o seleciona com o mouse
copy_on_select yes
```

### "Kittens" - Programas de Extensão

Kittens são pequenos aplicativos que rodam dentro do kitty para adicionar funcionalidades.

#### a) `icat` - Visualizar Imagens

Visualize imagens diretamente no terminal.

```bash
kitty +kitten icat /path/to/your/image.png
```

É impressionante e muito útil!

#### b) `diff` - Comparação de Arquivos

Um `diff` visualmente muito superior ao padrão.

```bash
kitty +kitten diff file1.txt file2.txt
```

Você pode até integrá-lo com o `git`:

```bash
git config --global core.pager "kitty +kitten diff"
```

#### c) `Unicode Input` - Inserir Emojis e Símbolos

Pressione `⌘ + control + shift + u` para abrir um seletor de caracteres unicode e emojis.

---

### Exemplo de um `kitty.conf` Melhorado

Aqui está um exemplo que combina várias dessas ideias:

```conf
# ~/.config/kitty/kitty.conf

# --- APARÊNCIA ---

# Fonte com ligaduras e ícones
font_family                 JetBrainsMono Nerd Font
bold_font                   auto
italic_font                 auto
font_size                   14.0

# Tema (coloque o arquivo do tema na mesma pasta)
include themes/Catppuccin-Mocha.conf

# Transparência
background_opacity          0.95

# Cursor
cursor_shape                block
cursor_blink_interval       0

# Padding da janela
window_padding_width        15

# Esconder a barra de título (sua configuração original)
hide_window_decorations     titlebar-only
macos_titlebar_color        background

# --- FUNCIONALIDADE ---

# Integração com o shell para navegação rápida
shell_integration           enabled

# Aumentar o histórico de scroll
scrollback_lines            10000

# Copiar ao selecionar com o mouse
copy_on_select              yes

# Permitir controle remoto do kitty
allow_remote_control        yes

# --- ATALHOS CUSTOMIZADOS ---

# Mapeia cmd+enter para abrir uma nova janela do OS no mesmo diretório
map cmd+enter new_os_window_with_cwd

# Limpa o scrollback e a tela com cmd+k
map cmd+k combine L send_text \x0c
```

**Meu conselho:** comece com o básico (fonte e tema) e depois vá adicionando as funcionalidades de fluxo de trabalho (como `shell_integration`) aos poucos. O kitty é extremamente poderoso, e a melhor configuração é aquela que se adapta ao *seu* jeito de trabalhar.

### Como aplicar as alterações de configuração do Kitty

1. Salve o arquivo `kitty.conf` no seu editor de texto.
2. Para que a alteração tenha efeito, você pode:
    * **Simplesmente fechar e reabrir o kitty.**
    * Ou, com o kitty aberto, recarregar a configuração pressionando `⌘ + ,` (Command + vírgula) para reabrir o config e depois `control + command + ,` para recarregar. A forma mais fácil é simplesmente reiniciar o aplicativo.
