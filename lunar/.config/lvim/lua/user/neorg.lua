local ok_status, neorg = pcall(require, "neorg")
if ok_status then
  return
end

neorg.setup({
  load = {
    ["core.defaults"] = {},
    ["core.dirman"] = {
      config = {
        workspaces = {
          -- work = "~/mynotes/work",
          home = "~/Notes/home",
        }
      }
    }
  }
})
