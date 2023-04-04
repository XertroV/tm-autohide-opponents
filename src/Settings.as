[Setting name="Opponent visibility when driving" category="General"]
OpponentsVisibility S_WhenRacing = OpponentsVisibility::Off;

[Setting name="Opponent visibility when not driving" category="General"]
OpponentsVisibility S_WhenNotRacing = OpponentsVisibility::Opaque;

[Setting name="Enabled for Knockout Rounds?" category="General"]
bool S_EnabledForKO = true;

[Setting name="Enabled for TimeAttack?" category="General"]
bool S_EnabledForTA = false;

[Setting name="Enabled for Matchmaking?" category="General"]
bool S_EnabledForMM = false;

[Setting name="Also autohide Ghosts?" category="General"]
bool S_AlsoGhosts = false;

[SettingsTab name="Current Visibility"]
void Render_CurrentVis() {
    if (!GameVersionSafe) {
        UI::Text("Game version unsafe!");
        return;
    }
    UI::Text("Opponent Visibility: " + tostring(GetOpponentsVisibility()));
    UI::Text("Ghosts Visibile: " + tostring(GetGhostVisibility()));
}
