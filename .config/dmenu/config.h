/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
 
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 500;                    /* minimum width when centered */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"SourceCodePro:size=11"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
		    /*     fg         bg       */
	[SchemeNorm] = { "#000000", "#a7d407" },
	[SchemeSel] = { "#000000", "#ffffff" },
	[SchemeSelHighlight] = { "#a7d407", "#000000" },
	[SchemeNormHighlight] = { "#000000", "#ffffff" },
	[SchemeOut] = { "#ffffff", "#00ffff" },
	[SchemeOutHighlight] = { "#000000", "#ffffff" },
	[SchemeMid] = { "#ffffff", "#000000" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

 /* Size of the window border */
static const unsigned int border_width = 4;
