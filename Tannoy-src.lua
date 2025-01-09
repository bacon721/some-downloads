--hi 2
local s = script.Parent.Parent.Config:FindFirstChild("TannoyManager")
s.Parent = game.StarterPlayer.StarterPlayerScripts
s.Enabled = true
task.wait(0.2,2)
local folder = script.Parent
local conf = folder.Parent:WaitForChild("Config",10)





function SE(msg,DS)
	local XE,SS,RR = nil,nil,nil
	RR = msg
	XE = DS
	SS = {}
	if XE == "err" then
		SS[1] = 5
		SS[2] = true
	elseif XE == "warn" then
		SS[1] = 2
		SS[2] = false
	end
	for x=1,SS[1] do
		warn(RR)
		print(RR)
	end
	while SS[2] == true do

	end
end

if(conf==nil)then SE("easyTannoy Build 2 :: Config not found.","err")return;end
local loaded_conf = require(conf)
if(loaded_conf["Running"]~=nil)then SE("easyTannoy Build 2 :: Another instance was found running, this instance will not work.","warn")end
loaded_conf.Setup()
loaded_conf["Running"] = true
loaded=true
task.wait(0.2)
function wh(plr)
	local all = false
	for id,min in pairs(loaded_conf.Whitelist) do
		if plr:GetRankInGroup(id) >= min then
			all = true
		end
	end
	return all
end
local event = game.ReplicatedStorage:WaitForChild("Tannoy_Interaction")::RemoteFunction
if loaded then
	print("easyTannoy 2 :: Loaded.")
	event.OnServerInvoke = function(plr,info)
		print("FIRED")
		print(plr.Name)
		if info["Type"] == "GetDevices" then
			local devices = {}
			for k,l in pairs(folder:GetChildren()) do
				if l.ClassName == "Model" then
					table.insert(devices,l)
				end
			end
			return devices
		end
		
		if info["Type"] == "PlaySound" then
			if wh(plr) == true then
				print("Playing sound: " .. info["SoundButton"].Name)
				local sound_button = info["SoundButton"] :: TextButton
				local SoundId = sound_button:GetAttribute("SoundId")
				local Volume = sound_button:GetAttribute("Volume")
				local Pitch = sound_button:GetAttribute("Pitch")
				local Looped = sound_button:GetAttribute("Looped")
				local Ding = sound_button:GetAttribute("Ding")
				local Ding_ = info["Tannoy"].Ding :: Sound
				local sound = info["Tannoy"].Playback :: Sound
				
				local function play()
					sound.SoundId = SoundId
					sound.Volume = Volume
					sound.PlaybackSpeed = Pitch
					sound.Looped = Looped
					sound:Play()
				end
				
				if Ding == true then
					Ding_:Play()
					Ding_.Ended:Wait()
					play()
				else
					play()
				end
			end
		end
		
		if info["Type"] == "Login" then
			if wh(plr) == true and info["Tannoy"]:GetAttribute("USER_LOGGED_IN") == false then
				info["Tannoy"]:SetAttribute("USER_LOGGED_IN",true)
				info["Tannoy"].Screen.Main.Display.SurfaceGui.Login.Visible = false
				info["Tannoy"].Screen.Main.Display.SurfaceGui.Main.Visible = true
			end
		end
		
		if info["Type"] == "Logout" then
			if wh(plr) == true and info["Tannoy"]:GetAttribute("USER_LOGGED_IN") == true then
				info["Tannoy"]:SetAttribute("USER_LOGGED_IN",false)
				info["Tannoy"].Screen.Main.Display.SurfaceGui.Login.Visible = true
				info["Tannoy"].Screen.Main.Display.SurfaceGui.Main.Visible = false
			end
		end
		
		if info["Type"] == "StopAllSounds" then
			if wh(plr) == true then
				info["Tannoy"].Ding:Stop()
				info["Tannoy"].Playback:Stop()
			end
		end
	end
	
	for _,tannoy in pairs(script.Parent:GetChildren()) do
		if tannoy.Name == "Tannoy" then
			
			local audio = loaded_conf.Audio
			for name,information in pairs(audio) do
				local Clone = tannoy.Screen.Main.Display.SurfaceGui.Main.Sounds.Buttons.Scroller.Template:Clone() :: TextButton
				Clone.Visible = true
				Clone.Parent = tannoy.Screen.Main.Display.SurfaceGui.Main.Sounds.Buttons.Scroller
				Clone.Name = name
				Clone.Text = name
				Clone:SetAttribute("SoundId",information["AudioId"])
				Clone:SetAttribute("Volume",information["Volume"])
				Clone:SetAttribute("Pitch",information["Pitch"])
				Clone:SetAttribute("Looped",information["Looped"])
				Clone:SetAttribute("Ding",information["Ding"])
			end
		end
	end
end
