
stock IsSurvivor(client) {
	return IsClientInGame(client) && GetClientTeam(client) == 2;
}

stock GetSurvivorPermanentHealth(client) {
	return GetEntProp(client, Prop_Send, "m_iHealth");
}

stock GetSurvivorTempHealth(client) {
	new temphp = RoundToCeil(GetEntPropFloat(client, Prop_Send, "m_healthBuffer") - ((GetGameTime() - GetEntPropFloat(client, Prop_Send, "m_healthBufferTime")) * GetConVarFloat(FindConVar("pain_pills_decay_rate")))) - 1;
	return (temphp > 0 ? temphp : 0);
}

stock bool:DoesSurvivorHaveMedkit(client) {
	new iTemp = GetPlayerWeaponSlot(client, 3);
	if (iTemp > -1) {
		decl String:strTemp[64];
		GetEdictClassname(iTemp, strTemp, sizeof(strTemp));
		if (StrEqual(strTemp, "weapon_first_aid_kit")) {
			return true;
		}
	}
	return false;
}

stock bool:DoesSurvivorHavePills(client) {
	new iTemp = GetPlayerWeaponSlot(client, 4);
	if (iTemp > -1) {
		decl String:strTemp[64];
		GetEdictClassname(iTemp, strTemp, sizeof(strTemp));
		if (StrEqual(strTemp, "weapon_pain_pills")) {
			return true;
		}
	}
	return false;
}

stock bool:DoesSurvivorHaveAdrenaline(client) {
	new iTemp = GetPlayerWeaponSlot(client, 4);
	if (iTemp > -1) {
		decl String:strTemp[64];
		GetEdictClassname(iTemp, strTemp, sizeof(strTemp));
		if (StrEqual(strTemp, "weapon_adrenaline")) {
			return true;
		}
	}
	return false;
}

stock bool:IsPlayerIncap(client) {
	return !!GetEntProp(client, Prop_Send, "m_isIncapacitated");
}

stock bool:isVersus() {
	new String:tmp[32];
	GetConVarString(FindConVar("mp_gamemode"), tmp);
	if (tmp == "versus") {
		return true;
	}
	return false;
}
