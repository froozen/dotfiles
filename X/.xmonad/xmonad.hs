import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.EZConfig (additionalKeys)
import System.IO

styleColor = "#6074c8"

customPP handle = xmobarPP {
             ppOutput = hPutStrLn handle
           , ppLayout = const ""
           , ppTitle  = const ""
           , ppCurrent = xmobarColor "black" styleColor . pad
           , ppHidden  = pad
           , ppWsSep   = ""
           }

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
          manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts  $  layoutHook defaultConfig
        , terminal   = "termite"
        , logHook    = dynamicLogWithPP . customPP $ xmproc
        , normalBorderColor = "#000000"
        , focusedBorderColor = styleColor
        , workspaces = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
        } `additionalKeys`
        [ ((mod4Mask, xK_l), spawn "alock -bg shade")
        , ((mod1Mask, xK_r), spawn "dmenu_run")

        -- Toggle control scheme
        , ((mod4Mask, xK_k), spawn "~/.bin/toggle-layout.sh")
        , ((mod4Mask, xK_f), spawn "~/.bin/touchpad-control.sh toggle")

        -- MPD keybinds
        , ((mod4Mask, xK_comma), spawn "~/.bin/mpc-query.sh toggle")
        , ((mod4Mask, xK_m), spawn "~/.bin/mpc-query.sh prev")
        , ((mod4Mask, xK_period), spawn "~/.bin/mpc-query.sh next")
        ]
