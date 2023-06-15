local settings = require("core.settings")
local nvim_lsp = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local lsp_settings = require("core.plugins.lsp.settings")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("core.utils.functions").on_attach(function(client, buffer)
  -- disable formatting for LSP clients as this is handled by null-ls
  -- TODO: not required anymore?
  -- client.server_capabilities.documentFormattingProvider = false
  -- client.server_capabilities.documentRangeFormattingProvider = false
  require("core.plugins.lsp.keys").on_attach(client, buffer)
end)

local pid = vim.fn.getpid()
for _, lsp in ipairs(settings.lsp_servers) do
    nvim_lsp[lsp].setup({
        cmd = { "c:\\users\\mdieleuterio\\appdata\\local\\nvim-data\\mason\\packages\\omnisharp\\omnisharp.exe" , '--languageserver' , '--host ', tostring(pid) },
        --cmd = { "dotnet", "c:\\users\\mdieleuterio\\appdata\\local\\nvim-data\\mason\\packages\\omnisharp\\omnisharp.dll" },
        --cmd = { "dotnet", "/root/.local/share/nvim/mason/packages/omnisharp/omnisharp.dll" },
        handlers = {
          ["textdocument/definition"] = require('omnisharp_extended').handler,
        },
        enable_editorconfig_support = true,
        enable_ms_build_load_projects_on_demand = false,
        enable_roslyn_analyzers = false,
        organize_imports_on_format = false,
        enable_import_completion = false,
        sdk_include_prereleases = true,
        analyze_open_documents_only = false,
      before_init = function(_, config)
        if lsp == "pyright" then
          config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
        end
      end,
      capabilities = capabilities,
      flags = { debounce_text_changes = 150 },
      on_attach = function(client)
        --if client.name == "omnisharp" then
        --  client.server_capabilities.semanticTokensProvider  = {
        --    full = vim.empty_dict(),
        --    legend = {
        --      tokenmodifiers = { "static_symbol" },
        --      tokentypes = {
        --        "comment",
        --        "excluded_code",
        --        "identifier",
        --        "keyword",
        --        "keyword_control",
        --        "number",
        --        "operator",
        --        "operator_overloaded",
        --        "preprocessor_keyword",
        --        "string",
        --        "whitespace",
        --        "text",
        --        "static_symbol",
        --        "preprocessor_text",
        --        "punctuation",
        --        "string_verbatim",
        --        "string_escape_character",
        --        "class_name",
        --        "delegate_name",
        --        "enum_name",
        --        "interface_name",
        --        "module_name",
        --        "struct_name",
        --        "type_parameter_name",
        --        "field_name",
        --        "enum_member_name",
        --        "constant_name",
        --        "local_name",
        --        "parameter_name",
        --        "method_name",
        --        "extension_method_name",
        --        "property_name",
        --        "event_name",
        --        "namespace_name",
        --        "label_name",
        --        "xml_doc_comment_attribute_name",
        --        "xml_doc_comment_attribute_quotes",
        --        "xml_doc_comment_attribute_value",
        --        "xml_doc_comment_cdata_section",
        --        "xml_doc_comment_comment",
        --        "xml_doc_comment_delimiter",
        --        "xml_doc_comment_entity_reference",
        --        "xml_doc_comment_name",
        --        "xml_doc_comment_processing_instruction",
        --        "xml_doc_comment_text",
        --        "xml_literal_attribute_name",
        --        "xml_literal_attribute_quotes",
        --        "xml_literal_attribute_value",
        --        "xml_literal_cdata_section",
        --        "xml_literal_comment",
        --        "xml_literal_delimiter",
        --        "xml_literal_embedded_expression",
        --        "xml_literal_entity_reference",
        --        "xml_literal_name",
        --        "xml_literal_processing_instruction",
        --        "xml_literal_text",
        --        "regex_comment",
        --        "regex_character_class",
        --        "regex_anchor",
        --        "regex_quantifier",
        --        "regex_grouping",
        --        "regex_alternation",
        --        "regex_text",
        --        "regex_self_escaped_character",
        --        "regex_other_escape",
        --      },
        --    },
        --    range = true,
        --  }
        --end
      end,
      settings = {
        json = lsp_settings.json,
        Lua = lsp_settings.lua,
        ltex = lsp_settings.ltex,
        redhat = { telemetry = { enabled = false } },
        texlab = lsp_settings.tex,
        yaml = lsp_settings.yaml,
        --csharp = lsp_settings.omnisharp, --do not uncomment
        --omnisharp = lsp_settings.omnisharp, --do not uncomment
      },
    })

end
