;; Match describe("name", () => { ... })
(call_expression
  function: (identifier) @func_name
    (#match? @func_name "^(describe|context)$")
  arguments: (arguments
    (string
      (string_fragment) @test.name)
    (arrow_function
      (statement_block) @test.definition))) @test.definition

;; Match it("name", () => { ... }) or test("name", () => { ... })
(call_expression
  function: (identifier) @func_name
    (#match? @func_name "^(it|test)$")
  arguments: (arguments
    (string
      (string_fragment) @test.name)
    (arrow_function
      (statement_block) @test.definition))) @test.definition

