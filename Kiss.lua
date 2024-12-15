--[[
Copyright (c) 2013, Registry
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of autoinvite nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Registry BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE. 
]]

_addon.name = 'Kiss'
_addon.author = 'Cliff'
_addon.version = '1.0.0'
_addon.commands = {'kiss'}

require('logger')

local enabled = false
local lastCheck = os.clock()

local WS_NAME = "TP吸収キッス"

windower.register_event('addon command', function(command, ...)
    if command =="start" then
        enabled = true
		log('Kiss start')
    elseif command =="stop" then
        enabled = false
		log('Kiss stopped')
    end
end)

windower.register_event('prerender', function(...)
	if not enabled then return end
	
	if os.clock() - lastCheck > 0.5 then
		if windower.ffxi.get_ability_recasts()[72] == 0 then --ほんきだせ
			 windower.send_command(windower.to_shift_jis('input /pet "'..WS_NAME..'" <bt>'))
		end
		lastCheck = os.clock()
	end
end)

windower.register_event('chat message', function(message, player, mode, is_gm)
    if message:lower():match('kiss him':lower()) then
		enabled = true
		log('Kiss start')
		windower.send_command("wait 1; input /t "..player.." Let's do it.")
		
	elseif message:lower():match('stop':lower()) then
		enabled = false
		log('Kiss stopped')
		windower.send_command("wait 1; input /t "..player.." bye")
	end
end)

windower.register_event('load', function()
	log('========= Kiss loaded =========')
end)

windower.register_event('unload', function()
	log('========= Kiss unloaded =========')
end)