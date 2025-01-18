surface.CreateFont( "CWorkshopAddonTitle", {
	font = "Arial",
	extended = false,
	size = 14,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

surface.CreateFont( "CWorkshopSettingsTitle", {
	font = "Arial",
	extended = false,
	size = 20,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
})

function CreateCWorkshopGui()
    local Root = vgui.Create("DFrame")
    Root:SetSize(ScreenScale(150), ScreenScale(200))
    Root:Center()
    Root:MakePopup()
    Root:SetTitle("CWorkshop - Dynamic Workshop Loader")

    local Sheet = vgui.Create("DPropertySheet", Root)
    Sheet:Dock(FILL)

    local InformationPanel = vgui.Create("DPanel", Sheet)
    local InformationHTML = vgui.Create("HTML", InformationPanel)
    InformationHTML:Dock(FILL)
    InformationHTML:OpenURL("https://cirroskais.github.io/cworkshop-html/information.html?"..math.random(9999999,1111111))
    Sheet:AddSheet("Information", InformationPanel, "icon16/information.png")

    local AddonsPanel = vgui.Create("DPanel", Sheet)
    local DownloadAllButton = vgui.Create("DButton", AddonsPanel)
    DownloadAllButton:Dock(BOTTOM)
    DownloadAllButton:SetSize(0, 30)
    DownloadAllButton:SetText("Download All Addons")
    DownloadAllButton:SetConsoleCommand("cworkshop_downloadall")
    local AddonsScrollPanel = vgui.Create("DScrollPanel", AddonsPanel)
    AddonsScrollPanel:Dock(LEFT)
    AddonsScrollPanel:SetSize(ScreenScale(141.5), 0)
    steamworks.FileInfo(CWorkshop.Collection, function(data) 
        if not data then return error("[CWorkshop] Failed to fetch collection information!") end
        for i,v in pairs(data.children) do
            steamworks.FileInfo(v, function(child) 
                local AddonFrame = vgui.Create("DPanel", AddonsScrollPanel)
                AddonFrame:Dock(TOP)
                AddonFrame:SetSize(0, 85)

                local AddonImage = vgui.Create("HTML", AddonFrame)
                AddonImage:OpenURL(child.previewurl)
                AddonImage:SetSize(85, 85)

                local AddonTitle = vgui.Create("DLabel", AddonFrame)
                AddonTitle:SetFont("CWorkshopAddonTitle")
                AddonTitle:SetText(child.title)
                AddonTitle:SizeToContents()
                AddonTitle:SetPos(90, 18)
                AddonTitle:SetTextColor(Color(0, 0, 0))
                
                steamworks.RequestPlayerInfo(child.owner, function(author)
                    local AddonAuthor = vgui.Create("DLabel", AddonFrame)
                    AddonAuthor:SetText(author)
                    AddonAuthor:SizeToContents()
                    AddonAuthor:SetPos(90, 35)
                    AddonAuthor:SetTextColor(Color(128, 128, 128))
                end)

                local AddonDownload = vgui.Create("DButton", AddonFrame)
                AddonDownload:SetIcon("icon16/add.png")
                AddonDownload:SetText("Download")
                AddonDownload:SetPos(90, 50)
                AddonDownload:SetSize(100, 20)
                AddonDownload:SetConsoleCommand("cworkshop_download", child.id)
            end)
        end
    end)
    Sheet:AddSheet("Addons", AddonsPanel, "icon16/package.png")

    local SettingsPanel = vgui.Create("DPanel", Sheet)
    local ReloadButtonsTitle = vgui.Create("DLabel", SettingsPanel)
    ReloadButtonsTitle:SetFont("CWorkshopSettingsTitle")
    ReloadButtonsTitle:SetText("Reload Resources")
    ReloadButtonsTitle:SizeToContents()
    ReloadButtonsTitle:SetPos(5, 5)
    ReloadButtonsTitle:SetTextColor(Color(0, 0, 0))
    local ReloadSpawnmenuButton = vgui.Create("DButton", SettingsPanel)
    ReloadSpawnmenuButton:SetPos(5, 30)
    ReloadSpawnmenuButton:SetSize(200, 25)
    ReloadSpawnmenuButton:SetText("Reload Spawnmenu")
    ReloadSpawnmenuButton:SetConsoleCommand("spawnmenu_reload")
    local ReloadEffectsButton = vgui.Create("DButton", SettingsPanel)
    ReloadEffectsButton:SetPos(5, 60)
    ReloadEffectsButton:SetSize(200, 25)
    ReloadEffectsButton:SetText("Reload Effects")
    ReloadEffectsButton:SetConsoleCommand("effects_reload")
    local ReloadLanguageButton = vgui.Create("DButton", SettingsPanel)
    ReloadLanguageButton:SetPos(5, 90)
    ReloadLanguageButton:SetSize(200, 25)
    ReloadLanguageButton:SetText("Reload Translations")
    ReloadLanguageButton:SetConsoleCommand("language_reload")
    local ReloadMaterialButton = vgui.Create("DButton", SettingsPanel)
    ReloadMaterialButton:SetPos(5, 120)
    ReloadMaterialButton:SetSize(200, 25)
    ReloadMaterialButton:SetText("Reload Material")
    ReloadMaterialButton:SetConsoleCommand("mat_reloadmaterial 1")
    ReloadMaterialButton:SetTooltip("I'm not entirely sure this does anything that could help you.\nI've given you the option anyways.")
    Sheet:AddSheet("Settings", SettingsPanel, "icon16/cog.png")
end