
-- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
setImmersiveMode(true)
Settings:set("MinSimilarity", 0.9)
-- ==========  main program ===========
upperRight = Region(640, 0, 640, 350)
low = Region(0, 580, 1280, 140)
item = Location(110, 620)

for i = 1, 50 do
    longClick(item, 0.8)
    waitClick("sell.png")
    waitClick("bigSell.png")
    waitClick("sellOk.png", 15)
    wait(2)
    toast((i .. " items sold"))
end

do return end

