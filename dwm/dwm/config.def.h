/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 5;       /* snap pixel */
static const unsigned int gappih    = 20;       /* horiz inner gap between windows */
static const unsigned int gappiv    = 10;       /* vert inner gap between windows */
static const unsigned int gappoh    = 10;       /* horiz outer gap between windows and screen edge */
static const unsigned int gappov    = 30;       /* vert outer gap between windows and screen edge */
static       int smartgaps          = 0;        /* 1 means no outer gap when there is only one window */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "monospace:size=10" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#222222";
static const char col_cyan[]        = "#5aecf9";

/* solarized colors http://ethanschoonover.com/solarized */
static const char s_base03[]        = "#002b36";
static const char s_base02[]        = "#073642";
static const char s_base01[]        = "#586e75";
static const char s_base00[]        = "#657b83";
static const char s_base0[]         = "#839496";
static const char s_base1[]         = "#93a1a1";
static const char s_base2[]         = "#eee8d5";
static const char s_base3[]         = "#fdf6e3";


static const char *colors[][3] = {
	

	/* Original */
	{ col_gray3, col_gray1, col_gray2 }, // Norm
	{ col_gray4, col_cyan,  col_cyan  }, // Sel

	/* Dark */
	{ s_base0,  s_base03, s_base2 },  // Norm
	{ s_base0,  s_base02, s_base2 },  // Sel

	/* Light */
	{ s_base00, s_base3,  s_base02 }, // Norm
	{ s_base00, s_base2,  s_base02 }, // Sel

	/* Vaporwave */
	{ "#e0aaff", "#1a0033", "#7b2cbf" }, // Norm
	{ "#ffffff", "#5a189a", "#c77dff" }, // Sel  


	/* Frutiger Aero */
	{ "#003b44", "#dffcff", "#5aeccf" }, // Norm 
	{ "#ffffff", "#00cfff", "#00ffa6" }, // Sel

	/* Matrix */
	{ "#00ff00", "#000000", "#003300" }, // Norm
	{ "#ffffff", "#001a00", "#00ff00" }, // Sel

	/* Cyberpunk */
	{ "#00ff9f", "#0a0a0a", "#ff00ff" }, // Norm
	{ "#ffffff", "#1a1a1a", "#00e5ff" }, // Sel

	/* Sunset */
	{ "#ffd6a5", "#2b2d42", "#ef476f" }, // Norm
	{ "#ffffff", "#ef476f", "#ffd166" }, // Sel

	/* Akatsuki */
	{ "#e0e0e0", "#0a0a0a", "#1a1a1a" }, // Norm
	{ "#ff2a2a", "#1a0000", "#ff0000" }, // Sel

/*	[SchemeStatus]  = { col_gray3, col_gray1,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { col_gray4, col_cyan,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeTagsNorm]  = { col_gray3, col_gray1,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel]  = { col_gray4, col_cyan,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm]  = { col_gray3, col_gray1,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
*/};

/* tagging */
static const char *tags[] = { "", "", "", "", "", "", "", "", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "discord",     NULL,       NULL,       1 << 2,         0,       -1 },
	{ "TelegramDesktop", NULL,   NULL,       1 << 2,         0,       -1 },
	{ "Brave-browser",  NULL,    NULL,       1 << 1,         0,       -1 },
	{ "brave",  NULL,    NULL,               1 << 1,         0,       -1 },
	{ "Nemo",	NULL,	NULL,				 1 << 4,	     0,	 	  -1 },
	{ "Nautilus",	NULL,	NULL,			 1 << 4,		 0,	 	  -1 },
	{ "steam", NULL,	NULL,				 1 << 3,		 0,	 	  -1 },
	{ "Spotify", "spotify",	"Spotify",	 	 1 << 5,		 0,	 	  -1 },
	{ "pavucontrol", NULL,	NULL,		 	 1 << 8,		 0,		  -1 },
	{ "KeePassXC", NULL,	NULL,		 	 1 << 8,		 0,		  -1 },
	{ "Minecraft Launcher", NULL,	NULL,	 1 << 3,		 0,		  -1 },
 	{ "yuzu", NULL,    NULL,          	 	 1 << 3,         0,   	  -1 },
    { "dolphin-emu", NULL,    NULL,          1 << 3,         0,   	  -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 120;  /* refresh rate (per second) for client move/resize */

#define FORCE_VSPLIT 1  /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[T]",      tile },/* first entry is default */
	{ "[F]",      NULL },    
	{ "[M]",      monocle },
	{ "[@]",      spiral },
	{ "[\\]",     dwindle },
	{ "H[]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
	{ "HHH",      grid },
	{ "###",      nrowgrid },
	{ "---",      horizgrid },
	{ ":::",      gaplessgrid },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "kitty", NULL };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },

	{ MODKEY|Mod4Mask,              XK_u,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_u,      incrgaps,       {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_i,      incrigaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_i,      incrigaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_o,      incrogaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_o,      incrogaps,      {.i = -1 } },
/*	{ MODKEY|Mod4Mask,              XK_6,      incrihgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_6,      incrihgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_7,      incrivgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_7,      incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_8,      incrohgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_8,      incrohgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_9,      incrovgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_9,      incrovgaps,     {.i = -1 } }, */

	{ MODKEY|Mod4Mask,              XK_0,      togglegaps,     {0} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },

	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY|ShiftMask,             XK_r,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_1,      setlayout,      {.v = &layouts[5]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_2,      setlayout,      {.v = &layouts[6]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_3,      setlayout,      {.v = &layouts[7]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_4,      setlayout,      {.v = &layouts[8]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_5,      setlayout,      {.v = &layouts[9]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_6,      setlayout,      {.v = &layouts[10]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_7,      setlayout,      {.v = &layouts[11]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_8,      setlayout,      {.v = &layouts[12]} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_9,      setlayout,      {.v = &layouts[13]} },

	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = +1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_t,      schemeToggle,   {0} },
	{ MODKEY|ShiftMask,             XK_z,      schemeCycle,    {0} },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	/*{ MODKEY,			XK_Super_L, spawn,	  SHCMD("ulauncher") },*/
	{ MODKEY|ShiftMask, 		XK_p, 	   spawn, 	  SHCMD("flameshot gui") },
        { MODKEY|ShiftMask,             XK_m,      spawn,         SHCMD("killall Discord") },
	{ MODKEY,                       XK_F5,     spawn,         SHCMD("setxkbmap us") },
        { MODKEY,                       XK_F6,     spawn,         SHCMD("setxkbmap ru -variant phonetic") },
        { ControlMask|ShiftMask,        XK_Escape, spawn,         SHCMD("gnome-system-monitor") },
        {MODKEY|ShiftMask|ControlMask,  XK_c,      spawn,         SHCMD("xkill") },
        {MODKEY|ShiftMask|ControlMask,  XK_Return, spawn,         SHCMD("cool-retro-term -p ~/.config/cool-retro-term/custom.json") },
        {Mod4Mask,                      XK_e,      spawn,         SHCMD("nemo") },
        {Mod4Mask,                      XK_period, spawn,         SHCMD("dwm-emoji.sh") },
	{0, XF86XK_AudioRaiseVolume,          	   spawn,         SHCMD("amixer set Master 5%+") },
        {0, XF86XK_AudioMute,                      spawn,         SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle") },
        {0, XF86XK_AudioLowerVolume,          	   spawn,         SHCMD("amixer set Master 5%-") },
	{0, XF86XK_AudioPlay,                      spawn,         SHCMD("playerctl play-pause") },
	{0, XF86XK_AudioNext,                      spawn,         SHCMD("playerctl next") },
	{0, XF86XK_AudioPrev,                      spawn,         SHCMD("playerctl previous") },
	{0, XF86XK_AudioStop,                      spawn,         SHCMD("playerctl stop") },
	{0, XF86XK_Calculator,          	   spawn,         SHCMD("gnome-calculator") },
        {0, XF86XK_Explorer,                       spawn,         SHCMD("arandr") },
	{0, XF86XK_MonBrightnessUp, 		   spawn,	  SHCMD("brightnessctl set +10%")},
	{0, XF86XK_MonBrightnessDown, 		   spawn, 	  SHCMD("brightnessctl set 10%-")},
        {Mod4Mask,                       XK_l,     spawn,         SHCMD("slock") },
{ Mod1Mask,                       XK_F4,      spawn,         SHCMD("dwm-power.sh") },
{ ControlMask|Mod1Mask,           XK_Delete,  spawn,         SHCMD("dwm-power.sh") },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
