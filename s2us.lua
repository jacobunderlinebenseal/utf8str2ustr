local function s2us(convertStr)
    if type(convertStr)~="string" then
        return convertStr
    end

    local resultStr=""
    local i=1
    local num1=string.byte(convertStr,i)

    while num1~=nil do
        local tempVar1,tempVar2
        if num1 >= 0x00 and num1 <= 0x7f then
            tempVar1=num1
            tempVar2=0
        elseif num1 >= 0xc0 and num1 <= 0xdf then
            local t1 = 0
            local t2 = 0
            t1 = math.fmod(num1,0x20)
            i=i+1
            num1=string.byte(convertStr,i)
            t2 = math.fmod(num1,0x40)
            tempVar1=t2+64*math.fmod(t1,0x04)
            tempVar2=math.floor(t1/4)
        elseif num1 >= 0xe0 and num1 <= 0xf7 then
            local t1 = 0
            local t2 = 0
            local t3 = 0
            t1 = math.fmod(num1,0x10)
            i=i+1
            num1=string.byte(convertStr,i)
            t2 = math.fmod(num1,0x40)
            i=i+1
            num1=string.byte(convertStr,i)
            t3 = math.fmod(num1,0x40)
            tempVar1=math.fmod(t2,0x04)*64+t3
            tempVar2=t1*16+math.floor(t2/4)
        else
            tempVar2=0x00
            tempVar1=0x20
        end
        resultStr=resultStr..string.format("\\u%02x%02x",tempVar2,tempVar1)
        i=i+1
        num1=string.byte(convertStr,i)
    end

    return resultStr
end
