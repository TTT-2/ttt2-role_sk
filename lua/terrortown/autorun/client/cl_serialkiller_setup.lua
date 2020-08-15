hook.Add("Initialize", "ttt2_role_sk_setup_client", function()
	STATUS:RegisterStatus("ttt2_sk_refill_knife", {
		hud = Material("vgui/ttt/hud_icon_sk_knife.png"),
		type = "bad"
	})
end)
