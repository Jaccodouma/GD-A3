#define SPEEDLIMITER_ACTION \
	class ACE_SelfActions { \
		class GVAR(SpeedLimiterActions) { \
			displayName = "Speed limiter"; \
			condition = "_player == driver _target"; \
			statement = ""; \
			insertChildren = QUOTE(call DFUNC(addSpeedLimiterActions)); \
		}; \
	}

class CfgVehicles {
    class LandVehicle;
    class Car: LandVehicle {
        SPEEDLIMITER_ACTION;
    };
    class Motorcycle: LandVehicle {
        SPEEDLIMITER_ACTION;
    };
    class Tank: LandVehicle {
        SPEEDLIMITER_ACTION;
    };
};