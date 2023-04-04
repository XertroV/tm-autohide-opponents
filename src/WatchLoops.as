string lastGM;
void WatchForUiSeqChanges() {
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
void WatchForGameModeChanges() {
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
        if (lastUiSeq != app.CurrentPlayground.UIConfigs[0].UISequence) {
            lastUiSeq = app.CurrentPlayground.UIConfigs[0].UISequence;
            OnUiSeqChange(lastUiSeq);
        }
    }
}
