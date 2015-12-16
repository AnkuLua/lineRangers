-- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
setImmersiveMode(true)
Settings:set("MinSimilarity", 0.9)
-- ==========  main program ===========
upperRight = Region(640, 0, 640, 350)
low = Region(0, 580, 1280, 140)
nextRegion = Region(440, 580, 485, 130)

friend = Location(75, 75)
fire = Location(150, 75)
diamond = Location(1080, 700)
member5 = Location(910, 700)
member4 = Location(780, 700)
member3 = Location(640, 700)
member2 = Location(515, 700)
member1 = Location(370, 700)
missile = Location(200, 700)
thomson = Location(640, 190)

if (exists("mainStage.en.png",0)) then
    lang = ".en.png"
elseif (exists("mainStage.zh.png", 0)) then
    lang = ".zh.png"
else
    dialogInit()
    addTextView("The script now support English and traditional Chinese only.")
    newRow()
    addTextView("Swtich the Line Rangers language to either and start again.")
    dialogShow("Please switch language to English and start the script again")
end

nextBtn = "next" .. lang
stopBtn = "stop" .. lang
okBtn = "ok" .. lang
bigOkBtn = "bigOK" .. lang
acquiredBtn = "acquired" .. lang


while (true) do

    num = 1

    wait(Pattern("newStage.png"):similar(0.7),15)
    wait(5)
    if (not existsClick(Pattern("newStage.png"):similar(0.9))) then
        existsClick("newBossStage.png")
    end

--    if (not existsClick("bossStage.png")) then
--        click("newStage.png")
--    end

    if (not exists(nextBtn,5)) then -- cutscenes
    toast("cutscenes")
    click(member3)
    end

    nextRegion:waitClick(nextBtn, 5)
    nextRegion:waitClick(Pattern("feather.png"):similar(0.6), 6)


    click(diamond)
    wait(1)
    click(friend)

    click(diamond)
    wait(1)
    click(diamond)
    wait(1)

    while(true) do
        click(diamond)
        click(member5)
        click(member4)
        click(member3)
        click(member2)
        click(member1)
        click(missile)
        click(thomson)
        if (num == 3) then
            --            click(fire)
        end
        num = num + 1
        if (exists(Pattern("resultDim.png"):similar(0.80),0)) then
            wait(1)
            if (exists(Pattern("resultDim.png"):similar(0.80),0)) then break end
        end
    end

    Settings:set("MinSimilarity", 0.7)

--    upperRight:wait(Pattern("pause.png"):similar(0.6), 10)
--    wait(2)
--    click(auto) --click("auto.png")
--    wait(2)
--    longClick(auto, 0.8) --click(getLastMatch())

--    waitClick("win.png", 60*30)
--    if (not exists(stopBtn, 3)) then click(nextRegion) end

    for i = 1, 15 do
        if (exists(stopBtn, 2)) then break end
--        toast("stopBtn not found " .. i)
        existsClick(acquiredBtn, 0)
        existsClick(bigOkBtn, 0)
        existsClick(okBtn, 0)
--        if (not existsClick(acquiredBtn, 0)) then
--        elseif (not existsClick(bigOkBtn, 0)) then
--            existsClick(okBtn, 0)
--        end
    end

    waitClick(stopBtn, 5)
    waitClick(okBtn, 5)


    if (stageNum == 192 or stageNum == 324) then --exists("watchVideo.png", 3)) then
    wait(2)
    existsClick(Pattern("skip.png"):similar(0.9), 10) --click(skip)
    end

--    wait(Pattern(stagePic):similar(0.7),15)

end