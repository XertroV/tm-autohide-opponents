bool GameVersionSafe = false;
const string LatestGameVersionDuringDev = "2023-03-28_19_52";

void Main() {
    EnsureGameVersionCompatibility();
    if (!GameVersionSafe) {
        WarnBadGameVersion();
        return;
    }
    startnew(WatchForUiSeqChanges);
    startnew(WatchForGameModeChanges);
}

string TmGameVersion = "";
void EnsureGameVersionCompatibility() {
    TmGameVersion = GetApp().SystemPlatform.ExeVersion;
    GameVersionSafe = TmGameVersion == LatestGameVersionDuringDev;
    if (GameVersionSafe) return;
    // todo: get config from openplanet
    GameVersionSafe = GetStatusFromOpenplanet();
}

void WarnBadGameVersion() {
    NotifyWarning("Game version ("+TmGameVersion+") not marked as compatible with this version of the plugin -- will be inactive!\n\nChecking new versions is a manual process and avoids crashing your game after an update.");
}


void Notify(const string &in msg) {
    UI::ShowNotification(Meta::ExecutingPlugin().Name, msg);
    trace("Notified: " + msg);
}

void NotifyError(const string &in msg) {
    warn(msg);
    UI::ShowNotification(Meta::ExecutingPlugin().Name + ": Error", msg, vec4(.9, .3, .1, .3), 15000);
}

void NotifyWarning(const string &in msg) {
    warn(msg);
    UI::ShowNotification(Meta::ExecutingPlugin().Name + ": Warning", msg, vec4(.9, .6, .2, .3), 15000);
}

const string PluginIcon = Icons::EyeSlash;
const string MenuTitle = "\\$3ff" + PluginIcon + "\\$z " + Meta::ExecutingPlugin().Name;

// // show the window immediately upon installation
// [Setting hidden]
// bool ShowWindow = true;

// /** Render function called every frame intended only for menu items in `UI`. */
// void RenderMenu() {
//     if (UI::MenuItem(MenuTitle, "", ShowWindow)) {
//         ShowWindow = !ShowWindow;
//     }
// }
