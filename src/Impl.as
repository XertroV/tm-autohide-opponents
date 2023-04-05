/**
 * offsets for special user profile and user profile wrapper
 *
 * 2023-03-28: {rootMapM.Offset + 0x48, 0, 0x20, 0xA8}, {.., .., 0x18, 0x98}
 *
 */


CGameUserProfile@ GetSpecialUserProfile(CGameCtnApp@ app) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto appTy = Reflection::GetType("CTrackMania");
    auto rootMapM = appTy.GetMember("RootMap");
    // orig 0x3a0
    auto off1 = rootMapM.Offset + 0x48;
    int[] offsets = {off1, 0, 0x20, 0xA8};
    auto fakeNod1 = Dev::GetOffsetNod(app, offsets[0]);
    auto fakeNod2 = Dev::GetOffsetNod(fakeNod1, offsets[1]);
    auto nod3 = Dev::GetOffsetNod(fakeNod2, offsets[2]);
    return cast<CGameUserProfile>(nod3);
}

bool GetGhostVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    return Dev::GetOffsetUint32(GetSpecialUserProfile(GetApp()), 0xA8) == 1;
}

void SetGhostVisibility(bool v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    Dev::SetOffset(GetSpecialUserProfile(GetApp()), 0xA8, uint(v ? 1 : 0));
}



enum OpponentsVisibility { Off = 0, Transparent = 1, Opaque = 2 }

CGameUserProfileWrapper@ GetSpecialUserProfileWrapper(CGameCtnApp@ app) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    auto appTy = Reflection::GetType("CTrackMania");
    auto rootMapM = appTy.GetMember("RootMap");
    // orig 0x3a0
    auto off1 = rootMapM.Offset + 0x48;
    int[] offsets = {off1, 0, 0x18, 0x98};
    auto fakeNod1 = Dev::GetOffsetNod(app, offsets[0]);
    auto fakeNod2 = Dev::GetOffsetNod(fakeNod1, offsets[1]);
    auto nod3 = Dev::GetOffsetNod(fakeNod2, offsets[2]);
    return cast<CGameUserProfileWrapper>(nod3);
}

OpponentsVisibility GetOpponentsVisibility() {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    return OpponentsVisibility(Dev::GetOffsetUint32(GetSpecialUserProfileWrapper(GetApp()), 0x98));
}

void SetOpponentsVisibility(OpponentsVisibility v) {
    if (!GameVersionSafe) throw("Call to unsafe dev method");
    trace('setting opponents visibility: ' + tostring(v));
    Dev::SetOffset(GetSpecialUserProfileWrapper(GetApp()), 0x98, uint(v));
}


bool GameModeActive = false;

void OnUiSeqChange(CGamePlaygroundUIConfig::EUISequence seq) {
    if (!GameVersionSafe) return;
    if (!GameModeActive) return;
    bool isPlaying = seq == CGamePlaygroundUIConfig::EUISequence::Playing;
    if (isPlaying) {
        SetOpponentsVisibility(S_WhenRacing);
        if (S_AlsoGhosts) SetGhostVisibility(S_WhenRacing != OpponentsVisibility::Off);
    } else {
        SetOpponentsVisibility(S_WhenNotRacing);
        if (S_AlsoGhosts) SetGhostVisibility(S_WhenNotRacing != OpponentsVisibility::Off);
    }
}

void OnGameModeChange(const string &in mode) {
    GameModeActive = (S_EnabledForKO &&
            (mode == "TM_KnockoutDaily_Online"
            || mode == "TM_Knockout_Online"
            || mode == "TM_Knockout_Debug"))
        || (S_EnabledForMM && mode == "TM_Teams_Matchmaking_Online")
        || (S_EnabledForTA && (
            mode.StartsWith("TM_TimeAttack")
            || mode.StartsWith("TM_Campaign")
            || mode.StartsWith("TM_PlayMap")
            || mode.StartsWith("TM_Archivist")
        ))
        ;
}
