{-# LANGUAGE NoMonomorphismRestriction #-}
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.EwmhDesktops
import XMonad.Actions.UpdatePointer
import XMonad.Actions.Plane
import XMonad.Actions.GridSelect
import XMonad.Util.Run (spawnPipe)
import XMonad.Util.Replace
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import XMonad.Layout.NoBorders
import XMonad.Layout.GridVariants
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Hooks.SetWMName
import XMonad.Actions.WindowBringer
import XMonad.Util.Paste

import System.IO
import qualified Data.Map as M

workspaces' = ["Web", "Emacs", "Terminal", "Email", "IRC", "Local"]
gsconfig' = defaultGSConfig { gs_cellheight = 60, gs_cellwidth = 800 }

main = do
  replace
  xmproc <- spawnPipe "xmobar"
  xmonad $ ewmh defaultConfig 
         { modMask = mod4Mask
         , workspaces = workspaces'
         , terminal = "gnome-terminal"
         , focusFollowsMouse = True
         , handleEventHook = handleEventHook defaultConfig <+> fullscreenEventHook
         , manageHook = manageDocks <+> manageHook defaultConfig
         , layoutHook = avoidStruts $ layoutHook defaultConfig ||| noBorders Full ||| Grid (16/10)
         , startupHook = ewmhDesktopsStartup >> setWMName "LG3D"
         , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 80
                        } >> updatePointer (0.5, 0.5) (0.5, 0.5)

         }
         `additionalKeysP`
         [ ("M-s", spawn "xscreensaver-command --lock")
         , ("<Scroll_lock>", spawn "pactl set-sink-mute 0 toggle")
         , ("M-p", spawn "rofi -show run")
         , ("M-a", gridselectWorkspace defaultGSConfig W.view)
         , ("M-x", goToSelected gsconfig')
         , ("M-y", sendMessage ToggleStruts)
         , ("C-M-o", restart "/home/pasja/bin/obtoxmd" False)
         , ("M-o", shellPrompt defaultXPConfig)
         , ("M-<Insert>", pasteSelection)
         , ("C-M-d", spawn "~/bin/laptop2desktop.sh")
         , ("C-M-l", spawn "~/bin/desktop2laptop.sh")
         , ("C-M-t", spawn "~/bin/tv.sh")
         ]
         `additionalKeys`
         M.toList (planeKeys mod4Mask (Lines 2) Circular)

