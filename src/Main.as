bool GameVersionSafe = false;
const string[] KnownSafeVersions = {"2023-03-28_19_52", "2023-03-31_13_17"};
string LocalUsersLogin = GetLocalLogin();

/**
 * New version checklist:
 * - Update KnownSafeVersions
 * - Update JSON config on site
 * - Update info toml min version
 */

void Main() {
    startnew(CacheLocalLoginWhenAvailable);
    EnsureGameVersionCompatibility();
    if (!GameVersionSafe) {
        WarnBadGameVersion();
        return;
    }
    startnew(WatchForUiSeqChanges);
    startnew(WatchForGameModeChanges);
    if (!S_ShownInitSettings) {
        S_ShownInitSettings = true;
        ShowWindow = true;
    }
}

string TmGameVersion = "";
void EnsureGameVersionCompatibility() {
    TmGameVersion = GetApp().SystemPlatform.ExeVersion;
    GameVersionSafe = KnownSafeVersions.Find(TmGameVersion) > -1;
    if (GameVersionSafe) return;
    GameVersionSafe = GetStatusFromOpenplanet();
}

void WarnBadGameVersion() {
    NotifyWarning("Game version ("+TmGameVersion+") not marked as compatible with this version of the plugin -- will be inactive!\n\nChecking new versions is a manual process and avoids crashing your game after an update.");
}

void CacheLocalLoginWhenAvailable() {
    auto start = Time::Now;
    while (true) {
        sleep(100);
        LocalUsersLogin = GetLocalLogin();
        if (LocalUsersLogin.Length > 10) break;
    }
    // took about 2.5s at startup
    // print("Got local user login after: " + Time::Format(Time::Now - start));
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

/** Called when a setting in the settings panel was changed.
*/
void OnSettingsChanged() {
    startnew(TriggerRecheck);
}

const string PluginIcon = Icons::EyeSlash;
const string MenuTitle = "\\$3ff" + PluginIcon + "\\$z " + Meta::ExecutingPlugin().Name;

[Setting hidden]
bool ShowWindow = false;

// /** Render function called every frame intended only for menu items in `UI`. */
// void RenderMenu() {
//     if (UI::MenuItem(MenuTitle, "", ShowWindow)) {
//         ShowWindow = !ShowWindow;
//     }
// }

/** Render function called every frame.
*/
void RenderInterface() {
    if (!ShowWindow) return;
    // if (!S_ShownInitSettings)
    UI::SetNextWindowSize(860, 500, UI::Cond::Appearing);
    if (UI::Begin(MenuTitle, ShowWindow)) {
        UI::Text("Settings");
        UI::Separator();
        Render_GeneralSettings();
    }
    UI::End();
}
