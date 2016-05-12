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

customLayoutHook = avoidStruts tiled
    where tiled   = Tall nmaster delta ratio
          nmaster = 1
          ratio   = 1/2
          delta   = 1/100

main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaultConfig {
          manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = customLayoutHook
        , terminal   = "termite"
        , logHook    = dynamicLogWithPP . customPP $ xmproc
        , normalBorderColor = "#000000"
        , focusedBorderColor = styleColor
        , modMask = mod4Mask
        , workspaces = map (:[]) ['a'..'i']
        } `additionalKeys`
        [ ((mod4Mask, xK_l), spawn "slock")
        , ((mod4Mask, xK_r), spawn "rofi -show run")

        -- Toggle control scheme
        , ((mod4Mask, xK_k), spawn "~/.bin/toggle-layout")
        , ((mod4Mask, xK_f), spawn "~/.bin/touchpad-control toggle")

        -- MPD keybinds
        , ((mod4Mask, xK_comma), spawn "~/.bin/mpc-query toggle")
        , ((mod4Mask, xK_m), spawn "~/.bin/mpc-query prev")
        , ((mod4Mask, xK_period), spawn "~/.bin/mpc-query next")
        ]
