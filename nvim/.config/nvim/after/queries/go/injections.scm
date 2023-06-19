;; extends

(short_var_declaration
    left: (expression_list
            (identifier))
    right: (expression_list
             (raw_string_literal) @sql (#offset! @sql 0 1 0 -1)))

(var_declaration
  (var_spec
    name: (identifier)
    value: (expression_list
             (raw_string_literal) @sql (#offset! @sql 0 1 0 -1))))

(const_declaration
  (const_spec
    name: (identifier)
    value: (expression_list
             (raw_string_literal) @sql (#offset! @sql 0 1 0 -1))))

;; copy from https://github.com/arsham/shark/blob/897683938573de5ceb23b7b985540953d86025e5/after/queries/go/injections.scm
;; vim: fo-=t
