task.wait(2) -- Removing this line could break the script due to Roblox being bad
local event = game.ReplicatedStorage:WaitForChild("Tannoy_Interaction") :: RemoteFunction
local Devices = event:InvokeServer({Type = "GetDevices"})

for _,Device:Model in pairs(Devices) do
	local UI = Device.Screen.Main.Display.SurfaceGui
	local Main = UI.Main
	local Login = UI.Login
	local Buttons_Actions = Main.Buttons
	local Sounds = Main.Sounds.Buttons.Scroller
	local LoginBtn = Login.Frame.Login
	local LogoutBtn = Main.Buttons.Logout
	local StopAllBtn = Main.Buttons.Stop
	
	for _,button in pairs(Sounds:GetChildren()) do
		if button:IsA("TextButton") then
			button.MouseButton1Click:Connect(function()
				event:InvokeServer({
					Type = "PlaySound",
					SoundButton = button,
					Tannoy = Device
				})
			end)
			button.TouchTap:Connect(function()
				event:InvokeServer({
					Type = "PlaySound",
					SoundButton = button,
					Tannoy = Device
				})
			end)
		end
	end
	
	LoginBtn.MouseButton1Click:Connect(function()
		event:InvokeServer({
			Type = "Login",
			Tannoy = Device
		})
	end)
	LoginBtn.TouchTap:Connect(function()
		event:InvokeServer({
			Type = "Login",
			Tannoy = Device
		})
	end)
	
	LogoutBtn.MouseButton1Click:Connect(function()
		event:InvokeServer({
			Type = "Logout",
			Tannoy = Device
		})
	end)
	LogoutBtn.TouchTap:Connect(function()
		event:InvokeServer({
			Type = "Logout",
			Tannoy = Device
		})
	end)
	
	StopAllBtn.MouseButton1Click:Connect(function()
		event:InvokeServer({
			Type = "StopAllSounds",
			Tannoy = Device
		})
	end)
	StopAllBtn.TouchTap:Connect(function()
		event:InvokeServer({
			Type = "StopAllSounds",
			Tannoy = Device
		})
	end)
	
end
