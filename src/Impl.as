/**
 * offsets for special user profile and user profile wrapper
 *
 * 2023-03-28: {rootMapM.Offset + 0x48, 0, 0x20, 0xA8}, {.., .., 0x18, 0x98}
 * 2023-04-28: {rootMapM.Offset + 0x48, 0, 0x28, 0xA8}, {.., .., 0x30, 0x98}
 *
 * For special interface UI
 *
 * 2023-03-28: app.Network, 0x158, (Names: 0x28, UI: 0x1c, 0x3c, 0x40)
 *
 */

// user profile
uint GhostVisOffset = 0xA8;
uint SecondaryNameTagVisOffset = 0xC4;
// user profile wrapper
uint OpponentVisOffset = 0x98;
// interface UI
uint NameTagVisOffset = 0x28;
uint UIVisOffset = 0x3c;
uint UIVisKeyOffset = 0x1c;


// updated 2024-04-28: +0x8 to both.
uint SpecialUserProfileWrapperOffset = 0x20;
uint SpecialUserProfileOffset = 0x28;


CGameUserProfile@ GetSpecialUserProfile(CGameCtnApp@ app) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto appTy = Reflection::GetType("CTrackMania");
    auto rootMapM = appTy.GetMember("RootMap");
    // orig 0x3a0 = 0x358 + 0x48
    auto off1 = rootMapM.Offset + 0x48;
    int[] offsets = {off1, 0, SpecialUserProfileOffset, GhostVisOffset};
    auto fakeNod1 = Dev::GetOffsetNod(app, offsets[0]);
    auto fakeNod2 = Dev::GetOffsetNod(fakeNod1, offsets[1]);
    auto nod3 = Dev::GetOffsetNod(fakeNod2, offsets[2]);
    return cast<CGameUserProfile>(nod3);
}

CGameUserProfileWrapper@ GetSpecialUserProfileWrapper(CGameCtnApp@ app) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto appTy = Reflection::GetType("CTrackMania");
    auto rootMapM = appTy.GetMember("RootMap");
    // orig 0x3a0
    auto off1 = rootMapM.Offset + 0x48;
    int[] offsets = {off1, 0, SpecialUserProfileWrapperOffset, OpponentVisOffset};
    auto fakeNod1 = Dev::GetOffsetNod(app, offsets[0]);
    auto fakeNod2 = Dev::GetOffsetNod(fakeNod1, offsets[1]);
    auto nod3 = Dev::GetOffsetNod(fakeNod2, offsets[2]);
    return cast<CGameUserProfileWrapper>(nod3);
}

CSmArenaInterfaceUI@ GetSpecialInterfaceUI(CGameCtnApp@ app) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    return cast<CSmArenaInterfaceUI>(Dev::GetOffsetNod(app.Network, 0x158));
}


// Special User Profile

bool GetGhostVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    return Dev::GetOffsetUint32(GetSpecialUserProfile(GetApp()), GhostVisOffset) == 1;
}

void SetGhostVisibility(bool v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    Dev::SetOffset(GetSpecialUserProfile(GetApp()), GhostVisOffset, uint(v ? 1 : 0));
}

bool GetSecNameTagsVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    return Dev::GetOffsetUint32(GetSpecialUserProfile(GetApp()), SecondaryNameTagVisOffset) == 1;
}

void SetSecNameTagsVisibility(bool v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    Dev::SetOffset(GetSpecialUserProfile(GetApp()), SecondaryNameTagVisOffset, uint(v ? 1 : 0));
}

// Special User Profile Wrapper

OpponentsVisibility GetOpponentsVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    return OpponentsVisibility(Dev::GetOffsetUint32(GetSpecialUserProfileWrapper(GetApp()), OpponentVisOffset));
}

void SetOpponentsVisibility(OpponentsVisibility v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    trace('setting opponents visibility: ' + tostring(v));
    Dev::SetOffset(GetSpecialUserProfileWrapper(GetApp()), OpponentVisOffset, uint(v));
}

// Special Interface UI

bool GetPriNameTagsVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    return Dev::GetOffsetUint32(GetSpecialInterfaceUI(GetApp()), NameTagVisOffset) == 1;
}

void SetPriNameTagsVisibility(bool v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    Dev::SetOffset(GetSpecialInterfaceUI(GetApp()), NameTagVisOffset, uint(v ? 1 : 0));
}

// modified version of GetPrimary to handle null nod when not in game
bool GetNameTagsVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto interfaceUi = GetSpecialInterfaceUI(GetApp());
    if (interfaceUi is null) {
        return GetSecNameTagsVisibility();
    }
    return Dev::GetOffsetUint32(interfaceUi, NameTagVisOffset) == 1;
}

// we need to set both because the secondary one via the profile is persistent, but the primary one decides the in-playground setting
void SetNameTagsVisibility(bool v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto interfaceUi = GetSpecialInterfaceUI(GetApp());
    if (interfaceUi !is null) {
        Dev::SetOffset(GetSpecialInterfaceUI(GetApp()), NameTagVisOffset, uint(v ? 1 : 0));
    }
    SetSecNameTagsVisibility(v);
}

// 0x1c -- updated when key pressed, then 0x3c is syncd to this value (so if you flip this value, then the next key press doesn't do anything)
// 0x3c -- actual value that controls on/off
// 0x40 -- duplicate value, appears just to be a copy of 0x3c

bool GetUIVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto interfaceUi = GetSpecialInterfaceUI(GetApp());
    if (interfaceUi !is null) {
        return Dev::GetOffsetUint32(interfaceUi, UIVisOffset) == 1;
    }
    return true;
}

void SetUIVisibility(bool v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto interfaceUi = GetSpecialInterfaceUI(GetApp());
    if (interfaceUi !is null) {
        Dev::SetOffset(interfaceUi, UIVisKeyOffset, uint(v ? 1 : 0));
        Dev::SetOffset(interfaceUi, UIVisOffset, uint(v ? 1 : 0));
        // Dev::SetOffset(interfaceUi, UIVisOffset + 0x4, uint(v ? 1 : 0));
    }
    // also need to check a UI element for this to work for spectating
    auto cp = GetApp().CurrentPlayground;
    if (v && cp !is null) {
        try {
            cp.Interface.InterfaceRoot.Childs[2].IsVisible = true;
        } catch {}
    }
}

// Events

void OnUiSeqChange(CGamePlaygroundUIConfig::EUISequence seq) {
    if (!GameVersionSafe) return;
    if (g_Mode == GameMode::None) return;
    yield();
    bool isPlaying = seq == CGamePlaygroundUIConfig::EUISequence::Playing;
    GetActiveSettings(g_Mode, isPlaying).ApplySettings();
}

enum GameMode {
    None, CotdKo, TA, MM, Solo, Cup, Other
}

GameMode g_Mode = GameMode::None;

void OnGameModeChange(const string &in mode) {
    if (mode == "") {
        g_Mode = GameMode::None;
    } else if (mode.StartsWith("TM_Knockout")) {
        g_Mode = GameMode::CotdKo;
    } else if (mode.StartsWith("TM_Teams_Matchmaking_Online")) {
        g_Mode = GameMode::MM;
    } else if (mode.StartsWith("TM_Cup")) {
        g_Mode = GameMode::Cup;
    } else if (mode.StartsWith("TM_TimeAttack")) {
        g_Mode = GameMode::TA;
    } else if (mode.EndsWith("_Local")) {
        g_Mode = GameMode::Solo;
    } else {
        g_Mode = GameMode::Other;
    }
}
