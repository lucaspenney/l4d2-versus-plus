#pragma semicolon 1
#include <sourcemod>
#include <sdktools>

#include "functions.sp"

public Plugin:myinfo =
{
	name = "[L4D2] Versus Plus",
	author = "Lucas Penney",
	version = "0.1.0",
	description = "A reworked versus mode for L4D2 for better scoring and competitive gameplay",
	url = "https://github.com/lucaspenney/l4d2-versus-plus"
};

public OnPluginStart()
{
	HookEvent("player_left_start_area", PlayerLeftStartArea);
	HookEvent("player_incapacitated_start", PlayerIncapStart);
	HookEvent("round_start", RoundStart);
}

new incapCount = 0;

public Action:PlayerLeftStartArea(Event event, const String:name[], bool:dontBroadcast){

}

public Action:RoundStart(Handle:event, const String:name[], bool:dontBroadcast) {
	incapCount = 0;
	UpdateSurvivalBonus();
}

public Action:PlayerIncapStart(Event event, const String:name[], bool:dontBroadcast) {
	new userId = event.GetInt("userid");
	new client = GetClientOfUserId(userId);
	if (IsSurvivor(client)) {
		incapCount += 1;
		UpdateSurvivalBonus();
	}
}

public SetSurvivalBonus(score) {
	SetConVarInt(FindConVar("vs_survival_bonus"), score);
}

public UpdateSurvivalBonus() {
	new score = 200 - (incapCount * 25);
	if (score <= 40) {
		score = 40;
	}
	new Float:div = score / 4.0;
	new survivalScore = RoundToFloor(div);
	SetSurvivalBonus(survivalScore);
}
