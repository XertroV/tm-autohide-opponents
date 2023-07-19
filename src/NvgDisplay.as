auto nvgFont = nvg::LoadFont("DroidSans.ttf");

void RenderNvg() {
    if (!GameVersionSafe) return;
    if (S_RenderOSD) RenderNvgOSD();
}



void RenderNvgOSD() {
    // don't draw if we're not in a playground
    if (GetApp().CurrentPlayground is null) return;

    if (!S_RenderOSD_HudOff && !UI::IsGameUIVisible()) return;

    vec2 screen = vec2(Draw::GetWidth(), Draw::GetHeight());
    vec2 pos = S_OSD_PositionPct / 100. * screen;
    float fs = S_OSD_SizePct / 100. * screen.y;

    string[] toDraw = {};
    if (S_RenderOSD_Opponents) toDraw.InsertLast("Opponents: " + tostring(GetOpponentsVisibility()));
    if (S_RenderOSD_Ghosts) toDraw.InsertLast("Ghosts: " + (GetGhostVisibility() ? "Visible" : "Hidden"));

    if (toDraw.Length == 0) return;

    nvg::Reset();
    nvg::BeginPath();

    nvg::FontSize(fs);
    nvg::FontFace(nvgFont);
    nvg::TextAlign(nvg::Align::Left | nvg::Align::Top);
    nvg::FillColor(S_OSD_Color);

    for (uint i = 0; i < toDraw.Length; i++) {
        nvg::Text(pos + vec2(0, fs * i * 1.2), toDraw[i]);
    }

    nvg::ClosePath();
}
