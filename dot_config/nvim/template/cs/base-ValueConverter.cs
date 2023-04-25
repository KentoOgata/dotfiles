namespace {{_expr_:dotnet#namespace('%')}};

public class {{_expr_:dotnet#classname('%')}} : ValueConverter<{{_expr_:substitute(dotnet#classname('%'), 'Converter$', '', '')}}, int>
{
    public {{_expr_:dotnet#classname('%')}}()
        : base({{_cursor_}}) { }
}
