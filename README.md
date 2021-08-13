# **Team Collaboration Aides - BFT and more!**
Some scripts to keep track of your teams. Requires DUI and ACE3.

## **For mission makers**
There's three variables used:
- **BFT_groupMarker_visible**, obvious. 
- **BFT_groupMarker_type**, can be one of: *air, antiair, armor, art, hq, inf, installation, maint, mech_inf, med, mortar, motor_inf, naval, ordinance, plane, recon, service, support, uav, unknown*.
- **BFT_groupMarker_color**, found [here](https://community.bistudio.com/wiki/Arma_3:_CfgMarkerColors).

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
- Group markers
  - Allow custom names 
  - Don't allow names that are in use
  - Show team info when clicking marker
  - Need GPS?
  - Can be disabled/scrambled within a given area (e.g. they are jammed)
  - Add the options to 3DEN and Zeus
  - Have a list mission makers can add to. e.g. show Civ group location. 
  - Encryption codes for group markers - maybe multiple codes? e.g. cant see where "special forces" are, but "special forces" can see you (I did a little thing here... not sure if works.. or what happens if you give a player the decryption code to an enemy unit?)
  - Add quick function for mission makers to set group vars
  - Add ability to disable BFT for groups (for mission makers). (Implement HT's networks idea)
  - Add setting for "Preferred icons". 
  - Add setting for "Preferred colours", and maybe get the rest from config? 

- Player markers
  - Add setting to zeus to enable/disable their marker. Right now it'll never mark zeus. 
  - Need GPS?
  - Change show hide marker thingy to have options "Off, Zeus only, On".

- Troop overview
  - A tab on the map with all teams/units

- Vehicles
  - Limit vehicle speed (to match player walk / run speed)
    The ACE function does not take speed, maybe use onEachFrame EH to poll for speed and lock.
  - Vehicle damage status easier to see
  - Can we stabilize the gun when vehicle turning? 