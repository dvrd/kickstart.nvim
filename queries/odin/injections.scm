; sql
(call_expression
    function: ((identifier) @function.name (#eq? @function.name "select"))
    argument: (string (string_content) @injection.content)
  (#set! injection.language "sql")
  (#set! injection.include-children))
