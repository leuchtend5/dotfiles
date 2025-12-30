return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/lazydev.nvim", opts = {} },
		"mason-org/mason-lspconfig.nvim",
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")
		local util = require("lspconfig.util")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }

				-- set keybinds
				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

				-- opts.desc = "Show line diagnostics"
				-- keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
			end,
		})

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		lspconfig["sourcekit"].setup({
			cmd = {
				"sourcekit-lsp",
			},
			filetypes = { "swift", "objc", "objcpp", "c", "cpp" },
			root_dir = function(pattern)
				local cwd = vim.loop.cwd()
				local root = util.root_pattern(
					"buildServer.json",
					"*.xcodeproj",
					"*.xcworkspace",
					"compile_commands.json",
					"Package.swift",
					".git"
				)(pattern)

				-- prefer cwd if root is a descendant
				-- return util.path.is_descendant(cwd, root) and cwd or root
				return root or util.path.dirname(pattern)
			end,
		})

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"ts_ls",
				"html",
				"cssls",
				"tailwindcss",
				"svelte",
				"lua_ls",
				"graphql",
				"emmet_ls",
				"prismals",
				"pyright",
				"angularls",
				"bashls",
				"cssmodules_ls",
				"css_variables",
				"dockerls",
				"eslint",
				"jsonls",
				"spectral",
				"vacuum",
				"intelephense",
				-- "phpactor",
				-- "psalm",
				"pyre",
				"sqlls",
				"somesass_ls",
			},

			-- default handler for installed servers

			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["harper_ls"] = function()
					lspconfig["harper_ls"].setup({
						capabilities = capabilities,
						settings = {
							["harper-ls"] = {
								linters = {
									sentence_capitalization = false,
									spell_check = true,
								},
							},
						},
					})
				end,
				["tailwindcss"] = function()
					lspconfig["tailwindcss"].setup({
						capabilities = capabilities,
						cmd = { "tailwindcss-language-server", "--stdio" },
						filetypes = {
							"aspnetcorerazor",
							"astro",
							"astro-markdown",
							"blade",
							"clojure",
							"django-html",
							"htmldjango",
							"edge",
							"eelixir",
							"elixir",
							"ejs",
							"erb",
							"eruby",
							"gohtml",
							"gohtmltmpl",
							"haml",
							"handlebars",
							"hbs",
							"html",
							"htmlangular",
							"html-eex",
							"heex",
							"jade",
							"leaf",
							"liquid",
							"markdown",
							"mdx",
							"mustache",
							"njk",
							"nunjucks",
							"php",
							"razor",
							"slim",
							"twig",
							"css",
							"less",
							"postcss",
							"sass",
							"scss",
							"stylus",
							"sugarss",
							"javascript",
							"javascriptreact",
							"reason",
							"rescript",
							"typescript",
							"typescriptreact",
							"vue",
							"svelte",
							"templ",
						},
						settings = {
							tailwindCSS = {
								classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
								includeLanguages = {
									eelixir = "html-eex",
									eruby = "erb",
									htmlangular = "html",
									templ = "html",
								},
								lint = {
									cssConflict = "warning",
									invalidApply = "error",
									invalidConfigPath = "error",
									invalidScreen = "error",
									invalidTailwindDirective = "error",
									invalidVariant = "error",
									unknownAtRules = "ignore",
									recommendedVariantOrder = "warning",
								},
								validate = true,
							},
						},
						on_new_config = function(new_config)
							if not new_config.settings then
								new_config.settings = {}
							end
							if not new_config.settings.editor then
								new_config.settings.editor = {}
							end
							if not new_config.settings.editor.tabSize then
								-- set tab size for hover
								new_config.settings.editor.tabSize = vim.lsp.util.get_effective_tabstop()
							end
						end,
						root_dir = function(fname)
							return util.root_pattern(
								"tailwind.config.js",
								"tailwind.config.cjs",
								"tailwind.config.mjs",
								"tailwind.config.ts",
								"postcss.config.js",
								"postcss.config.cjs",
								"postcss.config.mjs",
								"postcss.config.ts"
							)(fname) or vim.fs.dirname(
								vim.fs.find("package.json", { path = fname, upward = true })[1]
							) or vim.fs.dirname(vim.fs.find("node_modules", { path = fname, upward = true })[1]) or vim.fs.dirname(
								vim.fs.find(".git", { path = fname, upward = true })[1]
							)
						end,
					})
				end,
				["svelte"] = function()
					-- configure svelte server
					lspconfig["svelte"].setup({
						capabilities = capabilities,
						on_attach = function(client, bufnr)
							vim.api.nvim_create_autocmd("BufWritePost", {
								pattern = { "*.js", "*.ts" },
								callback = function(ctx)
									-- Here use ctx.match instead of ctx.file
									client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
								end,
							})
						end,
					})
				end,
				["graphql"] = function()
					-- configure graphql language server
					lspconfig["graphql"].setup({
						capabilities = capabilities,
						filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
					})
				end,
				["emmet_ls"] = function()
					-- configure emmet language server
					lspconfig["emmet_ls"].setup({
						capabilities = capabilities,
						filetypes = {
							"html",
							"typescriptreact",
							"javascriptreact",
							"css",
							"sass",
							"scss",
							"less",
							"svelte",
						},
					})
				end,
				["lua_ls"] = function()
					-- configure lua server (with special settings)
					lspconfig["lua_ls"].setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								-- make the language server recognize "vim" global
								diagnostics = {
									globals = { "vim" },
								},
								completion = {
									callSnippet = "Replace",
								},
							},
						},
					})
				end,
				["ts_ls"] = function()
					lspconfig["ts_ls"].setup({
						capabilities = capabilities,
					})
				end,
				["eslint"] = function()
					lspconfig["eslint"].setup({
						cmd = { "eslint_d", "--stdin", "--stdin-fd", "1" },
						filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
						root_dir = require("lspconfig").util.root_pattern(
							".eslintrc.cjs",
							".eslintrc.js",
							".eslintrc.json",
							"package.json",
							".git"
						),
					})
				end,
				["angularls"] = function()
					local ok, mason_registry = pcall(require, "mason-registry")
					if not ok then
						vim.notify("mason-registry could not be loaded")
						return
					end

					local angularls_path = mason_registry.get_package("angular-language-server"):get_install_path()

					local cmd = {
						"ngserver",
						"--stdio",
						"--tsProbeLocations",
						table.concat({
							angularls_path,
							vim.uv.cwd(),
						}, ","),
						"--ngProbeLocations",
						table.concat({
							angularls_path .. "/node_modules/@angular/language-server",
							vim.uv.cwd(),
						}, ","),
					}
					lspconfig["angularls"].setup({
						cmd = cmd,
						filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
						root_dir = util.root_pattern("angular.json", "package.json", ".git"),

						on_new_config = function(new_config, new_root_dir)
							new_config.cmd = cmd
						end,
						capabilities = capabilities,
						settings = {
							angularls = {
								includeLanguages = {
									htmlangular = "html",
								},
							},
						},
					})
				end,
				["intelephense"] = function()
					lspconfig["intelephense"].setup({
						cmd = {
							"intelephense",
							"--stdio",
						},
						filetypes = {
							"php",
						},
						root_dir = function(pattern)
							local cwd = vim.loop.cwd()
							local root = util.root_pattern("composer.json", ".git", "*.php")(pattern)

							-- prefer cwd if root is a descendant
							return util.path.is_descendant(cwd, root) and cwd or root
						end,
						capabilities = capabilities,
						settings = {
							intelephense = {
								diagnostics = {
									undefinedTypes = true, -- or set to false if you want to disable
									undefinedVariables = false, -- set to false to disable undefined variables diagnostics
								},
							},
						},
					})
				end,
				-- ["dartls"] = function()
				-- 	lspconfig["dartls"].setup({
				-- 		cmd = { "/opt/homebrew/bin/dart", "language-server", "--protocol=lsp" },
				-- 		filetypes = { "dart" },
				-- 		init_options = {
				-- 			closingLabels = true,
				-- 			flutterOutline = true,
				-- 			onlyAnalyzeProjectsWithOpenFiles = true,
				-- 			outline = true,
				-- 			suggestFromUnimportedLibraries = true,
				-- 		},
				-- 		root_dir = util.root_pattern("pubspec.yaml"),
				-- 		settings = {
				-- 			dart = {
				-- 				completeFunctionCalls = true,
				-- 				showTodos = true,
				-- 			},
				-- 		},
				-- 	})
				-- end,
				-- ["dcmls"] = function()
				-- 	lspconfig["dcmls"].setup({
				-- 		cmd = { "dcm", "start-server", "--client=neovim" },
				-- 		filetypes = { "dart" },
				-- 		root_dir = util.root_pattern("pubspec.yaml"),
				-- 	})
				-- end,
				["golangci_lint_ls"] = function()
					lspconfig["golangci_lint_ls"].setup({
						cmd = {
							"golangci-lint-langserver",
							"--stdio",
						},
						filetypes = {
							"go",
							"gomod",
						},
						init_options = {
							command = { "golangci-lint", "run", "--out-format", "json" },
						},
						root_dir = function(pattern)
							local cwd = vim.loop.cwd()
							local root = util.root_pattern("golangci-lint", "run", "--out-format", "json")(pattern)

							-- prefer cwd if root is a descendant
							return util.path.is_descendant(cwd, root) and cwd or root
						end,
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					lspconfig["gopls"].setup({
						cmd = {
							"gopls",
						},
						filetypes = {
							"go",
							"gomod",
							"gowork",
							"gotmpl",
						},
						single_file_support = true,
						root_dir = function(pattern)
							local cwd = vim.loop.cwd()
							local root = util.root_pattern("go, env, GOMODCACHE")(pattern)

							-- prefer cwd if root is a descendant
							return util.path.is_descendant(cwd, root) and cwd or root
						end,
					})
				end,
				["pyright"] = function()
					lspconfig["pyright"].setup({
						cmd = {
							"pyright-langserver",
							"--stdio",
						},
						filetypes = {
							"python",
						},
						root_dir = function(pattern)
							local root = util.root_pattern(
								"pyproject.toml",
								"setup.py",
								"setup.cfg",
								"requirements.txt",
								".git"
							)(pattern)

							return root or vim.loop.cwd()
						end,
						single_file_support = true,
						settings = {
							python = {
								analysis = {
									autoSearchPaths = true,
									diagnosticMode = "openFilesOnly", -- Only show diagnostics for open files
									useLibraryCodeForTypes = true, -- Use library code for better type checking
									typeCheckingMode = "off", -- Disable type checking for more relaxed linting
									diagnosticSeverityOverrides = {
										missingDocstring = "none", -- Disable the missing docstring warning
									},
								},
							},
						},
						capabilities = capabilities,
					})
				end,
				["clangd"] = function()
					lspconfig["clangd"].setup({
						cmd = {
							"clangd",
						},
						filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
						root_dir = util.root_pattern("compile_commands.json", ".git"),
						capabilities = {
							textDocument = {
								completion = {
									editsNearCursor = true,
								},
							},
							offsetEncoding = { "utf-8", "utf-16" }, -- Default capabilities
						},
						single_file_support = true, -- Enable support for single file projects
					})
				end,
				-- ["psalm"] = function()
				-- 	lspconfig["psalm"].setup({
				-- 		cmd = {
				-- 			"psalm",
				-- 			"--language-server",
				-- 		},
				-- 		filetypes = {
				-- 			"php",
				-- 		},
				-- 		root_dir = function(pattern)
				-- 			local cwd = vim.loop.cwd()
				-- 			local root = util.root_pattern("psalm.xml", "psalm.xml.dist", "composer.json", ".git")(pattern)
				--
				-- 			-- prefer cwd if root is a descendant
				-- 			return util.path.is_descendant(cwd, root) and cwd or root
				-- 		end,
				-- 		capabilities = capabilities,
				-- 	})
				-- end,
			},
		})
	end,
}
