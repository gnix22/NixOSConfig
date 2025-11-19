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

    -- LaTeX snippets (FIXED with proper escaping)
    ls.add_snippets('tex', {
        -- Inline math with auto-spacing
        snip({trig = "mm", snippetType="autosnippet"}, {
            t("$"),
            i(1),
            t("$"),
            i(0)
        }),
        -- Subscript
        snip({trig = "_", snippetType="autosnippet"}, {
            t("_{"),
            i(1),
            t("}"),
            i(0)
        }),
        -- Superscript
        snip({trig = "^", snippetType="autosnippet"}, {
            t("^{"),
            i(1),
            t("}"),
            i(0)
        }),
        -- Angle Brackets (FIXED: using [[raw string]] to avoid escaping issues)
        snip({trig = [[angle]], snippetType="autosnippet"}, {
            t("\\left\\langle{"),
            i(1),
            t("}\\right\\rangle"),
            i(0)
        }),
        -- Braces
        snip({trig = [[brace]], snippetType="autosnippet"}, {
            t("\\left\\{"),
            i(1),
            t("\\right\\}"),
            i(0)
        }),
        -- Parentheses
        snip({trig = "((", snippetType="autosnippet"}, {
            t("\\left("),
            i(1),
            t("\\right)"),
            i(0)
        }),
        -- Square Brackets
        snip({trig = "[[", snippetType="autosnippet"}, {
            t("\\left["),
            i(1),
            t("\\right]"),
            i(0)
        }),
        -- Fraction
        snip({trig = "ff", snippetType="autosnippet"}, {
            t("\\frac{"),
            i(1),
            t("}{"),
            i(2),
            t("}"),
            i(0)
        }),
        -- Integral
        snip({trig = "intt", snippetType="autosnippet"}, {
            t("\\int_{"),
            i(1),
            t("}^{"),
            i(2),
            t("}"),
            i(0)
        }),
        -- Nabla
        snip({trig = "nab", snippetType="autosnippet"}, {
            t("\\nabla"),
            i(0)
        }),
        -- Greek letters 
        snip({trig = "a;", snippetType="autosnippet"}, {
            t("\\alpha"),
            i(0)
        }),
        snip({trig = "b;", snippetType="autosnippet"}, {
            t("\\beta"),
            i(0)
        }),
        snip({trig = "D;", snippetType="autosnippet"}, {
            t("\\Delta"),
            i(0)
        }),
        snip({trig = "t;", snippetType="autosnippet"}, {
            t("\\theta"),
            i(0)
        }),
        snip({trig = "l;", snippetType="autosnippet"}, {
            t("\\lambda"),
            i(0)
        }),
        
        -- Font styles (using simpler triggers)
        snip({trig = "mbb", snippetType="autosnippet"}, {
            t("\\mathbb{"),
            i(1),
            t("}"),
            i(0)
        }),
        snip({trig = "mbf", snippetType="autosnippet"}, {
            t("\\mathbf{"),
            i(1),
            t("}"),
            i(0)
        }),
        snip({trig = "mcal", snippetType="autosnippet"}, {
            t("\\mathcal{"),
            i(1),
            t("}"),
            i(0)
        }),
        snip({trig = "mfrak", snippetType="autosnippet"}, {
            t("\\mathfrak{"),
            i(1),
            t("}"),
            i(0)
        }),
        
        -- Relations
        snip({trig = "sset", snippetType="autosnippet"}, {
            t("\\subseteq"),
            i(0)
        }),
        snip({trig = "rset", snippetType="autosnippet"}, {
            t("\\preceq"),
            i(0)
        }),
        
        -- Equation environment (beginning of line) - MANUAL snippet
        snip({trig = "eqn", snippetType="snippet"}, {
            t({"\\begin{equation}", "    "}),
            i(1),
            t({"", "\\end{equation}", ""}),
            i(0)
        }),
        
        -- Begin environment - MANUAL snippet
        snip({trig = "beg", snippetType="snippet"}, {
            t("\\begin{"),
            i(1, "environment"),
            t({"}", "    "}),
            i(2),
            t({"", "\\end{"}),
            f(function(args) return args[1][1] end, {1}),
            t("}"),
            i(0)
        }),
        
        -- Sections - MANUAL snippets
        snip({trig = "sec", snippetType="snippet"}, {
            t("\\section{"),
            i(1, "section"),
            t({"}", ""}),
            i(0)
        }),
        snip({trig = "ssec", snippetType="snippet"}, {
            t("\\subsection{"),
            i(1, "subsection"),
            t({"}", ""}),
            i(0)
        }),
        snip({trig = "sssec", snippetType="snippet"}, {
            t("\\subsubsection{"),
            i(1, "subsubsection"),
            t({"}", ""}),
            i(0)
        }),
        
        -- Document template - MANUAL snippet
        snip({trig = "doctemplate", snippetType="snippet"}, {
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
        }),

        -- hw macro
        snip({trig = "doctemplate", snippetType="snippet"}, {
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
