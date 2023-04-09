string lastGM;
void WatchForGameModeChanges() {
    auto net = cast<CTrackManiaNetwork>(GetApp().Network);
    while (GameVersionSafe) {
        yield();
        string currGM = cast<CTrackManiaNetworkServerInfo>(net.ServerInfo).CurGameModeStr;
        if (currGM != lastGM) {
            lastGM = currGM;
            OnGameModeChange(currGM);
        }
    }
}

CGamePlaygroundUIConfig::EUISequence lastUiSeq = CGamePlaygroundUIConfig::EUISequence::None;
void WatchForUiSeqChanges() {
    auto app = cast<CGameManiaPlanet>(GetApp());
    while (GameVersionSafe) {
        yield();
        if (app.CurrentPlayground is null) {
            if (lastUiSeq != CGamePlaygroundUIConfig::EUISequence::None) {
                lastUiSeq = CGamePlaygroundUIConfig::EUISequence::None;
                OnUiSeqChange(lastUiSeq);
            }
            continue;
        }
        if (app.CurrentPlayground.UIConfigs.Length == 0) continue;
        CSmPlayer@ player = VehicleState::GetViewingPlayer();
        auto currSeq = (player is null || player.ScriptAPI.Login != LocalUsersLogin)
                ? CGamePlaygroundUIConfig::EUISequence::None
                : app.CurrentPlayground.UIConfigs[0].UISequence;
        if (lastUiSeq != currSeq) {
            lastUiSeq = currSeq;
            OnUiSeqChange(lastUiSeq);
        }
    }
}

void TriggerRecheck() {
    OnUiSeqChange(lastUiSeq);
}
