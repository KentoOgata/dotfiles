namespace {{_expr_:dotnet#namespace('%')}};

file class {{_expr_:dotnet#classname('%')}} : IEntityTypeConfiguration<{{_expr_:dotnet#EntityFramework#entityname('%')}}>
{
    public void Configure(EntityTypeBuilder<{{_expr_:dotnet#EntityFramework#entityname('%')}}> builder)
    {
        {{_cursor_}}
    }
}
