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
        } `additionalKeys`
        [ ((mod4Mask, xK_l), spawn "alock") ]
