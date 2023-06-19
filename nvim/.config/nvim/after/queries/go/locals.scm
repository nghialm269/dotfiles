;; extends

(var_spec) @scope

(field_declaration
  name: (field_identifier) @definition.field)

(method_declaration
  name: (field_identifier) @method.name
  parameters: (parameter_list) @method.parameter_list) @interface.method.declaration

(type_declaration
  (type_spec
    name: (type_identifier) @name
    type: [(struct_type) (interface_type)] @type)) @start

;; copy from https://github.com/arsham/shark/blob/897683938573de5ceb23b7b985540953d86025e5/after/queries/go/locals.scm
;; vim: fo-=t
