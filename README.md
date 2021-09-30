# **Team Collaboration Aides - BFT and more!**
Some scripts to keep track of your teams. Requires DUI and ACE3.

## **For mission makers**
There's three variables used:
- **BFT_groupMarker_visible**, obvious. 
- **BFT_groupMarker_type**, can be one of: *air, antiair, armor, art, hq, inf, installation, maint, mech_inf, med, mortar, motor_inf, naval, ordinance, plane, recon, service, support, uav, unknown*.
- **BFT_groupMarker_color**, found [here](https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors). (Note: other mods can add to CfgMarkers, these will also be available and show up in the map interact menu)

An example (in the init field of a group): 
```ts
this setVariable ["BFT_groupMarker_visible", true];
this setVariable ["BFT_groupMarker_type", "mech_inf"];
this setVariable ["BFT_groupMarker_color", "ColorOrange"];
```

Player groups will have their marker enabled by default. 

## **For developers**
I use [HEMTT](https://github.com/BrettMayson/HEMTT) to build etc.

`./hemtt.exe build` to build 

`./hemtt.exe build --release` to create a release

`./hemtt.exe file-patching` to create link for file patching

For file patching to work with CBA functions you need to add the following to your test mission's description.ext: 
```ts
class CfgSettings {
    class CBA {
        class Caching {
            compile = 0;
            xeh = 0;
            functions = 0;
        };
    };
};
```


## **Todos:**
- Group markers (BFT)
  - Allow custom names 
  - Show team info when clicking marker
  - Need GPS?
  - Can be disabled/scrambled within a given area (e.g. they are jammed) (Pitch: "Scramble BFT" module for Zeus & 3DEN)
  - Add the options to 3DEN and Zeus
  - Add quick function for mission makers to set group vars
  - Add ability to disable BFT for groups (for mission makers). (Implement HT's networks idea)
  - Larger group support (ie Alpha lead with Alpha 1,2,3 etc)
  - Allow mission makers to disable completely

- Player markers (BFT)
  - Clean up (separate functions mainly)
  - Need GPS?
  - Change show hide marker thingy to have options "Off, Zeus only, On".
  - Allow mission makers to disable completely

- Troop overview (BFT)
  - A tab on the map with all teams/units

- Vehicles
  - Vehicle damage status easier to see
  - Can we stabilize the gun when vehicle turning? 
  - Keybinds for speed limiter (Try to use the ACE keybind maybe? Default is del, so ctrl+del = nearest speed lower than current, shift+del nearest speed higher than current)
  - Maybe rework the ACE speed limiter. Right now it simply wont exceed the set speed, which makes no sense when going downhill for example. Maybe just ignore holding W whenever the speed is above the set speed? 

- Mission tools
  - Some mission timeout thing? (Mission ends after x minutes, admins can add to it)
  - Some tool that allows people to select certain gear during briefing (Briefing arsenal)
  - Look into adding an improved "Cover Map" module, which covers the map and squares can be "Unlocked" by scripts
    Maybe allow non square shapes if we find a way
    https://community.bistudio.com/wiki/drawTriangle 

Misc. 
  - Dslyexci seems to have made a lot of private things for ShackTac, could replicate some
      Like the heli tools (gunner compass, view on map?), seen in this video https://www.youtube.com/watch?v=gI-GJpCpza8 
  - mb move the hand comms thingy to a separate menu? Like opens a new ACE interact menu or smth
