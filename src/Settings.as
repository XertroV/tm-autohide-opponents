[Setting hidden] // name="Opponent visibility when driving" category="General"]
OpponentsVisibility S_WhenRacing = OpponentsVisibility::Off;

[Setting hidden] // name="Opponent visibility when not driving" category="General"]
OpponentsVisibility S_WhenNotRacing = OpponentsVisibility::Opaque;

[Setting hidden] // name="Name tags enabled when driving" category="General"]
bool S_NameVisWhenRacing = false;

[Setting hidden] // name="Name tags enabled when not driving" category="General"]
bool S_NameVisWhenNotRacing = true;

[Setting hidden] // name="Also autohide Ghosts?" category="General"]
bool S_AlsoGhosts = false;

[Setting hidden] // name="Enabled for Knockout Rounds?" category="General"]
bool S_EnabledForKO = true;

[Setting hidden] // name="Enabled for TimeAttack?" category="General"]
bool S_EnabledForTA = false;

[Setting hidden] // name="Enabled for Matchmaking?" category="General"]
bool S_EnabledForMM = false;

[Setting hidden] // name="Enabled for Cup?" category="General"]
bool S_EnabledForCup = true;

[Setting hidden]
bool S_ShownInitSettings = false;


enum OpponentsVisibility { Off = 0, Transparent = 1, Opaque = 2 }

enum S_Opponents {
    Off = 0, Transparent = 1, Opaque = 2, Do_Nothing = 3
}

enum S_Bool {
    Off = 0, On = 1, Do_Nothing = 2
}

[Setting hidden]
S_Opponents S_CotdKo_Racing_Opponents = S_Opponents::Off;
[Setting hidden]
S_Bool S_CotdKo_Racing_Ghosts = S_Bool::Off;
[Setting hidden]
S_Bool S_CotdKo_Racing_NameTags = S_Bool::Off;
[Setting hidden]
S_Bool S_CotdKo_Racing_UIVis = S_Bool::Off;

[Setting hidden]
S_Opponents S_CotdKo_Specing_Opponents = S_Opponents::Opaque;
[Setting hidden]
S_Bool S_CotdKo_Specing_Ghosts = S_Bool::On;
[Setting hidden]
S_Bool S_CotdKo_Specing_NameTags = S_Bool::On;
[Setting hidden]
S_Bool S_CotdKo_Specing_UIVis = S_Bool::On;


[Setting hidden]
S_Opponents S_MM_Racing_Opponents = S_Opponents::Off;
[Setting hidden]
S_Bool S_MM_Racing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_MM_Racing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_MM_Racing_UIVis = S_Bool::Do_Nothing;

[Setting hidden]
S_Opponents S_MM_Specing_Opponents = S_Opponents::Opaque;
[Setting hidden]
S_Bool S_MM_Specing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_MM_Specing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_MM_Specing_UIVis = S_Bool::Do_Nothing;


[Setting hidden]
S_Opponents S_TA_Racing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_TA_Racing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_TA_Racing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_TA_Racing_UIVis = S_Bool::Do_Nothing;

[Setting hidden]
S_Opponents S_TA_Specing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_TA_Specing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_TA_Specing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_TA_Specing_UIVis = S_Bool::Do_Nothing;


[Setting hidden]
S_Opponents S_Cup_Racing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_Cup_Racing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Cup_Racing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Cup_Racing_UIVis = S_Bool::Do_Nothing;

[Setting hidden]
S_Opponents S_Cup_Specing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_Cup_Specing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Cup_Specing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Cup_Specing_UIVis = S_Bool::Do_Nothing;


[Setting hidden]
S_Opponents S_Solo_Racing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_Solo_Racing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Solo_Racing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Solo_Racing_UIVis = S_Bool::Do_Nothing;

[Setting hidden]
S_Opponents S_Solo_Specing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_Solo_Specing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Solo_Specing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Solo_Specing_UIVis = S_Bool::Do_Nothing;


[Setting hidden]
S_Opponents S_Other_Racing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_Other_Racing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Other_Racing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Other_Racing_UIVis = S_Bool::Do_Nothing;

[Setting hidden]
S_Opponents S_Other_Specing_Opponents = S_Opponents::Do_Nothing;
[Setting hidden]
S_Bool S_Other_Specing_Ghosts = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Other_Specing_NameTags = S_Bool::Do_Nothing;
[Setting hidden]
S_Bool S_Other_Specing_UIVis = S_Bool::Do_Nothing;


[SettingsTab name="General" order="1"]
void Render_GeneralSettings() {
    if (!ShowWindow) {
        if (UI::Button("Open Settings Window")) {
            ShowWindow = true;
        }
    }

    if (UI::BeginTable("genset", 6, UI::TableFlags::SizingStretchSame)) {
        UI::TableSetupColumn("Mode");
        UI::TableSetupColumn("When");
        UI::TableSetupColumn("Opponents");
        UI::TableSetupColumn("Ghosts");
        UI::TableSetupColumn("Name Tags");
        UI::TableSetupColumn("UI Visibility");

        UI::TableHeadersRow();

        S_StartMode("COTD / KO");
        S_StartWhen();
        S_CotdKo_Racing_Opponents = S_ComboOpponents(S_CotdKo_Racing_Opponents, "S_CotdKo_Racing_Opponents");
        S_CotdKo_Racing_Ghosts = S_ComboGhosts(S_CotdKo_Racing_Ghosts, "S_CotdKo_Racing_Ghosts");
        S_CotdKo_Racing_NameTags = S_ComboNameTags(S_CotdKo_Racing_NameTags, "S_CotdKo_Racing_NameTags");
        S_CotdKo_Racing_UIVis = S_ComboUIVis(S_CotdKo_Racing_UIVis, "S_CotdKo_Racing_UIVis");
        if (S_SecondWhen()) { Reset_S_CotdKo(); }
        S_CotdKo_Specing_Opponents = S_ComboOpponents(S_CotdKo_Specing_Opponents, "S_CotdKo_Specing_Opponents");
        S_CotdKo_Specing_Ghosts = S_ComboGhosts(S_CotdKo_Specing_Ghosts, "S_CotdKo_Specing_Ghosts");
        S_CotdKo_Specing_NameTags = S_ComboNameTags(S_CotdKo_Specing_NameTags, "S_CotdKo_Specing_NameTags");
        S_CotdKo_Specing_UIVis = S_ComboUIVis(S_CotdKo_Specing_UIVis, "S_CotdKo_Specing_UIVis");
        S_EndMode();

        S_StartMode("Matchmaking");
        S_StartWhen();
        S_MM_Racing_Opponents = S_ComboOpponents(S_MM_Racing_Opponents, "S_MM_Racing_Opponents");
        S_MM_Racing_Ghosts = S_ComboGhosts(S_MM_Racing_Ghosts, "S_MM_Racing_Ghosts");
        S_MM_Racing_NameTags = S_ComboNameTags(S_MM_Racing_NameTags, "S_MM_Racing_NameTags");
        S_MM_Racing_UIVis = S_ComboUIVis(S_MM_Racing_UIVis, "S_MM_Racing_UIVis");
        if (S_SecondWhen()) { Reset_S_MM(); }
        S_MM_Specing_Opponents = S_ComboOpponents(S_MM_Specing_Opponents, "S_MM_Specing_Opponents");
        S_MM_Specing_Ghosts = S_ComboGhosts(S_MM_Specing_Ghosts, "S_MM_Specing_Ghosts");
        S_MM_Specing_NameTags = S_ComboNameTags(S_MM_Specing_NameTags, "S_MM_Specing_NameTags");
        S_MM_Specing_UIVis = S_ComboUIVis(S_MM_Specing_UIVis, "S_MM_Specing_UIVis");
        S_EndMode();

        S_StartMode("Time Attack");
        S_StartWhen();
        S_TA_Racing_Opponents = S_ComboOpponents(S_TA_Racing_Opponents, "S_TA_Racing_Opponents");
        S_TA_Racing_Ghosts = S_ComboGhosts(S_TA_Racing_Ghosts, "S_TA_Racing_Ghosts");
        S_TA_Racing_NameTags = S_ComboNameTags(S_TA_Racing_NameTags, "S_TA_Racing_NameTags");
        S_TA_Racing_UIVis = S_ComboUIVis(S_TA_Racing_UIVis, "S_TA_Racing_UIVis");
        if (S_SecondWhen()) { Reset_S_TA(); }
        S_TA_Specing_Opponents = S_ComboOpponents(S_TA_Specing_Opponents, "S_TA_Specing_Opponents");
        S_TA_Specing_Ghosts = S_ComboGhosts(S_TA_Specing_Ghosts, "S_TA_Specing_Ghosts");
        S_TA_Specing_NameTags = S_ComboNameTags(S_TA_Specing_NameTags, "S_TA_Specing_NameTags");
        S_TA_Specing_UIVis = S_ComboUIVis(S_TA_Specing_UIVis, "S_TA_Specing_UIVis");
        S_EndMode();

        S_StartMode("Cup");
        S_StartWhen();
        S_Cup_Racing_Opponents = S_ComboOpponents(S_Cup_Racing_Opponents, "S_Cup_Racing_Opponents");
        S_Cup_Racing_Ghosts = S_ComboGhosts(S_Cup_Racing_Ghosts, "S_Cup_Racing_Ghosts");
        S_Cup_Racing_NameTags = S_ComboNameTags(S_Cup_Racing_NameTags, "S_Cup_Racing_NameTags");
        S_Cup_Racing_UIVis = S_ComboUIVis(S_Cup_Racing_UIVis, "S_Cup_Racing_UIVis");
        if (S_SecondWhen()) { Reset_S_Cup(); }
        S_Cup_Specing_Opponents = S_ComboOpponents(S_Cup_Specing_Opponents, "S_Cup_Specing_Opponents");
        S_Cup_Specing_Ghosts = S_ComboGhosts(S_Cup_Specing_Ghosts, "S_Cup_Specing_Ghosts");
        S_Cup_Specing_NameTags = S_ComboNameTags(S_Cup_Specing_NameTags, "S_Cup_Specing_NameTags");
        S_Cup_Specing_UIVis = S_ComboUIVis(S_Cup_Specing_UIVis, "S_Cup_Specing_UIVis");
        S_EndMode();

        S_StartMode("Solo");
        S_StartWhen();
        S_Solo_Racing_Opponents = S_ComboOpponents(S_Solo_Racing_Opponents, "S_Solo_Racing_Opponents");
        S_Solo_Racing_Ghosts = S_ComboGhosts(S_Solo_Racing_Ghosts, "S_Solo_Racing_Ghosts");
        S_Solo_Racing_NameTags = S_ComboNameTags(S_Solo_Racing_NameTags, "S_Solo_Racing_NameTags");
        S_Solo_Racing_UIVis = S_ComboUIVis(S_Solo_Racing_UIVis, "S_Solo_Racing_UIVis");
        if (S_SecondWhen()) { Reset_S_Solo(); }
        S_Solo_Specing_Opponents = S_ComboOpponents(S_Solo_Specing_Opponents, "S_Solo_Specing_Opponents");
        S_Solo_Specing_Ghosts = S_ComboGhosts(S_Solo_Specing_Ghosts, "S_Solo_Specing_Ghosts");
        S_Solo_Specing_NameTags = S_ComboNameTags(S_Solo_Specing_NameTags, "S_Solo_Specing_NameTags");
        S_Solo_Specing_UIVis = S_ComboUIVis(S_Solo_Specing_UIVis, "S_Solo_Specing_UIVis");
        S_EndMode();

        S_StartMode("Other");
        S_StartWhen();
        S_Other_Racing_Opponents = S_ComboOpponents(S_Other_Racing_Opponents, "S_Other_Racing_Opponents");
        S_Other_Racing_Ghosts = S_ComboGhosts(S_Other_Racing_Ghosts, "S_Other_Racing_Ghosts");
        S_Other_Racing_NameTags = S_ComboNameTags(S_Other_Racing_NameTags, "S_Other_Racing_NameTags");
        S_Other_Racing_UIVis = S_ComboUIVis(S_Other_Racing_UIVis, "S_Other_Racing_UIVis");
        if (S_SecondWhen()) { Reset_S_Other(); }
        S_Other_Specing_Opponents = S_ComboOpponents(S_Other_Specing_Opponents, "S_Other_Specing_Opponents");
        S_Other_Specing_Ghosts = S_ComboGhosts(S_Other_Specing_Ghosts, "S_Other_Specing_Ghosts");
        S_Other_Specing_NameTags = S_ComboNameTags(S_Other_Specing_NameTags, "S_Other_Specing_NameTags");
        S_Other_Specing_UIVis = S_ComboUIVis(S_Other_Specing_UIVis, "S_Other_Specing_UIVis");
        S_EndMode();

        UI::EndTable();
    }
}

void S_StartMode(const string &in mode) {
    UI::PushID("set-for-" + mode);
    UI::TableNextRow();
    UI::TableNextColumn();
    UI::AlignTextToFramePadding();
    UI::Text(mode);
}

void S_StartWhen() {
    UI::TableNextColumn();
    UI::Text("Racing:");
}

bool S_SecondWhen() {
    UI::TableNextRow();
    UI::TableNextColumn();
    bool ret = UI::Button("Reset");
    UI::TableNextColumn();
    UI::AlignTextToFramePadding();
    UI::Text("Specing:");
    return ret;
}

void S_EndMode() {
    UI::PopID();
    UI::TableNextRow();
    UI::TableNextColumn();
    UI::Dummy(vec2(0, UI::GetTextLineHeightWithSpacing() / 3.));

}

S_Opponents S_ComboOpponents(S_Opponents v, const string &in id) {
    auto ret = v;
    UI::TableNextColumn();
    UI::SetNextItemWidth(UI::GetContentRegionAvail().x);
    if (UI::BeginCombo("##Opponents-"+id, tostring(v))) {
        for (int i = 0; i <= int(S_Opponents::Do_Nothing); i++) {
            if (UI::Selectable(tostring(S_Opponents(i)) + "##Opponents-"+id, i == int(v))) {
                OnSettingsChanged();
                ret = S_Opponents(i);
            }
        }
        UI::EndCombo();
    }
    return ret;
}

S_Bool S_ComboGhosts(S_Bool v, const string &in id) {
    auto ret = v;
    UI::TableNextColumn();
    UI::SetNextItemWidth(UI::GetContentRegionAvail().x);
    if (UI::BeginCombo("##Ghosts-"+id, tostring(v))) {
        for (int i = 0; i <= S_Bool::Do_Nothing; i++) {
            if (UI::Selectable(tostring(S_Bool(i)) + "##Ghosts-"+id, i == int(v))) {
                OnSettingsChanged();
                ret = S_Bool(i);
            }
        }
        UI::EndCombo();
    }
    return ret;
}

S_Bool S_ComboNameTags(S_Bool v, const string &in id) {
    auto ret = v;
    UI::TableNextColumn();
    UI::SetNextItemWidth(UI::GetContentRegionAvail().x);
    if (UI::BeginCombo("##NameTags-"+id, tostring(v))) {
        for (int i = 0; i <= S_Bool::Do_Nothing; i++) {
            if (UI::Selectable(tostring(S_Bool(i)) + "##NameTags-"+id, i == int(v))) {
                OnSettingsChanged();
                ret = S_Bool(i);
            }
        }
        UI::EndCombo();
    }
    return ret;
}

S_Bool S_ComboUIVis(S_Bool v, const string &in id) {
    auto ret = v;
    UI::TableNextColumn();
    UI::SetNextItemWidth(UI::GetContentRegionAvail().x);
    if (UI::BeginCombo("##UIVis-"+id, tostring(v))) {
        for (int i = 0; i <= S_Bool::Do_Nothing; i++) {
            if (UI::Selectable(tostring(S_Bool(i)) + "##UIVis-"+id, i == int(v))) {
                OnSettingsChanged();
                ret = S_Bool(i);
            }
        }
        UI::EndCombo();
    }
    return ret;
}

void Reset_S_CotdKo() {
    S_CotdKo_Racing_Opponents = S_Opponents::Do_Nothing;
    S_CotdKo_Racing_Ghosts = S_Bool::Do_Nothing;
    S_CotdKo_Racing_NameTags = S_Bool::Do_Nothing;
    S_CotdKo_Racing_UIVis = S_Bool::Do_Nothing;
    S_CotdKo_Specing_Opponents = S_Opponents::Do_Nothing;
    S_CotdKo_Specing_Ghosts = S_Bool::Do_Nothing;
    S_CotdKo_Specing_NameTags = S_Bool::Do_Nothing;
    S_CotdKo_Specing_UIVis = S_Bool::Do_Nothing;
}

void Reset_S_MM() {
    S_MM_Racing_Opponents = S_Opponents::Do_Nothing;
    S_MM_Racing_Ghosts = S_Bool::Do_Nothing;
    S_MM_Racing_NameTags = S_Bool::Do_Nothing;
    S_MM_Racing_UIVis = S_Bool::Do_Nothing;
    S_MM_Specing_Opponents = S_Opponents::Do_Nothing;
    S_MM_Specing_Ghosts = S_Bool::Do_Nothing;
    S_MM_Specing_NameTags = S_Bool::Do_Nothing;
    S_MM_Specing_UIVis = S_Bool::Do_Nothing;
}

void Reset_S_TA() {
    S_TA_Racing_Opponents = S_Opponents::Do_Nothing;
    S_TA_Racing_Ghosts = S_Bool::Do_Nothing;
    S_TA_Racing_NameTags = S_Bool::Do_Nothing;
    S_TA_Racing_UIVis = S_Bool::Do_Nothing;
    S_TA_Specing_Opponents = S_Opponents::Do_Nothing;
    S_TA_Specing_Ghosts = S_Bool::Do_Nothing;
    S_TA_Specing_NameTags = S_Bool::Do_Nothing;
    S_TA_Specing_UIVis = S_Bool::Do_Nothing;
}

void Reset_S_Cup() {
    S_Cup_Racing_Opponents = S_Opponents::Do_Nothing;
    S_Cup_Racing_Ghosts = S_Bool::Do_Nothing;
    S_Cup_Racing_NameTags = S_Bool::Do_Nothing;
    S_Cup_Racing_UIVis = S_Bool::Do_Nothing;
    S_Cup_Specing_Opponents = S_Opponents::Do_Nothing;
    S_Cup_Specing_Ghosts = S_Bool::Do_Nothing;
    S_Cup_Specing_NameTags = S_Bool::Do_Nothing;
    S_Cup_Specing_UIVis = S_Bool::Do_Nothing;
}

void Reset_S_Solo() {
    S_Solo_Racing_Opponents = S_Opponents::Do_Nothing;
    S_Solo_Racing_Ghosts = S_Bool::Do_Nothing;
    S_Solo_Racing_NameTags = S_Bool::Do_Nothing;
    S_Solo_Racing_UIVis = S_Bool::Do_Nothing;
    S_Solo_Specing_Opponents = S_Opponents::Do_Nothing;
    S_Solo_Specing_Ghosts = S_Bool::Do_Nothing;
    S_Solo_Specing_NameTags = S_Bool::Do_Nothing;
    S_Solo_Specing_UIVis = S_Bool::Do_Nothing;
}

void Reset_S_Other() {
    S_Other_Racing_Opponents = S_Opponents::Do_Nothing;
    S_Other_Racing_Ghosts = S_Bool::Do_Nothing;
    S_Other_Racing_NameTags = S_Bool::Do_Nothing;
    S_Other_Racing_UIVis = S_Bool::Do_Nothing;
    S_Other_Specing_Opponents = S_Opponents::Do_Nothing;
    S_Other_Specing_Ghosts = S_Bool::Do_Nothing;
    S_Other_Specing_NameTags = S_Bool::Do_Nothing;
    S_Other_Specing_UIVis = S_Bool::Do_Nothing;
}



[SettingsTab name="Current Visibility" order="10"]
void Render_CurrentVis() {
    if (!GameVersionSafe) {
        UI::Text("Game version unsafe!");
        return;
    }
    UI::Text("Curr Mode: " + tostring(g_Mode));
    UI::Text("Curr UI Seq: " + tostring(lastUiSeq));

    UI::AlignTextToFramePadding();
    UI::Text("Opponent Visibility: " + tostring(GetOpponentsVisibility()));
    UI::SameLine();
    if (UI::Button("Toggle##GetOpponentsVisibility")) {
        SetOpponentsVisibility(OpponentsVisibility((GetOpponentsVisibility() + 1) % 3));
    }

    UI::AlignTextToFramePadding();
    UI::Text("Ghosts Visibile: " + tostring(GetGhostVisibility()));
    UI::SameLine();
    if (UI::Button("Toggle##GetGhostVisibility")) {
        SetGhostVisibility(!GetGhostVisibility());
    }
    UI::AlignTextToFramePadding();
    UI::Text("Name Tags Visibile: " + tostring(GetNameTagsVisibility()));
    UI::SameLine();
    if (UI::Button("Toggle##GetNameTagsVisibility")) {
        SetNameTagsVisibility(!GetNameTagsVisibility());
    }
    UI::AlignTextToFramePadding();
    UI::Text("UI Visibile: " + tostring(GetUIVisibility()));
    UI::SameLine();
    if (UI::Button("Toggle##GetUIVisibility")) {
        SetUIVisibility(!GetUIVisibility());
    }
}


VisConfig@ GetActiveSettings(GameMode mode, bool isPlaying) {
    if (isPlaying) {
        switch (mode) {
            case GameMode::None: return VisConfig();
            case GameMode::CotdKo: return VisConfig(S_CotdKo_Racing_Opponents, S_CotdKo_Racing_Ghosts, S_CotdKo_Racing_NameTags, S_CotdKo_Racing_UIVis);
            case GameMode::MM: return VisConfig(S_MM_Racing_Opponents, S_MM_Racing_Ghosts, S_MM_Racing_NameTags, S_MM_Racing_UIVis);
            case GameMode::TA: return VisConfig(S_TA_Racing_Opponents, S_TA_Racing_Ghosts, S_TA_Racing_NameTags, S_TA_Racing_UIVis);
            case GameMode::Cup: return VisConfig(S_Cup_Racing_Opponents, S_Cup_Racing_Ghosts, S_Cup_Racing_NameTags, S_Cup_Racing_UIVis);
            case GameMode::Solo: return VisConfig(S_Solo_Racing_Opponents, S_Solo_Racing_Ghosts, S_Solo_Racing_NameTags, S_Solo_Racing_UIVis);
            case GameMode::Other: return VisConfig(S_Other_Racing_Opponents, S_Other_Racing_Ghosts, S_Other_Racing_NameTags, S_Other_Racing_UIVis);
        }
    } else {
        switch (mode) {
            case GameMode::None: return VisConfig();
            case GameMode::CotdKo: return VisConfig(S_CotdKo_Specing_Opponents, S_CotdKo_Specing_Ghosts, S_CotdKo_Specing_NameTags, S_CotdKo_Specing_UIVis);
            case GameMode::MM: return VisConfig(S_MM_Specing_Opponents, S_MM_Specing_Ghosts, S_MM_Specing_NameTags, S_MM_Specing_UIVis);
            case GameMode::TA: return VisConfig(S_TA_Specing_Opponents, S_TA_Specing_Ghosts, S_TA_Specing_NameTags, S_TA_Specing_UIVis);
            case GameMode::Cup: return VisConfig(S_Cup_Specing_Opponents, S_Cup_Specing_Ghosts, S_Cup_Specing_NameTags, S_Cup_Specing_UIVis);
            case GameMode::Solo: return VisConfig(S_Solo_Specing_Opponents, S_Solo_Specing_Ghosts, S_Solo_Specing_NameTags, S_Solo_Specing_UIVis);
            case GameMode::Other: return VisConfig(S_Other_Specing_Opponents, S_Other_Specing_Ghosts, S_Other_Specing_NameTags, S_Other_Specing_UIVis);
        }
    }
    return VisConfig();
}


class VisConfig {
    S_Opponents opponents = S_Opponents::Do_Nothing;
    S_Bool ghosts = S_Bool::Do_Nothing;
    S_Bool nameTags = S_Bool::Do_Nothing;
    S_Bool ui = S_Bool::Do_Nothing;

    VisConfig() {}

    VisConfig(S_Opponents opponents, S_Bool ghosts, S_Bool nameTags, S_Bool ui) {
        this.opponents = opponents;
        this.ghosts = ghosts;
        this.nameTags = nameTags;
        this.ui = ui;
    }

    void ApplySettings() {
        if (opponents != S_Opponents::Do_Nothing) {
            SetOpponentsVisibility(OpponentsVisibility(int(opponents)));
        }
        if (ghosts != S_Bool::Do_Nothing) {
            SetGhostVisibility(ghosts == S_Bool::On);
        }
        if (nameTags != S_Bool::Do_Nothing) {
            SetNameTagsVisibility(nameTags == S_Bool::On);
        }
        if (ui != S_Bool::Do_Nothing) {
            SetUIVisibility(ui == S_Bool::On);
        }
    }
}
