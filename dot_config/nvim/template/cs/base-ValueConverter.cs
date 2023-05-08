namespace {{_expr_:g:CSNamespace('%')}};

public class {{_expr_:g:CSClassName('%')}} : ValueConverter<{{_expr_:substitute(g:CSClassName('%'), 'Converter$', '', '')}}, int>
{
    public {{_expr_:g:CSClassName('%')}}()
        : base({{_cursor_}}) { }
}
