function findStage(snum)
    Settings:set("MinSimilarity", 0.7)

    local allStage = findAll(stagePic)

    for i, r in ipairs(allStage) do
        r:highlight()
    end

    wait(2)
    for i, r in ipairs(allStage) do
        r:highlight()
    end

    local found = false
    local stage
    for i, r in ipairs(allStage) do
        local num = numberOCR(r, "num")
        if (num == snum) then
            found = true
            stage = r;
        end
    end
    Settings:set("MinSimilarity", 0.9)

    if (not found) then
        return nil
    end

    stage:highlight(1)
    return stage

end

function featherNum()
    Settings:set("MinSimilarity", 0.7)
    local feather = find("feather.png")
    local backslash = find("featherBackslash.png")
    local numRegion = Region(feather:getX() + feather:getW(),
        feather:getY(), backslash:getX() - (feather:getX() + feather:getW()), feather:getH())
    numRegion:highlight(1)
    return(numberOCR(numRegion, "feather"))
end

function waitButton(second)
    local low = Region(0, 580, 1280, 140)
    wait(1)
    low:waitClick("button.png", second)
    wait(1)

end
-- ========== Settings ================
Settings:setCompareDimension(true, 1280)
Settings:setScriptDimension(true, 1280)
setImmersiveMode(true)
Settings:set("MinSimilarity", 0.9)
-- ==========  main program ===========
upperRight = Region(640, 0, 640, 350)
low = Region(0, 580, 1280, 140)
nextRegion = Region(440, 580, 485, 130)

--friend = Location(75, 75)
--fire = Location(150, 75)
--diamond = Location(1080, 700)
--member5 = Location(910, 700)
--member4 = Location(780, 700)
member3 = Location(640, 700)
--member2 = Location(515, 700)
--member1 = Location(370, 700)
--missile = Location(200, 700)
--touchScreen = Location(640, 400)
auto = Location(1217, 175)
skip = Location(1170, 635)
centerBtn = Location(640, 650)

--highlight = {Region(230, 300, 100, 90), Region(600, 300, 100, 90), Region(1100, 300, 100, 90) }

if (exists("mainStage.en.png",0)) then
    lang = ".en.png"
elseif (exists("mainStage.zh.png", 0)) then
    lang = ".zh.png"
else
    dialogInit()
    addTextView("The script now supports English and traditional Chinese only.")
    newRow()
    addTextView("Swtich the Line Rangers language to either one and start again.")
    dialogShow("Please switch language to English and start the script again")
end

nextBtn = "next" .. lang
stopBtn = "stop" .. lang
okBtn = "ok" .. lang
bigOkBtn = "bigOK" .. lang
acquiredBtn = "acquired" .. lang


dialogInit()
addCheckBox("bossStage", "Boss Stage", false)
newRow()
addTextView("Choose the stage to farm on: ")
addEditText("num", "1")
dialogShow("Choose the stage")

stageNum = tonumber(num)
if (stageNum >= 325) then
    stagePic = "s3stage.png"
--    nextPic = "s2Next.png"
--    startPic = "s2Start.png"
elseif (stageNum >= 193) then
    stagePic = "s2Stage.png"
--    nextPic = "s2Next.png"
--    startPic = "s2Start.png"
elseif (stageNum >= 100) then
    stagePic = "s1Stage.png"
else
    stagePic = "stage1.png"
--    nextPic = "s1Next.png"
--    startPic = "s1Start.png"
end



while (true) do

    num = 1


    if (bossStage) then
        stage = find(Pattern("bossStage.png"):similar(0.75))
    else
        stage = findStage(stageNum)
        if (stage == nil) then
            print("Can't find the chosen stage")
            do return end
        end
    end


--    if (exists(Pattern("featherZero.png"):similar(0.95))) then
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

    stage:highlight(1)
    click(stage)
    waitVanish(Pattern(stagePic):similar(0.7),5)


    Settings:set("MinSimilarity", 0.8)

    if (not exists(nextBtn,3)) then -- cutscenes
        toast("cutscenes")
        click(member3)
    end

    nextRegion:waitClick(nextBtn, 5)
    nextRegion:waitClick(Pattern("feather.png"):similar(0.6), 6)


    Settings:set("MinSimilarity", 0.8)

    upperRight:wait(Pattern("pause.png"):similar(0.7), 15)
    wait(2)
    click(auto) --click("auto.png")
    wait(2)
    longClick(auto, 0.8) --click(getLastMatch())

    waitClick("win.png", 60*30)

--    if (not exists(stopBtn, 10)) then
--        toast("Click next region")
----        nextRegion:highlight(2)
--        existsClick(acquiredBtn, 0)
--        existsClick(bigOkBtn, 0)
--    end

    for i = 1, 15 do
        if (exists(stopBtn, 2)) then break end
        existsClick(acquiredBtn, 0)
        existsClick(bigOkBtn, 0)
        existsClick(okBtn, 0)
    end

    waitClick(stopBtn, 5)
    waitClick(okBtn, 5)


    if (stageNum == 192 or stageNum == 324) then --exists("watchVideo.png", 3)) then
        wait(2)
       existsClick(Pattern("skip.png"):similar(0.9), 10) --click(skip)
    end

    wait(Pattern(stagePic):similar(0.7),15)
--    wait(2)

end