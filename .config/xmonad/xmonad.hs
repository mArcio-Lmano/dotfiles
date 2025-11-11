-- Imports
import XMonad
import Data.Monoid
import System.Exit

-- Gaps
import XMonad.Layout.Spacing

-- Grid Layout
import XMonad.Layout.Grid

-- Wallpaper
import XMonad.Util.Run
import XMonad.Util.SpawnOnce

-- Xmobar
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.DynamicLog
import XMonad.Util.ClickableWorkspaces

  -- Float
import XMonad.Hooks.ManageHelpers

-- Multimedia keys
import Graphics.X11.ExtraTypes.XF86

-- Toggle Border
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders

-- Screen Shot
-- import XMonad.Util.Ungrab
import XMonad.Operations

-- Terminal on Startup
import XMonad.Actions.SpawnOn

-- Cursor
import XMonad.Util.Cursor

-- Grid Select
import XMonad.Actions.GridSelect
import XMonad.Actions.WorkspaceNames

-- Resize Layout
import XMonad.Layout.ResizableTile

 --------------------------------
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

--ScratchPads
import XMonad.ManageHook
import XMonad.Util.NamedScratchpad
import XMonad.Hooks.OnPropertyChange

-- Window Swallowing
import XMonad.Hooks.WindowSwallowing

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
myTerminal :: String
myTerminal = "alacritty"

-- Font
myFont :: String
myFont = "xft:FantasqueSansMono Nerd Font:bold:size=18:antialias=true:hinting=true"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Width of the window border in pixels.
--
myBorderWidth   = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask       = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces    = ["1","2","3","4","5","6","7","8","9"]
--
-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor  = "#a7d407"
myFocusedBorderColor = "#ffffff"


------------------------------------------------------------------------
-- Grid Selec
myNavigation :: TwoD a (Maybe a)
myNavigation = makeXEventhandler $ shadowWithKeymap navKeyMap navDefaultHandler
 where navKeyMap = M.fromList [
          ((0,xK_Escape), cancel)
         ,((0,xK_Return), select)
         ,((0,xK_slash) , substringSearch myNavigation)
         ,((0,xK_Left)  , move (-1,0)  >> myNavigation)
         ,((0,xK_h)     , move (-1,0)  >> myNavigation)
         ,((0,xK_Right) , move (1,0)   >> myNavigation)
         ,((0,xK_l)     , move (1,0)   >> myNavigation)
         ,((0,xK_Down)  , move (0,1)   >> myNavigation)
         ,((0,xK_j)     , move (0,1)   >> myNavigation)
         ,((0,xK_Up)    , move (0,-1)  >> myNavigation)
         ,((0,xK_k)     , move (0,-1)  >> myNavigation)
         ,((0,xK_y)     , move (-1,-1) >> myNavigation)
         ,((0,xK_i)     , move (1,-1)  >> myNavigation)
         ,((0,xK_n)     , move (-1,1)  >> myNavigation)
         ,((0,xK_m)     , move (1,-1)  >> myNavigation)
         ,((0,xK_space) , setPos (0,0) >> myNavigation)
         ]
       navDefaultHandler = const myNavigation

-- Grid Color Scheme
myColorizer :: Window -> Bool -> X (String, String)
myColorizer = colorRangeFromClassName
                (0x00,0x00,0x00) -- lowest inactive bg
                (0x00,0x00,0x00) -- highest inactive bg
                (0xff,0xff,0xff) -- active bg
                (0xa7,0xd4,0x07) -- inactive fg
                (0x00,0x00,0x00) -- active fg


-- gridSelect menu layout
mygridConfig :: p -> GSConfig Window
mygridConfig colorizer = (buildDefaultGSConfig myColorizer)
    { gs_cellheight   = 40
    , gs_cellwidth    = 200
    , gs_cellpadding  = 6
    , gs_navigate     = myNavigation
    , gs_originFractX = 0.5
    , gs_originFractY = 0.5
    , gs_font         = myFont
    }

mygridConfigW :: HasColorizer a => GSConfig a
mygridConfigW = def { gs_cellheight    = 100
                    , gs_cellwidth     = 100
                    , gs_font          = myFont
                    , gs_navigate      = myNavigation
                    }


spawnSelected' :: [(String, String)] -> X ()
spawnSelected' lst = gridselect conf lst >>= flip whenJust spawn
    where conf = def
                   { gs_cellheight   = 40
                   , gs_cellwidth    = 180
                   , gs_cellpadding  = 6
                   , gs_originFractX = 0.5
                   , gs_originFractY = 0.5
                   , gs_font         = myFont
                   }

runSelectedAction' :: GSConfig (X ()) -> [(String, X ())] -> X ()
runSelectedAction' conf actions = do
    selectedActionM <- gridselect conf actions
    case selectedActionM of
        Just selectedAction -> selectedAction
        Nothing -> return ()

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ 
      ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
      -- launch dmenu
      , ((modm,               xK_d       ), spawn "dmenu_run -c -l 15")
      -- lauch firefox
      , ((modm,               xK_f        ), spawn "firefox")

      -- lauch mocp (Music On Consule, not working)

      -- screen shot
      , ((0,                  xK_Print    ), unGrab >> spawn "scrot -u ~/Images/Screenshots/%Y-%m-%d-%T-screenshot.png") -- focused window
      , ((shiftMask,          xK_Print    ), unGrab >> spawn "scrot ~/Images/Screenshots/%Y-%m-%d-%T-screenshot.png")    -- windows on the screen
      
      -- close focused window
      , ((modm .|. shiftMask, xK_q     ), kill)

      -- Rotate through the available layout algorithms
      , ((modm,               xK_space ), sendMessage NextLayout)

      --  Reset the layouts on the current workspace to default
      , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

      -- Resize viewed windows to the correct size
      , ((modm,               xK_n     ), refresh)

      -- Move focus to the next window
      , ((modm,               xK_Tab   ), windows W.focusDown)

      -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    , ((modm               , xK_g    ), goToSelected $ mygridConfig myColorizer)
    , ((modm               , xK_b    ), bringSelected $ mygridConfig myColorizer)
    , ((modm               , xK_w    ), gridselectWorkspace mygridConfigW W.greedyView)
    --, ((modm               , xK_w    ), gridselectWorkspace' mygridConfigW gsWorkspaces)
    
    -- ScratchPads
    , ((modm .|. shiftMask, xK_t), namedScratchpadAction myScratchPads "terminal")
    , ((modm .|. shiftMask, xK_m), namedScratchpadAction myScratchPads "music")
    
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_c     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_c     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    , ((modm              , xK_x), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- Multimedia keys from the keybord
    [ ((0, xF86XK_AudioLowerVolume   ), spawn "amixer -D pulse sset Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume   ), spawn "amixer -D pulse sset Master 5%+")
    , ((0, xF86XK_AudioMute          ), spawn "amixer -D pulse sset Master toggle")]
    ++

    -- Resize windows inside resizeble layout
    [ ((modm, xK_a), sendMessage MirrorShrink)
    , ((modm, xK_z), sendMessage MirrorExpand)]
    -- Togle Avoid Structs and Toggle Gaps
   --[ ((modm               , xK_b    ), sendMessage (Toggle NOBORDERS))]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--

myGaps = spacingRaw True             -- False=Apply even when single window
                    (Border 2 2 2 2) -- Screen border size top bot rght lft
                    True             -- Enable screen border
                    (Border 2 2 2 2) -- Window border size
                    True             -- Enable window borders


myLayout = smartBorders $ avoidStruts $ myGaps $ tiled ||| resizeble ||| Mirror tiled  ||| Full ||| Grid
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- Resible tile
     resizeble = ResizableTall 2 delta ratio [] 

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100


------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
-- Scratch Pads

myScratchPads :: [NamedScratchpad]
myScratchPads = [ NS "terminal" spawnTerm findTerm manageTerm
                , NS "music" spawnMusic findMusic manageMusic
 ]
    where
    spawnTerm  = myTerminal ++ " -t scratchpad"
    findTerm   = title =? "scratchpad"
    manageTerm = customFloating $ W.RationalRect l t w h
        where
            h = 0.5
            w = 0.5
            t = (1 - h) / 2  -- Center vertically
            l = (1 - w) / 2  -- Center horizontally

    spawnMusic  = "spotify"
    findMusic   = className =? "Spotify"
    manageMusic = customFloating $W.RationalRect l t w h
        where
            h = 0.5
            w = 0.5
            t = (1 - h) / 2
            l = (1 - w) / 2

myManageHook = composeAll
    [ title =? "Burrito" --> doFloat
    , className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
    , className =? "Tk"             --> doFloat
    , className =? "Toplevel"       --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ] <+> namedScratchpadManageHook myScratchPads


--
--
--
-- scratchpads = [
--     NS "terminal" myTerminal (title =? "terminal") defaultFloating
--  ] where role = stringProperty "WM_WINDOW_ROLE"
--
-- myScratchpadHook = namedScratchpadManageHook scratchpads
------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook

-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
-- myEventHook = mempty
myEventHook = onXPropertyChange "WM_NAME" (className =? "Spotify" --> floating) 
    where 
        floating = customFloating $W.RationalRect l t w h
            where
                h = 0.7
                w = 0.7
                t = (1 - h) / 2
                l = (1 - w) / 2
     

-- Window Swallowing
mySwallowEventHook = swallowEventHook (className =? "Alacritty") (return True)
------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--myLogHook = myPP >>= dynamicLogWithPP
myLogHook = return ()

-- Xmobar Workspaces
myBar = "xmobar"
myPP  = xmobarPP { ppCurrent         = xmobarColor "#a7d407" "" . wrap "[" "]" ,
                   ppHidden          = xmobarColor "#a7d407" "" ,
                   ppHiddenNoWindows = xmobarColor "white" "" , 
                   ppUrgent          = xmobarColor "red" "" ,
                   ppTitle           = shorten 30,
                   ppLayout          = xmobarColor "#a7d507" "" }
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_s)

------------------------------------------------------------------------
------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook :: X ()
myStartupHook = do
                spawnOnce "picom -b"
                spawnOnce "xmobar -x 0 /home/talocha/.config/xmobar/xmobarrc"
--                spawnOnce "trayer --transparent true --alpha 0 --tint black --edge top --align right --height 25 --widthtype request"
                spawnOnce "feh --bg-fill --randomize ~/Pictures/wallpapers/*"
                setDefaultCursor xC_left_ptr
                mySpawn "1" "alacritty"
                -- spawnOnce "/usr/bin/emacs --daemon"

mySpawn :: String -> String -> X()
mySpawn workspace program = do
                             spawnOn workspace program

------------------------------------------------------------------------

-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify. No need to modify this.
--
main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults
--main = xmonad defaults

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults = def {

        terminal           = myTerminal,
        focusFollowsMouse  = myFocusFollowsMouse,
        clickJustFocuses   = myClickJustFocuses,
        borderWidth        = myBorderWidth,
        modMask            = myModMask,
        workspaces         = myWorkspaces,
        normalBorderColor  = myNormalBorderColor,
        focusedBorderColor = myFocusedBorderColor,

      -- key bindings
        keys               = myKeys,
        mouseBindings      = myMouseBindings,

      -- hooks, layouts
        layoutHook         = myLayout,
        manageHook         = myManageHook,
        handleEventHook    = myEventHook <+> mySwallowEventHook,
        logHook            = myLogHook,
        startupHook        = myStartupHook
    }

-- | Finally, a copy of the default bindings in simple textual tabular format.
help :: String
help = unlines ["The default modifier key is 'alt'. Default keybindings:",
    "",
    "-- launching and killing programs",
    "mod-Shift-Enter  Launch xterminal",
    "mod-d            Launch dmenu",
    "mod-Shift-p      Launch gmrun",
    "mod-Shift-c      Close/kill the focused window",
    "mod-Space        Rotate through the available layout algorithms",
    "mod-Shift-Space  Reset the layouts on the current workSpace to default",
    "mod-n            Resize/refresh viewed windows to the correct size",
    "",
    "-- move focus up or down the window stack",
    "mod-Tab        Move focus to the next window",
    "mod-Shift-Tab  Move focus to the previous window",
    "mod-j          Move focus to the next window",
    "mod-k          Move focus to the previous window",
    "mod-m          Move focus to the master window",
    "",
    "-- modifying the window order",
    "mod-Return   Swap the focused window and the master window",
    "mod-Shift-j  Swap the focused window with the next window",
    "mod-Shift-k  Swap the focused window with the previous window",
    "",
    "-- resizing the master/slave ratio",
    "mod-h  Shrink the master area",
    "mod-l  Expand the master area",
    "",
    "-- floating layer support",
    "mod-t  Push window back into tiling; unfloat and re-tile it",
    "",
    "-- increase or decrease number of windows in the master area",
    "mod-comma  (mod-,)   Increment the number of windows in the master area",
    "mod-period (mod-.)   Deincrement the number of windows in the master area",
    "",
    "-- quit, or restart",
    "mod-Shift-q  Quit xmonad",
    "mod-q        Restart xmonad",
    "mod-[1..9]   Switch to workSpace N",
    "",
    "-- Workspaces & screens",
    "mod-Shift-[1..9]   Move client to workspace N",
    "mod-{w,e,r}        Switch to physical/Xinerama screens 1, 2, or 3",
    "mod-Shift-{w,e,r}  Move client to screen 1, 2, or 3",
    "",
    "-- Mouse bindings: default actions bound to mouse events",
    "mod-button1  Set the window to floating mode and move by dragging",
    "mod-button2  Raise the window to the top of the stack",
    "mod-button3  Set the window to floating mode and resize by dragging"]



