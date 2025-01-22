
function _tide_item_jj
  if not command -sq jj; or not jj root --quiet &>/dev/null
      return 1
  end

  set jj_template '
  separate(" ",
    coalesce(
      bookmarks.map(|x| if(
        x.name().substr(0, 20).starts_with(x.name()),
        x.name().substr(0, 20),
        x.name().substr(0, 19) ++ "…")
      ).join(" "),
      surround("\"","\"",
        if(
          description.first_line().substr(0, 24).starts_with(description.first_line()),
          description.first_line().substr(0, 24),
          description.first_line().substr(0, 23) ++ "…"
        )
      ),
    ),
    if(conflict, "conflict"),
    if(divergent, "divergent"),
    if(hidden, "hidden"),
  )'

  set jj_status (jj log -r @ -n1 --ignore-working-copy --no-graph --color always -T "$jj_template")

  set jj_parent_status (jj log -r @- -n1 --ignore-working-copy --no-graph --color always -T "$jj_template")
  _tide_print_item jj $tide_jj_icon' ' "(@$jj_status <- $jj_parent_status)"
end
