function featherNum()
--    Settings:set("MinSimilarity", 0.7)
    local feather = find("feather.png")
    local backslash = find("featherBackslash.png")
    local numRegion = Region(feather:getX() + feather:getW(),
        feather:getY(), backslash:getX() - (feather:getX() + feather:getW()), feather:getH())
    numRegion:highlight(1)
--    Settings:set("MinSimilarity", 0.9)
    return(numberOCR(numRegion, "feather"))

end

-- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
setImmersiveMode(true)
--Settings:set("MinSimilarity", 0.9)
-- ==========  main program ===========
upperRight = Region(640, 0, 640, 350)
battleRegion = Region(780, 520, 500, 200)
nextRegion = Region(440, 580, 485, 130)
low = Region(0, 580, 1280, 140)
member3 = Location(640, 700)
auto = Location(1225, 210)
skip = Location(1170, 635)

if (exists("battle.en.png",0)) then
    lang = ".en.png"
elseif (exists("battle.zh.png", 0)) then
    lang = ".zh.png"
else
    dialogInit()
    addTextView("The script now support English and traditional Chinese only.")
    newRow()
    addTextView("Swtich the Line Rangers language to either and start again.")
    dialogShow("Please switch language to English and start the script again")
end

battleBtn = "battle" .. lang
nextBtn = "next" .. lang
stopBtn = "stop" .. lang
okBtn = "ok" .. lang


while (true) do
    battleRegion:waitClick(battleBtn, 15)

    while (true) do
        feaNum = featherNum()
        if ( feaNum == 0) then
            toast("No feather, wait 5 minutes")
            wait(5*60)

        else
            toast(feaNum.." feathers")
            break
        end
    end

    nextRegion:waitClick(nextBtn, 5)
    nextRegion:waitClick("specialFeather.png", 6)

    upperRight:wait(Pattern("pause.png"):similar(0.8), 30)
    wait(1)
    click(auto) --click("auto.png")
    wait(2)
    longClick(auto, 0.8) --click(getLastMatch())

    wait(Pattern("result.png"):similar(0.8), 60*60) -- longest is 60 minutes, change it if your rangers are stronger
    wait(1)
    click(getLastMatch())
    getLastMatch():highlight(1)

    waitClick(stopBtn, 30)
    waitClick(okBtn, 30)

--    while(exists("reward.png", 5)) do
--        nextRegion:waitClick("button.png", 5)
--        wait(1)
--    end

    wait("feather.png", 30)

end
