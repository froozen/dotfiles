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
        , terminal   = "urxvt"
        , logHook    = dynamicLogWithPP . customPP $ xmproc
        , normalBorderColor = "#000000"
        , focusedBorderColor = styleColor
        , workspaces = ["a", "b", "c", "d", "e", "f", "g", "h", "i"]
        } `additionalKeys`
        [ ((mod4Mask, xK_l), spawn "alock")
        , ((mod1Mask, xK_r), spawn "dmenu_run")
        , ((mod4Mask, xK_k), spawn "~/.bin/toggle-layout.sh")
        ]
