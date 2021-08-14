#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Modules_F"};
        author = "AUTHOR";
        VERSION_CONFIG;
    };
};

class CfgFactionClasses {
    class NO_CATEGORY; 
    class GVAR(editorCategory): NO_CATEGORY {
        displayName = "TCA Modules"; 
    };
};

class CfgVehicles {
    class Logic;
    class Module_F: Logic
	{
		class AttributesBase
		{
			class Default;
			class Edit;					// Default edit box (i.e., text input field)
			class Combo;				// Default combo box (i.e., drop-down menu)
			class Checkbox;				// Default checkbox (returned value is Boolean)
			class CheckboxNumber;		// Default checkbox (returned value is Number)
			class ModuleDescription;	// Module description
			class Units;				// Selection of units on which the module is applied
		};
		// Description base classes, for more information see below
		class ModuleDescription
		{
			class AnyBrain;
		};
	};
    class GVAR(coverMap_node): Module_F {
        scope = 2; 
        displayName = "CoverMap Node"; 
        icon = ""; 
        category = GVAR(editorCategory); 

        function = ""; 
        functionPriority = 1; 
        isTriggerActivated = 0; 
        isDisposable = 0; 
        is3DEN = 0;
        curatorInfoType = ""; 

        class Attributes: AttributesBase {
            class Name: Edit {
                displayName = "Name"; 
                tooltip = "Name of the zone";
                defaultValue = """Zone_0"""; 
            }
        }

    };
};

#include "CfgEventHandlers.hpp"