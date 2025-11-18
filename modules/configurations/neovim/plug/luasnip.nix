{ pkgs, ... }:

with pkgs.vimPlugins;
{
  plugin = luasnip;
  type = "lua";
  config = /* lua */ ''
    --> luasnip <--
    local ls = require'luasnip'

    ls.config.setup({
        enable_autosnippets = true,
    })

    map({'i', 's'}, '<Tab>', function()
        if ls.expand_or_jumpable() then
            ls.expand_or_jump()
        else
            vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, false, true), 'n', false)
        end
    end)

    local snip = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local l = require'luasnip.extras'.lambda

    local function shell_cmd(cmd)
        local handle = io.popen(cmd)
        local result = handle:read("*a")
        handle:close()
        return result:gsub('%s+$', ''')
    end

    local function figlet(_, snippet)
        local cap_one = snippet.captures[1] or ""
        local cap_two = snippet.captures[2] or ""

        local font, text
        if cap_two ~= "" then
            font = cap_one
            text = cap_two
        else
            font = nil
            text = cap_one
        end

        if not text or text == "" then
            return "!empty input"
        end

        local cmd
        if font then
            cmd = "figlet -f " .. vim.fn.shellescape(font) .. " " .. vim.fn.shellescape(text)
        else
            cmd = "figlet " .. vim.fn.shellescape(text)
        end

        local handle = io.popen(cmd)
        if handle then
            local result = handle:read("*a")
            handle:close()
            if result then
                local lines = {}
                for line in result:gmatch("([^\n]*)\n") do
                    table.insert(lines, (line:gsub("%s+$", "")))
                end
                return lines
            end
        else
            return "!failed to run figlet"
        end
    end

    ls.add_snippets('nix', {
        snip({
            trig = '^f}',
            trigEngine = 'pattern',
            snippetType = 'autosnippet'
        }, {
            t('{ '),
            i(1),
            t({'... }:', ''', '''}),
            i(0),
        }),
        snip({
            trig = 'w]',
            snippetType = 'autosnippet',
        }, {
            t('with '),
            i(1, 'pkgs'),
            t({'; [', '  '}),
            i(2),
            t({''', '];', '''}),
            i(0)
        }),
        snip({
            trig = "s'",
            snippetType = 'autosnippet',
        }, {
            t({"'''", '  '}),
            i(0),
            t({''', "''';"})
        }),
    })

    ls.add_snippets('python', {
        snip({
            trig = '^main',
            trigEngine = 'pattern',
            snippetType = 'autosnippet',
        }, {
            t({ 'def main() -> None:', '    ' }),
            i(0, '...'),
            t({ ''', ''', 'if __name__ == \'__main__\':', '    main()' }),
        }),
        snip({
            trig = 'def ',
            snippetType = 'autosnippet',
        }, {
            t('def '),
            i(1, 'fn'),
            t('('),
            i(2),
            t(') -> '),
            i(3, 'None'),
            t({':', '    '}),
            i(0, '...')
        }),
        snip({
            trig = '^class ',
            trigEngine = 'pattern',
            snippetType = 'autosnippet',
        }, {
            t('class '),
            i(1, 'Cls'),
            t({':', '    def __init__('}),
            i(2, 'self,'),
            t({'):', '       '}),
            i(0, '...')
        }),
        snip({
            trig = 'match ',
            snippetType = 'autosnippet',
        }, {
            t('match '),
            i(1),
            t({':', '    case '}),
            i(2),
            t({':', '        '}),
            i(3, '...'),
            t({''', '    case _:', '        '}),
            i(0, '...'),
        })
    })
    -- LaTeX snippets
    ls.add_snippets('tex', {
        -- Inline math with auto-spacing
        snip({trig = "mm", snippetType="autosnippet"}, {
            t("$"),
            i(1),
            t("$"),
            f(char_after, {1}),
            i(2)
        }),
        -- Subscript
        snip({trig = "_", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("_{"),
            i(1),
            t("}"),
            i(0)
        }),
        -- Superscript
        snip({trig = "^", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("^{"),
            i(1),
            t("}"),
            i(0)
        }),
        -- Angle Brackets
        snip({trig = "\\angle", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\left\\langle{"),
            i(1),
            t("}\\right\\rangle"),
            i(0)
        }),
        -- Braces
        snip({trig = "\\brace", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\left\\{"),
            i(1),
            t("\\right\\}"),
            i(0)
        }),
        -- Parentheses
        snip({trig = "\\(", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\left("),
            i(1),
            t(")\\right("),
            i(0)
        }),
        -- Square Brackets
        snip({trig = "\\squareb", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\left["),
            i(1),
            t("\\right]"),
            i(0)
        }),
        -- Fraction
        snip({trig = "ff", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\frac{"),
            i(1),
            t("}{"),
            i(2),
            t("}"),
            i(0)
        }),
        -- Integral
        snip({trig = "\\int", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\int_{"),
            i(1),
            t("}^{"),
            i(2),
            t("}"),
            i(0)
        }),
        -- Nabla
        snip({trig = "\\nab", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\nabla"),
            i(0)
        }),
        -- Greek letters
        snip({trig = "g;a", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\alpha"),
            i(0)
        }),
        snip({trig = "g;b", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\beta"),
            i(0)
        }),
        snip({trig = "g;D", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\Delta"),
            i(0)
        }),
        snip({trig = "g;t", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\theta"),
            i(0)
        }),
        snip({trig = "g;l", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\lambda"),
            i(0)
        }),
        -- Font styles
        snip({trig = "\\bb", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\mathbb{"),
            i(1),
            t("}"),
            i(0)
        }),
        snip({trig = "\\bf", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\mathbf{"),
            i(1),
            t("}"),
            i(0)
        }),
        snip({trig = "\\cal", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\mathcal{"),
            i(1),
            t("}"),
            i(0)
        }),
        snip({trig = "\\frak", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\mathfrak{"),
            i(1),
            t("}"),
            i(0)
        }),
        -- Relations
        snip({trig = "\\sset", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\subseteq"),
            i(0)
        }),
        snip({trig = "\\rset", regTrig = true, snippetType="autosnippet"}, {
            f(function(_, snippet) return snippet.captures[1] end),
            t("\\preceq"),
            i(0)
        }),
        -- Equation environment (beginning of line)
        snip({trig = "nn", snippetType="snippet", condition = function()
            return vim.fn.col('.') == 1
        end}, {
            t({"\\begin{equation}", "    "}),
            i(1),
            t({"", "\\end{equation}", ""}),
            i(0)
        }),
        -- Begin environment
        snip({trig = "\\beg", snippetType="snippet", condition = function()
            return vim.fn.col('.') == 1
        end}, {
            t("\\begin{"),
            i(1, "environment"),
            t({"}", "    "}),
            i(0),
            t({"", "\\end{"}),
            f(function(args) return args[1][1] end, {1}),
            t("}")
        }),
        -- Sections
        snip({trig = "\\sec", snippetType="snippet", condition = function()
            return vim.fn.col('.') == 1
        end}, {
            t("\\section{"),
            i(1, "section"),
            t({"}", ""}),
            i(0)
        }),
        snip({trig = "\\ssec", snippetType="snippet", condition = function()
            return vim.fn.col('.') == 1
        end}, {
            t("\\subsection{"),
            i(1, "subsection"),
            t({"}", ""}),
            i(0)
        }),
        snip({trig = "\\sssec", snippetType="snippet", condition = function()
            return vim.fn.col('.') == 1
        end}, {
            t("\\subsubsection{"),
            i(1, "subsubsection"),
            t({"}", ""}),
            i(0)
        }),
        -- Document template
        snip({trig = "doctemplate", snippetType="snippet", condition = function()
            return vim.fn.col('.') == 1
        end}, {
            t("\\documentclass["),
            i(1, "12pt"),
            t("]{"),
            i(2, "article"),
            t({"}",
            "\\usepackage{graphicx} % Use this package to include images",
            "\\usepackage{amsmath} % A library of many standard math expressions",
            "\\usepackage[margin=1in]{geometry}% Sets 1in margins.",
            "\\usepackage{fancyhdr} % Creates headers and footers",
            "\\usepackage{enumerate}  %These two package give custom labels to a list",
            "\\usepackage{enumitem}",
            "\\usepackage{amssymb}",
            "\\usepackage{amsthm} % for theorem style environments for question and answers for readablity",
            "\\usepackage{titlesec}",
            "\\geometry{margin="}),
            i(3, "1in"),
            t({"}",
            "% Reduce spacing around section headers",
            "\\titlespacing*{\\section}{0pt}{1ex}{0.5ex}",
            "\\titlespacing*{\\subsection}{0pt}{0.8ex}{0.4ex}",
            "\\newtheorem*{thm}{Theorem}",
            "\\theoremstyle{definition}",
            "\\newtheorem*{q}{Question}",
            "\\newtheorem*{ans}{Answer}",
            "\\title{"}),
            i(4, "Title"),
            t({"}", "\\author{"}),
            i(5, "Author"),
            t({"}", "\\date{"}),
            i(6, "\\today"),
            t({"}",
            "\\begin{document}",
            "\\maketitle",
            "\\vspace{-2em}  % Remove space after title block",
            "\\section{"}),
            i(7, "section"),
            t({"}", ""}),
            i(0),
            t({"", "\\end{document}"})
        })
    })
    -- ls.add_snippets('rust', {
    --     snip({
    --         trig = 'fn ',
    --         snippetType = 'autosnippet',
    --     }, {
    --         t('fn '),
    --         i(1, 'name'),
    --         t('('),
    --         i(2),
    --         t(') -> '),
    --         i(3, '()'),
    --         t({' {', '    '}),
    --         i(0),
    --         t({''', '}'}),
    --     }),
    --     snip({
    --         trig = 'fnn',
    --         snippetType = 'autosnippet',
    --     }, {
    --         t('fn '),
    --         i(1, 'name'),
    --         t('('),
    --         i(2),
    --         t({') {', '    '}),
    --         i(0),
    --         t({''', '}'}),
    --     }),
    -- })
  '';
}
