local M = {}

function M.add(repos)
  local pkgs = {}
  for _, repo in ipairs(repos) do
    if type(repo) == "string" then
      table.insert(pkgs, { src = "https://github.com/" .. repo })
    else
      repo.src = "https://github.com/" .. repo[1]
      repo[1] = nil
      table.insert(pkgs, repo)
    end
  end
  return pkgs
end

return M
