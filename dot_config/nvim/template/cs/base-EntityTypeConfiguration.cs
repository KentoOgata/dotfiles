namespace {{_expr_:g:CSNamespace('%')}};

file class {{_expr_:g:CSClassName('%')}} : IEntityTypeConfiguration<{{_expr_:g:CSEntityName('%')}}>
{
    public void Configure(EntityTypeBuilder<{{_expr_:g:CSEntityName('%')}}> builder)
    {
        {{_cursor_}}
    }
}
