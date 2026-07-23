/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 3;
static const unsigned int snap      = 0;
static const int showbar            = 1;
static const int topbar             = 1;
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
#define COORDINATES_STYLE "[x%d y%d]"

static const char normbgcolor[]           = "#0f1414";
static const char normbordercolor[]       = "#444444";
static const char normfgcolor[]           = "#dfe3e2";
static const char selfgcolor[]            = "#0f1414";
static const char selbordercolor[]        = "#87CEEB";
static const char selbgcolor[]            = "#87CEEB";
static const char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};

#define CENTER_NEW_FLOATING_WINDOWS 1
#define NEW_FLOATING_WINDOWS_APPEAR_UNDER_CURSOR 0

#if GAPS
static const unsigned int gappx = 8;
#endif

#if BAR_HEIGHT
static const int user_bh = 0;
#endif

#if BAR_PADDING
static const int top_vertpad = 0;
static const int bottom_vertpad = 0;
static const int left_sidepad = 0;
static const int right_sidepad = 0;
#endif

#define BAR_ALWAYS_ON_TOP 1

#if EXTERNAL_BARS
#define EXTERNAL_BARS_ALWAYS_ON_TOP 1
#endif

#if INFINITE_TAGS
#define PINNED_WINDOWS_ALWAYS_ON_TOP 1
#endif

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" };

#if OCCUPIED_TAGS_DECORATION
static const char *occupiedtags[] = { "1+", "2+", "3+", "4+", "5+", "6+", "7+", "8+", "9+" };
#endif

#if INFINITE_TAGS
#define MOVE_CANVAS_STEP 120
#endif

#if INFINITE_TAGS && IT_SHOW_COORDINATES_IN_BAR
#define COORDINATES_DIVISOR 10
#endif

#if MOVE_RESIZE_WITH_KEYBOARD
#define MOVE_WITH_KEYBOARD_STEP 50
#define RESIZE_WITH_KEYBOARD_STEP 50
#endif

#if AUTOSTART
static const char *const autostart[] = {
  "feh", "--bg-scale", "/home/sabrina/Wallpapers/wallhaven-6kqoz7_1920x1080.png",
  "blueman-applet",
  NULL
};
#endif

static const Rule rules[] = {
  { "Gimp",     NULL,       NULL,       0,            1,           -1 },
  { "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55;
static const int nmaster     = 1;
static const int resizehints = 1;
static const int lockfullscreen = 1;
#if LOCK_MOVE_RESIZE_REFRESH_RATE
static const int refreshrate = 360;
#endif
static const Layout layouts[] = {
  { "><>",      NULL },
  { "[]=",      tile },
  { "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define ALTERNATE_MODKEY Mod1Mask

#define SCROLL_UP Button4
#define SCROLL_DOWN Button5

#define TAGKEYS(KEY,TAG) \
  { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
  { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[] = { "rofi", "-show", "run", NULL };

static const char *termcmd[]        = { "alacritty", NULL };
static const char *nautiluscmd[]    = { "nautilus", NULL };
static const char *vivaldicmd[]     = { "vivaldi", NULL };
static const char *spotifycmd[]     = { "spotify", NULL };
static const char *launchercmd[]    = { "rofi", "-show", "run", NULL };
static const char *lockcmd[]        = { "slock", NULL };

static const char *volupcmd[]       = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL };
static const char *voldowncmd[]     = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL };
static const char *volmutecmd[]     = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };

static const char *brightnessupcmd[]   = { "brightnessctl", "set", "+5%", NULL };
static const char *brightnessdowncmd[] = { "brightnessctl", "set", "5%-", NULL };

static const Key keys[] = {
  /* Apps */
  { MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
  { MODKEY,                       XK_E,      spawn,          {.v = nautiluscmd } },
  { MODKEY,                       XK_F,      spawn,          {.v = vivaldicmd } },
  { MODKEY,                       XK_S,      spawn,          {.v = spotifycmd } },
  { MODKEY,                       XK_space,  spawn,          {.v = launchercmd } },

  /* Window management */
  { MODKEY,                       XK_Q,      killclient,     {0} },
  { MODKEY,                       XK_C,      setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_D,      togglefullscr,  {0} },
  { MODKEY,                       XK_A,      togglefloating, {0} },

  /* Focus (directional) */
  { ALTERNATE_MODKEY,             XK_Tab,    focusdir,       {.i = 1 } },
  { ALTERNATE_MODKEY|ShiftMask,   XK_Tab,    focusdir,       {.i = 0 } },
  { MODKEY,                       XK_Left,   focusdir,       {.i = 0 } },
  { MODKEY,                       XK_Right,  focusdir,       {.i = 1 } },
  { MODKEY,                       XK_Up,     focusdir,       {.i = 2 } },
  { MODKEY,                       XK_Down,   focusdir,       {.i = 3 } },

  /* Move windows (directional) */
  { MODKEY|ShiftMask,             XK_Left,   movedir,        {.i = 0 } },
  { MODKEY|ShiftMask,             XK_Right,  movedir,        {.i = 1 } },
  { MODKEY|ShiftMask,             XK_Up,     movedir,        {.i = 2 } },
  { MODKEY|ShiftMask,             XK_Down,   movedir,        {.i = 3 } },

  /* Lock screen */
  { MODKEY,                       XK_L,      spawn,          {.v = lockcmd } },

  /* Layouts */
  { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
  { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
  { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
  { MODKEY,                       XK_space,  setlayout,      {0} },
  { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },

  /* Tags */
  { MODKEY,                       XK_Tab,    view,           {.ui = ~0 } },
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  TAGKEYS(                        XK_6,                      5)
  TAGKEYS(                        XK_7,                      6)
  TAGKEYS(                        XK_8,                      7)
  TAGKEYS(                        XK_9,                      8)
  { MODKEY,                       XK_0,      view,           {.ui = 1 << 9 } },
  { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = 1 << 9 } },

  /* Quit */
  { MODKEY|ShiftMask,             XK_Q,      quit,           {0} },

  /* Monitors */
  { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period, focusmon,       {.i = +1 } },

  /* Screenshots */
  { 0,                            XK_Print,  spawn,          SHCMD("maim /home/sabrina/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d-%H%M%S).png") },
  { ControlMask,                  XK_Print,  spawn,          SHCMD("maim /home/sabrina/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d-%H%M%S).png") },
  { Mod1Mask,                     XK_Print,  spawn,          SHCMD("maim -i $(xdotool getactivewindow) /home/sabrina/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d-%H%M%S).png") },

  /* Hardware: Audio */
  { 0,                            XF86XK_AudioRaiseVolume,  spawn, {.v = volupcmd } },
  { 0,                            XF86XK_AudioLowerVolume,  spawn, {.v = voldowncmd } },
  { 0,                            XF86XK_AudioMute,         spawn, {.v = volmutecmd } },
  { 0,                            XF86XK_AudioPlay,         spawn, SHCMD("playerctl play-pause") },
  { 0,                            XF86XK_AudioPause,        spawn, SHCMD("playerctl play-pause") },
  { 0,                            XF86XK_AudioNext,         spawn, SHCMD("playerctl next") },
  { 0,                            XF86XK_AudioPrev,         spawn, SHCMD("playerctl previous") },
  { 0,                            XF86XK_AudioStop,         spawn, SHCMD("playerctl stop") },

  /* Hardware: Brightness */
  { 0,                            XF86XK_MonBrightnessUp,   spawn, {.v = brightnessupcmd } },
  { 0,                            XF86XK_MonBrightnessDown, spawn, {.v = brightnessdowncmd } },
};

/* button definitions */
static const Button buttons[] = {
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkWinTitle,          0,              Button2,        swapmaster,     {0} },
  { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
