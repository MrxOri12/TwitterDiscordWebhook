local webhookURL = GetConvar('xoritwt:webhookURL', 'ADD HERE WEBHOOK')
local charLimit = GetConvarInt('xoritwt:charLimit', 280)


RegisterCommand("xori", function(source, args, rawCommand) -- Here If You Want Change Twt Command Now is /xori Text (Replace xori To Own Command(
    name = (source == 0) and 'console' or GetPlayerName(source)

    xori = table.concat(args, " ")


    if (xori == "") then
        errorMessage("אתה לא יכול לפרסם ציוץ ריק", source)
    elseif (xori:len() >= charLimit) then
        errorMessage("יותר מדי אותיות " .. charLimit, source)
    else
        announcexori(name, xori)
        postDiscordWebhook(name, xori)
    end

end, false)

function errorMessage(message, id)
    TriggerClientEvent('chatMessage', id, "^8" .. message)
end

function announcexori(name, xori)
    TriggerClientEvent('chatMessage', -1, "^0[^4Twitter^0]", {30, 144, 255}, "^3@" .. name .."^0 " .. xori)
end

function postDiscordWebhook(name, xori)
    if webhookURL ~= "nil" then
            PerformHttpRequest(webhookURL, function(statusCode, text, headers)
                --print(statusCode)
            end, 'POST', json.encode({ content = xori, username = name}), { ["Content-Type"] = 'application/json' })
    end
end
