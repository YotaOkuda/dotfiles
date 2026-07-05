# プラグイン一覧

## プラグインマネージャー / 依存ライブラリ

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `lazy.nvim` | プラグインマネージャー | `lua/config/lazy.lua` |
| `plenary.nvim` | 多くのプラグインが依存するLuaユーティリティ | `lua/plugins/init.lua` |
| `nvim-web-devicons` | ファイルタイプアイコン（lualine, troubleの依存） | `lua/plugins/lualine.lua` ほか |

## UI / 外観

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `tokyonight.nvim` | カラースキーム（現在有効。`active` 変数で切替） | `lua/plugins/colorscheme.lua` |
| `catppuccin` | カラースキーム（切替候補） | `lua/plugins/colorscheme.lua` |
| `lualine.nvim` | ステータスライン | `lua/plugins/lualine.lua` |

## snacks.nvim（統合ユーティリティ）

`lua/plugins/snacks.lua` で以下の機能を有効化している。

| 機能 | 用途 |
|---|---|
| `explorer` | ファイルツリー（neo-treeから移行。git状態をM/S/U表示、未保存バッファに○マーカー、現在ファイル自動追従、`Y`/`gy`/`gY` でファイル名/相対パス/絶対パスをコピー） |
| `picker` | ファジーファインダー（`<leader>ff` files, `<leader>fs` grep, `<leader>fb` buffers など。LSPのreferences/definitions等も `lua/config/lsp.lua` で使用） |
| `terminal` | フロートターミナル（`<leader>t`） |
| `gitbrowse` | カーソル行のblameコミットをブラウザで開く（`<leader>go`） |
| `dashboard` | 起動画面（alpha-nvimから移行。NEOVIMヘッダー + New File/Explorer/Find File等のショートカット） |
| `indent` | インデントガイド表示（indent-blanklineから移行。実線ガイド `│`、カーソル位置のスコープは丸角+矢印のchunk枠 `╭─>` で強調） |
| その他 | `bigfile` / `input` / `notifier` / `quickfile` / `scope` / `scroll` / `statuscolumn` / `words` |

## シンタックス / パーサー (Tree-sitter)

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `nvim-treesitter` | シンタックスハイライト・インデント | `lua/plugins/treesitter.lua` |
| `nvim-treesitter-endwise` | `end` キーワード自動補完 (Ruby, Luaなど) | `lua/plugins/treesitter.lua` |
| `nvim-ts-autotag` | HTML/JSXタグ自動閉じ・リネーム | `lua/plugins/treesitter.lua` |

## 補完 / スニペット

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `blink.cmp` | 補完エンジン（スニペットはNeovim組み込みの `vim.snippet` を使用） | `lua/plugins/blink-cmp.lua` |
| `friendly-snippets` | VSCode互換スニペット集 | `lua/plugins/blink-cmp.lua` |

## 編集支援

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `nvim-autopairs` | 括弧・クォート自動補完 | `lua/plugins/autopairs.lua` |
| `nvim-surround` | 囲み文字操作 (`cs`, `ds`, `ys`) | `lua/plugins/surround.lua` |
| `substitute.nvim` | テキスト置換オペレーター | `lua/plugins/substitute.lua` |

## LSP (Language Server Protocol)

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `nvim-lspconfig` | LSPクライアント設定 | `lua/plugins/lsp/nvim-lspconfig.lua` |
| `mason.nvim` | LSP/フォーマッター/リンターインストーラー | `lua/plugins/lsp/mason.lua` |
| `mason-lspconfig.nvim` | MasonとLSPの連携 | `lua/plugins/lsp/mason.lua` |
| `mason-tool-installer.nvim` | ツール自動インストール | `lua/plugins/lsp/mason.lua` |

## コード品質 / フォーマット

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `conform.nvim` | フォーマッター | `lua/plugins/formatting.lua` |
| `nvim-lint` | リンター | `lua/plugins/linting.lua` |

## Git

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `gitsigns.nvim` | Git差分の行表示・操作 | `lua/plugins/gitsigns.lua` |
| `lazygit.nvim` | LazyGit連携 | `lua/plugins/lazygit.lua` |

## 診断 / エラー管理

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `trouble.nvim` | 診断・quickfix・TODOリスト | `lua/plugins/trouble.lua` |
| `todo-comments.nvim` | TODOコメントのハイライト・ナビゲーション | `lua/plugins/todo-comments.lua` |

## ユーティリティ

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `which-key.nvim` | キーバインドヘルパー | `lua/plugins/which-key.lua` |
| `vim-tmux-navigator` | Tmux/Neovim間のシームレスなペイン移動 | `lua/plugins/vim-tmux-navigator.lua` |
