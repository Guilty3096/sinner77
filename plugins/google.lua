Local function googlethat(query)
  Local api        = "http://ajax.googleapis.com/ajax/services/search/web?v=1.0&"
  Local parameters = "q=".. (URL.escape(query) or "")

  -- Do the request
  Local res, code = https.request(api..parameters)
  If code ~=200 then return nil  end
  Local data = json:decode(res)

  Local results = {}
  For key,result in ipairs(data.responseData.results) do
    Table.insert(results, {
        Result.titleNoFormatting,
        Result.unescapedUrl or result.url
      })
  End
  Return results
End

Local function stringlinks(results)
  Local stringresults=""
  For key,val in ipairs(results) do
    Stringresults=stringresults..val[1].." - "..val[2].."\n"
  End
  Return stringresults
End

Local function run(msg, matches)
  Local results = googlethat(matches[1])
  Return stringlinks(results)
End

Return {
  Description = "Searches Google and send results",
  Usage = "scr [terms]: Searches Google and send results",
  Patterns = {
    "^[Ss]cr (.*)$",
    "^%.[S|s]cr (.*)$"
  },
  Run = run
}
