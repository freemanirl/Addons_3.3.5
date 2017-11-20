--The Options Page functions
--Note: most of this code could be written much cleaner, nicer, and better...
--But this is for an option page that is only loaded some of the time, so if
--its not broken, I'm not worrying about fixing it! =)

local tinsert = function(t,v)
  t[#t+1] = v
end
local pairs = pairs


SCT.OptionFrames = { ["SCTOptionsFrame_Misc21"] = "SCTOptions_EventsFrame",
                     ["SCTOptionsFrame_Misc18"] = "SCTOptions_FramesFrame",
                     ["SCTOptionsFrame_Misc19"] = "SCTOptions_SpellFrame",
                     ["SCTOptionsFrame_Misc16"] = "SCTOptions_AnimationFrame",
                     ["SCTOptionsFrame_Misc10"] = "SCTOptions_SaveLoadFrame"}

SCT.OptionFrameFrames = { ["SCTOptionsFrame_Misc14"] = {frame="SCTOptions_TextFrame", example="SCTaniExampleData1"},
                          ["SCTOptionsFrame_Misc20"] = {frame="SCTOptions_TextFrame", example="SCTaniExampleData2"},
                          ["SCTOptionsFrame_Misc15"] = {frame="SCTOptions_MessageFrame", example="SCTMsgExample1"}}


------------------------------
--Copy table to table
--Taken from AceDB-3.0
local function copyTable(src, dest)
  if not type(dest) == "table" then dest = {} end
  for k,v in pairs(src) do
    if type(v) == "table" then
      -- try to index the key first so that the metatable creates the defaults, if set, and use that table
      v = copyTable(v, dest[k])
    end
    dest[k] = v
  end
  return dest
end

----------------------
--Called when option page loads
function SCT:OptionsFrame_OnShow()
  local option1, option2, option3, option4, option5, string, getvalue
  --Misc Options
  for key, value in pairs(SCT.OPTIONS.FrameMisc) do
    string = getglobal("SCTOptionsFrame_Misc"..value.index)
    if (string) then
      string:SetText(key)
      if (value.tooltipText) then
        string.tooltipText = value.tooltipText
      end
    end
  end

  local frame, swatch, sColor
  -- Set Options values
  for key, value in pairs(SCT.OPTIONS.FrameEventFrames) do
    option1 = getglobal("SCTOptionsFrame"..value.index.."_CheckButton")
    option2 = getglobal("SCTOptionsFrame"..value.index.."_CritCheckButton")
    option3 = getglobal("SCTOptionsFrame"..value.index.."_RadioMsgButton")
    option4 = getglobal("SCTOptionsFrame"..value.index.."_RadioFrame1Button")
    option5 = getglobal("SCTOptionsFrame"..value.index.."_RadioFrame2Button")
    string = getglobal("SCTOptionsFrame"..value.index.."_CheckButtonText")

    --main check
    option1.SCTVar = value.SCTVar
    option1:SetChecked(self.db.profile[value.SCTVar])
    option1.tooltipText = value.tooltipText
    string:SetText(key)

    --crit check
    option2.SCTVar = value.SCTVar
    option2:SetChecked(self.db.profile[self.CRITS_TABLE][value.SCTVar])
    option2.tooltipText = SCT.LOCALS.Option_Crit_Tip

    --radios
    option3.tooltipText = SCT.LOCALS.Option_Msg_Tip
    option4.tooltipText = SCT.LOCALS.Frame1_Tip
    option5.tooltipText = SCT.LOCALS.Frame2_Tip
    self:OptionsRadioButtonOnClick(self.db.profile[self.FRAMES_TABLE][value.SCTVar],"SCTOptionsFrame"..value.index)
    --set vars after setting up radios, so no redundant saving.
    option3.SCTVar = value.SCTVar
    option4.SCTVar = value.SCTVar
    option5.SCTVar = value.SCTVar

    --Color Swatch
    frame = getglobal("SCTOptionsFrame"..value.index)
    swatch = getglobal("SCTOptionsFrame"..value.index.."_ColorSwatchNormalTexture")
    sColor = self.db.profile[self.COLORS_TABLE][value.SCTVar]
    frame.r = sColor.r
    frame.g = sColor.g
    frame.b = sColor.b
    local k = value.SCTVar
    local s = swatch:GetName()
    local f = frame:GetName()
    local t = self.COLORS_TABLE
    frame.swatchFunc = function() self:OptionsFrame_SetColor(f, s, k, t) end
    frame.cancelFunc = function(x) self:OptionsFrame_CancelColor(f, s, k, t, x) end
    swatch:SetVertexColor(sColor.r,sColor.g,sColor.b)
  end

  -- Set CheckButton states
  for key, value in pairs(SCT.OPTIONS.FrameCheckButtons) do
    option1 = getglobal("SCTOptionsFrame_CheckButton"..value.index)
    string = getglobal("SCTOptionsFrame_CheckButton"..value.index.."Text")
    if option1 and string then
      option1.SCTVar = value.SCTVar
      option1.SCTTable = value.SCTTable
      if (option1.SCTTable) then
        option1:SetChecked(self.db.profile[SCT.FRAMES_DATA_TABLE][option1.SCTTable][value.SCTVar])
      else
        option1:SetChecked(self.db.profile[value.SCTVar])
      end
      option1.tooltipText = value.tooltipText
      string:SetText(key)
    end
  end

  --Set Sliders
  for key, value in pairs(SCT.OPTIONS.FrameSliders) do
    option1 = getglobal("SCTOptionsFrame_Slider"..value.index.."Slider")
    string = getglobal("SCTOptionsFrame_Slider"..value.index.."SliderText")
    option2 = getglobal("SCTOptionsFrame_Slider"..value.index.."SliderLow")
    option3 = getglobal("SCTOptionsFrame_Slider"..value.index.."SliderHigh")
    option4 = getglobal("SCTOptionsFrame_Slider"..value.index.."EditBox")
    option1.SCTVar = value.SCTVar
    option1.SCTTable = value.SCTTable
    if (option1.SCTTable) then
      getvalue = self.db.profile[SCT.FRAMES_DATA_TABLE][option1.SCTTable][value.SCTVar]
    else
      getvalue = self.db.profile[value.SCTVar] or 0
    end
    option1.SCTLabel = key
    option1:SetScript("OnValueChanged", nil)
    option1:SetMinMaxValues(value.minValue, value.maxValue)
    option1:SetScript("OnValueChanged", function() SCT:OptionsSliderOnValueChanged() end)
    option1:SetValueStep(value.valueStep)
    option1.tooltipText = value.tooltipText
    string:SetText(key)
    option4:SetText(getvalue)
    option2:SetText(value.minText)
    option3:SetText(value.maxText)
    --set value based on type
    if (option4:GetObjectType() == "EditBox") then
      self:OptionsEditBoxOnValueChanged(option4)
    else
      option1:SetValue(getvalue)
    end
  end

  --Dropdowns
  for key, value in pairs(SCT.OPTIONS.FrameSelections) do
    option1 = getglobal("SCTOptionsFrame_Selection"..value.index)
    option2 = getglobal("SCTOptionsFrame_Selection"..value.index.."Label")
    option1.SCTVar = value.SCTVar
    option1.SCTTable = value.SCTTable
    option1.SCTValueSave = value.SCTValueSave
    --lookup table cause of WoW's crappy dropdown UI.
    option1.lookup = value.table
    if (option1.SCTTable) then
      getvalue = self.db.profile[SCT.FRAMES_DATA_TABLE][option1.SCTTable][value.SCTVar]
    elseif value.SCTVar then
      getvalue = self.db.profile[value.SCTVar]
    end
    if (value.SCTValueSave) then
      UIDropDownMenu_SetSelectedValue(option1, getvalue)
      --not sure why I have to do this, but only way to make it show correctly cause of WoW's crappy dropdown UI.
      UIDropDownMenu_SetText(option1, getvalue)
    else
      UIDropDownMenu_SetSelectedID(option1, getvalue)
      --not sure why I have to do this, but only way to make it show correctly cause of WoW's crappy dropdown UI.
      UIDropDownMenu_SetText(option1, value.table[getvalue])
    end
    option1.tooltipText = value.tooltipText
    option2:SetText(key)
  end

  --Custom Dropdowns
  for key, value in pairs(SCT.OPTIONS.FrameCustomSelections) do
    option1 = getglobal("SCTOptionsFrame_CustomSelection"..value.index)
    option2 = getglobal("SCTOptionsFrame_CustomSelection"..value.index.."Label")
    --lookup table cause of WoW's crappy dropdown UI.
    option1.lookup = value.table
    option1.tooltipText = value.tooltipText
    option2:SetText(key)
  end

  --Colors
  for key, value in pairs(SCT.OPTIONS.FrameColors) do
    frame = getglobal("SCTOptionsFrame_Color"..value.index)
    string = getglobal("SCTOptionsFrame_Color"..value.index.."_Label")
    swatch = getglobal("SCTOptionsFrame_Color"..value.index.."NormalTexture")
    sColor = self.db.profile[self.SPELL_COLORS_TABLE][value.SCTVar]
    if sColor then
      frame.r = sColor.r
      frame.g = sColor.g
      frame.b = sColor.b
      swatch:SetVertexColor(sColor.r,sColor.g,sColor.b)
    end
    local k = value.SCTVar
    local s = swatch:GetName()
    local f = frame:GetName()
    local t = self.SPELL_COLORS_TABLE
    frame.swatchFunc = function() self:OptionsFrame_SetColor(f, s, k, t) end
    frame.cancelFunc = function(x) self:OptionsFrame_CancelColor(f, s, k, t, x) end
    string:SetText(key)
  end

  --Edit Boxes
  for key, value in pairs(SCT.OPTIONS.EditBoxes) do
    frame = getglobal("SCTOptionsFrame_EditBox"..value.index.."_EditBox")
    string = getglobal("SCTOptionsFrame_EditBox"..value.index.."_Label")
    if (frame) then
      string:SetText(key)
      if (value.tooltipText) then
        frame.tooltipText = value.tooltipText
      end
    end
  end

  --Class checkboxes
  SCTOptionsFrame_DeathknightText:SetText(SCT.LOCALS.DEATHKNIGHT)
  SCTOptionsFrame_DruidText:SetText(SCT.LOCALS.DRUID)
  SCTOptionsFrame_HunterText:SetText(SCT.LOCALS.HUNTER)
  SCTOptionsFrame_MageText:SetText(SCT.LOCALS.MAGE)
  SCTOptionsFrame_PaladinText:SetText(SCT.LOCALS.PALADIN)
  SCTOptionsFrame_PriestText:SetText(SCT.LOCALS.PRIEST)
  SCTOptionsFrame_RogueText:SetText(SCT.LOCALS.ROGUE)
  SCTOptionsFrame_ShamanText:SetText(SCT.LOCALS.SHAMAN)
  SCTOptionsFrame_WarlockText:SetText(SCT.LOCALS.WARLOCK)
  SCTOptionsFrame_WarriorText:SetText(SCT.LOCALS.WARRIOR)

  --set sticky mode
  self:ChangeStickyMode(SCT.db.profile["STICKYCRIT"])
  --Update Profiles
  self:ScrollBar_Update()
end

----------------------
--Sets the colors of the config from a color swatch
function SCT:OptionsFrame_SetColor(f,s,k,t)
  local r,g,b = ColorPickerFrame:GetColorRGB()
  local color={}
  local swatch = getglobal(s)
  local frame = getglobal(f)
  swatch:SetVertexColor(r,g,b)
  frame.r, frame.g, frame.b = r,g,b
  color.r, color.g, color.b = r,g,b
  --update back to config
  if k then
    self.db.profile[t][k] = color
  end
end

----------------------
-- Cancels the color selection
function SCT:OptionsFrame_CancelColor(f,s,k,t,prev)
  local r,g,b = prev.r, prev.g, prev.b
  local color={}
  local swatch = getglobal(s)
  local frame = getglobal(f)
  swatch:SetVertexColor(r, g, b)
  frame.r, frame.g, frame.b = r,g,b
  color.r, color.g, color.b = r,g,b
  -- Update back to config
  if k then
    self.db.profile[t][k] = color
  end
end

----------------------
--Sets the silder values in the config
function SCT:OptionsSliderOnValueChanged()
  local string, editbox
  string = getglobal(this:GetName().."Text")
  editbox = getglobal(this:GetParent():GetName().."EditBox")
  string:SetText(this.SCTLabel)
  editbox:SetText(this:GetValue())
  if (this.SCTTable) then
    self.db.profile[SCT.FRAMES_DATA_TABLE][this.SCTTable][this.SCTVar] = this:GetValue()
  elseif this.SCTVar then
    self.db.profile[this.SCTVar] = this:GetValue()
  end
  --update Example
  self:ShowExample()
end

----------------------
--Sets the silder values in the config
function SCT:OptionsEditBoxOnValueChanged(obj)
  local slider = getglobal(obj:GetParent():GetName().."Slider")
  local getvalue = tonumber(obj:GetText())
  if (slider.SCTTable) then
    self.db.profile[SCT.FRAMES_DATA_TABLE][slider.SCTTable][slider.SCTVar] = getvalue
  elseif slider.SCTVar then
    self.db.profile[slider.SCTVar] = getvalue
  end
  -- disable update change,set slider,setonchance back
  slider:SetScript("OnValueChanged", nil)
  slider:SetValue(getvalue)
  slider:SetScript("OnValueChanged", function() SCT:OptionsSliderOnValueChanged() end)
  --update Example
  self:ShowExample()
end

----------------------
--Sets the checkbox values in the config
function SCT:OptionsCheckButtonOnClick()
  if (string.find(this:GetName(), "_CritCheckButton")) then
    self.db.profile[self.CRITS_TABLE][this.SCTVar] = this:GetChecked() or false
  else
    if (this.SCTTable) then
      self.db.profile[SCT.FRAMES_DATA_TABLE][this.SCTTable][this.SCTVar] = this:GetChecked() or false
    elseif this.SCTVar then
      self.db.profile[this.SCTVar] = this:GetChecked() or false
    end
  end
  --update Example
  self:ShowExample()
end

----------------------
--Sets the checkbox values in the config
function SCT:OptionsRadioButtonOnClick(id,parent)
  local frame1 = getglobal(parent.."_RadioFrame1Button")
  local frame2 = getglobal(parent.."_RadioFrame2Button")
  local msg = getglobal(parent.."_RadioMsgButton")
  --set radio button options based on what was clicked.
  if (id==SCT.FRAME1) then
    frame1:SetButtonState("NORMAL", true)
    frame1:SetChecked(true)
    frame2:SetChecked(nil)
    frame2:SetButtonState("NORMAL", false)
    msg:SetChecked(nil)
    msg:SetButtonState("NORMAL", false)
  elseif (id==SCT.FRAME2) then
    frame2:SetButtonState("NORMAL", true)
    frame2:SetChecked(true)
    frame1:SetChecked(nil)
    frame1:SetButtonState("NORMAL", false)
    msg:SetChecked(nil)
    msg:SetButtonState("NORMAL", false)
  elseif (id==SCT.MSG ) then
    msg:SetButtonState("NORMAL", true)
    msg:SetChecked(true)
    frame1:SetChecked(nil)
    frame1:SetButtonState("NORMAL", false)
    frame2:SetChecked(nil)
    frame2:SetButtonState("NORMAL", false)
  end
  --if it has a var, save it (some don't)
  if (this.SCTVar) then
    self.db.profile[self.FRAMES_TABLE][this.SCTVar] = id
  end
  --update Example
  self:ShowExample()
end

---------------------
--Init a Dropdown
function SCT:DropDown_Initialize()
  local info, index, value, key
  for index, value in pairs(SCT.OPTIONS.FrameSelections) do
    if (this:GetName() == "SCTOptionsFrame_Selection"..value.index.."Button") then
      for key=1, #value.table do
        info = UIDropDownMenu_CreateInfo()
        info.text = value.table[key]
        info.func = SCT.DropDown_OnClick
        info.arg1 = this:GetParent()
        UIDropDownMenu_AddButton(info)
      end
      break
    end
  end
end

---------------------
-- Dropdown Onclick
function SCT:DropDown_OnClick(ddl)
  local save = this:GetID()
  UIDropDownMenu_SetSelectedID(ddl, this:GetID())
  if (ddl.SCTValueSave) then save = this:GetText() end
  if (ddl.SCTTable) then
    SCT.db.profile[SCT.FRAMES_DATA_TABLE][ddl.SCTTable][ddl.SCTVar] = save
  else
    SCT.db.profile[ddl.SCTVar] = save
  end
  --update Example
  SCT:ShowExample()
end

----------------------
--Open the color selector using show/hide
function SCT:SaveList_OnClick()
  local text = getglobal(this:GetName().."_Name"):GetText()
  if (text ~= nil) then
    getglobal("SCTOptionsProfileEditBox_EditBox"):SetText(text)
  end
end

----------------------
--Open the color selector using show/hide
function SCT:ProfileList_OnClick()
  local text = getglobal(this:GetName().."_Name"):GetText()
  if (text ~= nil) then
    getglobal("SCTOptionsProfileEditBox"):SetText(text)
  end
end

------------------------------
--Copy one profile to another, any type
function SCT:CopyProfile(from)
  self.db:ResetProfile()
  if SCTD then SCTD:UpdateValues() end
  copyTable(from, self.db.profile);
  self:HideMenu();
  self:ShowMenu();
end

-----------------------
--Load a profile
function SCT:LoadProfile()
  local editbox = getglobal("SCTOptionsProfileEditBox_EditBox")
  local profile = editbox:GetText()
  if (profile ~= "" and profile ~= self.db:GetCurrentProfile()) then
    self.db:CopyProfile(profile)
    editbox:SetText("")
    self:Print(SCT.LOCALS.PROFILE..profile)
    self:HideMenu()
    self:ShowMenu()
  end
end

-----------------------
--Delete a profile
function SCT:DeleteProfile()
  local editbox = getglobal("SCTOptionsProfileEditBox_EditBox")
  local profile = editbox:GetText()

  if (profile ~= "") then
    if (profile == self.db:GetCurrentProfile()) then
      SCT:Reset()
    else
      self.db:DeleteProfile(profile)
      self:Print(SCT.LOCALS.PROFILE_DELETE..profile)
      self:ScrollBar_Update()
    end
    editbox:SetText("")
  end
end

----------------------
--Open the color selector using show/hide
function SCT:OpenColorPicker(button)
  CloseMenus()
  if ( not button ) then
    button = this
  end
  ColorPickerFrame.func = button.swatchFunc
  ColorPickerFrame:SetColorRGB(button.r, button.g, button.b)
  ColorPickerFrame.previousValues = {r = button.r, g = button.g, b = button.b, opacity = button.opacity}
  ColorPickerFrame.cancelFunc = button.cancelFunc
  ColorPickerFrame:Show()
end

----------------------
-- display ddl or chxbox based on type
function SCT:UpdateAnimationOptions()
  --get scroll down checkbox
  local chkbox = getglobal("SCTOptionsFrame_CheckButton4")
  --get anime type dropdown
  local ddl1 = getglobal("SCTOptionsFrame_Selection1")
  --get animside type dropdown
  local ddl2 = getglobal("SCTOptionsFrame_Selection2")
  --get gap distance silder
  local slide = getglobal("SCTOptionsFrame_Slider15")
  --get subframe
  local subframe = getglobal("SCTAnimationSubFrame")
  --get item
  local id = UIDropDownMenu_GetSelectedID(ddl1)
  chkbox:ClearAllPoints()
  chkbox:SetPoint("TOPLEFT", "SCTOptionsFrame_Selection1", "BOTTOMLEFT", 15, 0)
  if (id == 1 or id == 6) then
    chkbox:Show()
    ddl2:Hide()
    slide:Hide()
    subframe:SetHeight(80)
  elseif (id == 7 or id == 8) then
    chkbox:ClearAllPoints()
    chkbox:SetPoint("TOPLEFT", "SCTOptionsFrame_Selection1", "BOTTOMLEFT", 15, -40)
    chkbox:Show()
    ddl2:Show()
    slide:Show()
    subframe:SetHeight(165)
  else
    chkbox:Hide()
    ddl2:Show()
    slide:Hide()
    subframe:SetHeight(90)
  end
end

----------------------
-- update scroll bar settings
function SCT:ScrollBar_Update()
  local i, idx, item, key, value
  local offset = FauxScrollFrame_GetOffset(SCTScrollBar)
  --get table size, getn doesn't work cause not an array
  local size = 0
  local profiles = {}
  for key, value in SCT:PairsByKeys(SCT.db.profiles) do
    tinsert(profiles, key)
  end
  for key, _ in pairs(profiles) do
      size = size + 1
  end
  --get update
  FauxScrollFrame_Update(SCTScrollBar, size, 10, 20)
  --loop thru each display item
  for i=1,10 do
    item = getglobal("SCTList"..i.."_Name")
    idx = offset+i
    if idx<=size then
      key, value = next(profiles)
      for j=2,idx do
        key, value = next(profiles, key)
      end
      item:SetText(value)
      item:Show()
    else
      item:Hide()
    end
  end
end

----------------------
--change frame tabs
function SCT:OptionFrameTabClick()
  self:ToggleFrameTab(this:GetName(),self.OptionFrameFrames[this:GetName()].frame)
  PlaySound("igCharacterInfoTab")
end

----------------------
--change frame tabs
function SCT:ToggleFrameTab(tab, frameName)
  local key, value
  for key, value in pairs(self.OptionFrameFrames) do
    if ( key == tab and value.frame == frameName ) then
      getglobal(value.frame):Show()
      getglobal(value.example):SetTextColor(1, 1, 0)
      getglobal(key):LockHighlight()
    else
      getglobal(value.frame):Hide()
      getglobal(value.example):SetTextColor(1, 1, 1)
      getglobal(key):UnlockHighlight()
    end
  end
end

----------------------
--change which frame is being used
function SCT:ChangeFrameTab(frame)
  local tab = self.db.profile[SCT.FRAMES_DATA_TABLE][frame]
  --set all tables to selected frame
  SCTOptionsFrame_CheckButton4.SCTTable = frame
  SCTOptionsFrame_Slider2Slider.SCTTable = frame
  SCTOptionsFrame_Slider5Slider.SCTTable = frame
  SCTOptionsFrame_Slider7Slider.SCTTable = frame
  SCTOptionsFrame_Slider8Slider.SCTTable = frame
  SCTOptionsFrame_Slider15Slider.SCTTable = frame
  SCTOptionsFrame_Selection1.SCTTable = frame
  SCTOptionsFrame_Selection2.SCTTable = frame
  SCTOptionsFrame_Selection3.SCTTable = frame
  SCTOptionsFrame_Selection4.SCTTable = frame
  SCTOptionsFrame_Selection7.SCTTable = frame
  SCTOptionsFrame_Selection9.SCTTable = frame
  --update all frame options
  SCTOptionsFrame_CheckButton4:SetChecked(tab[SCTOptionsFrame_CheckButton4.SCTVar])
  --text slider
  SCTOptionsFrame_Slider2SliderText:SetText(SCTOptionsFrame_Slider2Slider.SCTLabel)
  SCTOptionsFrame_Slider2EditBox:SetText(tab[SCTOptionsFrame_Slider2Slider.SCTVar])
  SCTOptionsFrame_Slider2Slider:SetValue(tab[SCTOptionsFrame_Slider2Slider.SCTVar])
  --alpha slider
  SCTOptionsFrame_Slider5SliderText:SetText(SCTOptionsFrame_Slider5Slider.SCTLabel)
  SCTOptionsFrame_Slider5EditBox:SetText(tab[SCTOptionsFrame_Slider5Slider.SCTVar])
  SCTOptionsFrame_Slider5Slider:SetValue(tab[SCTOptionsFrame_Slider5Slider.SCTVar])
  --x slider
  SCTOptionsFrame_Slider7SliderText:SetText(SCTOptionsFrame_Slider7Slider.SCTLabel)
  SCTOptionsFrame_Slider7EditBox:SetText(tab[SCTOptionsFrame_Slider7Slider.SCTVar])
  SCTOptionsFrame_Slider7Slider:SetScript("OnValueChanged", nil)
  SCTOptionsFrame_Slider7Slider:SetValue(tab[SCTOptionsFrame_Slider7Slider.SCTVar])
  SCTOptionsFrame_Slider7Slider:SetScript("OnValueChanged", function() SCT:OptionsSliderOnValueChanged() end)
  --y slider
  SCTOptionsFrame_Slider8SliderText:SetText(SCTOptionsFrame_Slider8Slider.SCTLabel)
  SCTOptionsFrame_Slider8EditBox:SetText(tab[SCTOptionsFrame_Slider8Slider.SCTVar])
  SCTOptionsFrame_Slider8Slider:SetScript("OnValueChanged", nil)
  SCTOptionsFrame_Slider8Slider:SetValue(tab[SCTOptionsFrame_Slider8Slider.SCTVar])
  SCTOptionsFrame_Slider8Slider:SetScript("OnValueChanged", function() SCT:OptionsSliderOnValueChanged() end)
  --gap slider
  SCTOptionsFrame_Slider15SliderText:SetText(SCTOptionsFrame_Slider15Slider.SCTLabel)
  SCTOptionsFrame_Slider15EditBox:SetText(tab[SCTOptionsFrame_Slider15Slider.SCTVar])
  SCTOptionsFrame_Slider15Slider:SetScript("OnValueChanged", nil)
  SCTOptionsFrame_Slider15Slider:SetValue(tab[SCTOptionsFrame_Slider15Slider.SCTVar])
  SCTOptionsFrame_Slider15Slider:SetScript("OnValueChanged", function() SCT:OptionsSliderOnValueChanged() end)
  --Selection
  UIDropDownMenu_SetSelectedID(SCTOptionsFrame_Selection1, tab[SCTOptionsFrame_Selection1.SCTVar])
  UIDropDownMenu_SetText(SCTOptionsFrame_Selection1, SCTOptionsFrame_Selection1.lookup[tab[SCTOptionsFrame_Selection1.SCTVar]])
  UIDropDownMenu_SetSelectedID(SCTOptionsFrame_Selection2, tab[SCTOptionsFrame_Selection2.SCTVar])
  UIDropDownMenu_SetText(SCTOptionsFrame_Selection2, SCTOptionsFrame_Selection2.lookup[tab[SCTOptionsFrame_Selection2.SCTVar]])
  UIDropDownMenu_SetSelectedValue(SCTOptionsFrame_Selection3, tab[SCTOptionsFrame_Selection3.SCTVar])
  UIDropDownMenu_SetText(SCTOptionsFrame_Selection3, tab[SCTOptionsFrame_Selection3.SCTVar])
  UIDropDownMenu_SetSelectedID(SCTOptionsFrame_Selection4, tab[SCTOptionsFrame_Selection4.SCTVar])
  UIDropDownMenu_SetText(SCTOptionsFrame_Selection4, SCTOptionsFrame_Selection4.lookup[tab[SCTOptionsFrame_Selection4.SCTVar]])
  UIDropDownMenu_SetSelectedID(SCTOptionsFrame_Selection7, tab[SCTOptionsFrame_Selection7.SCTVar])
  UIDropDownMenu_SetText(SCTOptionsFrame_Selection7, SCTOptionsFrame_Selection7.lookup[tab[SCTOptionsFrame_Selection7.SCTVar]])
  UIDropDownMenu_SetSelectedID(SCTOptionsFrame_Selection9, tab[SCTOptionsFrame_Selection9.SCTVar])
  UIDropDownMenu_SetText(SCTOptionsFrame_Selection9, SCTOptionsFrame_Selection9.lookup[tab[SCTOptionsFrame_Selection9.SCTVar]])
  --update what is visible
  self:UpdateAnimationOptions()
end

----------------------
--change Sticky Mode
function SCT:ChangeStickyMode(stickyOn)
  if (stickyOn) then
    BlizzardOptionsPanel_CheckButton_Enable(SCTOptionsFrame_CheckButton15)
  else
    BlizzardOptionsPanel_CheckButton_Disable(SCTOptionsFrame_CheckButton15)
  end
end

---------------------
--Show SCT Example
function SCT:ShowExample()
  local example
  SCT:AniInit()

  --animated example for options that may need it
  local option = this.SCTVar
  if (option) and (string.find(option,"SHOW") == 1) then
    SCT:Display_Event(option, SCT.LOCALS.EXAMPLE)
  end

  --show example FRAME1
  --get object
  example = getglobal("SCTaniExampleData1")
  --set text size
  SCT:SetFontSize(example,
                  SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["FONT"],
                  SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["TEXTSIZE"],
                  SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["FONTSHADOW"])

  --set alpha
  example:SetAlpha(SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["ALPHA"]/100)
  --Position
  example:SetPoint("CENTER", "UIParent", "CENTER",
                   SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["XOFFSET"],
                   SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME1]["YOFFSET"])
  --Set the text to display
  example:SetText(SCT.LOCALS.EXAMPLE)


  --show example FRAME2
  --get object
  example = getglobal("SCTaniExampleData2")
  --set text size
  SCT:SetFontSize(example,
                  SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME2]["FONT"],
                  SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME2]["TEXTSIZE"],
                  SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME2]["FONTSHADOW"])

  --set alpha
  example:SetAlpha(SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME2]["ALPHA"]/100)
  --Position
  example:SetPoint("CENTER", "UIParent", "CENTER",
                   SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME2]["XOFFSET"],
                   SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.FRAME2]["YOFFSET"])
  --Set the text to display
  example:SetText(SCT.LOCALS.EXAMPLE2)

  --get object
  example = getglobal("SCTMsgExample1")
  --set text size
  SCT:SetMsgFont(example)
  --set alpha
  example:SetAlpha(1)
  --Position
  example:SetPoint("CENTER", "UIParent", "CENTER",
                   SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.MSG]["MSGXOFFSET"],
                   SCT.db.profile[SCT.FRAMES_DATA_TABLE][SCT.MSG]["MSGYOFFSET"]-30)
  --Set the text to display
  example:SetText(SCT.LOCALS.MSG_EXAMPLE)

  --update animation options
  SCT:UpdateAnimationOptions()
end

---------------------
--Show SCT Test
function SCT:ShowTest()
  local color = {r=1,g=1,b=1}
  SCT:DisplayText(SCT.LOCALS.EXAMPLE, color, nil, "damage", SCT.FRAME1, nil, nil, "Interface\\Icons\\INV_Misc_QuestionMark")
  SCT:DisplayText(SCT.LOCALS.EXAMPLE2, color, nil, "damage", SCT.FRAME2, nil, nil, "Interface\\Icons\\INV_Misc_QuestionMark")
  SCT:DisplayText(SCT.LOCALS.EXAMPLE, color, nil, "event", SCT.FRAME1, nil, nil, "Interface\\Icons\\INV_Misc_QuestionMark")
  SCT:DisplayText(SCT.LOCALS.EXAMPLE2, color, nil, "event", SCT.FRAME2, nil, nil, "Interface\\Icons\\INV_Misc_QuestionMark")
  SCT:DisplayMessage( SCT.LOCALS.MSG_EXAMPLE, color )
end

function SCT:MakeBlizzOptions()
  self:OptionsFrame_OnShow()

  SCTOptions_EventsFrame.name = "SCT "..SCT.LOCALS.OPTION_MISC21.name
  SCTOptions_EventsFrame.parent = "SCT"
  SCTOptions_EventsFrame:SetScale(.95)
  SCTOptions_EventsFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTOptions_EventsFrame)

  SCTOptions_FramesFrame.name = "SCT "..SCT.LOCALS.OPTION_MISC18.name
  SCTOptions_FramesFrame.parent = "SCT"
  SCTOptions_FramesFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTOptions_FramesFrame)

  SCTOptions_SpellFrame.name = "SCT "..SCT.LOCALS.OPTION_MISC19.name
  SCTOptions_SpellFrame.parent = "SCT"
  SCTOptions_SpellFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTOptions_SpellFrame)

  SCTOptions_AnimationFrame.name = "SCT "..SCT.LOCALS.OPTION_MISC16.name
  SCTOptions_AnimationFrame.parent = "SCT"
  SCTOptions_AnimationFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTOptions_AnimationFrame)

  SCTOptions_CustomEventsFrame.name = "SCT "..SCT.LOCALS.OPTION_MISC29.name
  SCTOptions_CustomEventsFrame.parent = "SCT"
  SCTOptions_CustomEventsFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTOptions_CustomEventsFrame)

  SCTOptions_SaveLoadFrame.name = "SCT "..SCT.LOCALS.OPTION_MISC10.name
  SCTOptions_SaveLoadFrame.parent = "SCT"
  SCTOptions_SaveLoadFrame.default = function() SCT:Reset() end
  InterfaceOptions_AddCategory(SCTOptions_SaveLoadFrame)
end




local sort_table
----------------------
-- update scroll bar settings
function SCT:CustomEventsScrollBar_Update()
  local idx, key
  local offset = FauxScrollFrame_GetOffset(SCTCustomEventsScrollBar)
  --get table size
  local size = 0
  local current_table = SCT.EventConfig
  --if not sorted, sort now
  if (sort_table == nil) then
    sort_table = {}
    if current_table then
      table.foreach(current_table, function (k, v) table.insert (sort_table, k) end )
    end
    table.sort(sort_table, function (a,b) return current_table[a].name < current_table[b].name end)
  end
  size = #sort_table
  --get update
  FauxScrollFrame_Update(SCTCustomEventsScrollBar, size, 10, 20)
  --loop thru each display item
  for i=1,10 do
    item = getglobal("SCTCustomEventList"..i.."_Name")
    frame = getglobal("SCTCustomEventList"..i)
    idx = offset+i
    if idx<=size then
      k,key = next(sort_table)
      for j=2,idx do
        k,key = next(sort_table, k)
      end
      item:SetText(current_table[key].name)
      item:SetTextColor(current_table[key].r, current_table[key].g, current_table[key].b)
      frame.key = key
      frame:Show()
    else
      frame:Hide()
    end
  end
end

function SCT:CustomEventList_OnClick(self)
  local option = SCT.EventConfig[self.key]
  SCTOptions_CustomEventsDetailsFrame.current = option
  SCTOptions_CustomEventsDetailsFrame.currentkey = self.key
  SCT:CustomEventShow(option)
end

function SCT:CustomEventShow(option)

  --text boxes
  SCTOptionsFrame_EditBox1_EditBox:SetText(option.name or "")
  SCTOptionsFrame_EditBox2_EditBox:SetText(option.display or "")
  SCTOptionsFrame_EditBox3_EditBox:SetText(option.search or "")
  SCTOptionsFrame_EditBox4_EditBox:SetText(option.sound or "")
  SCTOptionsFrame_EditBox5_EditBox:SetText(option.soundwave or "")

  --dropdowns
  UIDropDownMenu_SetSelectedValue(SCTOptionsFrame_CustomSelection1, option.type or "BUFF")
  UIDropDownMenu_SetText(SCTOptionsFrame_CustomSelection1, SCTOptionsFrame_CustomSelection1.lookup[option.type or "BUFF"])
  UIDropDownMenu_SetSelectedValue(SCTOptionsFrame_CustomSelection2, option.target or "ANY")
  UIDropDownMenu_SetText(SCTOptionsFrame_CustomSelection2, SCTOptionsFrame_CustomSelection2.lookup[option.target or "ANY"])
  UIDropDownMenu_SetSelectedValue(SCTOptionsFrame_CustomSelection3, option.source or "ANY")
  UIDropDownMenu_SetText(SCTOptionsFrame_CustomSelection3, SCTOptionsFrame_CustomSelection3.lookup[option.source or "ANY"])
  UIDropDownMenu_SetSelectedValue(SCTOptionsFrame_CustomSelection4, option.frame or 1)
  UIDropDownMenu_SetText(SCTOptionsFrame_CustomSelection4, SCTOptionsFrame_CustomSelection4.lookup[option.frame or 1])

  --color
  SCTOptionsFrame_Color8.r = option.r
  SCTOptionsFrame_Color8.g = option.g
  SCTOptionsFrame_Color8.b = option.b
  SCTOptionsFrame_Color8NormalTexture:SetVertexColor(option.r, option.g, option.b)

  --checks
  SCTOptionsFrame_CheckButton21:SetChecked(option.icon)
  SCTOptionsFrame_CheckButton22:SetChecked(option.iscrit)

  --classes (this could be done much nicer with a table, but i'm lazy)
  SCTOptionsFrame_Deathknight:SetChecked(false)
  SCTOptionsFrame_Druid:SetChecked(false)
  SCTOptionsFrame_Hunter:SetChecked(false)
  SCTOptionsFrame_Mage:SetChecked(false)
  SCTOptionsFrame_Paladin:SetChecked(false)
  SCTOptionsFrame_Priest:SetChecked(false)
  SCTOptionsFrame_Rogue:SetChecked(false)
  SCTOptionsFrame_Shaman:SetChecked(false)
  SCTOptionsFrame_Warlock:SetChecked(false)
  SCTOptionsFrame_Warrior:SetChecked(false)
  if option.class then
    for k, class in pairs(option.class) do
      if class == SCT.LOCALS.DEATHKNIGHT then
        SCTOptionsFrame_Deathknight:SetChecked(true)
      elseif class == SCT.LOCALS.DRUID then
        SCTOptionsFrame_Druid:SetChecked(true)
      elseif class == SCT.LOCALS.HUNTER then
        SCTOptionsFrame_Hunter:SetChecked(true)
      elseif class == SCT.LOCALS.MAGE then
        SCTOptionsFrame_Mage:SetChecked(true)
      elseif class == SCT.LOCALS.PALADIN then
        SCTOptionsFrame_Paladin:SetChecked(true)
      elseif class == SCT.LOCALS.PRIEST then
        SCTOptionsFrame_Priest:SetChecked(true)
      elseif class == SCT.LOCALS.ROGUE then
        SCTOptionsFrame_Rogue:SetChecked(true)
      elseif class == SCT.LOCALS.SHAMAN then
        SCTOptionsFrame_Shaman:SetChecked(true)
      elseif class == SCT.LOCALS.WARLOCK then
        SCTOptionsFrame_Warlock:SetChecked(true)
      elseif class == SCT.LOCALS.WARRIOR then
        SCTOptionsFrame_Warrior:SetChecked(true)
      end
    end
  end

  --setup other fields base on type
  SCT:CustomEventSetType(option.type, option)

  SCTOptions_CustomEventsDetailsFrame:Show()
end

function SCT:CustomEventSetType(etype, option)
  self:CustomEventTypeReset()
  if etype == "BUFF" then
    SCTOptionsFrame_CustomSelection3:Hide();
    SCTOptionsFrame_Slider18:Show()
    SCTOptionsFrame_Slider18EditBox:SetText(option.buffcount or 0)
    SCTOptionsFrame_CheckButton29:Show()
    SCTOptionsFrame_CheckButton29:SetChecked(option.source == "SELF")
  elseif etype == "FADE" then
    SCTOptionsFrame_CustomSelection3:Hide();
    SCTOptionsFrame_Slider18:Show()
    SCTOptionsFrame_Slider18EditBox:SetText(option.buffcount or 0)
  elseif etype == "MISS" then
    SCTOptionsFrame_CustomSelection5:Show()
    UIDropDownMenu_SetSelectedValue(SCTOptionsFrame_CustomSelection5, option.misstype or "ANY")
    UIDropDownMenu_SetText(SCTOptionsFrame_CustomSelection5, SCTOptionsFrame_CustomSelection5.lookup[option.misstype or "ANY"])
  elseif etype == "HEAL" then
    SCTOptionsFrame_CheckButton23:Show()
    SCTOptionsFrame_CheckButton23:SetChecked(option.critical)
  elseif etype == "DAMAGE" then
    SCTOptionsFrame_CheckButton23:Show()
    SCTOptionsFrame_CheckButton23:SetChecked(option.critical)
    SCTOptionsFrame_CheckButton24:Show()
    SCTOptionsFrame_CheckButton24:SetChecked(option.resisted)
    SCTOptionsFrame_CheckButton25:Show()
    SCTOptionsFrame_CheckButton25:SetChecked(option.blocked)
    SCTOptionsFrame_CheckButton26:Show()
    SCTOptionsFrame_CheckButton26:SetChecked(option.absorbed)
    SCTOptionsFrame_CheckButton27:Show()
    SCTOptionsFrame_CheckButton27:SetChecked(option.glancing)
    SCTOptionsFrame_CheckButton28:Show()
    SCTOptionsFrame_CheckButton28:SetChecked(option.crushing)
  elseif etype == "POWER" then
    SCTOptionsFrame_CustomSelection6:Show()
    UIDropDownMenu_SetSelectedValue(SCTOptionsFrame_CustomSelection6, option.power or 0)
    UIDropDownMenu_SetText(SCTOptionsFrame_CustomSelection6, SCTOptionsFrame_CustomSelection6.lookup[option.power or 0])
  end
end

function SCT:CustomEventTypeReset()
  SCTOptionsFrame_CustomSelection3:Show();
  SCTOptionsFrame_Slider18:Hide()
  SCTOptionsFrame_CheckButton29:Hide()
  SCTOptionsFrame_CustomSelection5:Hide()
  SCTOptionsFrame_CustomSelection6:Hide()
  SCTOptionsFrame_CheckButton23:Hide()
  SCTOptionsFrame_CheckButton24:Hide()
  SCTOptionsFrame_CheckButton25:Hide()
  SCTOptionsFrame_CheckButton26:Hide()
  SCTOptionsFrame_CheckButton27:Hide()
  SCTOptionsFrame_CheckButton28:Hide()
end

function SCT:CustomEventSave_OnClick()
    local option = SCTOptions_CustomEventsDetailsFrame.current
    for k in pairs(option) do
      option[k] = nil
    end

    --text boxes
    option.name = SCTOptionsFrame_EditBox1_EditBox:GetText()
    option.display = SCTOptionsFrame_EditBox2_EditBox:GetText()
    option.search = SCTOptionsFrame_EditBox3_EditBox:GetText()
    option.sound = SCTOptionsFrame_EditBox4_EditBox:GetText()
    option.soundwave = SCTOptionsFrame_EditBox5_EditBox:GetText()

    if option.search == "" then option.search = nil end
    if option.sound == "" then option.sound = nil end
    if option.soundwave == "" then option.soundwave = nil end

    --dropdowns
    option.type = UIDropDownMenu_GetSelectedValue(SCTOptionsFrame_CustomSelection1)
    option.target = UIDropDownMenu_GetSelectedValue(SCTOptionsFrame_CustomSelection2)
    option.source = UIDropDownMenu_GetSelectedValue(SCTOptionsFrame_CustomSelection3)
    option.frame = UIDropDownMenu_GetSelectedValue(SCTOptionsFrame_CustomSelection4)

    --color
    option.r = SCTOptionsFrame_Color8.r
    option.g = SCTOptionsFrame_Color8.g
    option.b = SCTOptionsFrame_Color8.b

    --checks
    option.icon = SCTOptionsFrame_CheckButton21:GetChecked()
    option.iscrit = SCTOptionsFrame_CheckButton22:GetChecked()

    --class
    local class = {}
    if SCTOptionsFrame_Deathknight:GetChecked() then
      tinsert(class, SCT.LOCALS.DEATHKNIGHT)
    end
    if SCTOptionsFrame_Druid:GetChecked() then
      tinsert(class, SCT.LOCALS.DRUID)
    end
    if SCTOptionsFrame_Hunter:GetChecked() then
      tinsert(class, SCT.LOCALS.HUNTER)
    end
    if SCTOptionsFrame_Mage:GetChecked() then
      tinsert(class, SCT.LOCALS.MAGE)
    end
    if SCTOptionsFrame_Paladin:GetChecked() then
      tinsert(class, SCT.LOCALS.PALADIN)
    end
    if SCTOptionsFrame_Priest:GetChecked() then
      tinsert(class, SCT.LOCALS.PRIEST)
    end
    if SCTOptionsFrame_Rogue:GetChecked() then
      tinsert(class, SCT.LOCALS.ROGUE)
    end
    if SCTOptionsFrame_Shaman:GetChecked() then
      tinsert(class, SCT.LOCALS.SHAMAN)
    end
    if SCTOptionsFrame_Warlock:GetChecked() then
      tinsert(class, SCT.LOCALS.WARLOCK)
    end
    if SCTOptionsFrame_Warrior:GetChecked() then
      tinsert(class, SCT.LOCALS.WARRIOR)
    end
    if #class > 0 then
      option.class = class
    end
    --get event type details
    SCT:CustomEventGetType(option)

    --clear sort table
    sort_table = nil
    --recreate cache
    SCT:CacheCustomEvents()
    --update scroll bars
    SCT:CustomEventsScrollBar_Update()
    --sound
    PlaySound("igMainMenuOptionCheckBoxOn")
    --close details
    SCTOptions_CustomEventsDetailsFrame:Hide()
end

function SCT:CustomEventGetType(option)
  local etype = option.type
  if etype == "BUFF" then
    if SCTOptionsFrame_CheckButton29:GetChecked() then
      option.source = "SELF"
    else
      option.source = nil
    end
    option.buffcount = tonumber(SCTOptionsFrame_Slider18EditBox:GetText())
    if option.buffcount == 0 then option.buffcount = nil end
  elseif etype == "FADE" then
    option.source = nil
    option.buffcount = tonumber(SCTOptionsFrame_Slider18EditBox:GetText())
    if option.buffcount == 0 then option.buffcount = nil end
  elseif etype == "MISS" then
    option.misstype = UIDropDownMenu_GetSelectedValue(SCTOptionsFrame_CustomSelection5)
    if option.misstype == "ANY" then option.misstype = nil end
  elseif etype == "HEAL" then
    option.critical = SCTOptionsFrame_CheckButton23:GetChecked()
  elseif etype == "DAMAGE" then
    option.critical = SCTOptionsFrame_CheckButton23:GetChecked()
    option.resisted = SCTOptionsFrame_CheckButton24:GetChecked()
    option.blocked = SCTOptionsFrame_CheckButton25:GetChecked()
    option.absorbed = SCTOptionsFrame_CheckButton26:GetChecked()
    option.glancing = SCTOptionsFrame_CheckButton27:GetChecked()
    option.crushing = SCTOptionsFrame_CheckButton28:GetChecked()
  elseif etype == "POWER" then
    option.power = UIDropDownMenu_GetSelectedValue(SCTOptionsFrame_CustomSelection6)
    if option.power == 0 then option.power = nil end
  end
end

function SCT:CustomEventNew_OnClick()
  local newevent = {}
  newevent.name = SCT.LOCALS.OPTION_MISC32.name.." "..#SCT.EventConfig+1
  newevent.search = SCT.LOCALS.OPTION_MISC32.name.." "..#SCT.EventConfig+1
  newevent.type = "BUFF"
  newevent.target = "SELF"
  newevent.r = 1
  newevent.g = 1
  newevent.b = 1
  tinsert(SCT.EventConfig, newevent)
  local option = SCT.EventConfig[#SCT.EventConfig]
  SCTOptions_CustomEventsDetailsFrame.current = option
  SCTOptions_CustomEventsDetailsFrame.currentkey = #SCT.EventConfig
  --clear sort table
  sort_table = nil
  --recreate cache
  SCT:CacheCustomEvents()
  --update scroll bars
  SCT:CustomEventsScrollBar_Update()
  --show event
  self:CustomEventShow(option)
end

function SCT:CustomEventDelete_OnClick()
  tremove(SCT.EventConfig, SCTOptions_CustomEventsDetailsFrame.currentkey)
  --clear sort table
  sort_table = nil
  --recreate cache
  SCT:CacheCustomEvents()
  --update scroll bars
  SCT:CustomEventsScrollBar_Update()
  --sound
  PlaySound("igMainMenuOptionCheckBoxOn")
  --close details
  SCTOptions_CustomEventsDetailsFrame:Hide()
end

function SCT:ResetEvents_OnClick()
  local found
  for k in pairs(self.EventConfig) do
    tremove(SCT.EventConfig)
  end
  for k,v in pairs(self.Events) do
    self.EventConfig[k] = v
  end
  --clear sort table
  sort_table = nil
  --recreate cache
  SCT:CacheCustomEvents()
  --update scroll bars
  SCT:CustomEventsScrollBar_Update()
  --sound
  PlaySound("igMainMenuOptionCheckBoxOn")
  --close details
  SCTOptions_CustomEventsDetailsFrame:Hide()
end

---------------------
--Init a Custom Dropdown
function SCT:CustomDropDown_Initialize()
  local info, index, value, key
  for index, value in pairs(SCT.OPTIONS.FrameCustomSelections) do
    if (this:GetName() == "SCTOptionsFrame_CustomSelection"..value.index.."Button") then
      for k, v in self:PairsByKeys(value.table) do
        info = UIDropDownMenu_CreateInfo()
        info.text = v
        info.func = SCT.CustomDropDown_OnClick
        info.arg1 = this:GetParent()
        info.value = k
        UIDropDownMenu_AddButton(info)
      end
      break
    end
  end
end

---------------------
-- Custom Dropdown Onclick
function SCT:CustomDropDown_OnClick(ddl)
  UIDropDownMenu_SetSelectedValue(ddl, this.value)
  if ddl == SCTOptionsFrame_CustomSelection1 then
    SCT:CustomEventSetType(this.value, SCTOptions_CustomEventsDetailsFrame.current)
  end
end