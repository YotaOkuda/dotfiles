## プラグインマネージャー / 依存ライブラリ

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `lazy.nvim` | プラグインマネージャー | `lua/yota/lazy.lua` |
| `plenary.nvim` | 多くのプラグインが依存するLuaユーティリティ | `lua/yota/plugins/init.lua` |
| `nui.nvim` | UIコンポーネントライブラリ | `lua/yota/plugins/neo-tree.lua` |

## UI / 外観

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `tokyonight.nvim` | カラースキーム（透過対応） | `lua/yota/plugins/colorscheme.lua` |
| `lualine.nvim` | ステータスライン | `lua/yota/plugins/lualine.lua` |
| `bufferline.nvim` | バッファタブ表示 | `lua/yota/plugins/bufferline.lua` |
| `alpha-nvim` | ダッシュボード/起動画面 | `lua/yota/plugins/alpha.lua` |
| `dressing.nvim` | `vim.ui` の見た目改善 | `lua/yota/plugins/dressing.lua` |
| `nvim-web-devicons` | ファイルタイプアイコン | `lua/yota/plugins/telescope.lua` |
| `indent-blankline.nvim` | インデントガイド表示 | `lua/yota/plugins/indent-blankline.lua` |

## ファイルナビゲーション / 検索

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `telescope.nvim` | ファジーファインダー | `lua/yota/plugins/telescope.lua` |
| `telescope-fzf-native.nvim` | Telescope用FZFソーター | `lua/yota/plugins/telescope.lua` |
| `neo-tree.nvim` | ファイルツリー | `lua/yota/plugins/neo-tree.lua` |
| `lazygit.nvim` | LazyGit連携 | `lua/yota/plugins/lazygit.lua` |

## シンタックス / パーサー (Tree-sitter)

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `nvim-treesitter` | シンタックスハイライト・インデント | `lua/yota/plugins/treesitter.lua` |
| `nvim-treesitter-endwise` | `end` キーワード自動補完 (Ruby, Luaなど) | `lua/yota/plugins/treesitter.lua` |
| `nvim-ts-autotag` | HTML/JSXタグ自動閉じ・リネーム | `lua/yota/plugins/treesitter.lua` |
| `nvim-ts-context-commentstring` | コンテキスト対応コメント文字列 | `lua/yota/plugins/comment.lua` |

## 補完 / スニペット

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `nvim-cmp` | 補完エンジン | `lua/yota/plugins/nvim-cmp.lua` |
| `cmp-buffer` | バッファ内テキスト補完ソース | `lua/yota/plugins/nvim-cmp.lua` |
| `cmp-path` | ファイルパス補完ソース | `lua/yota/plugins/nvim-cmp.lua` |
| `cmp-nvim-lsp` | LSP補完ソース | `lua/yota/plugins/lsp/nvim-lspconfig.lua` |
| `cmp_luasnip` | LuaSnip補完ソース | `lua/yota/plugins/nvim-cmp.lua` |
| `LuaSnip` | スニペットエンジン | `lua/yota/plugins/nvim-cmp.lua` |
| `friendly-snippets` | VSCode互換スニペット集 | `lua/yota/plugins/nvim-cmp.lua` |
| `lspkind.nvim` | 補完メニューのアイコン表示 | `lua/yota/plugins/nvim-cmp.lua` |

## 編集支援

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `nvim-autopairs` | 括弧・クォート自動補完（Ruby除外設定あり） | `lua/yota/plugins/autopairs.lua` |
| `nvim-surround` | 囲み文字操作 (`cs`, `ds`, `ys`) | `lua/yota/plugins/surround.lua` |
| `substitute.nvim` | テキスト置換オペレーター | `lua/yota/plugins/substitute.lua` |
| `Comment.nvim` | コメントトグル（TSX/JSX対応） | `lua/yota/plugins/comment.lua` |
| `vim-maximizer` | 分割ウィンドウ最大化/復元 | `lua/yota/plugins/vim-maximizer.lua` |

## LSP (Language Server Protocol)

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `nvim-lspconfig` | LSPクライアント設定（v0.11+ `vim.lsp.config` 使用） | `lua/yota/plugins/lsp/nvim-lspconfig.lua` |
| `mason.nvim` | LSP/フォーマッター/リンターインストーラー | `lua/yota/plugins/lsp/mason.lua` |
| `mason-lspconfig.nvim` | MasonとLSPの連携 | `lua/yota/plugins/lsp/mason.lua` |
| `mason-tool-installer.nvim` | ツール自動インストール | `lua/yota/plugins/lsp/mason.lua` |
| `nvim-lsp-file-operations` | LSP経由のファイルリネーム/削除 | `lua/yota/plugins/lsp/nvim-lspconfig.lua` |
| `neodev.nvim` | Neovim Lua開発支援 | `lua/yota/plugins/lsp/nvim-lspconfig.lua` |

## コード品質 / フォーマット

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `conform.nvim` | フォーマッター（Prettier, Stylua, Black, Isort） | `lua/yota/plugins/formatting.lua` |
| `nvim-lint` | リンター（ESLint, Pylint） | `lua/yota/plugins/linting.lua` |

## Git

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `gitsigns.nvim` | Git差分の行表示・操作 | `lua/yota/plugins/gitsigns.lua` |

## 診断 / エラー管理

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `trouble.nvim` | 診断・quickfix・TODOリスト | `lua/yota/plugins/trouble.lua` |
| `todo-comments.nvim` | TODOコメントのハイライト・ナビゲーション | `lua/yota/plugins/todo-comments.lua` |

## ユーティリティ

| プラグイン | 用途 | 定義ファイル |
|---|---|---|
| `which-key.nvim` | キーバインドヘルパー | `lua/yota/plugins/which-key.lua` |
| `auto-session` | セッション自動保存/復元 | `lua/yota/plugins/auto-session.lua` |
| `auto-save.nvim` | ファイル自動保存（1500msデバウンス） | `lua/yota/plugins/auto-save.lua` |
| `vim-tmux-navigator` | Tmux/Neovim間のシームレスなペイン移動 | `lua/yota/plugins/vim-tmux-navigator.lua` |
