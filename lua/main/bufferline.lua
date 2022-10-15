local bufferline_status_ok, bufferline = pcall(require, "bufferline")
if not bufferline_status_ok then
    return
end

local config = {
    options = {
        numbers = "none",
    }
}

bufferline.setup(config)
