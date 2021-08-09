# **GD Mod - BFT and more!**
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
I use HEMTT to build etc.

`hemtt build` to build 

`hemtt build --release` to create a release

`hemtt file-patching` to create link for file patching