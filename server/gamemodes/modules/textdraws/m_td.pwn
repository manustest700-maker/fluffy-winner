
	
	
/*
	//login textdraw
	
	Autorization_TD[0] = TextDrawCreate(258.4999, 300.4212, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[0], 14.0000, 18.0000);
	TextDrawAlignment(Autorization_TD[0], 1);
	TextDrawColor(Autorization_TD[0], 235802367);
	TextDrawBackgroundColor(Autorization_TD[0], 255);
	TextDrawFont(Autorization_TD[0], 4);
	TextDrawSetProportional(Autorization_TD[0], 0);
	TextDrawSetShadow(Autorization_TD[0], 0);

	Autorization_TD[1] = TextDrawCreate(373.4334, 264.7767, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[1], 14.0000, 18.0000);
	TextDrawAlignment(Autorization_TD[1], 1);
	TextDrawColor(Autorization_TD[1], 235802367);
	TextDrawBackgroundColor(Autorization_TD[1], 255);
	TextDrawFont(Autorization_TD[1], 4);
	TextDrawSetProportional(Autorization_TD[1], 0);
	TextDrawSetShadow(Autorization_TD[1], 0);

	Autorization_TD[2] = TextDrawCreate(255.8331, 168.2738, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[2], 14.0000, 18.0000);
	TextDrawAlignment(Autorization_TD[2], 1);
	TextDrawColor(Autorization_TD[2], 235802367);
	TextDrawBackgroundColor(Autorization_TD[2], 255);
	TextDrawFont(Autorization_TD[2], 4);
	TextDrawSetProportional(Autorization_TD[2], 0);
	TextDrawSetShadow(Autorization_TD[2], 0);

	Autorization_TD[3] = TextDrawCreate(129.7334, 347.1486, ""); 
	TextDrawTextSize(Autorization_TD[3], 255.6800, -82.0000);
	TextDrawAlignment(Autorization_TD[3], 1);
	TextDrawColor(Autorization_TD[3], 235802367);
	TextDrawFont(Autorization_TD[3], 5);
	TextDrawSetProportional(Autorization_TD[3], 0);
	TextDrawSetShadow(Autorization_TD[3], 0);
	TextDrawSetPreviewModel(Autorization_TD[3], 3090);
	TextDrawSetPreviewRot(Autorization_TD[3], 0.0000, -90.0000, 0.0000, 1.0000);
	TextDrawBackgroundColor(Autorization_TD[3], 0xFFFFFF00);

	Autorization_TD[4] = TextDrawCreate(263.5999, 171.2775, "LD_SPAC:white"); 
	TextDrawTextSize(Autorization_TD[4], 118.0000, 108.0000);
	TextDrawAlignment(Autorization_TD[4], 1);
	TextDrawColor(Autorization_TD[4], 235802367);
	TextDrawBackgroundColor(Autorization_TD[4], 255);
	TextDrawFont(Autorization_TD[4], 4);
	TextDrawSetProportional(Autorization_TD[4], 0);
	TextDrawSetShadow(Autorization_TD[4], 0);

	Autorization_TD[5] = TextDrawCreate(258.0666, 175.5405, "LD_SPAC:white"); 
	TextDrawTextSize(Autorization_TD[5], 127.0000, 98.0000);
	TextDrawAlignment(Autorization_TD[5], 1);
	TextDrawColor(Autorization_TD[5], 235802367);
	TextDrawBackgroundColor(Autorization_TD[5], 255);
	TextDrawFont(Autorization_TD[5], 4);
	TextDrawSetProportional(Autorization_TD[5], 0);
	TextDrawSetShadow(Autorization_TD[5], 0);

	Autorization_TD[6] = TextDrawCreate(272.3334, 238.3874, "particle:lamp_shad_64"); 
	TextDrawTextSize(Autorization_TD[6], 96.0000, 22.0000);
	TextDrawAlignment(Autorization_TD[6], 1);
	TextDrawColor(Autorization_TD[6], 1234959648);
	TextDrawBackgroundColor(Autorization_TD[6], 255);
	TextDrawFont(Autorization_TD[6], 4);
	TextDrawSetProportional(Autorization_TD[6], 0);
	TextDrawSetShadow(Autorization_TD[6], 0);

	Autorization_TD[7] = TextDrawCreate(285.9998, 247.0278, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[7], 21.0000, 25.0000);
	TextDrawAlignment(Autorization_TD[7], 1);
	TextDrawColor(Autorization_TD[7], 1234959871);
	TextDrawBackgroundColor(Autorization_TD[7], 255);
	TextDrawFont(Autorization_TD[7], 4);
	TextDrawSetProportional(Autorization_TD[7], 0);
	TextDrawSetShadow(Autorization_TD[7], 0);

	Autorization_TD[8] = TextDrawCreate(296.4998, 267.8833, "LD_SPAC:white"); 
	TextDrawTextSize(Autorization_TD[8], 48.0000, -16.7098);
	TextDrawAlignment(Autorization_TD[8], 1);
	TextDrawColor(Autorization_TD[8], 1234959871);
	TextDrawBackgroundColor(Autorization_TD[8], 255);
	TextDrawFont(Autorization_TD[8], 4);
	TextDrawSetProportional(Autorization_TD[8], 0);
	TextDrawSetShadow(Autorization_TD[8], 0);

	Autorization_TD[9] = TextDrawCreate(333.9998, 246.9130, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[9], 21.0000, 25.0000);
	TextDrawAlignment(Autorization_TD[9], 1);
	TextDrawColor(Autorization_TD[9], 1234959871);
	TextDrawBackgroundColor(Autorization_TD[9], 255);
	TextDrawFont(Autorization_TD[9], 4);
	TextDrawSetProportional(Autorization_TD[9], 0);
	TextDrawSetShadow(Autorization_TD[9], 0);

	Autorization_TD[10] = TextDrawCreate(320.6667, 254.2351, "CONTINUE"); 
	TextDrawLetterSize(Autorization_TD[10], 0.1553, 1.0355);
	TextDrawTextSize(Autorization_TD[10], 10.0000, 60.0000);
	TextDrawAlignment(Autorization_TD[10], 2);
	TextDrawColor(Autorization_TD[10], 235802367);
	TextDrawUseBox(Autorization_TD[10], 1);
	TextDrawBoxColor(Autorization_TD[10], 0);
	TextDrawBackgroundColor(Autorization_TD[10], 255);
	TextDrawFont(Autorization_TD[10], 2);
	TextDrawSetProportional(Autorization_TD[10], 1);
	TextDrawSetShadow(Autorization_TD[10], 0);
	TextDrawSetSelectable(Autorization_TD[10], true);

	Autorization_TD[11] = TextDrawCreate(262.3333, 215.7628, "LD_Beat:chit"); // Password
	TextDrawTextSize(Autorization_TD[11], 19.0000, 23.7098);
	TextDrawAlignment(Autorization_TD[11], 1);
	TextDrawColor(Autorization_TD[11], 505290495);
	TextDrawBackgroundColor(Autorization_TD[11], 255);
	TextDrawFont(Autorization_TD[11], 4);
	TextDrawSetProportional(Autorization_TD[11], 0);
	TextDrawSetShadow(Autorization_TD[11], 0);

	Autorization_TD[12] = TextDrawCreate(272.0330, 219.4962, "LD_SPAC:white"); // Password
	TextDrawTextSize(Autorization_TD[12], 101.0000, 16.0000);
	TextDrawAlignment(Autorization_TD[12], 1);
	TextDrawColor(Autorization_TD[12], 505290495);
	TextDrawBackgroundColor(Autorization_TD[12], 255);
	TextDrawFont(Autorization_TD[12], 4);
	TextDrawSetProportional(Autorization_TD[12], 0);
	TextDrawSetShadow(Autorization_TD[12], 0);

	Autorization_TD[13] = TextDrawCreate(361.8000, 215.6481, "LD_Beat:chit"); // Password
	TextDrawTextSize(Autorization_TD[13], 19.0000, 23.6898);
	TextDrawAlignment(Autorization_TD[13], 1);
	TextDrawColor(Autorization_TD[13], 505290495);
	TextDrawBackgroundColor(Autorization_TD[13], 255);
	TextDrawFont(Autorization_TD[13], 4);
	TextDrawSetProportional(Autorization_TD[13], 0);
	TextDrawSetShadow(Autorization_TD[13], 0);

	Autorization_TD[14] = TextDrawCreate(263.4332, 217.6073, "LD_Beat:chit"); // Password
	TextDrawTextSize(Autorization_TD[14], 18.0000, 20.1798);
	TextDrawAlignment(Autorization_TD[14], 1);
	TextDrawColor(Autorization_TD[14], 235802367);
	TextDrawBackgroundColor(Autorization_TD[14], 255);
	TextDrawFont(Autorization_TD[14], 4);
	TextDrawSetProportional(Autorization_TD[14], 0);
	TextDrawSetShadow(Autorization_TD[14], 0);

	Autorization_TD[15] = TextDrawCreate(361.7331, 217.5220, "LD_Beat:chit"); // Password
	TextDrawTextSize(Autorization_TD[15], 18.0000, 20.1798);
	TextDrawAlignment(Autorization_TD[15], 1);
	TextDrawColor(Autorization_TD[15], 235802367);
	TextDrawBackgroundColor(Autorization_TD[15], 255);
	TextDrawFont(Autorization_TD[15], 4);
	TextDrawSetProportional(Autorization_TD[15], 0);
	TextDrawSetShadow(Autorization_TD[15], 0);

	Autorization_TD[16] = TextDrawCreate(273.4332, 220.7554, "LD_SPAC:white"); // Password
	TextDrawTextSize(Autorization_TD[16], 97.0000, 13.4898);
	TextDrawAlignment(Autorization_TD[16], 1);
	TextDrawColor(Autorization_TD[16], 235802367);
	TextDrawBackgroundColor(Autorization_TD[16], 255);
	TextDrawFont(Autorization_TD[16], 4);
	TextDrawSetProportional(Autorization_TD[16], 0);
	TextDrawSetShadow(Autorization_TD[16], 0);

	Autorization_TD[17] = TextDrawCreate(270.4666, 211.7850, "Password"); // Password
	TextDrawLetterSize(Autorization_TD[17], 0.1550, 0.7196);
	TextDrawAlignment(Autorization_TD[17], 1);
	TextDrawColor(Autorization_TD[17], -2139062017);
	TextDrawBackgroundColor(Autorization_TD[17], 255);
	TextDrawFont(Autorization_TD[17], 1);
	TextDrawSetProportional(Autorization_TD[17], 1);
	TextDrawSetShadow(Autorization_TD[17], 0);

	Autorization_TD[18] = TextDrawCreate(271.6331, 223.9147, "CLICK_TO_ENTER_PASSWORD"); // Password
	TextDrawLetterSize(Autorization_TD[18], 0.1550, 0.7196);
	TextDrawTextSize(Autorization_TD[18], 369.0000, 10.0000);
	TextDrawAlignment(Autorization_TD[18], 1);
	TextDrawColor(Autorization_TD[18], -2139062017);
	TextDrawUseBox(Autorization_TD[18], 1);
	TextDrawBoxColor(Autorization_TD[18], 0);
	TextDrawBackgroundColor(Autorization_TD[18], 255);
	TextDrawFont(Autorization_TD[18], 1);
	TextDrawSetProportional(Autorization_TD[18], 1);
	TextDrawSetShadow(Autorization_TD[18], 0);
	TextDrawSetSelectable(Autorization_TD[18], true);

	Autorization_TD[19] = TextDrawCreate(258.1667, 269.9036, "LD_SPAC:white"); 
	TextDrawTextSize(Autorization_TD[19], 7.0000, 22.0000);
	TextDrawAlignment(Autorization_TD[19], 1);
	TextDrawColor(Autorization_TD[19], 235802367);
	TextDrawBackgroundColor(Autorization_TD[19], 255);
	TextDrawFont(Autorization_TD[19], 4);
	TextDrawSetProportional(Autorization_TD[19], 0);
	TextDrawSetShadow(Autorization_TD[19], 0);

	Autorization_TD[20] = TextDrawCreate(273.3334, 281.1282, "particle:lamp_shad_64"); 
	TextDrawTextSize(Autorization_TD[20], 96.0000, -21.0000);
	TextDrawAlignment(Autorization_TD[20], 1);
	TextDrawColor(Autorization_TD[20], 1234959648);
	TextDrawBackgroundColor(Autorization_TD[20], 255);
	TextDrawFont(Autorization_TD[20], 4);
	TextDrawSetProportional(Autorization_TD[20], 0);
	TextDrawSetShadow(Autorization_TD[20], 0);

	Autorization_TD[21] = TextDrawCreate(256.8666, 225.4178, ""); 
	TextDrawTextSize(Autorization_TD[21], 255.6800, -82.0000);
	TextDrawAlignment(Autorization_TD[21], 1);
	TextDrawColor(Autorization_TD[21], 235802367);
	TextDrawFont(Autorization_TD[21], 5);
	TextDrawSetProportional(Autorization_TD[21], 0);
	TextDrawSetShadow(Autorization_TD[21], 0);
	TextDrawSetPreviewModel(Autorization_TD[21], 3090);
	TextDrawSetPreviewRot(Autorization_TD[21], 0.0000, 90.0000, 0.0000, 1.0000);
	TextDrawBackgroundColor(Autorization_TD[21], 0xFFFFFF00);

	Autorization_TD[22] = TextDrawCreate(365.3333, 168.2740, "LD_SPAC:white"); 
	TextDrawTextSize(Autorization_TD[22], 20.1599, 30.0000);
	TextDrawAlignment(Autorization_TD[22], 1);
	TextDrawColor(Autorization_TD[22], 235802367);
	TextDrawBackgroundColor(Autorization_TD[22], 255);
	TextDrawFont(Autorization_TD[22], 4);
	TextDrawSetProportional(Autorization_TD[22], 0);
	TextDrawSetShadow(Autorization_TD[22], 0);

	Autorization_TD[23] = TextDrawCreate(266.9998, 170.9444, "LD_SPAC:white"); 
	TextDrawTextSize(Autorization_TD[23], 105.0000, 2.0000);
	TextDrawAlignment(Autorization_TD[23], 1);
	TextDrawColor(Autorization_TD[23], 235802367);
	TextDrawBackgroundColor(Autorization_TD[23], 255);
	TextDrawFont(Autorization_TD[23], 4);
	TextDrawSetProportional(Autorization_TD[23], 0);
	TextDrawSetShadow(Autorization_TD[23], 0);

	Autorization_TD[24] = TextDrawCreate(269.6666, 163.2962, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[24], 11.0000, 15.0000);
	TextDrawAlignment(Autorization_TD[24], 1);
	TextDrawColor(Autorization_TD[24], 1234959871);
	TextDrawBackgroundColor(Autorization_TD[24], 255);
	TextDrawFont(Autorization_TD[24], 4);
	TextDrawSetProportional(Autorization_TD[24], 0);
	TextDrawSetShadow(Autorization_TD[24], 0);

	Autorization_TD[25] = TextDrawCreate(375.6665, 242.8701, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[25], 16.0000, 20.0000);
	TextDrawAlignment(Autorization_TD[25], 1);
	TextDrawColor(Autorization_TD[25], 1234959871);
	TextDrawBackgroundColor(Autorization_TD[25], 255);
	TextDrawFont(Autorization_TD[25], 4);
	TextDrawSetProportional(Autorization_TD[25], 0);
	TextDrawSetShadow(Autorization_TD[25], 0);

	Autorization_TD[26] = TextDrawCreate(256.2666, 265.3406, "LD_Beat:chit"); 
	TextDrawTextSize(Autorization_TD[26], 6.0000, 7.0000);
	TextDrawAlignment(Autorization_TD[26], 1);
	TextDrawColor(Autorization_TD[26], 1234959871);
	TextDrawBackgroundColor(Autorization_TD[26], 255);
	TextDrawFont(Autorization_TD[26], 4);
	TextDrawSetProportional(Autorization_TD[26], 0);
	TextDrawSetShadow(Autorization_TD[26], 0);
*/

	//logo001
	PublicTD[0] = TextDrawCreate(25.529200, 417.333313, "ld_beat:chit");
	TextDrawFont(PublicTD[0], 4);
	TextDrawLetterSize(PublicTD[0], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[0], 5.000000, 5.000000);
	TextDrawSetOutline(PublicTD[0], 0);
	TextDrawSetShadow(PublicTD[0], 0);
	TextDrawAlignment(PublicTD[0], 1);
	TextDrawUseBox(PublicTD[0], 0);
	TextDrawColor(PublicTD[0], 0x00E676FF);
	TextDrawBackgroundColor(PublicTD[0], 0x000000ff);
	TextDrawBoxColor(PublicTD[0], 0x80808080);
	TextDrawSetProportional(PublicTD[0], 0);
	
	PublicTD[1] = TextDrawCreate(22.529200, 431.333313, "particle:lamp_shad_64");
	TextDrawFont(PublicTD[1], 4);
	TextDrawLetterSize(PublicTD[1], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[1], 37.000000, 7.000000);
	TextDrawSetOutline(PublicTD[1], 0);
	TextDrawSetShadow(PublicTD[1], 0);
	TextDrawAlignment(PublicTD[1], 1);
	TextDrawUseBox(PublicTD[1], 0);
	TextDrawColor(PublicTD[1], 0x00E676FF);
	TextDrawBackgroundColor(PublicTD[1], 0x000000ff);
	TextDrawBoxColor(PublicTD[1], 0x80808080);
	TextDrawSetProportional(PublicTD[1], 0);
	
	PublicTD[2] = TextDrawCreate(22.529200, 438.333313, "particle:lamp_shad_64");
	TextDrawFont(PublicTD[2], 4);
	TextDrawLetterSize(PublicTD[2], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[2], 37.000000, -7.000000);
	TextDrawSetOutline(PublicTD[2], 0);
	TextDrawSetShadow(PublicTD[2], 0);
	TextDrawAlignment(PublicTD[2], 1);
	TextDrawUseBox(PublicTD[2], 0);
	TextDrawColor(PublicTD[2], 0x00E676FF);
	TextDrawBackgroundColor(PublicTD[2], 0x000000ff);
	TextDrawBoxColor(PublicTD[2], 0x80808080);
	TextDrawSetProportional(PublicTD[2], 0);
	
	PublicTD[3] = TextDrawCreate(28.529200, 420.333313, "HAVANA");
	TextDrawFont(PublicTD[3], 2);
	TextDrawLetterSize(PublicTD[3], 0.225000, 0.980000);
	TextDrawTextSize(PublicTD[3], 1280.000000, 1280.000000);
	TextDrawSetOutline(PublicTD[3], 1);
	TextDrawSetShadow(PublicTD[3], 1);
	TextDrawAlignment(PublicTD[3], 1);
	TextDrawUseBox(PublicTD[3], 0);
	TextDrawColor(PublicTD[3], 0x00E676FF);
	TextDrawBackgroundColor(PublicTD[3], 0x000000FF);
	TextDrawBoxColor(PublicTD[3], 0x80808080);
	TextDrawSetProportional(PublicTD[3], 1);
	
	PublicTD[4] = TextDrawCreate(29.529200, 431.333313, "ROLEPLAY");
	TextDrawFont(PublicTD[4], 2);
	TextDrawLetterSize(PublicTD[4], 0.145000, 0.720000);
	TextDrawTextSize(PublicTD[4], 1280.000000, 1280.000000);
	TextDrawSetOutline(PublicTD[4], 1);
	TextDrawSetShadow(PublicTD[4], 1);
	TextDrawAlignment(PublicTD[4], 1);
	TextDrawUseBox(PublicTD[4], 0);
	TextDrawColor(PublicTD[4], 0xFFFFFFFF);
	TextDrawBackgroundColor(PublicTD[4], 0x000000FF);
	TextDrawBoxColor(PublicTD[4], 0x80808080);
	TextDrawSetProportional(PublicTD[4], 1);
	
	PublicTD[5] = TextDrawCreate(22.529200, 422.333313, "ld_beat:chit");
	TextDrawFont(PublicTD[5], 4);
	TextDrawLetterSize(PublicTD[5], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[5], 5.000000, 5.000000);
	TextDrawSetOutline(PublicTD[5], 0);
	TextDrawSetShadow(PublicTD[5], 0);
	TextDrawAlignment(PublicTD[5], 1);
	TextDrawUseBox(PublicTD[5], 0);
	TextDrawColor(PublicTD[5], 0x00E676FF);
	TextDrawBackgroundColor(PublicTD[5], 0x000000ff);
	TextDrawBoxColor(PublicTD[5], 0x80808080);
	TextDrawSetProportional(PublicTD[5], 0);
	
	PublicTD[6] = TextDrawCreate(21.529400, 418.333313, "ld_beat:chit");
	TextDrawFont(PublicTD[6], 4);
	TextDrawLetterSize(PublicTD[6], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[6], 4.000000, 4.000000);
	TextDrawSetOutline(PublicTD[6], 0);
	TextDrawSetShadow(PublicTD[6], 0);
	TextDrawAlignment(PublicTD[6], 1);
	TextDrawUseBox(PublicTD[6], 0);
	TextDrawColor(PublicTD[6], 0xFF353Fff);
	TextDrawBackgroundColor(PublicTD[6], 0x000000ff);
	TextDrawBoxColor(PublicTD[6], 0x80808080);
	TextDrawSetProportional(PublicTD[6], 0);
	
	PublicTD[7] = TextDrawCreate(58.529202, 433.333313, "ld_beat:chit");
	TextDrawFont(PublicTD[7], 4);
	TextDrawLetterSize(PublicTD[7], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[7], 5.000000, 5.000000);
	TextDrawSetOutline(PublicTD[7], 0);
	TextDrawSetShadow(PublicTD[7], 0);
	TextDrawAlignment(PublicTD[7], 1);
	TextDrawUseBox(PublicTD[7], 0);
	TextDrawColor(PublicTD[7], 0xFF353Fff);
	TextDrawBackgroundColor(PublicTD[7], 0x000000ff);
	TextDrawBoxColor(PublicTD[7], 0x80808080);
	TextDrawSetProportional(PublicTD[7], 0);
	
	PublicTD[8] = TextDrawCreate(55.229000, 438.733185, "ld_beat:chit");
	TextDrawFont(PublicTD[8], 4);
	TextDrawLetterSize(PublicTD[8], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[8], 5.000000, 5.000000);
	TextDrawSetOutline(PublicTD[8], 0);
	TextDrawSetShadow(PublicTD[8], 0);
	TextDrawAlignment(PublicTD[8], 1);
	TextDrawUseBox(PublicTD[8], 0);
	TextDrawColor(PublicTD[8], 0xFF353Fff);
	TextDrawBackgroundColor(PublicTD[8], 0x000000ff);
	TextDrawBoxColor(PublicTD[8], 0x80808080);
	TextDrawSetProportional(PublicTD[8], 0);
	
	PublicTD[9] = TextDrawCreate(60.027699, 438.033203, "ld_beat:chit");
	TextDrawFont(PublicTD[9], 4);
	TextDrawLetterSize(PublicTD[9], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[9], 4.000000, 4.000000);
	TextDrawSetOutline(PublicTD[9], 0);
	TextDrawSetShadow(PublicTD[9], 0);
	TextDrawAlignment(PublicTD[9], 1);
	TextDrawUseBox(PublicTD[9], 0);
	TextDrawColor(PublicTD[9], 0xFF353Fff);
	TextDrawBackgroundColor(PublicTD[9], 0x000000ff);
	TextDrawBoxColor(PublicTD[9], 0x80808080);
	TextDrawSetProportional(PublicTD[9], 0);
	
	PublicTD[10] = TextDrawCreate(53.529202, 414.333313, "ld_beat:chit");
	TextDrawFont(PublicTD[10], 4);
	TextDrawLetterSize(PublicTD[10], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[10], 10.000000, 10.000000);
	TextDrawSetOutline(PublicTD[10], 0);
	TextDrawSetShadow(PublicTD[10], 0);
	TextDrawAlignment(PublicTD[10], 1);
	TextDrawUseBox(PublicTD[10], 0);
	TextDrawColor(PublicTD[10], 0xFF353Fff);
	TextDrawBackgroundColor(PublicTD[10], 0x000000ff);
	TextDrawBoxColor(PublicTD[10], 0x80808080);
	TextDrawSetProportional(PublicTD[10], 0);
	
	PublicTD[11] = TextDrawCreate(56.229000, 415.533203, "x2");
	TextDrawFont(PublicTD[11], 2);
	TextDrawLetterSize(PublicTD[11], 0.087800, 0.684000);
	TextDrawTextSize(PublicTD[11], 1280.000000, 1280.000000);
	TextDrawSetOutline(PublicTD[11], 0);
	TextDrawSetShadow(PublicTD[11], 0);
	TextDrawAlignment(PublicTD[11], 1);
	TextDrawUseBox(PublicTD[11], 0);
	TextDrawColor(PublicTD[11], 0xffffffff);
	TextDrawBackgroundColor(PublicTD[11], 0x000000ff);
	TextDrawBoxColor(PublicTD[11], 0x80808080);
	TextDrawSetProportional(PublicTD[11], 1);
	
	PublicTD[12] = TextDrawCreate(3.529200, 422.333313, "01");
	TextDrawFont(PublicTD[12], 3);
	TextDrawLetterSize(PublicTD[12], 0.231900, 1.110000);
	TextDrawTextSize(PublicTD[12], 1280.000000, 1280.000000);
	TextDrawSetOutline(PublicTD[12], 0);
	TextDrawSetShadow(PublicTD[12], 1);
	TextDrawAlignment(PublicTD[12], 1);
	TextDrawUseBox(PublicTD[12], 0);
	TextDrawColor(PublicTD[12], 0xFF353Fff);
	TextDrawBackgroundColor(PublicTD[12], 0x0000000f);
	TextDrawBoxColor(PublicTD[12], 0x80808080);
	TextDrawSetProportional(PublicTD[12], 1);
	
	PublicTD[13] = TextDrawCreate(16.529200, 417.333313, "LD_SPAC:white");
	TextDrawFont(PublicTD[13], 4);
	TextDrawLetterSize(PublicTD[13], 0.480000, 1.120000);
	TextDrawTextSize(PublicTD[13], 1.000000, 21.000000);
	TextDrawSetOutline(PublicTD[13], 0);
	TextDrawSetShadow(PublicTD[13], 0);
	TextDrawAlignment(PublicTD[13], 1);
	TextDrawUseBox(PublicTD[13], 0);
	TextDrawColor(PublicTD[13], 0xFF353Fff);
	TextDrawBackgroundColor(PublicTD[13], 0x000000ff);
	TextDrawBoxColor(PublicTD[13], 0x80808080);
	TextDrawSetProportional(PublicTD[13], 0);
	
	//timer textdraw
	
	TD_DataTime[0] = TextDrawCreate(545.0001, 382.4843, "flin_txd:flin_times"); // bg time
    TextDrawTextSize(TD_DataTime[0], 88.0000, 103.0000);
    TextDrawAlignment(TD_DataTime[0], 1);
    TextDrawColor(TD_DataTime[0], -1);
    TextDrawBackgroundColor(TD_DataTime[0], 255);
    TextDrawFont(TD_DataTime[0], 4);
    TextDrawSetProportional(TD_DataTime[0], 0);
    TextDrawSetShadow(TD_DataTime[0], 0);

    TD_DataTime[1] = TextDrawCreate(595.6011, 428.4354, "19.11.2023_/_16:47"); // data + time
    TextDrawLetterSize(TD_DataTime[1], 0.1555, 1.1818);
    TextDrawAlignment(TD_DataTime[1], 2);
    TextDrawColor(TD_DataTime[1], 0xFF353FFF);
    TextDrawBackgroundColor(TD_DataTime[1], 255);
    TextDrawFont(TD_DataTime[1], 2);
    TextDrawSetProportional(TD_DataTime[1], 1);
    TextDrawSetShadow(TD_DataTime[1], 0);
	
	//welcome td
	Welcome_TD[0] = TextDrawCreate(270.6667, 74.2666, ""); // ?????
	TextDrawLetterSize(Welcome_TD[0], 0.0000, 6.9333);
	TextDrawTextSize(Welcome_TD[0], 377.8208, 0.0000);
	TextDrawAlignment(Welcome_TD[0], 1);
	TextDrawColor(Welcome_TD[0], -1);
	TextDrawUseBox(Welcome_TD[0], 1);
	TextDrawBoxColor(Welcome_TD[0], 269488383);
	TextDrawBackgroundColor(Welcome_TD[0], 255);
	TextDrawFont(Welcome_TD[0], 1);
	TextDrawSetProportional(Welcome_TD[0], 1);
	TextDrawSetShadow(Welcome_TD[0], 0);

	Welcome_TD[1] = TextDrawCreate(265.7333, 71.5221, ""); // ?????
	TextDrawTextSize(Welcome_TD[1], 6.4699, 7.7899);
	TextDrawAlignment(Welcome_TD[1], 1);
	TextDrawColor(Welcome_TD[1], 269488383);
	TextDrawBackgroundColor(Welcome_TD[1], 255);
	TextDrawFont(Welcome_TD[1], 4);
	TextDrawSetProportional(Welcome_TD[1], 0);
	TextDrawSetShadow(Welcome_TD[1], 0);

	Welcome_TD[2] = TextDrawCreate(265.7000, 131.9739, ""); // ?????
	TextDrawTextSize(Welcome_TD[2], 6.4699, 7.7899);
	TextDrawAlignment(Welcome_TD[2], 1);
	TextDrawColor(Welcome_TD[2], 269488383);
	TextDrawBackgroundColor(Welcome_TD[2], 255);
	TextDrawFont(Welcome_TD[2], 4);
	TextDrawSetProportional(Welcome_TD[2], 0);
	TextDrawSetShadow(Welcome_TD[2], 0);

	Welcome_TD[3] = TextDrawCreate(375.6667, 131.9739, ""); // ?????
	TextDrawTextSize(Welcome_TD[3], 6.4699, 7.7899);
	TextDrawAlignment(Welcome_TD[3], 1);
	TextDrawColor(Welcome_TD[3], 269488383);
	TextDrawBackgroundColor(Welcome_TD[3], 255);
	TextDrawFont(Welcome_TD[3], 4);
	TextDrawSetProportional(Welcome_TD[3], 0);
	TextDrawSetShadow(Welcome_TD[3], 0);

	Welcome_TD[4] = TextDrawCreate(375.6999, 71.4554, ""); // ?????
	TextDrawTextSize(Welcome_TD[4], 6.4699, 7.7899);
	TextDrawAlignment(Welcome_TD[4], 1);
	TextDrawColor(Welcome_TD[4], 269488383);
	TextDrawBackgroundColor(Welcome_TD[4], 255);
	TextDrawFont(Welcome_TD[4], 4);
	TextDrawSetProportional(Welcome_TD[4], 0);
	TextDrawSetShadow(Welcome_TD[4], 0);

	Welcome_TD[5] = TextDrawCreate(268.0668, 76.8666, ""); // ?????
	TextDrawLetterSize(Welcome_TD[5], 0.0000, 6.4333);
	TextDrawTextSize(Welcome_TD[5], 379.9008, 0.0000);
	TextDrawAlignment(Welcome_TD[5], 1);
	TextDrawColor(Welcome_TD[5], -1);
	TextDrawUseBox(Welcome_TD[5], 1);
	TextDrawBoxColor(Welcome_TD[5], 269488383);
	TextDrawBackgroundColor(Welcome_TD[5], 255);
	TextDrawFont(Welcome_TD[5], 1);
	TextDrawSetProportional(Welcome_TD[5], 1);
	TextDrawSetShadow(Welcome_TD[5], 0);

	Welcome_TD[6] = TextDrawCreate(265.1334, 116.2702, ""); // ?????
	TextDrawTextSize(Welcome_TD[6], 118.0000, 22.0000);
	TextDrawAlignment(Welcome_TD[6], 1);
	TextDrawColor(Welcome_TD[6], 562163333);
	TextDrawBackgroundColor(Welcome_TD[6], 255);
	TextDrawFont(Welcome_TD[6], 4);
	TextDrawSetProportional(Welcome_TD[6], 0);
	TextDrawSetShadow(Welcome_TD[6], 0);

	Welcome_TD[7] = TextDrawCreate(289.3332, 93.7629, ""); // ?????
	TextDrawLetterSize(Welcome_TD[7], 0.3779, 1.3718);
	TextDrawTextSize(Welcome_TD[7], 9.0000, 0.0000);
	TextDrawAlignment(Welcome_TD[7], 1);
	TextDrawColor(Welcome_TD[7], -1);
	TextDrawBackgroundColor(Welcome_TD[7], 255);
	TextDrawFont(Welcome_TD[7], 1);
	TextDrawSetProportional(Welcome_TD[7], 1);
	TextDrawSetShadow(Welcome_TD[7], 0);

	Welcome_TD[8] = TextDrawCreate(323.3331, 104.6481, "HAVANA ROLEPLAY"); // ?????
	TextDrawLetterSize(Welcome_TD[8], 0.3409, 1.2805);
	TextDrawTextSize(Welcome_TD[8], 0.0000, 9.0000);
	TextDrawAlignment(Welcome_TD[8], 2);
	TextDrawColor(Welcome_TD[8], 0xFF353FFF);
	TextDrawBackgroundColor(Welcome_TD[8], 255);
    TextDrawFont(Welcome_TD[8], 1);
    TextDrawSetProportional(Welcome_TD[8], 1);
    TextDrawSetShadow(Welcome_TD[8], 0);
    
    // Army Terrorist CaptureTD

	az_capture_td [0] = TextDrawCreate(28.749984, 189.859329, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [0], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [0], 121.666656, 52.666679 ) ;
	TextDrawAlignment(az_capture_td [0], 1 ) ;
	TextDrawColor(az_capture_td [0], 269488383 ) ;
	TextDrawSetShadow(az_capture_td [0], 0 ) ;
	TextDrawSetOutline(az_capture_td [0], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [0], 255 ) ;
	TextDrawFont(az_capture_td [0], 4 ) ;
	TextDrawSetProportional(az_capture_td [0], 0 ) ;
	TextDrawSetShadow(az_capture_td [0], 0 ) ;

	az_capture_td [1] = TextDrawCreate(27.499990, 188.185226, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [1], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [1], 124.999984, 12.740736 ) ;
	TextDrawAlignment(az_capture_td [1], 1 ) ;
	TextDrawColor(az_capture_td [1], 606348543 ) ;
	TextDrawSetShadow(az_capture_td [1], 0 ) ;
	TextDrawSetOutline(az_capture_td [1], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [1], 255 ) ;
	TextDrawFont(az_capture_td [1], 4 ) ;
	TextDrawSetProportional(az_capture_td [1], 0 ) ;
	TextDrawSetShadow(az_capture_td [1], 0 ) ;

	az_capture_td [2] = TextDrawCreate(27.500000, 200.111099, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [2], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [2], 2.499978, 43.851783 ) ;
	TextDrawAlignment(az_capture_td [2], 1 ) ;
	TextDrawColor(az_capture_td [2], 606348543 ) ;
	TextDrawSetShadow(az_capture_td [2], 0 ) ;
	TextDrawSetOutline(az_capture_td [2], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [2], 255 ) ;
	TextDrawFont(az_capture_td [2], 4 ) ;
	TextDrawSetProportional(az_capture_td [2], 0 ) ;
	TextDrawSetShadow(az_capture_td [2], 0 ) ;

	az_capture_td [3] = TextDrawCreate(150.000015, 200.629684, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [3], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [3], 2.499978, 42.814769 ) ;
	TextDrawAlignment(az_capture_td [3], 1 ) ;
	TextDrawColor(az_capture_td [3], 606348543 ) ;
	TextDrawSetShadow(az_capture_td [3], 0 ) ;
	TextDrawSetOutline(az_capture_td [3], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [3], 255 ) ;
	TextDrawFont(az_capture_td [3], 4 ) ;
	TextDrawSetProportional(az_capture_td [3], 0 ) ;
	TextDrawSetShadow(az_capture_td [3], 0 ) ;

	az_capture_td [4] = TextDrawCreate(27.916664, 241.073867, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [4], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [4], 124.999938, 2.888833 ) ;
	TextDrawAlignment(az_capture_td [4], 1 ) ;
	TextDrawColor(az_capture_td [4], 606348543 ) ;
	TextDrawSetShadow(az_capture_td [4], 0 ) ;
	TextDrawSetOutline(az_capture_td [4], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [4], 255 ) ;
	TextDrawFont(az_capture_td [4], 4 ) ;
	TextDrawSetProportional(az_capture_td [4], 0 ) ;
	TextDrawSetShadow(az_capture_td [4], 0 ) ;

	az_capture_td [5] = TextDrawCreate(89.583297, 190.518600, "CAPTURE_TIME:_2:28" ) ;
	TextDrawLetterSize(az_capture_td [5], 0.200828, 0.925924 ) ;
	TextDrawAlignment(az_capture_td [5], 2 ) ;
	TextDrawColor(az_capture_td [5], -1 ) ;
	TextDrawSetShadow(az_capture_td [5], 0 ) ;
	TextDrawSetOutline(az_capture_td [5], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [5], 255 ) ;
	TextDrawFont(az_capture_td [5], 1 ) ;
	TextDrawSetProportional(az_capture_td [5], 1 ) ;
	TextDrawSetShadow(az_capture_td [5], 0 ) ;

	az_capture_td [6] = TextDrawCreate(34.166622, 206.851898, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [6], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [6], 85.416732, 13.259243 ) ;
	TextDrawAlignment(az_capture_td [6], 1 ) ;
	TextDrawColor(az_capture_td [6], 522133503 ) ;
	TextDrawSetShadow(az_capture_td [6], 0 ) ;
	TextDrawSetOutline(az_capture_td [6], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [6], 255 ) ;
	TextDrawFont(az_capture_td [6], 4 ) ;
	TextDrawSetProportional(az_capture_td [6], 0 ) ;
	TextDrawSetShadow(az_capture_td [6], 0 ) ;

	az_capture_td [7] = TextDrawCreate(34.166622, 222.926025, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [7], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [7], 85.416732, 13.259243 ) ;
	TextDrawAlignment(az_capture_td [7], 1 ) ;
	TextDrawColor(az_capture_td [7], 522133503 ) ;
	TextDrawSetShadow(az_capture_td [7], 0 ) ;
	TextDrawSetOutline(az_capture_td [7], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [7], 255 ) ;
	TextDrawFont(az_capture_td [7], 4 ) ;
	TextDrawSetProportional(az_capture_td [7], 0 ) ;
	TextDrawSetShadow(az_capture_td [7], 0 ) ;

	az_capture_td [8] = TextDrawCreate(121.666618, 206.851882, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [8], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [8], 23.750068, 13.259243 ) ;
	TextDrawAlignment(az_capture_td [8], 1 ) ;
	TextDrawColor(az_capture_td [8], 522133503 ) ;
	TextDrawSetShadow(az_capture_td [8], 0 ) ;
	TextDrawSetOutline(az_capture_td [8], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [8], 255 ) ;
	TextDrawFont(az_capture_td [8], 4 ) ;
	TextDrawSetProportional(az_capture_td [8], 0 ) ;
	TextDrawSetShadow(az_capture_td [8], 0 ) ;

	az_capture_td [9] = TextDrawCreate(121.666610, 222.925964, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [9], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [9], 23.750068, 13.259243 ) ;
	TextDrawAlignment(az_capture_td [9], 1 ) ;
	TextDrawColor(az_capture_td [9], 522133503 ) ;
	TextDrawSetShadow(az_capture_td [9], 0 ) ;
	TextDrawSetOutline(az_capture_td [9], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [9], 255 ) ;
	TextDrawFont(az_capture_td [9], 4 ) ;
	TextDrawSetProportional(az_capture_td [9], 0 ) ;
	TextDrawSetShadow(az_capture_td [9], 0 ) ;

	az_capture_td [10] = TextDrawCreate(34.166622, 206.851898, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [10], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [10], 2.083405, 13.259244 ) ;
	TextDrawAlignment(az_capture_td [10], 1 ) ;
	TextDrawColor(az_capture_td [10], -5963521 ) ;
	TextDrawSetShadow(az_capture_td [10], 0 ) ;
	TextDrawSetOutline(az_capture_td [10], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [10], 255 ) ;
	TextDrawFont(az_capture_td [10], 4 ) ;
	TextDrawSetProportional(az_capture_td [10], 0 ) ;
	TextDrawSetShadow(az_capture_td [10], 0 ) ;

	az_capture_td [11] = TextDrawCreate(122.083328, 206.851882, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [11], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [11], 2.083405, 13.259244 ) ;
	TextDrawAlignment(az_capture_td [11], 1 ) ;
	TextDrawColor(az_capture_td [11], -5963521 ) ;
	TextDrawSetShadow(az_capture_td [11], 0 ) ;
	TextDrawSetOutline(az_capture_td [11], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [11], 255 ) ;
	TextDrawFont(az_capture_td [11], 4 ) ;
	TextDrawSetProportional(az_capture_td [11], 0 ) ;
	TextDrawSetShadow(az_capture_td [11], 0 ) ;

	az_capture_td [12] = TextDrawCreate(34.166648, 222.925979, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [12], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [12], 2.083405, 13.259244 ) ;
	TextDrawAlignment(az_capture_td [12], 1 ) ;
	TextDrawColor(az_capture_td [12], 8388863 ) ;
	TextDrawSetShadow(az_capture_td [12], 0 ) ;
	TextDrawSetOutline(az_capture_td [12], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [12], 255 ) ;
	TextDrawFont(az_capture_td [12], 4 ) ;
	TextDrawSetProportional(az_capture_td [12], 0 ) ;
	TextDrawSetShadow(az_capture_td [12], 0 ) ;

	az_capture_td [13] = TextDrawCreate(122.083328, 222.925949, "LD_SPAC:white" ) ;
	TextDrawLetterSize(az_capture_td [13], 0.000000, 0.000000 ) ;
	TextDrawTextSize(az_capture_td [13], 2.083405, 13.259244 ) ;
	TextDrawAlignment(az_capture_td [13], 1 ) ;
	TextDrawColor(az_capture_td [13], 8388863 ) ;
	TextDrawSetShadow(az_capture_td [13], 0 ) ;
	TextDrawSetOutline(az_capture_td [13], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [13], 255 ) ;
	TextDrawFont(az_capture_td [13], 4 ) ;
	TextDrawSetProportional(az_capture_td [13], 0 ) ;
	TextDrawSetShadow(az_capture_td [13], 0 ) ;

	az_capture_td [14] = TextDrawCreate(77.916641, 209.703842, "LOS_SANTOS_VAGOS" ) ;
	TextDrawLetterSize(az_capture_td [14], 0.200828, 0.925924 ) ;
	TextDrawAlignment(az_capture_td [14], 2 ) ;
	TextDrawColor(az_capture_td [14], -1 ) ;
	TextDrawSetShadow(az_capture_td [14], 0 ) ;
	TextDrawSetOutline(az_capture_td [14], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [14], 255 ) ;
	TextDrawFont(az_capture_td [14], 1 ) ;
	TextDrawSetProportional(az_capture_td [14], 1 ) ;
	TextDrawSetShadow(az_capture_td [14], 0 ) ;

	az_capture_td [15] = TextDrawCreate(77.916641, 225.259460, "GROVE_STREET" ) ;
	TextDrawLetterSize(az_capture_td [15], 0.200828, 0.925924 ) ;
	TextDrawAlignment(az_capture_td [15], 2 ) ;
	TextDrawColor(az_capture_td [15], -1 ) ;
	TextDrawSetShadow(az_capture_td [15], 0 ) ;
	TextDrawSetOutline(az_capture_td [15], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [15], 255 ) ;
	TextDrawFont(az_capture_td [15], 1 ) ;
	TextDrawSetProportional(az_capture_td [15], 1 ) ;
	TextDrawSetShadow(az_capture_td [15], 0 ) ;

	az_capture_td [16] = TextDrawCreate(135.000000, 225.259445, "0" ) ;
	TextDrawLetterSize(az_capture_td [16], 0.200828, 0.925924 ) ;
	TextDrawAlignment(az_capture_td [16], 2 ) ;
	TextDrawColor(az_capture_td [16], -1 ) ;
	TextDrawSetShadow(az_capture_td [16], 0 ) ;
	TextDrawSetOutline(az_capture_td [16], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [16], 255 ) ;
	TextDrawFont(az_capture_td [16], 1 ) ;
	TextDrawSetProportional(az_capture_td [16], 1 ) ;
	TextDrawSetShadow(az_capture_td [16], 0 ) ;

	az_capture_td [17] = TextDrawCreate(134.583404, 209.703887, "0" ) ;
	TextDrawLetterSize(az_capture_td [17], 0.200828, 0.925924 ) ;
	TextDrawAlignment(az_capture_td [17], 2 ) ;
	TextDrawColor(az_capture_td [17], -1 ) ;
	TextDrawSetShadow(az_capture_td [17], 0 ) ;
	TextDrawSetOutline(az_capture_td [17], 0 ) ;
	TextDrawBackgroundColor(az_capture_td [17], 255 ) ;
	TextDrawFont(az_capture_td [17], 1 ) ;
	TextDrawSetProportional(az_capture_td [17], 1 ) ;
	TextDrawSetShadow(az_capture_td [17], 0 ) ;
    
    
    //carpass
    Carpass_TD[0] = TextDrawCreate(249.3333, 144.3481, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[0], 139.0000, 175.0000);
	TextDrawAlignment(Carpass_TD[0], 1);
	TextDrawColor(Carpass_TD[0], 235802367);
	TextDrawBackgroundColor(Carpass_TD[0], 255);
	TextDrawFont(Carpass_TD[0], 4);
	TextDrawSetProportional(Carpass_TD[0], 0);
	TextDrawSetShadow(Carpass_TD[0], 0);

	Carpass_TD[1] = TextDrawCreate(379.2333, 299.2054, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[1], 19.0000, 24.0000);
	TextDrawAlignment(Carpass_TD[1], 1);
	TextDrawColor(Carpass_TD[1], 235802367);
	TextDrawBackgroundColor(Carpass_TD[1], 255);
	TextDrawFont(Carpass_TD[1], 4);
	TextDrawSetProportional(Carpass_TD[1], 0);
	TextDrawSetShadow(Carpass_TD[1], 0);

	Carpass_TD[2] = TextDrawCreate(379.2333, 140.2962, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[2], 19.0000, 24.0000);
	TextDrawAlignment(Carpass_TD[2], 1);
	TextDrawColor(Carpass_TD[2], 235802367);
	TextDrawBackgroundColor(Carpass_TD[2], 255);
	TextDrawFont(Carpass_TD[2], 4);
	TextDrawSetProportional(Carpass_TD[2], 0);
	TextDrawSetShadow(Carpass_TD[2], 0);

	Carpass_TD[3] = TextDrawCreate(239.3333, 140.2962, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[3], 19.0000, 24.0000);
	TextDrawAlignment(Carpass_TD[3], 1);
	TextDrawColor(Carpass_TD[3], 235802367);
	TextDrawBackgroundColor(Carpass_TD[3], 255);
	TextDrawFont(Carpass_TD[3], 4);
	TextDrawSetProportional(Carpass_TD[3], 0);
	TextDrawSetShadow(Carpass_TD[3], 0);

	Carpass_TD[4] = TextDrawCreate(239.3333, 299.2053, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[4], 19.0000, 24.0000);
	TextDrawAlignment(Carpass_TD[4], 1);
	TextDrawColor(Carpass_TD[4], 235802367);
	TextDrawBackgroundColor(Carpass_TD[4], 255);
	TextDrawFont(Carpass_TD[4], 4);
	TextDrawSetProportional(Carpass_TD[4], 0);
	TextDrawSetShadow(Carpass_TD[4], 0);

	Carpass_TD[5] = TextDrawCreate(242.6666, 153.3406, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[5], 152.5402, 157.0000);
	TextDrawAlignment(Carpass_TD[5], 1);
	TextDrawColor(Carpass_TD[5], 235802367);
	TextDrawBackgroundColor(Carpass_TD[5], 255);
	TextDrawFont(Carpass_TD[5], 4);
	TextDrawSetProportional(Carpass_TD[5], 0);
	TextDrawSetShadow(Carpass_TD[5], 0);

	Carpass_TD[6] = TextDrawCreate(252.3332, 175.0258, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[6], 48.0000, 38.4197);
	TextDrawAlignment(Carpass_TD[6], 1);
	TextDrawColor(Carpass_TD[6], 505290495);
	TextDrawBackgroundColor(Carpass_TD[6], 255);
	TextDrawFont(Carpass_TD[6], 4);
	TextDrawSetProportional(Carpass_TD[6], 0);
	TextDrawSetShadow(Carpass_TD[6], 0);

	Carpass_TD[7] = TextDrawCreate(253.2332, 176.1259, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[7], 46.0000, 36.0000);
	TextDrawAlignment(Carpass_TD[7], 1);
	TextDrawColor(Carpass_TD[7], 235802367);
	TextDrawBackgroundColor(Carpass_TD[7], 255);
	TextDrawFont(Carpass_TD[7], 4);
	TextDrawSetProportional(Carpass_TD[7], 0);
	TextDrawSetShadow(Carpass_TD[7], 0);

	Carpass_TD[8] = TextDrawCreate(255.5666, 179.4442, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[8], 41.0000, 29.5198);
	TextDrawAlignment(Carpass_TD[8], 1);
	TextDrawColor(Carpass_TD[8], 505290495);
	TextDrawBackgroundColor(Carpass_TD[8], 255);
	TextDrawFont(Carpass_TD[8], 4);
	TextDrawSetProportional(Carpass_TD[8], 0);
	TextDrawSetShadow(Carpass_TD[8], 0);

	Carpass_TD[9] = TextDrawCreate(256.5666, 180.6886, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[9], 39.0000, 27.0000);
	TextDrawAlignment(Carpass_TD[9], 1);
	TextDrawColor(Carpass_TD[9], 235802367);
	TextDrawBackgroundColor(Carpass_TD[9], 255);
	TextDrawFont(Carpass_TD[9], 4);
	TextDrawSetProportional(Carpass_TD[9], 0);
	TextDrawSetShadow(Carpass_TD[9], 0);

	Carpass_TD[10] = TextDrawCreate(262.6331, 193.9960, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[10], 27.0000, 4.8400);
	TextDrawAlignment(Carpass_TD[10], 1);
	TextDrawColor(Carpass_TD[10], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[10], 255);
	TextDrawFont(Carpass_TD[10], 4);
	TextDrawSetProportional(Carpass_TD[10], 0);
	TextDrawSetShadow(Carpass_TD[10], 0);

	Carpass_TD[11] = TextDrawCreate(261.5333, 190.6774, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[11], 5.0000, 6.0000);
	TextDrawAlignment(Carpass_TD[11], 1);
	TextDrawColor(Carpass_TD[11], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[11], 255);
	TextDrawFont(Carpass_TD[11], 4);
	TextDrawSetProportional(Carpass_TD[11], 0);
	TextDrawSetShadow(Carpass_TD[11], 0);

	Carpass_TD[12] = TextDrawCreate(285.2346, 190.6774, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[12], 5.0000, 6.0000);
	TextDrawAlignment(Carpass_TD[12], 1);
	TextDrawColor(Carpass_TD[12], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[12], 255);
	TextDrawFont(Carpass_TD[12], 4);
	TextDrawSetProportional(Carpass_TD[12], 0);
	TextDrawSetShadow(Carpass_TD[12], 0);

	Carpass_TD[13] = TextDrawCreate(264.9998, 191.7036, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[13], 22.0000, 3.4300);
	TextDrawAlignment(Carpass_TD[13], 1);
	TextDrawColor(Carpass_TD[13], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[13], 255);
	TextDrawFont(Carpass_TD[13], 4);
	TextDrawSetProportional(Carpass_TD[13], 0);
	TextDrawSetShadow(Carpass_TD[13], 0);

	Carpass_TD[14] = TextDrawCreate(279.3676, 192.9218, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[14], 9.6400, 11.0000);
	TextDrawAlignment(Carpass_TD[14], 1);
	TextDrawColor(Carpass_TD[14], 235802367);
	TextDrawBackgroundColor(Carpass_TD[14], 255);
	TextDrawFont(Carpass_TD[14], 4);
	TextDrawSetProportional(Carpass_TD[14], 0);
	TextDrawSetShadow(Carpass_TD[14], 0);

	Carpass_TD[15] = TextDrawCreate(280.4676, 194.4073, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[15], 7.0000, 9.0000);
	TextDrawAlignment(Carpass_TD[15], 1);
	TextDrawColor(Carpass_TD[15], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[15], 255);
	TextDrawFont(Carpass_TD[15], 4);
	TextDrawSetProportional(Carpass_TD[15], 0);
	TextDrawSetShadow(Carpass_TD[15], 0);

	Carpass_TD[16] = TextDrawCreate(262.5663, 193.0220, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[16], 9.4600, 11.0000);
	TextDrawAlignment(Carpass_TD[16], 1);
	TextDrawColor(Carpass_TD[16], 235802367);
	TextDrawBackgroundColor(Carpass_TD[16], 255);
	TextDrawFont(Carpass_TD[16], 4);
	TextDrawSetProportional(Carpass_TD[16], 0);
	TextDrawSetShadow(Carpass_TD[16], 0);

	Carpass_TD[17] = TextDrawCreate(263.6666, 194.4073, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[17], 7.0000, 9.0000);
	TextDrawAlignment(Carpass_TD[17], 1);
	TextDrawColor(Carpass_TD[17], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[17], 255);
	TextDrawFont(Carpass_TD[17], 4);
	TextDrawSetProportional(Carpass_TD[17], 0);
	TextDrawSetShadow(Carpass_TD[17], 0);

	Carpass_TD[18] = TextDrawCreate(278.9348, 185.2995, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[18], 6.0000, 10.0000);
	TextDrawAlignment(Carpass_TD[18], 1);
	TextDrawColor(Carpass_TD[18], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[18], 255);
	TextDrawFont(Carpass_TD[18], 4);
	TextDrawSetProportional(Carpass_TD[18], 0);
	TextDrawSetShadow(Carpass_TD[18], 0);

	Carpass_TD[19] = TextDrawCreate(266.7339, 185.2995, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[19], 6.0000, 10.0000);
	TextDrawAlignment(Carpass_TD[19], 1);
	TextDrawColor(Carpass_TD[19], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[19], 255);
	TextDrawFont(Carpass_TD[19], 4);
	TextDrawSetProportional(Carpass_TD[19], 0);
	TextDrawSetShadow(Carpass_TD[19], 0);

	Carpass_TD[20] = TextDrawCreate(267.4333, 190.2738, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[20], 16.3999, 4.0000);
	TextDrawAlignment(Carpass_TD[20], 1);
	TextDrawColor(Carpass_TD[20], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[20], 255);
	TextDrawFont(Carpass_TD[20], 4);
	TextDrawSetProportional(Carpass_TD[20], 0);
	TextDrawSetShadow(Carpass_TD[20], 0);

	Carpass_TD[21] = TextDrawCreate(270.0666, 186.9850, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[21], 11.3100, 4.0000);
	TextDrawAlignment(Carpass_TD[21], 1);
	TextDrawColor(Carpass_TD[21], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[21], 255);
	TextDrawFont(Carpass_TD[21], 4);
	TextDrawSetProportional(Carpass_TD[21], 0);
	TextDrawSetShadow(Carpass_TD[21], 0);

	Carpass_TD[22] = TextDrawCreate(270.5333, 188.4850, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[22], 4.0000, 2.9500);
	TextDrawAlignment(Carpass_TD[22], 1);
	TextDrawColor(Carpass_TD[22], 235802367);
	TextDrawBackgroundColor(Carpass_TD[22], 255);
	TextDrawFont(Carpass_TD[22], 4);
	TextDrawSetProportional(Carpass_TD[22], 0);
	TextDrawSetShadow(Carpass_TD[22], 0);

	Carpass_TD[23] = TextDrawCreate(277.5337, 188.4850, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[23], 4.0000, 2.9500);
	TextDrawAlignment(Carpass_TD[23], 1);
	TextDrawColor(Carpass_TD[23], 235802367);
	TextDrawBackgroundColor(Carpass_TD[23], 255);
	TextDrawFont(Carpass_TD[23], 4);
	TextDrawSetProportional(Carpass_TD[23], 0);
	TextDrawSetShadow(Carpass_TD[23], 0);

	Carpass_TD[24] = TextDrawCreate(271.7002, 193.8777, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[24], 2.0000, 1.0000);
	TextDrawAlignment(Carpass_TD[24], 1);
	TextDrawColor(Carpass_TD[24], 235802367);
	TextDrawBackgroundColor(Carpass_TD[24], 255);
	TextDrawFont(Carpass_TD[24], 4);
	TextDrawSetProportional(Carpass_TD[24], 0);
	TextDrawSetShadow(Carpass_TD[24], 0);

	Carpass_TD[25] = TextDrawCreate(277.5005, 193.8777, "LD_SPAC:white"); // Car
	TextDrawTextSize(Carpass_TD[25], 2.0000, 1.0000);
	TextDrawAlignment(Carpass_TD[25], 1);
	TextDrawColor(Carpass_TD[25], 235802367);
	TextDrawBackgroundColor(Carpass_TD[25], 255);
	TextDrawFont(Carpass_TD[25], 4);
	TextDrawSetProportional(Carpass_TD[25], 0);
	TextDrawSetShadow(Carpass_TD[25], 0);

	Carpass_TD[26] = TextDrawCreate(266.2007, 197.6405, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[26], 2.0000, 2.5699);
	TextDrawAlignment(Carpass_TD[26], 1);
	TextDrawColor(Carpass_TD[26], 235802367);
	TextDrawBackgroundColor(Carpass_TD[26], 255);
	TextDrawFont(Carpass_TD[26], 4);
	TextDrawSetProportional(Carpass_TD[26], 0);
	TextDrawSetShadow(Carpass_TD[26], 0);

	Carpass_TD[27] = TextDrawCreate(283.1017, 197.6405, "LD_Beat:Chit"); // Car
	TextDrawTextSize(Carpass_TD[27], 2.0000, 2.5699);
	TextDrawAlignment(Carpass_TD[27], 1);
	TextDrawColor(Carpass_TD[27], 235802367);
	TextDrawBackgroundColor(Carpass_TD[27], 255);
	TextDrawFont(Carpass_TD[27], 4);
	TextDrawSetProportional(Carpass_TD[27], 0);
	TextDrawSetShadow(Carpass_TD[27], 0);

	Carpass_TD[28] = TextDrawCreate(281.6666, 194.1479, "/"); // Car
	TextDrawLetterSize(Carpass_TD[28], 0.3152, -0.8015);
	TextDrawAlignment(Carpass_TD[28], 1);
	TextDrawColor(Carpass_TD[28], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[28], 255);
	TextDrawFont(Carpass_TD[28], 1);
	TextDrawSetProportional(Carpass_TD[28], 1);
	TextDrawSetShadow(Carpass_TD[28], 0);

	Carpass_TD[29] = TextDrawCreate(266.2332, 185.4368, "/"); // Car
	TextDrawLetterSize(Carpass_TD[29], 0.3235, 0.9362);
	TextDrawAlignment(Carpass_TD[29], 1);
	TextDrawColor(Carpass_TD[29], -2139062017);
	TextDrawBackgroundColor(Carpass_TD[29], 255);
	TextDrawFont(Carpass_TD[29], 1);
	TextDrawSetProportional(Carpass_TD[29], 1);
	TextDrawSetShadow(Carpass_TD[29], 0);

	Carpass_TD[30] = TextDrawCreate(263.3332, 192.7480, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[30], 1.0000, 2.0000);
	TextDrawAlignment(Carpass_TD[30], 1);
	TextDrawColor(Carpass_TD[30], 235802367);
	TextDrawBackgroundColor(Carpass_TD[30], 255);
	TextDrawFont(Carpass_TD[30], 4);
	TextDrawSetProportional(Carpass_TD[30], 0);
	TextDrawSetShadow(Carpass_TD[30], 0);

	Carpass_TD[31] = TextDrawCreate(287.6666, 192.7480, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[31], 1.0000, 1.0000);
	TextDrawAlignment(Carpass_TD[31], 1);
	TextDrawColor(Carpass_TD[31], 235802367);
	TextDrawBackgroundColor(Carpass_TD[31], 255);
	TextDrawFont(Carpass_TD[31], 4);
	TextDrawSetProportional(Carpass_TD[31], 0);
	TextDrawSetShadow(Carpass_TD[31], 0);

	Carpass_TD[32] = TextDrawCreate(306.2335, 175.6517, "OWNER:~n~~n~MODEL:~n~~n~NUMBER_PLATE:"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[32], 0.1791, 0.8076);
	TextDrawAlignment(Carpass_TD[32], 1);
	TextDrawColor(Carpass_TD[32], 505290495);
	TextDrawBackgroundColor(Carpass_TD[32], 255);
	TextDrawFont(Carpass_TD[32], 1);
	TextDrawSetProportional(Carpass_TD[32], 1);
	TextDrawSetShadow(Carpass_TD[32], 0);

	Carpass_TD[33] = TextDrawCreate(306.5334, 184.3334, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[33], 78.0000, 0.8500);
	TextDrawAlignment(Carpass_TD[33], 1);
	TextDrawColor(Carpass_TD[33], 505290495);
	TextDrawBackgroundColor(Carpass_TD[33], 255);
	TextDrawFont(Carpass_TD[33], 4);
	TextDrawSetProportional(Carpass_TD[33], 0);
	TextDrawSetShadow(Carpass_TD[33], 0);

	Carpass_TD[34] = TextDrawCreate(306.5334, 199.1342, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[34], 78.0000, 0.8500);
	TextDrawAlignment(Carpass_TD[34], 1);
	TextDrawColor(Carpass_TD[34], 505290495);
	TextDrawBackgroundColor(Carpass_TD[34], 255);
	TextDrawFont(Carpass_TD[34], 4);
	TextDrawSetProportional(Carpass_TD[34], 0);
	TextDrawSetShadow(Carpass_TD[34], 0);

	Carpass_TD[35] = TextDrawCreate(306.5334, 212.8351, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[35], 78.0000, 0.8500);
	TextDrawAlignment(Carpass_TD[35], 1);
	TextDrawColor(Carpass_TD[35], 505290495);
	TextDrawBackgroundColor(Carpass_TD[35], 255);
	TextDrawFont(Carpass_TD[35], 4);
	TextDrawSetProportional(Carpass_TD[35], 0);
	TextDrawSetShadow(Carpass_TD[35], 0);

	Carpass_TD[36] = TextDrawCreate(333.5002, 219.5742, "MILEAGE:"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[36], 0.1893, 0.8367);
	TextDrawAlignment(Carpass_TD[36], 1);
	TextDrawColor(Carpass_TD[36], 505290495);
	TextDrawBackgroundColor(Carpass_TD[36], 255);
	TextDrawFont(Carpass_TD[36], 1);
	TextDrawSetProportional(Carpass_TD[36], 1);
	TextDrawSetShadow(Carpass_TD[36], 0);

	Carpass_TD[37] = TextDrawCreate(252.3332, 219.4743, "ENGINE:"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[37], 0.1893, 0.8367);
	TextDrawAlignment(Carpass_TD[37], 1);
	TextDrawColor(Carpass_TD[37], 505290495);
	TextDrawBackgroundColor(Carpass_TD[37], 255);
	TextDrawFont(Carpass_TD[37], 1);
	TextDrawSetProportional(Carpass_TD[37], 1);
	TextDrawSetShadow(Carpass_TD[37], 0);

	Carpass_TD[38] = TextDrawCreate(252.3332, 228.5193, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[38], 72.0000, 0.6499);
	TextDrawAlignment(Carpass_TD[38], 1);
	TextDrawColor(Carpass_TD[38], 505290495);
	TextDrawBackgroundColor(Carpass_TD[38], 255);
	TextDrawFont(Carpass_TD[38], 4);
	TextDrawSetProportional(Carpass_TD[38], 0);
	TextDrawSetShadow(Carpass_TD[38], 0);

	Carpass_TD[39] = TextDrawCreate(332.9998, 228.5193, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[39], 52.0000, 0.7598);
	TextDrawAlignment(Carpass_TD[39], 1);
	TextDrawColor(Carpass_TD[39], 505290495);
	TextDrawBackgroundColor(Carpass_TD[39], 255);
	TextDrawFont(Carpass_TD[39], 4);
	TextDrawSetProportional(Carpass_TD[39], 0);
	TextDrawSetShadow(Carpass_TD[39], 0);

	Carpass_TD[40] = TextDrawCreate(318.4000, 155.3293, "Technical_Passport"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[40], 0.1993, 0.9487);
	TextDrawAlignment(Carpass_TD[40], 2);
	TextDrawColor(Carpass_TD[40], -1061109505);
	TextDrawBackgroundColor(Carpass_TD[40], 255);
	TextDrawFont(Carpass_TD[40], 1);
	TextDrawSetProportional(Carpass_TD[40], 1);
	TextDrawSetShadow(Carpass_TD[40], 0);

	Carpass_TD[41] = TextDrawCreate(319.5999, 235.8414, "Iznos_wheels"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[41], 0.1870, 1.0317);
	TextDrawAlignment(Carpass_TD[41], 2);
	TextDrawColor(Carpass_TD[41], -1061109505);
	TextDrawBackgroundColor(Carpass_TD[41], 255);
	TextDrawFont(Carpass_TD[41], 1);
	TextDrawSetProportional(Carpass_TD[41], 1);
	TextDrawSetShadow(Carpass_TD[41], 0);

	Carpass_TD[42] = TextDrawCreate(325.5002, 269.0758, "WHEEL_4:"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[42], 0.1850, 0.8615);
	TextDrawAlignment(Carpass_TD[42], 1);
	TextDrawColor(Carpass_TD[42], 505290495);
	TextDrawBackgroundColor(Carpass_TD[42], 255);
	TextDrawFont(Carpass_TD[42], 1);
	TextDrawSetProportional(Carpass_TD[42], 1);
	TextDrawSetShadow(Carpass_TD[42], 0);

	Carpass_TD[43] = TextDrawCreate(325.5004, 254.1425, "WHEEL_2:"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[43], 0.1844, 0.8324);
	TextDrawAlignment(Carpass_TD[43], 1);
	TextDrawColor(Carpass_TD[43], 505290495);
	TextDrawBackgroundColor(Carpass_TD[43], 255);
	TextDrawFont(Carpass_TD[43], 1);
	TextDrawSetProportional(Carpass_TD[43], 1);
	TextDrawSetShadow(Carpass_TD[43], 0);

	Carpass_TD[44] = TextDrawCreate(269.1667, 268.2463, "WHEEL_3:"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[44], 0.1844, 0.8489);
	TextDrawAlignment(Carpass_TD[44], 1);
	TextDrawColor(Carpass_TD[44], 505290495);
	TextDrawBackgroundColor(Carpass_TD[44], 255);
	TextDrawFont(Carpass_TD[44], 1);
	TextDrawSetProportional(Carpass_TD[44], 1);
	TextDrawSetShadow(Carpass_TD[44], 0);

	Carpass_TD[45] = TextDrawCreate(269.1667, 253.3127, "WHEEL_1:"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[45], 0.1893, 0.8367);
	TextDrawAlignment(Carpass_TD[45], 1);
	TextDrawColor(Carpass_TD[45], 505290495);
	TextDrawBackgroundColor(Carpass_TD[45], 255);
	TextDrawFont(Carpass_TD[45], 1);
	TextDrawSetProportional(Carpass_TD[45], 1);
	TextDrawSetShadow(Carpass_TD[45], 0);

	Carpass_TD[46] = TextDrawCreate(268.9998, 262.3777, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[46], 97.0000, 0.9900);
	TextDrawAlignment(Carpass_TD[46], 1);
	TextDrawColor(Carpass_TD[46], 505290495);
	TextDrawBackgroundColor(Carpass_TD[46], 255);
	TextDrawFont(Carpass_TD[46], 4);
	TextDrawSetProportional(Carpass_TD[46], 0);
	TextDrawSetShadow(Carpass_TD[46], 0);

	Carpass_TD[47] = TextDrawCreate(268.9998, 276.7786, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[47], 97.0000, 0.9900);
	TextDrawAlignment(Carpass_TD[47], 1);
	TextDrawColor(Carpass_TD[47], 505290495);
	TextDrawBackgroundColor(Carpass_TD[47], 255);
	TextDrawFont(Carpass_TD[47], 4);
	TextDrawSetProportional(Carpass_TD[47], 0);
	TextDrawSetShadow(Carpass_TD[47], 0);

	Carpass_TD[48] = TextDrawCreate(311.0329, 257.2821, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[48], 13.0000, 23.0000);
	TextDrawAlignment(Carpass_TD[48], 1);
	TextDrawColor(Carpass_TD[48], 235802367);
	TextDrawBackgroundColor(Carpass_TD[48], 255);
	TextDrawFont(Carpass_TD[48], 4);
	TextDrawSetProportional(Carpass_TD[48], 0);
	TextDrawSetShadow(Carpass_TD[48], 0);

	Carpass_TD[49] = TextDrawCreate(242.9999, 291.0599, "particle:lamp_shad_64"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[49], 156.0000, 28.0000);
	TextDrawAlignment(Carpass_TD[49], 1);
	TextDrawColor(Carpass_TD[49], -222);
	TextDrawBackgroundColor(Carpass_TD[49], 255);
	TextDrawFont(Carpass_TD[49], 4);
	TextDrawSetProportional(Carpass_TD[49], 0);
	TextDrawSetShadow(Carpass_TD[49], 0);

	Carpass_TD[50] = TextDrawCreate(285.9998, 291.9856, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[50], 17.0000, 20.7698);
	TextDrawAlignment(Carpass_TD[50], 1);
	TextDrawColor(Carpass_TD[50], -1);
	TextDrawBackgroundColor(Carpass_TD[50], 255);
	TextDrawFont(Carpass_TD[50], 4);
	TextDrawSetProportional(Carpass_TD[50], 0);
	TextDrawSetShadow(Carpass_TD[50], 0);

	Carpass_TD[51] = TextDrawCreate(295.3332, 295.3746, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[51], 46.0000, 14.0000);
	TextDrawAlignment(Carpass_TD[51], 1);
	TextDrawColor(Carpass_TD[51], -1);
	TextDrawBackgroundColor(Carpass_TD[51], 255);
	TextDrawFont(Carpass_TD[51], 4);
	TextDrawSetProportional(Carpass_TD[51], 0);
	TextDrawSetShadow(Carpass_TD[51], 0);

	Carpass_TD[52] = TextDrawCreate(333.3332, 291.9856, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[52], 17.0000, 20.7698);
	TextDrawAlignment(Carpass_TD[52], 1);
	TextDrawColor(Carpass_TD[52], -1);
	TextDrawBackgroundColor(Carpass_TD[52], 255);
	TextDrawFont(Carpass_TD[52], 4);
	TextDrawSetProportional(Carpass_TD[52], 0);
	TextDrawSetShadow(Carpass_TD[52], 0);

	Carpass_TD[53] = TextDrawCreate(318.3666, 298.0633, "CONTINUE"); // ذ؟رƒرپر‚ذ¾
	TextDrawLetterSize(Carpass_TD[53], 0.2002, 0.8988);
	TextDrawTextSize(Carpass_TD[53], 10.0000, 57.0000);
	TextDrawAlignment(Carpass_TD[53], 2);
	TextDrawColor(Carpass_TD[53], 235802367);
	TextDrawUseBox(Carpass_TD[53], 1);
	TextDrawBoxColor(Carpass_TD[53], 0);
	TextDrawBackgroundColor(Carpass_TD[53], 255);
	TextDrawFont(Carpass_TD[53], 1);
	TextDrawSetProportional(Carpass_TD[53], 1);
	TextDrawSetShadow(Carpass_TD[53], 0);
	TextDrawSetSelectable(Carpass_TD[53], true);

	Carpass_TD[54] = TextDrawCreate(242.6332, 154.9999, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[54], 16.0000, 3.0000);
	TextDrawAlignment(Carpass_TD[54], 1);
	TextDrawColor(Carpass_TD[54], 505290495);
	TextDrawBackgroundColor(Carpass_TD[54], 255);
	TextDrawFont(Carpass_TD[54], 4);
	TextDrawSetProportional(Carpass_TD[54], 0);
	TextDrawSetShadow(Carpass_TD[54], 0);

	Carpass_TD[55] = TextDrawCreate(242.6665, 160.4368, "LD_SPAC:white"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[55], 9.0000, 3.0000);
	TextDrawAlignment(Carpass_TD[55], 1);
	TextDrawColor(Carpass_TD[55], 505290495);
	TextDrawBackgroundColor(Carpass_TD[55], 255);
	TextDrawFont(Carpass_TD[55], 4);
	TextDrawSetProportional(Carpass_TD[55], 0);
	TextDrawSetShadow(Carpass_TD[55], 0);

	Carpass_TD[56] = TextDrawCreate(249.3332, 159.4072, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[56], 5.0000, 4.7799);
	TextDrawAlignment(Carpass_TD[56], 1);
	TextDrawColor(Carpass_TD[56], 505290495);
	TextDrawBackgroundColor(Carpass_TD[56], 255);
	TextDrawFont(Carpass_TD[56], 4);
	TextDrawSetProportional(Carpass_TD[56], 0);
	TextDrawSetShadow(Carpass_TD[56], 0);

	Carpass_TD[57] = TextDrawCreate(255.9998, 153.9998, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[57], 5.0000, 4.7799);
	TextDrawAlignment(Carpass_TD[57], 1);
	TextDrawColor(Carpass_TD[57], 505290495);
	TextDrawBackgroundColor(Carpass_TD[57], 255);
	TextDrawFont(Carpass_TD[57], 4);
	TextDrawSetProportional(Carpass_TD[57], 0);
	TextDrawSetShadow(Carpass_TD[57], 0);

	Carpass_TD[58] = TextDrawCreate(253.7999, 159.6072, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[58], 4.0000, 4.4699);
	TextDrawAlignment(Carpass_TD[58], 1);
	TextDrawColor(Carpass_TD[58], 505290495);
	TextDrawBackgroundColor(Carpass_TD[58], 255);
	TextDrawFont(Carpass_TD[58], 4);
	TextDrawSetProportional(Carpass_TD[58], 0);
	TextDrawSetShadow(Carpass_TD[58], 0);

	Carpass_TD[59] = TextDrawCreate(362.9999, 135.9592, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[59], 14.0000, 16.7999);
	TextDrawAlignment(Carpass_TD[59], 1);
	TextDrawColor(Carpass_TD[59], -1);
	TextDrawBackgroundColor(Carpass_TD[59], 255);
	TextDrawFont(Carpass_TD[59], 4);
	TextDrawSetProportional(Carpass_TD[59], 0);
	TextDrawSetShadow(Carpass_TD[59], 0);

	Carpass_TD[60] = TextDrawCreate(240.3331, 209.7962, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[60], 6.0000, 7.0299);
	TextDrawAlignment(Carpass_TD[60], 1);
	TextDrawColor(Carpass_TD[60], -1);
	TextDrawBackgroundColor(Carpass_TD[60], 255);
	TextDrawFont(Carpass_TD[60], 4);
	TextDrawSetProportional(Carpass_TD[60], 0);
	TextDrawSetShadow(Carpass_TD[60], 0);

	Carpass_TD[61] = TextDrawCreate(390.9332, 290.2704, "LD_Beat:Chit"); // ذ؟رƒرپر‚ذ¾
	TextDrawTextSize(Carpass_TD[61], 7.0000, 9.0000);
	TextDrawAlignment(Carpass_TD[61], 1);
	TextDrawColor(Carpass_TD[61], -1);
	TextDrawBackgroundColor(Carpass_TD[61], 255);
	TextDrawFont(Carpass_TD[61], 4);
	TextDrawSetProportional(Carpass_TD[61], 0);
	TextDrawSetShadow(Carpass_TD[61], 0);
    	
	/*
	SpeedDragon[0] = TextDrawCreate(294.3334, 363.6518, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[0], 97.0000, 74.0000);
	TextDrawAlignment(SpeedDragon[0], 1);
	TextDrawColor(SpeedDragon[0], 235802367);
	TextDrawBackgroundColor(SpeedDragon[0], 255);
	TextDrawFont(SpeedDragon[0], 4);
	TextDrawSetProportional(SpeedDragon[0], 0);
	TextDrawSetShadow(SpeedDragon[0], 0);

	SpeedDragon[1] = TextDrawCreate(383.3334, 360.0332, "LD_Beat:Chit"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[1], 17.0000, 22.0000);
	TextDrawAlignment(SpeedDragon[1], 1);
	TextDrawColor(SpeedDragon[1], 235802367);
	TextDrawBackgroundColor(SpeedDragon[1], 255);
	TextDrawFont(SpeedDragon[1], 4);
	TextDrawSetProportional(SpeedDragon[1], 0);
	TextDrawSetShadow(SpeedDragon[1], 0);

	SpeedDragon[2] = TextDrawCreate(284.9666, 419.5665, "LD_Beat:Chit"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[2], 17.0000, 22.0000);
	TextDrawAlignment(SpeedDragon[2], 1);
	TextDrawColor(SpeedDragon[2], 235802367);
	TextDrawBackgroundColor(SpeedDragon[2], 255);
	TextDrawFont(SpeedDragon[2], 4);
	TextDrawSetProportional(SpeedDragon[2], 0);
	TextDrawSetShadow(SpeedDragon[2], 0);

	SpeedDragon[3] = TextDrawCreate(287.8999, 363.6666, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[3], 90.0000, 67.1898);
	TextDrawAlignment(SpeedDragon[3], 1);
	TextDrawColor(SpeedDragon[3], 235802367);
	TextDrawBackgroundColor(SpeedDragon[3], 255);
	TextDrawFont(SpeedDragon[3], 4);
	TextDrawSetProportional(SpeedDragon[3], 0);
	TextDrawSetShadow(SpeedDragon[3], 0);

	SpeedDragon[4] = TextDrawCreate(307.5667, 370.7333, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[4], 90.0000, 67.1898);
	TextDrawAlignment(SpeedDragon[4], 1);
	TextDrawColor(SpeedDragon[4], 235802367);
	TextDrawBackgroundColor(SpeedDragon[4], 255);
	TextDrawFont(SpeedDragon[4], 4);
	TextDrawSetProportional(SpeedDragon[4], 0);
	TextDrawSetShadow(SpeedDragon[4], 0);

	SpeedDragon[5] = TextDrawCreate(290.6666, 362.8222, "particle:lamp_shad_64"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[5], 109.0000, 74.9101);
	TextDrawAlignment(SpeedDragon[5], 1);
	TextDrawColor(SpeedDragon[5], -16777187);
	TextDrawBackgroundColor(SpeedDragon[5], 255);
	TextDrawFont(SpeedDragon[5], 4);
	TextDrawSetProportional(SpeedDragon[5], 0);
	TextDrawSetShadow(SpeedDragon[5], 0);

	SpeedDragon[6] = TextDrawCreate(288.0000, 437.0740, "particle:lamp_shad_64"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[6], 111.0000, -73.3898);
	TextDrawAlignment(SpeedDragon[6], 1);
	TextDrawColor(SpeedDragon[6], -16777187);
	TextDrawBackgroundColor(SpeedDragon[6], 255);
	TextDrawFont(SpeedDragon[6], 4);
	TextDrawSetProportional(SpeedDragon[6], 0);
	TextDrawSetShadow(SpeedDragon[6], 0);

	SpeedDragon[7] = TextDrawCreate(270.3667, 359.6184, "LD_Beat:Chit"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[7], 17.0000, 22.0000);
	TextDrawAlignment(SpeedDragon[7], 1);
	TextDrawColor(SpeedDragon[7], -347323649);
	TextDrawBackgroundColor(SpeedDragon[7], 255);
	TextDrawFont(SpeedDragon[7], 4);
	TextDrawSetProportional(SpeedDragon[7], 0);
	TextDrawSetShadow(SpeedDragon[7], 0);

	SpeedDragon[8] = TextDrawCreate(236.0334, 419.0517, "LD_Beat:Chit"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[8], 17.0000, 22.0000);
	TextDrawAlignment(SpeedDragon[8], 1);
	TextDrawColor(SpeedDragon[8], -347323649);
	TextDrawBackgroundColor(SpeedDragon[8], 255);
	TextDrawFont(SpeedDragon[8], 4);
	TextDrawSetProportional(SpeedDragon[8], 0);
	TextDrawSetShadow(SpeedDragon[8], 0);

	SpeedDragon[9] = TextDrawCreate(238.8333, 363.2518, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[9], 40.0000, 67.0000);
	TextDrawAlignment(SpeedDragon[9], 1);
	TextDrawColor(SpeedDragon[9], -347323649);
	TextDrawBackgroundColor(SpeedDragon[9], 255);
	TextDrawFont(SpeedDragon[9], 4);
	TextDrawSetProportional(SpeedDragon[9], 0);
	TextDrawSetShadow(SpeedDragon[9], 0);

	SpeedDragon[10] = TextDrawCreate(244.5000, 370.4888, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[10], 40.0000, 67.0000);
	TextDrawAlignment(SpeedDragon[10], 1);
	TextDrawColor(SpeedDragon[10], -347323649);
	TextDrawBackgroundColor(SpeedDragon[10], 255);
	TextDrawFont(SpeedDragon[10], 4);
	TextDrawSetProportional(SpeedDragon[10], 0);
	TextDrawSetShadow(SpeedDragon[10], 0);

	SpeedDragon[11] = TextDrawCreate(241.3332, 362.8222, "particle:lamp_shad_64"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[11], 41.0000, 74.6599);
	TextDrawAlignment(SpeedDragon[11], 1);
	TextDrawColor(SpeedDragon[11], -189);
	TextDrawBackgroundColor(SpeedDragon[11], 255);
	TextDrawFont(SpeedDragon[11], 4);
	TextDrawSetProportional(SpeedDragon[11], 0);
	TextDrawSetShadow(SpeedDragon[11], 0);

	SpeedDragon[12] = TextDrawCreate(240.6666, 437.4888, "particle:lamp_shad_64"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[12], 42.0000, -74.2400);
	TextDrawAlignment(SpeedDragon[12], 1);
	TextDrawColor(SpeedDragon[12], -189);
	TextDrawBackgroundColor(SpeedDragon[12], 255);
	TextDrawFont(SpeedDragon[12], 4);
	TextDrawSetProportional(SpeedDragon[12], 0);
	TextDrawSetShadow(SpeedDragon[12], 0);

	SpeedDragon[13] = TextDrawCreate(297.6667, 394.3479, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[13], 84.0000, 11.0000);
	TextDrawAlignment(SpeedDragon[13], 1);
	TextDrawColor(SpeedDragon[13], -347323649);
	TextDrawBackgroundColor(SpeedDragon[13], 255);
	TextDrawFont(SpeedDragon[13], 4);
	TextDrawSetProportional(SpeedDragon[13], 0);
	TextDrawSetShadow(SpeedDragon[13], 0);

	SpeedDragon[14] = TextDrawCreate(374.0000, 391.1013, "LD_Beat:Chit"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[14], 16.0000, 19.0000);
	TextDrawAlignment(SpeedDragon[14], 1);
	TextDrawColor(SpeedDragon[14], -347323649);
	TextDrawBackgroundColor(SpeedDragon[14], 255);
	TextDrawFont(SpeedDragon[14], 4);
	TextDrawSetProportional(SpeedDragon[14], 0);
	TextDrawSetShadow(SpeedDragon[14], 0);

	SpeedDragon[15] = TextDrawCreate(294.9333, 396.4939, "LD_Beat:Chit"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[15], 16.0000, 19.0000);
	TextDrawAlignment(SpeedDragon[15], 1);
	TextDrawColor(SpeedDragon[15], -347323649);
	TextDrawBackgroundColor(SpeedDragon[15], 255);
	TextDrawFont(SpeedDragon[15], 4);
	TextDrawSetProportional(SpeedDragon[15], 0);
	TextDrawSetShadow(SpeedDragon[15], 0);

	SpeedDragon[16] = TextDrawCreate(303.3667, 401.2998, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[16], 83.7299, 11.0000);
	TextDrawAlignment(SpeedDragon[16], 1);
	TextDrawColor(SpeedDragon[16], -347323649);
	TextDrawBackgroundColor(SpeedDragon[16], 255);
	TextDrawFont(SpeedDragon[16], 4);
	TextDrawSetProportional(SpeedDragon[16], 0);
	TextDrawSetShadow(SpeedDragon[16], 0);

	SpeedDragon[17] = TextDrawCreate(297.0000, 399.3258, "particle:lamp_shad_64"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[17], 92.0000, 12.6699);
	TextDrawAlignment(SpeedDragon[17], 1);
	TextDrawColor(SpeedDragon[17], -180);
	TextDrawBackgroundColor(SpeedDragon[17], 255);
	TextDrawFont(SpeedDragon[17], 4);
	TextDrawSetProportional(SpeedDragon[17], 0);
	TextDrawSetShadow(SpeedDragon[17], 0);

	SpeedDragon[18] = TextDrawCreate(328.2000, 420.6814, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[18], 61.0000, 7.0000);
	TextDrawAlignment(SpeedDragon[18], 1);
	TextDrawColor(SpeedDragon[18], 437918463);
	TextDrawBackgroundColor(SpeedDragon[18], 255);
	TextDrawFont(SpeedDragon[18], 4);
	TextDrawSetProportional(SpeedDragon[18], 0);
	TextDrawSetShadow(SpeedDragon[18], 0);

	SpeedDragon[19] = TextDrawCreate(368.3333, 386.1518, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[19], 18.0000, 2.0000);
	TextDrawAlignment(SpeedDragon[19], 1);
	TextDrawColor(SpeedDragon[19], 437918463);
	TextDrawBackgroundColor(SpeedDragon[19], 255);
	TextDrawFont(SpeedDragon[19], 4);
	TextDrawSetProportional(SpeedDragon[19], 0);
	TextDrawSetShadow(SpeedDragon[19], 0);

	SpeedDragon[20] = TextDrawCreate(301.0000, 386.1518, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[20], 18.0000, 2.0000);
	TextDrawAlignment(SpeedDragon[20], 1);
	TextDrawColor(SpeedDragon[20], 437918463);
	TextDrawBackgroundColor(SpeedDragon[20], 255);
	TextDrawFont(SpeedDragon[20], 4);
	TextDrawSetProportional(SpeedDragon[20], 0);
	TextDrawSetShadow(SpeedDragon[20], 0);

	SpeedDragon[21] = TextDrawCreate(334.6666, 386.1518, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[21], 18.0000, 2.0000);
	TextDrawAlignment(SpeedDragon[21], 1);
	TextDrawColor(SpeedDragon[21], 437918463);
	TextDrawBackgroundColor(SpeedDragon[21], 255);
	TextDrawFont(SpeedDragon[21], 4);
	TextDrawSetProportional(SpeedDragon[21], 0);
	TextDrawSetShadow(SpeedDragon[21], 0);

	SpeedDragon[22] = TextDrawCreate(309.7000, 371.2740, "ENGINE"); // ïٌٍَî
	TextDrawLetterSize(SpeedDragon[22], 0.2353, 1.0814);
	TextDrawAlignment(SpeedDragon[22], 2);
	TextDrawColor(SpeedDragon[22], -1);
	TextDrawBackgroundColor(SpeedDragon[22], 255);
	TextDrawFont(SpeedDragon[22], 1);
	TextDrawSetProportional(SpeedDragon[22], 1);
	TextDrawSetShadow(SpeedDragon[22], 0);

	SpeedDragon[23] = TextDrawCreate(343.7001, 371.2740, "LIGHT"); // ïٌٍَî
	TextDrawLetterSize(SpeedDragon[23], 0.2353, 1.0814);
	TextDrawAlignment(SpeedDragon[23], 2);
	TextDrawColor(SpeedDragon[23], -1);
	TextDrawBackgroundColor(SpeedDragon[23], 255);
	TextDrawFont(SpeedDragon[23], 1);
	TextDrawSetProportional(SpeedDragon[23], 1);
	TextDrawSetShadow(SpeedDragon[23], 0);

	SpeedDragon[24] = TextDrawCreate(377.5003, 371.2740, "LOCK"); // ïٌٍَî
	TextDrawLetterSize(SpeedDragon[24], 0.2353, 1.0814);
	TextDrawAlignment(SpeedDragon[24], 2);
	TextDrawColor(SpeedDragon[24], -1);
	TextDrawBackgroundColor(SpeedDragon[24], 255);
	TextDrawFont(SpeedDragon[24], 1);
	TextDrawSetProportional(SpeedDragon[24], 1);
	TextDrawSetShadow(SpeedDragon[24], 0);

	SpeedDragon[25] = TextDrawCreate(329.2001, 421.9259, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[25], 58.9000, 4.7999);
	TextDrawAlignment(SpeedDragon[25], 1);
	TextDrawColor(SpeedDragon[25], 4194559);
	TextDrawBackgroundColor(SpeedDragon[25], 255);
	TextDrawFont(SpeedDragon[25], 4);
	TextDrawSetProportional(SpeedDragon[25], 0);
	TextDrawSetShadow(SpeedDragon[25], 0);

	SpeedDragon[26] = TextDrawCreate(329.2001, 421.9259, "LD_SPAC:white"); // ïٌٍَî
	TextDrawTextSize(SpeedDragon[26], 49.0000, 4.3599);
	TextDrawAlignment(SpeedDragon[26], 1);
	TextDrawColor(SpeedDragon[26], 10420479);
	TextDrawBackgroundColor(SpeedDragon[26], 255);
	TextDrawFont(SpeedDragon[26], 4);
	TextDrawSetProportional(SpeedDragon[26], 0);
	TextDrawSetShadow(SpeedDragon[26], 0);
	*/

/*
    // Change interior TextDraw
    ChangeInt[0] = TextDrawCreate(238.000000, 361.000000, "<<");
    TextDrawFont(ChangeInt[0], 1);
    TextDrawLetterSize(ChangeInt[0], 0.600000, 2.000000);
    TextDrawTextSize(ChangeInt[0], 400.000000, 17.000000);
    TextDrawSetOutline(ChangeInt[0], 0);
    TextDrawSetShadow(ChangeInt[0], 0);
    TextDrawAlignment(ChangeInt[0], 1);
    TextDrawColor(ChangeInt[0], -1);
    TextDrawBackgroundColor(ChangeInt[0], 255);
    TextDrawBoxColor(ChangeInt[0], 50);
    TextDrawUseBox(ChangeInt[0], 0);
    TextDrawSetProportional(ChangeInt[0], 1);
    TextDrawSetSelectable(ChangeInt[0], 0);

    ChangeInt[1] = TextDrawCreate(291.000000, 394.000000, "CANCEL");
    TextDrawFont(ChangeInt[1], 3);
    TextDrawLetterSize(ChangeInt[1], 0.600000, 2.000000);
    TextDrawTextSize(ChangeInt[1], 400.000000, 17.000000);
    TextDrawSetOutline(ChangeInt[1], 1);
    TextDrawSetShadow(ChangeInt[1], 0);
    TextDrawAlignment(ChangeInt[1], 1);
    TextDrawColor(ChangeInt[1], -16776961);
    TextDrawBackgroundColor(ChangeInt[1], 255);
    TextDrawBoxColor(ChangeInt[1], 50);
    TextDrawUseBox(ChangeInt[1], 0);
    TextDrawSetProportional(ChangeInt[1], 1);
    TextDrawSetSelectable(ChangeInt[1], 0);

    ChangeInt[2] = TextDrawCreate(303.000000, 361.000000, "BUY");
    TextDrawFont(ChangeInt[2], 3);
    TextDrawLetterSize(ChangeInt[2], 0.679166, 2.099999);
    TextDrawTextSize(ChangeInt[2], 400.000000, 17.000000);
    TextDrawSetOutline(ChangeInt[2], 1);
    TextDrawSetShadow(ChangeInt[2], 0);
    TextDrawAlignment(ChangeInt[2], 1);
    TextDrawColor(ChangeInt[2], 9109759);
    TextDrawBackgroundColor(ChangeInt[2], 255);
    TextDrawBoxColor(ChangeInt[2], 50);
    TextDrawUseBox(ChangeInt[2], 0);
    TextDrawSetProportional(ChangeInt[2], 1);
    TextDrawSetSelectable(ChangeInt[2], 0);

    ChangeInt[3] = TextDrawCreate(381.000000, 361.000000, ">>");
    TextDrawFont(ChangeInt[3], 1);
    TextDrawLetterSize(ChangeInt[3], 0.600000, 2.000000);
    TextDrawTextSize(ChangeInt[3], 400.000000, 17.000000);
    TextDrawSetOutline(ChangeInt[3], 0);
    TextDrawSetShadow(ChangeInt[3], 0);
    TextDrawAlignment(ChangeInt[3], 1);
    TextDrawColor(ChangeInt[3], -1);
    TextDrawBackgroundColor(ChangeInt[3], 255);
    TextDrawBoxColor(ChangeInt[3], 50);
    TextDrawUseBox(ChangeInt[3], 0);
    TextDrawSetProportional(ChangeInt[3], 1);
    TextDrawSetSelectable(ChangeInt[3], 0);

    ChangeInt[4] = TextDrawCreate(291.000000, 326.000000, "OTHER");
    TextDrawFont(ChangeInt[4], 3);
    TextDrawLetterSize(ChangeInt[4], 0.679166, 2.099999);
    TextDrawTextSize(ChangeInt[4], 400.000000, 17.000000);
    TextDrawSetOutline(ChangeInt[4], 1);
    TextDrawSetShadow(ChangeInt[4], 0);
    TextDrawAlignment(ChangeInt[4], 1);
    TextDrawColor(ChangeInt[4], -94829825);
    TextDrawBackgroundColor(ChangeInt[4], 255);
    TextDrawBoxColor(ChangeInt[4], 50);
    TextDrawUseBox(ChangeInt[4], 0);
    TextDrawSetProportional(ChangeInt[4], 1);
    TextDrawSetSelectable(ChangeInt[4], 0);
*/

	/*logo

	PublicTD[0] = TextDrawCreate(40.000000, 322.000000, "");
	TextDrawFont(PublicTD[0], 3);
	TextDrawLetterSize(PublicTD[0], 0.266665, 1.500000);
	TextDrawTextSize(PublicTD[0], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[0], 1);
	TextDrawSetShadow(PublicTD[0], 0);
	TextDrawAlignment(PublicTD[0], 1);
	TextDrawColor(PublicTD[0], -1);
	TextDrawBackgroundColor(PublicTD[0], 255);
	TextDrawBoxColor(PublicTD[0], 50);
	TextDrawUseBox(PublicTD[0], 0);
	TextDrawSetProportional(PublicTD[0], 1);
	TextDrawSetSelectable(PublicTD[0], 0);

	PublicTD[1] = TextDrawCreate(30.000000, 301.000000, "");
	TextDrawFont(PublicTD[1], 3);
	TextDrawLetterSize(PublicTD[1], -1.191668, 2.549998);
	TextDrawTextSize(PublicTD[1], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[1], 1);
	TextDrawSetShadow(PublicTD[1], 0);
	TextDrawAlignment(PublicTD[1], 1);
	TextDrawColor(PublicTD[1], -764862721);
	TextDrawBackgroundColor(PublicTD[1], 255);
	TextDrawBoxColor(PublicTD[1], 50);
	TextDrawUseBox(PublicTD[1], 0);
	TextDrawSetProportional(PublicTD[1], 1);
	TextDrawSetSelectable(PublicTD[1], 0);

	PublicTD[2] = TextDrawCreate(22.000000, 301.000000, "");
	TextDrawFont(PublicTD[2], 3);
	TextDrawLetterSize(PublicTD[2], 1.341665, 2.549998);
	TextDrawTextSize(PublicTD[2], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[2], 1);
	TextDrawSetShadow(PublicTD[2], 0);
	TextDrawAlignment(PublicTD[2], 1);
	TextDrawColor(PublicTD[2], -2686721);
	TextDrawBackgroundColor(PublicTD[2], 255);
	TextDrawBoxColor(PublicTD[2], 50);
	TextDrawUseBox(PublicTD[2], 0);
	TextDrawSetProportional(PublicTD[2], 1);
	TextDrawSetSelectable(PublicTD[2], 0);

	PublicTD[3] = TextDrawCreate(32.000000, 298.000000, "");
	TextDrawFont(PublicTD[3], 3);
	TextDrawLetterSize(PublicTD[3], 0.612500, 5.750000);
	TextDrawTextSize(PublicTD[3], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[3], 1);
	TextDrawSetShadow(PublicTD[3], 0);
	TextDrawAlignment(PublicTD[3], 1);
	TextDrawColor(PublicTD[3], -764862721);
	TextDrawBackgroundColor(PublicTD[3], 255);
	TextDrawBoxColor(PublicTD[3], 50);
	TextDrawUseBox(PublicTD[3], 0);
	TextDrawSetProportional(PublicTD[3], 1);
	TextDrawSetSelectable(PublicTD[3], 0);

	PublicTD[4] = TextDrawCreate(16.000000, 298.000000, "");
	TextDrawFont(PublicTD[4], 3);
	TextDrawLetterSize(PublicTD[4], 0.612500, 4.549994);
	TextDrawTextSize(PublicTD[4], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[4], 1);
	TextDrawSetShadow(PublicTD[4], 0);
	TextDrawAlignment(PublicTD[4], 1);
	TextDrawColor(PublicTD[4], -2686721);
	TextDrawBackgroundColor(PublicTD[4], 255);
	TextDrawBoxColor(PublicTD[4], 50);
	TextDrawUseBox(PublicTD[4], 0);
	TextDrawSetProportional(PublicTD[4], 1);
	TextDrawSetSelectable(PublicTD[4], 0);

	PublicTD[5] = TextDrawCreate(40.000000, 302.000000, "");
	TextDrawFont(PublicTD[5], 3);
	TextDrawLetterSize(PublicTD[5], 0.587499, 2.149996);
	TextDrawTextSize(PublicTD[5], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[5], 1);
	TextDrawSetShadow(PublicTD[5], 0);
	TextDrawAlignment(PublicTD[5], 1);
	TextDrawColor(PublicTD[5], -764862721);
	TextDrawBackgroundColor(PublicTD[5], 255);
	TextDrawBoxColor(PublicTD[5], 50);
	TextDrawUseBox(PublicTD[5], 0);
	TextDrawSetProportional(PublicTD[5], 1);
	TextDrawSetSelectable(PublicTD[5], 0);

	PublicTD[6] = TextDrawCreate(41.000000, 336.000000, "");
	TextDrawFont(PublicTD[6], 0);
	TextDrawLetterSize(PublicTD[6], 0.224996, 1.100000);
	TextDrawTextSize(PublicTD[6], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[6], 1);
	TextDrawSetShadow(PublicTD[6], 0);
	TextDrawAlignment(PublicTD[6], 1);
	TextDrawColor(PublicTD[6], -1);
	TextDrawBackgroundColor(PublicTD[6], 255);
	TextDrawBoxColor(PublicTD[6], 50);
	TextDrawUseBox(PublicTD[6], 0);
	TextDrawSetProportional(PublicTD[6], 1);
	TextDrawSetSelectable(PublicTD[6], 0);

	PublicTD[7] = TextDrawCreate(49.000000, 336.000000, "");
	TextDrawFont(PublicTD[7], 0);
	TextDrawLetterSize(PublicTD[7], 0.224996, 1.100000);
	TextDrawTextSize(PublicTD[7], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[7], 1);
	TextDrawSetShadow(PublicTD[7], 0);
	TextDrawAlignment(PublicTD[7], 1);
	TextDrawColor(PublicTD[7], -741092353);
	TextDrawBackgroundColor(PublicTD[7], 255);
	TextDrawBoxColor(PublicTD[7], 50);
	TextDrawUseBox(PublicTD[7], 0);
	TextDrawSetProportional(PublicTD[7], 1);
	TextDrawSetSelectable(PublicTD[7], 0);

	PublicTD[8] = TextDrawCreate(57.000000, 336.000000, "");
	TextDrawFont(PublicTD[8], 0);
	TextDrawLetterSize(PublicTD[8], 0.224996, 1.100000);
	TextDrawTextSize(PublicTD[8], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[8], 1);
	TextDrawSetShadow(PublicTD[8], 0);
	TextDrawAlignment(PublicTD[8], 1);
	TextDrawColor(PublicTD[8], -1094795521);
	TextDrawBackgroundColor(PublicTD[8], 255);
	TextDrawBoxColor(PublicTD[8], 50);
	TextDrawUseBox(PublicTD[8], 0);
	TextDrawSetProportional(PublicTD[8], 1);
	TextDrawSetSelectable(PublicTD[8], 0);

	PublicTD[9] = TextDrawCreate(65.000000, 336.000000, "");
	TextDrawFont(PublicTD[9], 0);
	TextDrawLetterSize(PublicTD[9], 0.224996, 1.100000);
	TextDrawTextSize(PublicTD[9], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[9], 1);
	TextDrawSetShadow(PublicTD[9], 0);
	TextDrawAlignment(PublicTD[9], 1);
	TextDrawColor(PublicTD[9], 1296911871);
	TextDrawBackgroundColor(PublicTD[9], 255);
	TextDrawBoxColor(PublicTD[9], 50);
	TextDrawUseBox(PublicTD[9], 0);
	TextDrawSetProportional(PublicTD[9], 1);
	TextDrawSetSelectable(PublicTD[9], 0);

	PublicTD[10] = TextDrawCreate(74.000000, 336.000000, "");
	TextDrawFont(PublicTD[10], 0);
	TextDrawLetterSize(PublicTD[10], 0.224996, 1.100000);
	TextDrawTextSize(PublicTD[10], 400.000000, 17.000000);
	TextDrawSetOutline(PublicTD[10], 1);
	TextDrawSetShadow(PublicTD[10], 0);
	TextDrawAlignment(PublicTD[10], 1);
	TextDrawColor(PublicTD[10], 255);
	TextDrawBackgroundColor(PublicTD[10], 255);
	TextDrawBoxColor(PublicTD[10], 50);
	TextDrawUseBox(PublicTD[10], 0);
	TextDrawSetProportional(PublicTD[10], 1);
	TextDrawSetSelectable(PublicTD[10], 0);


    HungerTD[0] = TextDrawCreate(462.000000, 13.000000, "");
	TextDrawFont(HungerTD[0], 4);
	TextDrawLetterSize(HungerTD[0], 0.600000, 2.000000);
	TextDrawTextSize(HungerTD[0], 16.500000, 21.000000);
	TextDrawSetOutline(HungerTD[0], 1);
	TextDrawSetShadow(HungerTD[0], 0);
	TextDrawAlignment(HungerTD[0], 1);
	TextDrawColor(HungerTD[0], -1);
	TextDrawBackgroundColor(HungerTD[0], 255);
	TextDrawBoxColor(HungerTD[0], 50);
	TextDrawUseBox(HungerTD[0], 1);
	TextDrawSetProportional(HungerTD[0], 1);
	TextDrawSetSelectable(HungerTD[0], 0);*/


// administrator panel [/sp]

    admin_panel[0] = TextDrawCreate(513.7500, 159.1481, "LD_SPAC:white"); // ?????
	TextDrawTextSize(admin_panel[0], 118.0000, 219.0000);
	TextDrawAlignment(admin_panel[0], 1);
	TextDrawColor(admin_panel[0], 255);
	TextDrawBackgroundColor(admin_panel[0], 255);
	TextDrawFont(admin_panel[0], 4);
	TextDrawSetProportional(admin_panel[0], 0);
	TextDrawSetShadow(admin_panel[0], 0);

	admin_panel[1] = TextDrawCreate(511.2496, 150.3334, "LD_SPAC:white"); // ?????
	TextDrawTextSize(admin_panel[1], 123.9002, 19.7800);
	TextDrawAlignment(admin_panel[1], 1);
	TextDrawColor(admin_panel[1], 1119719167);
	TextDrawBackgroundColor(admin_panel[1], 255);
	TextDrawFont(admin_panel[1], 4);
	TextDrawSetProportional(admin_panel[1], 0);
	TextDrawSetShadow(admin_panel[1], 0);

	admin_panel[2] = TextDrawCreate(504.7666, 148.1667, "LD_BEAT:chit"); // ?????
	TextDrawTextSize(admin_panel[2], 12.0000, 14.0000);
	TextDrawAlignment(admin_panel[2], 1);
	TextDrawColor(admin_panel[2], 1119719167);
	TextDrawBackgroundColor(admin_panel[2], 255);
	TextDrawFont(admin_panel[2], 4);
	TextDrawSetProportional(admin_panel[2], 0);
	TextDrawSetShadow(admin_panel[2], 0);

	admin_panel[3] = TextDrawCreate(629.1336, 148.0592, "LD_BEAT:chit"); // ?????
	TextDrawTextSize(admin_panel[3], 12.0000, 14.0000);
	TextDrawAlignment(admin_panel[3], 1);
	TextDrawColor(admin_panel[3], 1119719167);
	TextDrawBackgroundColor(admin_panel[3], 255);
	TextDrawFont(admin_panel[3], 4);
	TextDrawSetProportional(admin_panel[3], 0);
	TextDrawSetShadow(admin_panel[3], 0);

	admin_panel[4] = TextDrawCreate(506.3499, 154.0628, "LD_SPAC:white"); // ?????
	TextDrawTextSize(admin_panel[4], 7.0000, 16.0499);
	TextDrawAlignment(admin_panel[4], 1);
	TextDrawColor(admin_panel[4], 1119719167);
	TextDrawBackgroundColor(admin_panel[4], 255);
	TextDrawFont(admin_panel[4], 4);
	TextDrawSetProportional(admin_panel[4], 0);
	TextDrawSetShadow(admin_panel[4], 0);

	admin_panel[5] = TextDrawCreate(632.2656, 154.2552, "LD_SPAC:white"); // ?????
	TextDrawTextSize(admin_panel[5], 7.0000, 16.0499);
	TextDrawAlignment(admin_panel[5], 1);
	TextDrawColor(admin_panel[5], 1119719167);
	TextDrawBackgroundColor(admin_panel[5], 255);
	TextDrawFont(admin_panel[5], 4);
	TextDrawSetProportional(admin_panel[5], 0);
	TextDrawSetShadow(admin_panel[5], 0);

	admin_panel[6] = TextDrawCreate(506.5830, 170.4739, "LD_SPAC:white"); // ?????
	TextDrawTextSize(admin_panel[6], 9.0000, 207.6907);
	TextDrawAlignment(admin_panel[6], 1);
	TextDrawColor(admin_panel[6], 255);
	TextDrawBackgroundColor(admin_panel[6], 255);
	TextDrawFont(admin_panel[6], 4);
	TextDrawSetProportional(admin_panel[6], 0);
	TextDrawSetShadow(admin_panel[6], 0);

	admin_panel[7] = TextDrawCreate(630.2661, 170.4293, "LD_SPAC:white"); // ?????
	TextDrawTextSize(admin_panel[7], 9.0499, 207.7606);
	TextDrawAlignment(admin_panel[7], 1);
	TextDrawColor(admin_panel[7], 255);
	TextDrawBackgroundColor(admin_panel[7], 255);
	TextDrawFont(admin_panel[7], 4);
	TextDrawSetProportional(admin_panel[7], 0);
	TextDrawSetShadow(admin_panel[7], 0);

	admin_panel[8] = TextDrawCreate(514.4993, 267.0000, "LD_SPAC:white"); // stats
	TextDrawTextSize(admin_panel[8], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[8], 1);
	TextDrawColor(admin_panel[8], -2139062017);
	TextDrawBackgroundColor(admin_panel[8], 255);
	TextDrawFont(admin_panel[8], 4);
	TextDrawSetProportional(admin_panel[8], 0);
	TextDrawSetShadow(admin_panel[8], 0);
	TextDrawSetSelectable(admin_panel[8], true);

	admin_panel[9] = TextDrawCreate(578.2838, 267.0000, "LD_SPAC:white"); // jail
	TextDrawTextSize(admin_panel[9], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[9], 1);
	TextDrawColor(admin_panel[9], -2139062017);
	TextDrawBackgroundColor(admin_panel[9], 255);
	TextDrawFont(admin_panel[9], 4);
	TextDrawSetProportional(admin_panel[9], 0);
	TextDrawSetShadow(admin_panel[9], 0);
	TextDrawSetSelectable(admin_panel[9], true);

	admin_panel[10] = TextDrawCreate(514.4993, 281.3008, "LD_SPAC:white"); // slap
	TextDrawTextSize(admin_panel[10], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[10], 1);
	TextDrawColor(admin_panel[10], -2139062017);
	TextDrawBackgroundColor(admin_panel[10], 255);
	TextDrawFont(admin_panel[10], 4);
	TextDrawSetProportional(admin_panel[10], 0);
	TextDrawSetShadow(admin_panel[10], 0);
	TextDrawSetSelectable(admin_panel[10], true);

	admin_panel[11] = TextDrawCreate(578.2503, 281.4822, "LD_SPAC:white"); // mute
	TextDrawTextSize(admin_panel[11], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[11], 1);
	TextDrawColor(admin_panel[11], -2139062017);
	TextDrawBackgroundColor(admin_panel[11], 255);
	TextDrawFont(admin_panel[11], 4);
	TextDrawSetProportional(admin_panel[11], 0);
	TextDrawSetShadow(admin_panel[11], 0);
	TextDrawSetSelectable(admin_panel[11], true);

	admin_panel[12] = TextDrawCreate(514.4826, 296.1017, "LD_SPAC:white"); // ip
	TextDrawTextSize(admin_panel[12], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[12], 1);
	TextDrawColor(admin_panel[12], -2139062017);
	TextDrawBackgroundColor(admin_panel[12], 255);
	TextDrawFont(admin_panel[12], 4);
	TextDrawSetProportional(admin_panel[12], 0);
	TextDrawSetShadow(admin_panel[12], 0);
	TextDrawSetSelectable(admin_panel[12], true);

	admin_panel[13] = TextDrawCreate(578.1837, 296.1017, "LD_SPAC:white"); // warn
	TextDrawTextSize(admin_panel[13], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[13], 1);
	TextDrawColor(admin_panel[13], -2139062017);
	TextDrawBackgroundColor(admin_panel[13], 255);
	TextDrawFont(admin_panel[13], 4);
	TextDrawSetProportional(admin_panel[13], 0);
	TextDrawSetShadow(admin_panel[13], 0);
	TextDrawSetSelectable(admin_panel[13], true);

	admin_panel[14] = TextDrawCreate(514.4826, 311.1026, "LD_SPAC:white"); // kick
	TextDrawTextSize(admin_panel[14], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[14], 1);
	TextDrawColor(admin_panel[14], -2139062017);
	TextDrawBackgroundColor(admin_panel[14], 255);
	TextDrawFont(admin_panel[14], 4);
	TextDrawSetProportional(admin_panel[14], 0);
	TextDrawSetShadow(admin_panel[14], 0);
	TextDrawSetSelectable(admin_panel[14], true);

	admin_panel[15] = TextDrawCreate(578.2838, 311.0025, "LD_SPAC:white"); // ban
	TextDrawTextSize(admin_panel[15], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[15], 1);
	TextDrawColor(admin_panel[15], -2139062017);
	TextDrawBackgroundColor(admin_panel[15], 255);
	TextDrawFont(admin_panel[15], 4);
	TextDrawSetProportional(admin_panel[15], 0);
	TextDrawSetShadow(admin_panel[15], 0);
	TextDrawSetSelectable(admin_panel[15], true);

	admin_panel[16] = TextDrawCreate(514.4826, 326.0035, "LD_SPAC:white"); // next
	TextDrawTextSize(admin_panel[16], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[16], 1);
	TextDrawColor(admin_panel[16], -1061109505);
	TextDrawBackgroundColor(admin_panel[16], 255);
	TextDrawFont(admin_panel[16], 4);
	TextDrawSetProportional(admin_panel[16], 0);
	TextDrawSetShadow(admin_panel[16], 0);
	TextDrawSetSelectable(admin_panel[16], true);

	admin_panel[17] = TextDrawCreate(578.2838, 325.8034, "LD_SPAC:white"); // back
	TextDrawTextSize(admin_panel[17], 53.0000, 13.0000);
	TextDrawAlignment(admin_panel[17], 1);
	TextDrawColor(admin_panel[17], -1061109505);
	TextDrawBackgroundColor(admin_panel[17], 255);
	TextDrawFont(admin_panel[17], 4);
	TextDrawSetProportional(admin_panel[17], 0);
	TextDrawSetShadow(admin_panel[17], 0);
	TextDrawSetSelectable(admin_panel[17], true);

	admin_panel[18] = TextDrawCreate(514.6665, 340.7218, "LD_SPAC:white"); // update
	TextDrawTextSize(admin_panel[18], 117.0000, 13.1799);
	TextDrawAlignment(admin_panel[18], 1);
	TextDrawColor(admin_panel[18], 8388863);
	TextDrawBackgroundColor(admin_panel[18], 255);
	TextDrawFont(admin_panel[18], 4);
	TextDrawSetProportional(admin_panel[18], 0);
	TextDrawSetShadow(admin_panel[18], 0);
	TextDrawSetSelectable(admin_panel[18], true);

	admin_panel[19] = TextDrawCreate(514.8665, 355.6228, "LD_SPAC:white"); // close
	TextDrawTextSize(admin_panel[19], 116.7798, 13.1799);
	TextDrawAlignment(admin_panel[19], 1);
	TextDrawColor(admin_panel[19], -16776961);
	TextDrawBackgroundColor(admin_panel[19], 255);
	TextDrawFont(admin_panel[19], 4);
	TextDrawSetProportional(admin_panel[19], 0);
	TextDrawSetShadow(admin_panel[19], 0);
	TextDrawSetSelectable(admin_panel[19], true);

	admin_panel[20] = TextDrawCreate(506.4664, 375.2626, "LD_SPAC:white"); // ?????
	TextDrawTextSize(admin_panel[20], 132.5791, 3.0000);
	TextDrawAlignment(admin_panel[20], 1);
	TextDrawColor(admin_panel[20], 1119719167);
	TextDrawBackgroundColor(admin_panel[20], 255);
	TextDrawFont(admin_panel[20], 4);
	TextDrawSetProportional(admin_panel[20], 0);
	TextDrawSetShadow(admin_panel[20], 0);

	admin_panel[21] = TextDrawCreate(540.8331, 269.6148, "stats~n~~n~slap~n~~n~ip~n~~n~kick"); // ?????
	TextDrawLetterSize(admin_panel[21], 0.2416, 0.8125);
	TextDrawAlignment(admin_panel[21], 2);
	TextDrawColor(admin_panel[21], -1);
	TextDrawBackgroundColor(admin_panel[21], 255);
	TextDrawFont(admin_panel[21], 2);
	TextDrawSetProportional(admin_panel[21], 1);
	TextDrawSetShadow(admin_panel[21], 0);

	admin_panel[22] = TextDrawCreate(605.4172, 269.6148, "jail~n~~n~mute~n~~n~warn~n~~n~ban"); // ?????
	TextDrawLetterSize(admin_panel[22], 0.2416, 0.8125);
	TextDrawAlignment(admin_panel[22], 2);
	TextDrawColor(admin_panel[22], -1);
	TextDrawBackgroundColor(admin_panel[22], 255);
	TextDrawFont(admin_panel[22], 2);
	TextDrawSetProportional(admin_panel[22], 1);
	TextDrawSetShadow(admin_panel[22], 0);

	admin_panel[23] = TextDrawCreate(540.8341, 328.3259, "next"); // ?????
	TextDrawLetterSize(admin_panel[23], 0.2416, 0.8125);
	TextDrawAlignment(admin_panel[23], 2);
	TextDrawColor(admin_panel[23], 255);
	TextDrawBackgroundColor(admin_panel[23], 255);
	TextDrawFont(admin_panel[23], 2);
	TextDrawSetProportional(admin_panel[23], 1);
	TextDrawSetShadow(admin_panel[23], 0);

	admin_panel[24] = TextDrawCreate(604.7185, 328.3259, "back"); // ?????
	TextDrawLetterSize(admin_panel[24], 0.2416, 0.8125);
	TextDrawAlignment(admin_panel[24], 2);
	TextDrawColor(admin_panel[24], 255);
	TextDrawBackgroundColor(admin_panel[24], 255);
	TextDrawFont(admin_panel[24], 2);
	TextDrawSetProportional(admin_panel[24], 1);
	TextDrawSetShadow(admin_panel[24], 0);

	admin_panel[25] = TextDrawCreate(573.4671, 342.7998, "update"); // ?????
	TextDrawLetterSize(admin_panel[25], 0.2515, 0.9225);
	TextDrawAlignment(admin_panel[25], 2);
	TextDrawColor(admin_panel[25], -1);
	TextDrawBackgroundColor(admin_panel[25], 255);
	TextDrawFont(admin_panel[25], 2);
	TextDrawSetProportional(admin_panel[25], 1);
	TextDrawSetShadow(admin_panel[25], 0);

	admin_panel[26] = TextDrawCreate(572.8168, 357.3822, "close_this_admin_window"); // ?????
	TextDrawLetterSize(admin_panel[26], 0.1855, 0.9725);
	TextDrawAlignment(admin_panel[26], 2);
	TextDrawColor(admin_panel[26], -1);
	TextDrawBackgroundColor(admin_panel[26], 255);
	TextDrawFont(admin_panel[26], 2);
	TextDrawSetProportional(admin_panel[26], 1);
	TextDrawSetShadow(admin_panel[26], 0);


/*


			الشاشة التحميل


*/

	LoadScreenText[0] = TextDrawCreate(-25.0000, -3.3037, "Box"); // عنصر
	TextDrawLetterSize(LoadScreenText[0], 0.0000, 51.0666);
	TextDrawTextSize(LoadScreenText[0], 700.0000, 0.0000);
	TextDrawAlignment(LoadScreenText[0], 1);
	TextDrawColor(LoadScreenText[0], -1);
	TextDrawUseBox(LoadScreenText[0], 1);
	TextDrawBoxColor(LoadScreenText[0], 255);
	TextDrawBackgroundColor(LoadScreenText[0], 255);
	TextDrawFont(LoadScreenText[0], 1);
	TextDrawSetProportional(LoadScreenText[0], 1);
	TextDrawSetShadow(LoadScreenText[0], 0);

	LoadScreenText[1] = TextDrawCreate(233.8000, 223.0296, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(LoadScreenText[1], 155.0000, 2.0000);
	TextDrawAlignment(LoadScreenText[1], 1);
	TextDrawColor(LoadScreenText[1], -2139062017);
	TextDrawBackgroundColor(LoadScreenText[1], 255);
	TextDrawFont(LoadScreenText[1], 4);
	TextDrawSetProportional(LoadScreenText[1], 0);
	TextDrawSetShadow(LoadScreenText[1], 0);

	LoadScreenText[2] = TextDrawCreate(233.8000, 223.0296, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(LoadScreenText[2], 155.0000, 2.0000);
	TextDrawAlignment(LoadScreenText[2], 1);
	TextDrawColor(LoadScreenText[2], 1119719167);
	TextDrawBackgroundColor(LoadScreenText[2], 255);
	TextDrawFont(LoadScreenText[2], 4);
	TextDrawSetProportional(LoadScreenText[2], 0);
	TextDrawSetShadow(LoadScreenText[2], 0);

	LoadScreenText[3] = TextDrawCreate(285.6666, 201.1999, "_Loading..."); // عنصر
	TextDrawLetterSize(LoadScreenText[3], 0.2223, 1.2557);
	TextDrawAlignment(LoadScreenText[3], 1);
	TextDrawColor(LoadScreenText[3], -1);
	TextDrawBackgroundColor(LoadScreenText[3], 255);
	TextDrawFont(LoadScreenText[3], 2);
	TextDrawSetProportional(LoadScreenText[3], 1);
	TextDrawSetShadow(LoadScreenText[3], 0);

	LoadScreenText[4] = TextDrawCreate(292.0000, 234.6444, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(LoadScreenText[4], 36.0000, 43.0000);
	TextDrawAlignment(LoadScreenText[4], 1);
	TextDrawColor(LoadScreenText[4], 1119719167);
	TextDrawBackgroundColor(LoadScreenText[4], 255);
	TextDrawFont(LoadScreenText[4], 4);
	TextDrawSetProportional(LoadScreenText[4], 0);
	TextDrawSetShadow(LoadScreenText[4], 0);

	LoadScreenText[5] = TextDrawCreate(292.0000, 232.7443, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(LoadScreenText[5], 36.0000, 43.0000);
	TextDrawAlignment(LoadScreenText[5], 1);
	TextDrawColor(LoadScreenText[5], 255);
	TextDrawBackgroundColor(LoadScreenText[5], 255);
	TextDrawFont(LoadScreenText[5], 4);
	TextDrawSetProportional(LoadScreenText[5], 0);
	TextDrawSetShadow(LoadScreenText[5], 0);


/*

			عناصر خاصة بالمنطقة
			
*/

	
/*

		الاحصائيات و النقاط
		
*/	

/*


		TShop textdraws 
		
*/

	td_tshop [ 0 ] = TextDrawCreate(-8.411772, 333.500091, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 0 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 0 ] , 284.823303, 71.333312 ) ;
	TextDrawAlignment ( td_tshop [ 0 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 0 ] , 269488383 ) ;
	TextDrawSetShadow ( td_tshop [ 0 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 0 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 0 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 0 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 0 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 0 ] , 0 ) ;

	td_tshop [ 1 ] = TextDrawCreate(8.529340, 325.333648, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 1 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 1 ] , 114.000015, 15.916657 ) ;
	TextDrawAlignment ( td_tshop [ 1 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 1 ] , 709983487 ) ;
	TextDrawSetShadow ( td_tshop [ 1 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 1 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 1 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 1 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 1 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 1 ] , 0 ) ;

	td_tshop [ 2 ] = TextDrawCreate(38.705879, 328.833404, "-AUTO_SHOW" ) ;
	TextDrawLetterSize ( td_tshop [ 2 ] , 0.239528, 0.853331 ) ;
	TextDrawAlignment ( td_tshop [ 2 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 2 ] , -1 ) ;
	TextDrawSetShadow ( td_tshop [ 2 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 2 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 2 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 2 ] , 1 ) ;
	TextDrawSetProportional ( td_tshop [ 2 ] , 1 ) ;
	TextDrawSetShadow ( td_tshop [ 2 ] , 0 ) ;

	td_tshop [ 3 ] = TextDrawCreate(67.352958, 345.166748, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 3 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 3 ] , 93.764518, 56.749965 ) ;
	TextDrawAlignment ( td_tshop [ 3 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 3 ] , 522133503 ) ;
	TextDrawSetShadow ( td_tshop [ 3 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 3 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 3 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 3 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 3 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 3 ] , 0 ) ;

	td_tshop [ 4 ] = TextDrawCreate(8.529395, 338.166442, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 4 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 4 ] , 114.000000, 3.083328 ) ;
	TextDrawAlignment ( td_tshop [ 4 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 4 ] , 557867519 ) ;
	TextDrawSetShadow ( td_tshop [ 4 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 4 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 4 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 4 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 4 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 4 ] , 0 ) ;

	td_tshop [ 5 ] = TextDrawCreate(192.999969, 385.416839, "LD_SPAC:white" ) ; //info
	TextDrawLetterSize ( td_tshop [ 5 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 5 ] , 50.470550, 16.499988 ) ;
	TextDrawAlignment ( td_tshop [ 5 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 5 ] , 709983487 ) ;
	TextDrawSetShadow ( td_tshop [ 5 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 5 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 5 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 5 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 5 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 5 ] , 0 ) ;
	TextDrawSetSelectable ( td_tshop [ 5 ] , true ) ;

	td_tshop [ 6 ] = TextDrawCreate(163.352920, 385.416839, "LD_SPAC:white" ) ; // <<
	TextDrawLetterSize ( td_tshop [ 6 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 6 ] , 28.352882, 16.499988 ) ;
	TextDrawAlignment ( td_tshop [ 6 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 6 ] , 709983487 ) ;
	TextDrawSetShadow ( td_tshop [ 6 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 6 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 6 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 6 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 6 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 6 ] , 0 ) ;
	TextDrawSetSelectable ( td_tshop [ 6 ] , true ) ;

	td_tshop [ 7 ] = TextDrawCreate(244.764755, 385.416900, "LD_SPAC:white" ) ; // >>
	TextDrawLetterSize ( td_tshop [ 7 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 7 ] , 28.352882, 16.499988 ) ;
	TextDrawAlignment ( td_tshop [ 7 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 7 ] , 709983487 ) ;
	TextDrawSetShadow ( td_tshop [ 7 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 7 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 7 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 7 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 7 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 7 ] , 0 ) ;
	TextDrawSetSelectable ( td_tshop [ 7 ] , true ) ;

	td_tshop [ 8 ] = TextDrawCreate(172.352890, 387.166625, "<<" ) ;
	TextDrawLetterSize ( td_tshop [ 8 ] , 0.228235, 0.958333 ) ;
	TextDrawAlignment ( td_tshop [ 8 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 8 ] , -1 ) ;
	TextDrawSetShadow ( td_tshop [ 8 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 8 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 8 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 8 ] , 1 ) ;
	TextDrawSetProportional ( td_tshop [ 8 ] , 1 ) ;
	TextDrawSetShadow ( td_tshop [ 8 ] , 0 ) ;

	td_tshop [ 9 ] = TextDrawCreate(253.764236, 387.166625, ">>" ) ;
	TextDrawLetterSize ( td_tshop [ 9 ] , 0.228235, 0.958333 ) ;
	TextDrawAlignment ( td_tshop [ 9 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 9 ] , -1 ) ;
	TextDrawSetShadow ( td_tshop [ 9 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 9 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 9 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 9 ] , 1 ) ;
	TextDrawSetProportional ( td_tshop [ 9 ] , 1 ) ;
	TextDrawSetShadow ( td_tshop [ 9 ] , 0 ) ;

	td_tshop [ 10 ] = TextDrawCreate(210.470138, 387.166625, "INFO" ) ;
	TextDrawLetterSize ( td_tshop [ 10 ] , 0.228235, 0.958333 ) ;
	TextDrawAlignment ( td_tshop [ 10 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 10 ] , -1 ) ;
	TextDrawSetShadow ( td_tshop [ 10 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 10 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 10 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 10 ] , 1 ) ;
	TextDrawSetProportional ( td_tshop [ 10 ] , 1 ) ;
	TextDrawSetShadow ( td_tshop [ 10 ] , 0 ) ;

	td_tshop [ 11 ] = TextDrawCreate(163.352859, 398.833190, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 11 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 11 ] , 28.352939, 3.083328 ) ;
	TextDrawAlignment ( td_tshop [ 11 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 11 ] , 557867519 ) ;
	TextDrawSetShadow ( td_tshop [ 11 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 11 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 11 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 11 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 11 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 11 ] , 0 ) ;

	td_tshop [ 12 ] = TextDrawCreate(193.000000, 398.833190, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 12 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 12 ] , 50.470603, 3.083328 ) ;
	TextDrawAlignment ( td_tshop [ 12 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 12 ] , 557867519 ) ;
	TextDrawSetShadow ( td_tshop [ 12 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 12 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 12 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 12 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 12 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 12 ] , 0 ) ;

	td_tshop [ 13 ] = TextDrawCreate(244.764755, 398.833190, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 13 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 13 ] , 28.352943, 3.083328 ) ;
	TextDrawAlignment ( td_tshop [ 13 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 13 ] , 557867519 ) ;
	TextDrawSetShadow ( td_tshop [ 13 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 13 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 13 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 13 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 13 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 13 ] , 0 ) ;

	td_tshop [ 14 ] = TextDrawCreate(193.000000, 367.333435, "LD_SPAC:white" ) ; //buy
	TextDrawLetterSize ( td_tshop [ 14 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 14 ] , 50.470550, 16.499988 ) ;
	TextDrawAlignment ( td_tshop [ 14 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 14 ] , 709983487 ) ;
	TextDrawSetShadow ( td_tshop [ 14 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 14 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 14 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 14 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 14 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 14 ] , 0 ) ;
	TextDrawSetSelectable ( td_tshop [ 14 ] , true ) ;

	td_tshop [ 15 ] = TextDrawCreate(193.000000, 349.250091, "LD_SPAC:white" ) ; //exit
	TextDrawLetterSize ( td_tshop [ 15 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 15 ] , 50.470550, 16.499988 ) ;
	TextDrawAlignment ( td_tshop [ 15 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 15 ] , 709983487 ) ;
	TextDrawSetShadow ( td_tshop [ 15 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 15 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 15 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 15 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 15 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 15 ] , 0 ) ;
	TextDrawSetSelectable ( td_tshop [ 15 ] , true ) ;

	td_tshop [ 16 ] = TextDrawCreate(193.000000, 380.749847, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 16 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 16 ] , 50.470607, 3.083328 ) ;
	TextDrawAlignment ( td_tshop [ 16 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 16 ] , 557867519 ) ;
	TextDrawSetShadow ( td_tshop [ 16 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 16 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 16 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 16 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 16 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 16 ] , 0 ) ;

	td_tshop [ 17 ] = TextDrawCreate(193.000030, 362.666534, "LD_SPAC:white" ) ;
	TextDrawLetterSize ( td_tshop [ 17 ] , 0.000000, 0.000000 ) ;
	TextDrawTextSize ( td_tshop [ 17 ] , 50.470607, 3.083328 ) ;
	TextDrawAlignment ( td_tshop [ 17 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 17 ] , 557867519 ) ;
	TextDrawSetShadow ( td_tshop [ 17 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 17 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 17 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 17 ] , 4 ) ;
	TextDrawSetProportional ( td_tshop [ 17 ] , 0 ) ;
	TextDrawSetShadow ( td_tshop [ 17 ] , 0 ) ;

	td_tshop [ 18 ] = TextDrawCreate(211.411300, 368.499877, "BUY" ) ;
	TextDrawLetterSize ( td_tshop [ 18 ] , 0.228235, 0.958333 ) ;
	TextDrawAlignment ( td_tshop [ 18 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 18 ] , -1 ) ;
	TextDrawSetShadow ( td_tshop [ 18 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 18 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 18 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 18 ] , 1 ) ;
	TextDrawSetProportional ( td_tshop [ 18 ] , 1 ) ;
	TextDrawSetShadow ( td_tshop [ 18 ] , 0 ) ;

	td_tshop [ 19 ] = TextDrawCreate(210.940719, 350.999694, "EXIT" ) ;
	TextDrawLetterSize ( td_tshop [ 19 ] , 0.228235, 0.958333 ) ;
	TextDrawAlignment ( td_tshop [ 19 ] , 1 ) ;
	TextDrawColor ( td_tshop [ 19 ] , -1 ) ;
	TextDrawSetShadow ( td_tshop [ 19 ] , 0 ) ;
	TextDrawSetOutline ( td_tshop [ 19 ] , 0 ) ;
	TextDrawBackgroundColor ( td_tshop [ 19 ] , 255 ) ;
	TextDrawFont ( td_tshop [ 19 ] , 1 ) ;
	TextDrawSetProportional ( td_tshop [ 19 ] , 1 ) ;
	TextDrawSetShadow ( td_tshop [ 19 ] , 0 ) ;

	
/*

	car tuning
	
*/
	td_tun_box = TextDrawCreate ( 148.000000, 131.875000, "usebox" ) ;
	TextDrawLetterSize ( td_tun_box, 0.000000, 9.259722 ) ;
	TextDrawTextSize ( td_tun_box, 8.000000, 0.000000 ) ;
	TextDrawAlignment ( td_tun_box, 1 ) ;
	TextDrawColor ( td_tun_box, 0 ) ;
	TextDrawUseBox ( td_tun_box, true ) ;
	TextDrawBoxColor ( td_tun_box, 102 ) ;
	TextDrawSetShadow ( td_tun_box, 0 ) ;
	TextDrawSetOutline ( td_tun_box, 0 ) ;
	TextDrawFont ( td_tun_box, 0 ) ;


	td_tuning[0] = TextDrawCreate(485.833404, 123.888832, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[0], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[0], 131.250000, 255.925933 ) ;
	TextDrawAlignment(td_tuning[0], 1 ) ;
	TextDrawColor(td_tuning[0], 269488383 ) ;
	TextDrawSetShadow(td_tuning[0], 0 ) ;
	TextDrawSetOutline(td_tuning[0], 0 ) ;
	TextDrawBackgroundColor(td_tuning[0], 255 ) ;
	TextDrawFont(td_tuning[0], 4 ) ;
	TextDrawSetProportional(td_tuning[0], 0 ) ;
	TextDrawSetShadow(td_tuning[0], 0 ) ;

	td_tuning[1] = TextDrawCreate(485.833374, 134.777740, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[1], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[1], 131.250091, 2.888971 ) ;
	TextDrawAlignment(td_tuning[1], 1 ) ;
	TextDrawColor(td_tuning[1], 606348543 ) ;
	TextDrawSetShadow(td_tuning[1], 0 ) ;
	TextDrawSetOutline(td_tuning[1], 0 ) ;
	TextDrawBackgroundColor(td_tuning[1], 255 ) ;
	TextDrawFont(td_tuning[1], 4 ) ;
	TextDrawSetProportional(td_tuning[1], 0 ) ;
	TextDrawSetShadow(td_tuning[1], 0 ) ;

	td_tuning[2] = TextDrawCreate(500.000213, 117.148124, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[2], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[2], 102.083389, 15.333415 ) ;
	TextDrawAlignment(td_tuning[2], 1 ) ;
	TextDrawColor(td_tuning[2], 557867519 ) ;
	TextDrawSetShadow(td_tuning[2], 0 ) ;
	TextDrawSetOutline(td_tuning[2], 0 ) ;
	TextDrawBackgroundColor(td_tuning[2], 255 ) ;
	TextDrawFont(td_tuning[2], 4 ) ;
	TextDrawSetProportional(td_tuning[2], 0 ) ;
	TextDrawSetShadow(td_tuning[2], 0 ) ;

	td_tuning[3] = TextDrawCreate(551.250183, 120.518539, "TUNING_MENU" ) ;
	TextDrawLetterSize(td_tuning[3], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[3], 2 ) ;
	TextDrawColor(td_tuning[3], -1 ) ;
	TextDrawSetShadow(td_tuning[3], 0 ) ;
	TextDrawSetOutline(td_tuning[3], 0 ) ;
	TextDrawBackgroundColor(td_tuning[3], 255 ) ;
	TextDrawFont(td_tuning[3], 1 ) ;
	TextDrawSetProportional(td_tuning[3], 1 ) ;
	TextDrawSetShadow(td_tuning[3], 0 ) ;

	td_tuning[4] = TextDrawCreate(488.433380, 140.599990, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[4], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[4], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[4], 1 ) ;
	TextDrawColor(td_tuning[4], 606348543 ) ;
	TextDrawSetShadow(td_tuning[4], 0 ) ;
	TextDrawSetOutline(td_tuning[4], 0 ) ;
	TextDrawBackgroundColor(td_tuning[4], 255 ) ;
	TextDrawFont(td_tuning[4], 4 ) ;
	TextDrawSetProportional(td_tuning[4], 0 ) ;
	TextDrawSetShadow(td_tuning[4], 0 ) ;
	TextDrawSetSelectable(td_tuning[4], true ) ;

	td_tuning[5] = TextDrawCreate(488.333587, 140.481414, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[5], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[5], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[5], 1 ) ;
	TextDrawColor(td_tuning[5], 557867519 ) ;
	TextDrawSetShadow(td_tuning[5], 0 ) ;
	TextDrawSetOutline(td_tuning[5], 0 ) ;
	TextDrawBackgroundColor(td_tuning[5], 255 ) ;
	TextDrawFont(td_tuning[5], 4 ) ;
	TextDrawSetProportional(td_tuning[5], 0 ) ;
	TextDrawSetShadow(td_tuning[5], 0 ) ;

	td_tuning[6] = TextDrawCreate(552.500305, 143.333389, "COLOR_1" ) ;
	TextDrawLetterSize(td_tuning[6], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[6], 2 ) ;
	TextDrawColor(td_tuning[6], -1 ) ;
	TextDrawSetShadow(td_tuning[6], 0 ) ;
	TextDrawSetOutline(td_tuning[6], 0 ) ;
	TextDrawBackgroundColor(td_tuning[6], 255 ) ;
	TextDrawFont(td_tuning[6], 1 ) ;
	TextDrawSetProportional(td_tuning[6], 1 ) ;
	TextDrawSetShadow(td_tuning[6], 0 ) ;

	td_tuning[7] = TextDrawCreate(488.433380, 157.711135, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[7], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[7], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[7], 1 ) ;
	TextDrawColor(td_tuning[7], 606348543 ) ;
	TextDrawSetShadow(td_tuning[7], 0 ) ;
	TextDrawSetOutline(td_tuning[7], 0 ) ;
	TextDrawBackgroundColor(td_tuning[7], 255 ) ;
	TextDrawFont(td_tuning[7], 4 ) ;
	TextDrawSetProportional(td_tuning[7], 0 ) ;
	TextDrawSetShadow(td_tuning[7], 0 ) ;
	TextDrawSetSelectable(td_tuning[7], true ) ;

	td_tuning[8] = TextDrawCreate(488.333557, 157.592529, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[8], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[8], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[8], 1 ) ;
	TextDrawColor(td_tuning[8], 557867519 ) ;
	TextDrawSetShadow(td_tuning[8], 0 ) ;
	TextDrawSetOutline(td_tuning[8], 0 ) ;
	TextDrawBackgroundColor(td_tuning[8], 255 ) ;
	TextDrawFont(td_tuning[8], 4 ) ;
	TextDrawSetProportional(td_tuning[8], 0 ) ;
	TextDrawSetShadow(td_tuning[8], 0 ) ;

	td_tuning[9] = TextDrawCreate(552.916992, 160.444610, "COLOR_2" ) ;
	TextDrawLetterSize(td_tuning[9], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[9], 2 ) ;
	TextDrawColor(td_tuning[9], -1 ) ;
	TextDrawSetShadow(td_tuning[9], 0 ) ;
	TextDrawSetOutline(td_tuning[9], 0 ) ;
	TextDrawBackgroundColor(td_tuning[9], 255 ) ;
	TextDrawFont(td_tuning[9], 1 ) ;
	TextDrawSetProportional(td_tuning[9], 1 ) ;
	TextDrawSetShadow(td_tuning[9], 0 ) ;

	td_tuning[10] = TextDrawCreate(488.433410, 174.822250, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[10], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[10], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[10], 1 ) ;
	TextDrawColor(td_tuning[10], 606348543 ) ;
	TextDrawSetShadow(td_tuning[10], 0 ) ;
	TextDrawSetOutline(td_tuning[10], 0 ) ;
	TextDrawBackgroundColor(td_tuning[10], 255 ) ;
	TextDrawFont(td_tuning[10], 4 ) ;
	TextDrawSetProportional(td_tuning[10], 0 ) ;
	TextDrawSetShadow(td_tuning[10], 0 ) ;
	TextDrawSetSelectable(td_tuning[10], true ) ;

	td_tuning[11] = TextDrawCreate(488.333587, 174.703704, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[11], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[11], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[11], 1 ) ;
	TextDrawColor(td_tuning[11], 557867519 ) ;
	TextDrawSetShadow(td_tuning[11], 0 ) ;
	TextDrawSetOutline(td_tuning[11], 0 ) ;
	TextDrawBackgroundColor(td_tuning[11], 255 ) ;
	TextDrawFont(td_tuning[11], 4 ) ;
	TextDrawSetProportional(td_tuning[11], 0 ) ;
	TextDrawSetShadow(td_tuning[11], 0 ) ;

	td_tuning[12] = TextDrawCreate(552.500305, 177.555694, "PAINT_JOBS" ) ;
	TextDrawLetterSize(td_tuning[12], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[12], 2 ) ;
	TextDrawColor(td_tuning[12], -1 ) ;
	TextDrawSetShadow(td_tuning[12], 0 ) ;
	TextDrawSetOutline(td_tuning[12], 0 ) ;
	TextDrawBackgroundColor(td_tuning[12], 255 ) ;
	TextDrawFont(td_tuning[12], 1 ) ;
	TextDrawSetProportional(td_tuning[12], 1 ) ;
	TextDrawSetShadow(td_tuning[12], 0 ) ;

	td_tuning[13] = TextDrawCreate(488.433410, 191.933349, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[13], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[13], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[13], 1 ) ;
	TextDrawColor(td_tuning[13], 606348543 ) ;
	TextDrawSetShadow(td_tuning[13], 0 ) ;
	TextDrawSetOutline(td_tuning[13], 0 ) ;
	TextDrawBackgroundColor(td_tuning[13], 255 ) ;
	TextDrawFont(td_tuning[13], 4 ) ;
	TextDrawSetProportional(td_tuning[13], 0 ) ;
	TextDrawSetShadow(td_tuning[13], 0 ) ;
	TextDrawSetSelectable(td_tuning[13], true ) ;

	td_tuning[14] = TextDrawCreate(488.333618, 191.814865, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[14], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[14], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[14], 1 ) ;
	TextDrawColor(td_tuning[14], 557867519 ) ;
	TextDrawSetShadow(td_tuning[14], 0 ) ;
	TextDrawSetOutline(td_tuning[14], 0 ) ;
	TextDrawBackgroundColor(td_tuning[14], 255 ) ;
	TextDrawFont(td_tuning[14], 4 ) ;
	TextDrawSetProportional(td_tuning[14], 0 ) ;
	TextDrawSetShadow(td_tuning[14], 0 ) ;

	td_tuning[15] = TextDrawCreate(552.500305, 194.666946, "EXHAUST" ) ;
	TextDrawLetterSize(td_tuning[15], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[15], 2 ) ;
	TextDrawColor(td_tuning[15], -1 ) ;
	TextDrawSetShadow(td_tuning[15], 0 ) ;
	TextDrawSetOutline(td_tuning[15], 0 ) ;
	TextDrawBackgroundColor(td_tuning[15], 255 ) ;
	TextDrawFont(td_tuning[15], 1 ) ;
	TextDrawSetProportional(td_tuning[15], 1 ) ;
	TextDrawSetShadow(td_tuning[15], 0 ) ;

	td_tuning[16] = TextDrawCreate(488.433380, 209.044464, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[16], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[16], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[16], 1 ) ;
	TextDrawColor(td_tuning[16], 606348543 ) ;
	TextDrawSetShadow(td_tuning[16], 0 ) ;
	TextDrawSetOutline(td_tuning[16], 0 ) ;
	TextDrawBackgroundColor(td_tuning[16], 255 ) ;
	TextDrawFont(td_tuning[16], 4 ) ;
	TextDrawSetProportional(td_tuning[16], 0 ) ;
	TextDrawSetShadow(td_tuning[16], 0 ) ;
	TextDrawSetSelectable(td_tuning[16], true ) ;

	td_tuning[17] = TextDrawCreate(488.333618, 208.926040, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[17], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[17], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[17], 1 ) ;
	TextDrawColor(td_tuning[17], 557867519 ) ;
	TextDrawSetShadow(td_tuning[17], 0 ) ;
	TextDrawSetOutline(td_tuning[17], 0 ) ;
	TextDrawBackgroundColor(td_tuning[17], 255 ) ;
	TextDrawFont(td_tuning[17], 4 ) ;
	TextDrawSetProportional(td_tuning[17], 0 ) ;
	TextDrawSetShadow(td_tuning[17], 0 ) ;

	td_tuning[18] = TextDrawCreate(552.500305, 211.778091, "BULLBARS" ) ;
	TextDrawLetterSize(td_tuning[18], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[18], 2 ) ;
	TextDrawColor(td_tuning[18], -1 ) ;
	TextDrawSetShadow(td_tuning[18], 0 ) ;
	TextDrawSetOutline(td_tuning[18], 0 ) ;
	TextDrawBackgroundColor(td_tuning[18], 255 ) ;
	TextDrawFont(td_tuning[18], 1 ) ;
	TextDrawSetProportional(td_tuning[18], 1 ) ;
	TextDrawSetShadow(td_tuning[18], 0 ) ;

	td_tuning[19] = TextDrawCreate(488.433410, 226.155609, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[19], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[19], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[19], 1 ) ;
	TextDrawColor(td_tuning[19], 606348543 ) ;
	TextDrawSetShadow(td_tuning[19], 0 ) ;
	TextDrawSetOutline(td_tuning[19], 0 ) ;
	TextDrawBackgroundColor(td_tuning[19], 255 ) ;
	TextDrawFont(td_tuning[19], 4 ) ;
	TextDrawSetProportional(td_tuning[19], 0 ) ;
	TextDrawSetShadow(td_tuning[19], 0 ) ;
	TextDrawSetSelectable(td_tuning[19], true ) ;

	td_tuning[20] = TextDrawCreate(488.333618, 226.037155, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[20], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[20], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[20], 1 ) ;
	TextDrawColor(td_tuning[20], 557867519 ) ;
	TextDrawSetShadow(td_tuning[20], 0 ) ;
	TextDrawSetOutline(td_tuning[20], 0 ) ;
	TextDrawBackgroundColor(td_tuning[20], 255 ) ;
	TextDrawFont(td_tuning[20], 4 ) ;
	TextDrawSetProportional(td_tuning[20], 0 ) ;
	TextDrawSetShadow(td_tuning[20], 0 ) ;

	td_tuning[21] = TextDrawCreate(552.500305, 228.889297, "ROOF" ) ;
	TextDrawLetterSize(td_tuning[21], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[21], 2 ) ;
	TextDrawColor(td_tuning[21], -1 ) ;
	TextDrawSetShadow(td_tuning[21], 0 ) ;
	TextDrawSetOutline(td_tuning[21], 0 ) ;
	TextDrawBackgroundColor(td_tuning[21], 255 ) ;
	TextDrawFont(td_tuning[21], 1 ) ;
	TextDrawSetProportional(td_tuning[21], 1 ) ;
	TextDrawSetShadow(td_tuning[21], 0 ) ;

	td_tuning[22] = TextDrawCreate(488.433349, 243.266723, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[22], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[22], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[22], 1 ) ;
	TextDrawColor(td_tuning[22], 606348543 ) ;
	TextDrawSetShadow(td_tuning[22], 0 ) ;
	TextDrawSetOutline(td_tuning[22], 0 ) ;
	TextDrawBackgroundColor(td_tuning[22], 255 ) ;
	TextDrawFont(td_tuning[22], 4 ) ;
	TextDrawSetProportional(td_tuning[22], 0 ) ;
	TextDrawSetShadow(td_tuning[22], 0 ) ;
	TextDrawSetSelectable(td_tuning[22], true ) ;

	td_tuning[23] = TextDrawCreate(488.333618, 243.148315, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[23], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[23], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[23], 1 ) ;
	TextDrawColor(td_tuning[23], 557867519 ) ;
	TextDrawSetShadow(td_tuning[23], 0 ) ;
	TextDrawSetOutline(td_tuning[23], 0 ) ;
	TextDrawBackgroundColor(td_tuning[23], 255 ) ;
	TextDrawFont(td_tuning[23], 4 ) ;
	TextDrawSetProportional(td_tuning[23], 0 ) ;
	TextDrawSetShadow(td_tuning[23], 0 ) ;

	td_tuning[24] = TextDrawCreate(552.500305, 246.518966, "FRONT_BUMPER" ) ;
	TextDrawLetterSize(td_tuning[24], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[24], 2 ) ;
	TextDrawColor(td_tuning[24], -1 ) ;
	TextDrawSetShadow(td_tuning[24], 0 ) ;
	TextDrawSetOutline(td_tuning[24], 0 ) ;
	TextDrawBackgroundColor(td_tuning[24], 255 ) ;
	TextDrawFont(td_tuning[24], 1 ) ;
	TextDrawSetProportional(td_tuning[24], 1 ) ;
	TextDrawSetShadow(td_tuning[24], 0 ) ;

	td_tuning[25] = TextDrawCreate(488.433380, 260.377746, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[25], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[25], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[25], 1 ) ;
	TextDrawColor(td_tuning[25], 606348543 ) ;
	TextDrawSetShadow(td_tuning[25], 0 ) ;
	TextDrawSetOutline(td_tuning[25], 0 ) ;
	TextDrawBackgroundColor(td_tuning[25], 255 ) ;
	TextDrawFont(td_tuning[25], 4 ) ;
	TextDrawSetProportional(td_tuning[25], 0 ) ;
	TextDrawSetShadow(td_tuning[25], 0 ) ;
	TextDrawSetSelectable(td_tuning[25], true ) ;

	td_tuning[26] = TextDrawCreate(488.333679, 260.259399, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[26], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[26], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[26], 1 ) ;
	TextDrawColor(td_tuning[26], 557867519 ) ;
	TextDrawSetShadow(td_tuning[26], 0 ) ;
	TextDrawSetOutline(td_tuning[26], 0 ) ;
	TextDrawBackgroundColor(td_tuning[26], 255 ) ;
	TextDrawFont(td_tuning[26], 4 ) ;
	TextDrawSetProportional(td_tuning[26], 0 ) ;
	TextDrawSetShadow(td_tuning[26], 0 ) ;

	td_tuning[27] = TextDrawCreate(552.500244, 263.630035, "REAR_BUMPER" ) ;
	TextDrawLetterSize(td_tuning[27], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[27], 2 ) ;
	TextDrawColor(td_tuning[27], -1 ) ;
	TextDrawSetShadow(td_tuning[27], 0 ) ;
	TextDrawSetOutline(td_tuning[27], 0 ) ;
	TextDrawBackgroundColor(td_tuning[27], 255 ) ;
	TextDrawFont(td_tuning[27], 1 ) ;
	TextDrawSetProportional(td_tuning[27], 1 ) ;
	TextDrawSetShadow(td_tuning[27], 0 ) ;

	td_tuning[28] = TextDrawCreate(488.433410, 277.488952, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[28], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[28], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[28], 1 ) ;
	TextDrawColor(td_tuning[28], 606348543 ) ;
	TextDrawSetShadow(td_tuning[28], 0 ) ;
	TextDrawSetOutline(td_tuning[28], 0 ) ;
	TextDrawBackgroundColor(td_tuning[28], 255 ) ;
	TextDrawFont(td_tuning[28], 4 ) ;
	TextDrawSetProportional(td_tuning[28], 0 ) ;
	TextDrawSetShadow(td_tuning[28], 0 ) ;
	TextDrawSetSelectable(td_tuning[28], true ) ;

	td_tuning[29] = TextDrawCreate(488.333648, 277.370452, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[29], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[29], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[29], 1 ) ;
	TextDrawColor(td_tuning[29], 557867519 ) ;
	TextDrawSetShadow(td_tuning[29], 0 ) ;
	TextDrawSetOutline(td_tuning[29], 0 ) ;
	TextDrawBackgroundColor(td_tuning[29], 255 ) ;
	TextDrawFont(td_tuning[29], 4 ) ;
	TextDrawSetProportional(td_tuning[29], 0 ) ;
	TextDrawSetShadow(td_tuning[29], 0 ) ;

	td_tuning[30] = TextDrawCreate(552.500366, 280.741149, "SPOILER" ) ;
	TextDrawLetterSize(td_tuning[30], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[30], 2 ) ;
	TextDrawColor(td_tuning[30], -1 ) ;
	TextDrawSetShadow(td_tuning[30], 0 ) ;
	TextDrawSetOutline(td_tuning[30], 0 ) ;
	TextDrawBackgroundColor(td_tuning[30], 255 ) ;
	TextDrawFont(td_tuning[30], 1 ) ;
	TextDrawSetProportional(td_tuning[30], 1 ) ;
	TextDrawSetShadow(td_tuning[30], 0 ) ;

	td_tuning[31] = TextDrawCreate(488.433380, 294.600036, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[31], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[31], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[31], 1 ) ;
	TextDrawColor(td_tuning[31], 606348543 ) ;
	TextDrawSetShadow(td_tuning[31], 0 ) ;
	TextDrawSetOutline(td_tuning[31], 0 ) ;
	TextDrawBackgroundColor(td_tuning[31], 255 ) ;
	TextDrawFont(td_tuning[31], 4 ) ;
	TextDrawSetProportional(td_tuning[31], 0 ) ;
	TextDrawSetShadow(td_tuning[31], 0 ) ;
	TextDrawSetSelectable(td_tuning[31], true ) ;

	td_tuning[32] = TextDrawCreate(488.333801, 294.481658, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[32], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[32], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[32], 1 ) ;
	TextDrawColor(td_tuning[32], 557867519 ) ;
	TextDrawSetShadow(td_tuning[32], 0 ) ;
	TextDrawSetOutline(td_tuning[32], 0 ) ;
	TextDrawBackgroundColor(td_tuning[32], 255 ) ;
	TextDrawFont(td_tuning[32], 4 ) ;
	TextDrawSetProportional(td_tuning[32], 0 ) ;
	TextDrawSetShadow(td_tuning[32], 0 ) ;

	td_tuning[33] = TextDrawCreate(552.916992, 297.333648, "SIDESKIRT" ) ;
	TextDrawLetterSize(td_tuning[33], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[33], 2 ) ;
	TextDrawColor(td_tuning[33], -1 ) ;
	TextDrawSetShadow(td_tuning[33], 0 ) ;
	TextDrawSetOutline(td_tuning[33], 0 ) ;
	TextDrawBackgroundColor(td_tuning[33], 255 ) ;
	TextDrawFont(td_tuning[33], 1 ) ;
	TextDrawSetProportional(td_tuning[33], 1 ) ;
	TextDrawSetShadow(td_tuning[33], 0 ) ;

	td_tuning[34] = TextDrawCreate(488.433258, 311.711151, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[34], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[34], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[34], 1 ) ;
	TextDrawColor(td_tuning[34], 606348543 ) ;
	TextDrawSetShadow(td_tuning[34], 0 ) ;
	TextDrawSetOutline(td_tuning[34], 0 ) ;
	TextDrawBackgroundColor(td_tuning[34], 255 ) ;
	TextDrawFont(td_tuning[34], 4 ) ;
	TextDrawSetProportional(td_tuning[34], 0 ) ;
	TextDrawSetShadow(td_tuning[34], 0 ) ;
	TextDrawSetSelectable(td_tuning[34], true ) ;

	td_tuning[35] = TextDrawCreate(488.333801, 311.792816, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[35], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[35], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[35], 1 ) ;
	TextDrawColor(td_tuning[35], 557867519 ) ;
	TextDrawSetShadow(td_tuning[35], 0 ) ;
	TextDrawSetOutline(td_tuning[35], 0 ) ;
	TextDrawBackgroundColor(td_tuning[35], 255 ) ;
	TextDrawFont(td_tuning[35], 4 ) ;
	TextDrawSetProportional(td_tuning[35], 0 ) ;
	TextDrawSetShadow(td_tuning[35], 0 ) ;

	td_tuning[36] = TextDrawCreate(552.916931, 314.444824, "WHEELS" ) ;
	TextDrawLetterSize(td_tuning[36], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[36], 2 ) ;
	TextDrawColor(td_tuning[36], -1 ) ;
	TextDrawSetShadow(td_tuning[36], 0 ) ;
	TextDrawSetOutline(td_tuning[36], 0 ) ;
	TextDrawBackgroundColor(td_tuning[36], 255 ) ;
	TextDrawFont(td_tuning[36], 1 ) ;
	TextDrawSetProportional(td_tuning[36], 1 ) ;
	TextDrawSetShadow(td_tuning[36], 0 ) ;

	td_tuning[37] = TextDrawCreate(488.433258, 328.822235, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[37], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[37], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[37], 1 ) ;
	TextDrawColor(td_tuning[37], 606348543 ) ;
	TextDrawSetShadow(td_tuning[37], 0 ) ;
	TextDrawSetOutline(td_tuning[37], 0 ) ;
	TextDrawBackgroundColor(td_tuning[37], 255 ) ;
	TextDrawFont(td_tuning[37], 4 ) ;
	TextDrawSetProportional(td_tuning[37], 0 ) ;
	TextDrawSetShadow(td_tuning[37], 0 ) ;
	TextDrawSetSelectable(td_tuning[37], true ) ;

	td_tuning[38] = TextDrawCreate(488.333801, 328.903930, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[38], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[38], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[38], 1 ) ;
	TextDrawColor(td_tuning[38], 557867519 ) ;
	TextDrawSetShadow(td_tuning[38], 0 ) ;
	TextDrawSetOutline(td_tuning[38], 0 ) ;
	TextDrawBackgroundColor(td_tuning[38], 255 ) ;
	TextDrawFont(td_tuning[38], 4 ) ;
	TextDrawSetProportional(td_tuning[38], 0 ) ;
	TextDrawSetShadow(td_tuning[38], 0 ) ;

	td_tuning[39] = TextDrawCreate(552.916931, 331.556091, "HYDRAULICS" ) ;
	TextDrawLetterSize(td_tuning[39], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[39], 2 ) ;
	TextDrawColor(td_tuning[39], -1 ) ;
	TextDrawSetShadow(td_tuning[39], 0 ) ;
	TextDrawSetOutline(td_tuning[39], 0 ) ;
	TextDrawBackgroundColor(td_tuning[39], 255 ) ;
	TextDrawFont(td_tuning[39], 1 ) ;
	TextDrawSetProportional(td_tuning[39], 1 ) ;
	TextDrawSetShadow(td_tuning[39], 0 ) ;

	td_tuning[40] = TextDrawCreate(488.433258, 345.933319, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[40], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[40], 125.833396, 15.851929 ) ;
	TextDrawAlignment(td_tuning[40], 1 ) ;
	TextDrawColor(td_tuning[40], 606348543 ) ;
	TextDrawSetShadow(td_tuning[40], 0 ) ;
	TextDrawSetOutline(td_tuning[40], 0 ) ;
	TextDrawBackgroundColor(td_tuning[40], 255 ) ;
	TextDrawFont(td_tuning[40], 4 ) ;
	TextDrawSetProportional(td_tuning[40], 0 ) ;
	TextDrawSetShadow(td_tuning[40], 0 ) ;
	TextDrawSetSelectable(td_tuning[40], true ) ;

	td_tuning[41] = TextDrawCreate(488.333801, 346.015045, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[41], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[41], 3.333393, 15.851934 ) ;
	TextDrawAlignment(td_tuning[41], 1 ) ;
	TextDrawColor(td_tuning[41], 557867519 ) ;
	TextDrawSetShadow(td_tuning[41], 0 ) ;
	TextDrawSetOutline(td_tuning[41], 0 ) ;
	TextDrawBackgroundColor(td_tuning[41], 255 ) ;
	TextDrawFont(td_tuning[41], 4 ) ;
	TextDrawSetProportional(td_tuning[41], 0 ) ;
	TextDrawSetShadow(td_tuning[41], 0 ) ;

	td_tuning[42] = TextDrawCreate(552.916992, 348.667175, "NITRO" ) ;
	TextDrawLetterSize(td_tuning[42], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[42], 2 ) ;
	TextDrawColor(td_tuning[42], -1 ) ;
	TextDrawSetShadow(td_tuning[42], 0 ) ;
	TextDrawSetOutline(td_tuning[42], 0 ) ;
	TextDrawBackgroundColor(td_tuning[42], 255 ) ;
	TextDrawFont(td_tuning[42], 1 ) ;
	TextDrawSetProportional(td_tuning[42], 1 ) ;
	TextDrawSetShadow(td_tuning[42], 0 ) ;

	td_tuning[43] = TextDrawCreate(485.833526, 366.037048, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[43], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[43], 131.250091, 2.888971 ) ;
	TextDrawAlignment(td_tuning[43], 1 ) ;
	TextDrawColor(td_tuning[43], 606348543 ) ;
	TextDrawSetShadow(td_tuning[43], 0 ) ;
	TextDrawSetOutline(td_tuning[43], 0 ) ;
	TextDrawBackgroundColor(td_tuning[43], 255 ) ;
	TextDrawFont(td_tuning[43], 4 ) ;
	TextDrawSetProportional(td_tuning[43], 0 ) ;
	TextDrawSetShadow(td_tuning[43], 0 ) ;

	td_tuning[44] = TextDrawCreate(499.583587, 371.222198, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[44], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[44], 102.083389, 15.333415 ) ;
	TextDrawAlignment(td_tuning[44], 1 ) ;
	TextDrawColor(td_tuning[44], 557867519 ) ;
	TextDrawSetShadow(td_tuning[44], 0 ) ;
	TextDrawSetOutline(td_tuning[44], 0 ) ;
	TextDrawBackgroundColor(td_tuning[44], 255 ) ;
	TextDrawFont(td_tuning[44], 4 ) ;
	TextDrawSetProportional(td_tuning[44], 0 ) ;
	TextDrawSetShadow(td_tuning[44], 0 ) ;
	TextDrawSetSelectable(td_tuning[44], true ) ;

	td_tuning[45] = TextDrawCreate(550.416625, 374.074157, "EXIT" ) ;
	TextDrawLetterSize(td_tuning[45], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[45], 2 ) ;
	TextDrawColor(td_tuning[45], -1 ) ;
	TextDrawSetShadow(td_tuning[45], 0 ) ;
	TextDrawSetOutline(td_tuning[45], 0 ) ;
	TextDrawBackgroundColor(td_tuning[45], 255 ) ;
	TextDrawFont(td_tuning[45], 1 ) ;
	TextDrawSetProportional(td_tuning[45], 1 ) ;
	TextDrawSetShadow(td_tuning[45], 0 ) ;

	td_tuning[46] = TextDrawCreate(254.583587, 352.037109, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[46], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[46], 131.666702, 32.444423 ) ;
	TextDrawAlignment(td_tuning[46], 1 ) ;
	TextDrawColor(td_tuning[46], 269488383 ) ;
	TextDrawSetShadow(td_tuning[46], 0 ) ;
	TextDrawSetOutline(td_tuning[46], 0 ) ;
	TextDrawBackgroundColor(td_tuning[46], 255 ) ;
	TextDrawFont(td_tuning[46], 4 ) ;
	TextDrawSetProportional(td_tuning[46], 0 ) ;
	TextDrawSetShadow(td_tuning[46], 0 ) ;

	td_tuning[47] = TextDrawCreate(288.849914, 359.933319, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[47], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[47], 62.916755, 16.370449 ) ;
	TextDrawAlignment(td_tuning[47], 1 ) ;
	TextDrawColor(td_tuning[47], 606348543 ) ;
	TextDrawSetShadow(td_tuning[47], 0 ) ;
	TextDrawSetOutline(td_tuning[47], 0 ) ;
	TextDrawBackgroundColor(td_tuning[47], 255 ) ;
	TextDrawFont(td_tuning[47], 4 ) ;
	TextDrawSetProportional(td_tuning[47], 0 ) ;
	TextDrawSetShadow(td_tuning[47], 0 ) ;
	TextDrawSetSelectable(td_tuning[47], true ) ;

	td_tuning[48] = TextDrawCreate(353.016662, 359.933319, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[48], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[48], 29.583435, 16.370449 ) ;
	TextDrawAlignment(td_tuning[48], 1 ) ;
	TextDrawColor(td_tuning[48], 606348543 ) ;
	TextDrawSetShadow(td_tuning[48], 0 ) ;
	TextDrawSetOutline(td_tuning[48], 0 ) ;
	TextDrawBackgroundColor(td_tuning[48], 255 ) ;
	TextDrawFont(td_tuning[48], 4 ) ;
	TextDrawSetProportional(td_tuning[48], 0 ) ;
	TextDrawSetShadow(td_tuning[48], 0 ) ;
	TextDrawSetSelectable(td_tuning[48], true ) ;

	td_tuning[49] = TextDrawCreate(258.016662, 359.933288, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[49], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[49], 29.583435, 16.370449 ) ;
	TextDrawAlignment(td_tuning[49], 1 ) ;
	TextDrawColor(td_tuning[49], 606348543 ) ;
	TextDrawSetShadow(td_tuning[49], 0 ) ;
	TextDrawSetOutline(td_tuning[49], 0 ) ;
	TextDrawBackgroundColor(td_tuning[49], 255 ) ;
	TextDrawFont(td_tuning[49], 4 ) ;
	TextDrawSetProportional(td_tuning[49], 0 ) ;
	TextDrawSetShadow(td_tuning[49], 0 ) ;
	TextDrawSetSelectable(td_tuning[49], true ) ;

	td_tuning[50] = TextDrawCreate(319.583679, 362.667053, "SELECT" ) ;
	TextDrawLetterSize(td_tuning[50], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_tuning[50], 2 ) ;
	TextDrawColor(td_tuning[50], -1 ) ;
	TextDrawSetShadow(td_tuning[50], 0 ) ;
	TextDrawSetOutline(td_tuning[50], 0 ) ;
	TextDrawBackgroundColor(td_tuning[50], 255 ) ;
	TextDrawFont(td_tuning[50], 1 ) ;
	TextDrawSetProportional(td_tuning[50], 1 ) ;
	TextDrawSetShadow(td_tuning[50], 0 ) ;

	td_tuning[51] = TextDrawCreate(266.349884, 362.007385, "ld_beat:left" ) ;
	TextDrawLetterSize(td_tuning[51], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[51], 11.666770, 11.703783 ) ;
	TextDrawAlignment(td_tuning[51], 1 ) ;
	TextDrawColor(td_tuning[51], -1 ) ;
	TextDrawSetShadow(td_tuning[51], 0 ) ;
	TextDrawSetOutline(td_tuning[51], 0 ) ;
	TextDrawBackgroundColor(td_tuning[51], 255 ) ;
	TextDrawFont(td_tuning[51], 4 ) ;
	TextDrawSetProportional(td_tuning[51], 0 ) ;
	TextDrawSetShadow(td_tuning[51], 0 ) ;

	td_tuning[52] = TextDrawCreate(362.599670, 362.007354, "ld_beat:right" ) ;
	TextDrawLetterSize(td_tuning[52], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[52], 11.666770, 11.703783 ) ;
	TextDrawAlignment(td_tuning[52], 1 ) ;
	TextDrawColor(td_tuning[52], -1 ) ;
	TextDrawSetShadow(td_tuning[52], 0 ) ;
	TextDrawSetOutline(td_tuning[52], 0 ) ;
	TextDrawBackgroundColor(td_tuning[52], 255 ) ;
	TextDrawFont(td_tuning[52], 4 ) ;
	TextDrawSetProportional(td_tuning[52], 0 ) ;
	TextDrawSetShadow(td_tuning[52], 0 ) ;

	td_tuning[53] = TextDrawCreate(257.916839, 375.370422, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[53], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[53], 29.583410, 1.333415 ) ;
	TextDrawAlignment(td_tuning[53], 1 ) ;
	TextDrawColor(td_tuning[53], 557867519 ) ;
	TextDrawSetShadow(td_tuning[53], 0 ) ;
	TextDrawSetOutline(td_tuning[53], 0 ) ;
	TextDrawBackgroundColor(td_tuning[53], 255 ) ;
	TextDrawFont(td_tuning[53], 4 ) ;
	TextDrawSetProportional(td_tuning[53], 0 ) ;
	TextDrawSetShadow(td_tuning[53], 0 ) ;

	td_tuning[54] = TextDrawCreate(352.916809, 375.370422, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[54], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[54], 29.583410, 1.333415 ) ;
	TextDrawAlignment(td_tuning[54], 1 ) ;
	TextDrawColor(td_tuning[54], 557867519 ) ;
	TextDrawSetShadow(td_tuning[54], 0 ) ;
	TextDrawSetOutline(td_tuning[54], 0 ) ;
	TextDrawBackgroundColor(td_tuning[54], 255 ) ;
	TextDrawFont(td_tuning[54], 4 ) ;
	TextDrawSetProportional(td_tuning[54], 0 ) ;
	TextDrawSetShadow(td_tuning[54], 0 ) ;

	td_tuning[55] = TextDrawCreate(288.750183, 375.370422, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[55], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[55], 62.916755, 1.333415 ) ;
	TextDrawAlignment(td_tuning[55], 1 ) ;
	TextDrawColor(td_tuning[55], 557867519 ) ;
	TextDrawSetShadow(td_tuning[55], 0 ) ;
	TextDrawSetOutline(td_tuning[55], 0 ) ;
	TextDrawBackgroundColor(td_tuning[55], 255 ) ;
	TextDrawFont(td_tuning[55], 4 ) ;
	TextDrawSetProportional(td_tuning[55], 0 ) ;
	TextDrawSetShadow(td_tuning[55], 0 ) ;

	td_tuning[56] = TextDrawCreate(254.583297, 353.592498, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[56], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[56], 131.666763, 2.888971 ) ;
	TextDrawAlignment(td_tuning[56], 1 ) ;
	TextDrawColor(td_tuning[56], 606348543 ) ;
	TextDrawSetShadow(td_tuning[56], 0 ) ;
	TextDrawSetOutline(td_tuning[56], 0 ) ;
	TextDrawBackgroundColor(td_tuning[56], 255 ) ;
	TextDrawFont(td_tuning[56], 4 ) ;
	TextDrawSetProportional(td_tuning[56], 0 ) ;
	TextDrawSetShadow(td_tuning[56], 0 ) ;

	td_tuning[57] = TextDrawCreate(254.583297, 379.518310, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_tuning[57], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_tuning[57], 131.666763, 2.888971 ) ;
	TextDrawAlignment(td_tuning[57], 1 ) ;
	TextDrawColor(td_tuning[57], 606348543 ) ;
	TextDrawSetShadow(td_tuning[57], 0 ) ;
	TextDrawSetOutline(td_tuning[57], 0 ) ;
	TextDrawBackgroundColor(td_tuning[57], 255 ) ;
	TextDrawFont(td_tuning[57], 4 ) ;
	TextDrawSetProportional(td_tuning[57], 0 ) ;
	TextDrawSetShadow(td_tuning[57], 0 ) ;

	td_color [ 0 ] = TextDrawCreate(15.000000, 134.312500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 0 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 0 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 0 ], 1 ) ;
	TextDrawColor(td_color [ 0 ], td_car_colors [ 0 ] ) ;
	TextDrawSetShadow(td_color [ 0 ], 0 ) ;
	TextDrawSetOutline(td_color [ 0 ], 0 ) ;
	TextDrawFont(td_color [ 0 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 0 ], true ) ;

	td_color [ 1 ] = TextDrawCreate(33.500000, 134.312500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 1 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 1 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 1 ], 1 ) ;
	TextDrawColor(td_color [ 1 ], td_car_colors [ 1 ] ) ;
	TextDrawSetShadow(td_color [ 1 ], 0 ) ;
	TextDrawSetOutline(td_color [ 1 ], 0 ) ;
	TextDrawFont(td_color [ 1 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 1 ], true ) ;

	td_color [ 2 ] = TextDrawCreate(52.000000, 134.312500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 2 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 2 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 2 ], 1 ) ;
	TextDrawColor(td_color [ 2 ], td_car_colors [ 2 ] ) ;
	TextDrawSetShadow(td_color [ 2 ], 0 ) ;
	TextDrawSetOutline(td_color [ 2 ], 0 ) ;
	TextDrawFont(td_color [ 2 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 2 ], true ) ;

	td_color [ 3 ] = TextDrawCreate(70.500000, 134.312500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 3 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 3 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 3 ], 1 ) ;
	TextDrawColor(td_color [ 3 ], td_car_colors [ 3 ] ) ;
	TextDrawSetShadow(td_color [ 3 ], 0 ) ;
	TextDrawSetOutline(td_color [ 3 ], 0 ) ;
	TextDrawFont(td_color [ 3 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 3 ], true ) ;

	td_color [ 4 ] = TextDrawCreate(89.000000, 134.312500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 4 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 4 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 4 ], 1 ) ;
	TextDrawColor(td_color [ 4 ], td_car_colors [ 4 ] ) ;
	TextDrawSetShadow(td_color [ 4 ], 0 ) ;
	TextDrawSetOutline(td_color [ 4 ], 0 ) ;
	TextDrawFont(td_color [ 4 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 4 ], true ) ;

	td_color [ 5 ] = TextDrawCreate(107.500000, 134.312500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 5 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 5 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 5 ], 1 ) ;
	TextDrawColor(td_color [ 5 ], td_car_colors [ 5 ] ) ;
	TextDrawSetShadow(td_color [ 5 ], 0 ) ;
	TextDrawSetOutline(td_color [ 5 ], 0 ) ;
	TextDrawFont(td_color [ 5 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 5 ], true ) ;

	td_color [ 6 ] = TextDrawCreate(126.000000, 134.312500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 6 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 6 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 6 ], 1 ) ;
	TextDrawColor(td_color [ 6 ], td_car_colors [ 6 ] ) ;
	TextDrawSetShadow(td_color [ 6 ], 0 ) ;
	TextDrawSetOutline(td_color [ 6 ], 0 ) ;
	TextDrawFont(td_color [ 6 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 6 ], true ) ;

	td_color [ 7 ] = TextDrawCreate(15.000000, 147.875000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 7 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 7 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 7 ], 1 ) ;
	TextDrawColor(td_color [ 7 ], td_car_colors [ 7 ] ) ;
	TextDrawSetShadow(td_color [ 7 ], 0 ) ;
	TextDrawSetOutline(td_color [ 7 ], 0 ) ;
	TextDrawFont(td_color [ 7 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 7 ], true ) ;

	td_color [ 8 ] = TextDrawCreate(33.500000, 147.875000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 8 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 8 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 8 ], 1 ) ;
	TextDrawColor(td_color [ 8 ], td_car_colors [ 8 ] ) ;
	TextDrawSetShadow(td_color [ 8 ], 0 ) ;
	TextDrawSetOutline(td_color [ 8 ], 0 ) ;
	TextDrawFont(td_color [ 8 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 8 ], true ) ;

	td_color [ 9 ] = TextDrawCreate(52.000000, 147.875000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 9 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 9 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 9 ], 1 ) ;
	TextDrawColor(td_color [ 9 ], td_car_colors [ 9 ] ) ;
	TextDrawSetShadow(td_color [ 9 ], 0 ) ;
	TextDrawSetOutline(td_color [ 9 ], 0 ) ;
	TextDrawFont(td_color [ 9 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 9 ], true ) ;

	td_color [ 10 ] = TextDrawCreate(70.500000, 147.875000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 10 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 10 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 10 ], 1 ) ;
	TextDrawColor(td_color [ 10 ], td_car_colors [ 10 ] ) ;
	TextDrawSetShadow(td_color [ 10 ], 0 ) ;
	TextDrawSetOutline(td_color [ 10 ], 0 ) ;
	TextDrawFont(td_color [ 10 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 10 ], true ) ;

	td_color [ 11 ] = TextDrawCreate(89.000000, 147.875000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 11 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 11 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 11 ], 1 ) ;
	TextDrawColor(td_color [ 11 ], td_car_colors [ 11 ] ) ;
	TextDrawSetShadow(td_color [ 11 ], 0 ) ;
	TextDrawSetOutline(td_color [ 11 ], 0 ) ;
	TextDrawFont(td_color [ 11 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 11 ], true ) ;

	td_color [ 12 ] = TextDrawCreate(107.500000, 147.875000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 12 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 12 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 12 ], 1 ) ;
	TextDrawColor(td_color [ 12 ], td_car_colors [ 12 ] ) ;
	TextDrawSetShadow(td_color [ 12 ], 0 ) ;
	TextDrawSetOutline(td_color [ 12 ], 0 ) ;
	TextDrawFont(td_color [ 12 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 12 ], true ) ;

	td_color [ 13 ] = TextDrawCreate(126.000000, 147.875000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 13 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 13 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 13 ], 1 ) ;
	TextDrawColor(td_color [ 13 ], td_car_colors [ 13 ] ) ;
	TextDrawSetShadow(td_color [ 13 ], 0 ) ;
	TextDrawSetOutline(td_color [ 13 ], 0 ) ;
	TextDrawFont(td_color [ 13 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 13 ], true ) ;

	td_color [ 14 ] = TextDrawCreate(15.000000, 161.437500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 14 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 14 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 14 ], 1 ) ;
	TextDrawColor(td_color [ 14 ], td_car_colors [ 14 ] ) ;
	TextDrawSetShadow(td_color [ 14 ], 0 ) ;
	TextDrawSetOutline(td_color [ 14 ], 0 ) ;
	TextDrawFont(td_color [ 14 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 14 ], true ) ;

	td_color [ 15 ] = TextDrawCreate(33.500000, 161.437500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 15 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 15 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 15 ], 1 ) ;
	TextDrawColor(td_color [ 15 ], td_car_colors [ 15 ] ) ;
	TextDrawSetShadow(td_color [ 15 ], 0 ) ;
	TextDrawSetOutline(td_color [ 15 ], 0 ) ;
	TextDrawFont(td_color [ 15 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 15 ], true ) ;

	td_color [ 16 ] = TextDrawCreate(52.000000, 161.437500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 16 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 16 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 16 ], 1 ) ;
	TextDrawColor(td_color [ 16 ], td_car_colors [ 16 ] ) ;
	TextDrawSetShadow(td_color [ 16 ], 0 ) ;
	TextDrawSetOutline(td_color [ 16 ], 0 ) ;
	TextDrawFont(td_color [ 16 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 16 ], true ) ;

	td_color [ 17 ] = TextDrawCreate(70.500000, 161.437500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 17 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 17 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 17 ], 1 ) ;
	TextDrawColor(td_color [ 17 ], td_car_colors [ 17 ] ) ;
	TextDrawSetShadow(td_color [ 17 ], 0 ) ;
	TextDrawSetOutline(td_color [ 17 ], 0 ) ;
	TextDrawFont(td_color [ 17 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 17 ], true ) ;

	td_color [ 18 ] = TextDrawCreate(89.000000, 161.437500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 18 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 18 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 18 ], 1 ) ;
	TextDrawColor(td_color [ 18 ], td_car_colors [ 18 ] ) ;
	TextDrawSetShadow(td_color [ 18 ], 0 ) ;
	TextDrawSetOutline(td_color [ 18 ], 0 ) ;
	TextDrawFont(td_color [ 18 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 18 ], true ) ;

	td_color [ 19 ] = TextDrawCreate(107.500000, 161.437500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 19 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 19 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 19 ], 1 ) ;
	TextDrawColor(td_color [ 19 ], td_car_colors [ 19 ] ) ;
	TextDrawSetShadow(td_color [ 19 ], 0 ) ;
	TextDrawSetOutline(td_color [ 19 ], 0 ) ;
	TextDrawFont(td_color [ 19 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 19 ], true ) ;

	td_color [ 20 ] = TextDrawCreate(126.000000, 161.437500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 20 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 20 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 20 ], 1 ) ;
	TextDrawColor(td_color [ 20 ], td_car_colors [ 20 ] ) ;
	TextDrawSetShadow(td_color [ 20 ], 0 ) ;
	TextDrawSetOutline(td_color [ 20 ], 0 ) ;
	TextDrawFont(td_color [ 20 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 20 ], true ) ;

	td_color [ 21 ] = TextDrawCreate(126.500000, 202.125000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 21 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 21 ], 16.000000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 21 ], 1 ) ;
	TextDrawColor(td_color [ 21 ], td_car_colors [ 21 ] ) ;
	TextDrawSetShadow(td_color [ 21 ], 0 ) ;
	TextDrawSetOutline(td_color [ 21 ], 0 ) ;
	TextDrawFont(td_color [ 21 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 21 ], true ) ;

	td_color [ 22 ] = TextDrawCreate(15.000000, 175.000000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 22 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 22 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 22 ], 1 ) ;
	TextDrawColor(td_color [ 22 ], td_car_colors [ 22 ] ) ;
	TextDrawSetShadow(td_color [ 22 ], 0 ) ;
	TextDrawSetOutline(td_color [ 22 ], 0 ) ;
	TextDrawFont(td_color [ 22 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 22 ], true ) ;

	td_color [ 23 ] = TextDrawCreate(33.500000, 175.000000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 23 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 23 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 23 ], 1 ) ;
	TextDrawColor(td_color [ 23 ], td_car_colors [ 23 ] ) ;
	TextDrawSetShadow(td_color [ 23 ], 0 ) ;
	TextDrawSetOutline(td_color [ 23 ], 0 ) ;
	TextDrawFont(td_color [ 23 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 23 ], true ) ;

	td_color [ 24 ] = TextDrawCreate(52.000000, 175.000000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 24 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 24 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 24 ], 1 ) ;
	TextDrawColor(td_color [ 24 ], td_car_colors [ 24 ] ) ;
	TextDrawSetShadow(td_color [ 24 ], 0 ) ;
	TextDrawSetOutline(td_color [ 24 ], 0 ) ;
	TextDrawFont(td_color [ 24 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 24 ], true ) ;

	td_color [ 25 ] = TextDrawCreate(70.500000, 175.000000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 25 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 25 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 25 ], 1 ) ;
	TextDrawColor(td_color [ 25 ], td_car_colors [ 25 ] ) ;
	TextDrawSetShadow(td_color [ 25 ], 0 ) ;
	TextDrawSetOutline(td_color [ 25 ], 0 ) ;
	TextDrawFont(td_color [ 25 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 25 ], true ) ;

	td_color [ 26 ] = TextDrawCreate(89.000000, 175.000000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 26 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 26 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 26 ], 1 ) ;
	TextDrawColor(td_color [ 26 ], td_car_colors [ 26 ] ) ;
	TextDrawSetShadow(td_color [ 26 ], 0 ) ;
	TextDrawSetOutline(td_color [ 26 ], 0 ) ;
	TextDrawFont(td_color [ 26 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 26 ], true ) ;

	td_color [ 27 ] = TextDrawCreate(107.500000, 175.000000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 27 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 27 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 27 ], 1 ) ;
	TextDrawColor(td_color [ 27 ], td_car_colors [ 27 ] ) ;
	TextDrawSetShadow(td_color [ 27 ], 0 ) ;
	TextDrawSetOutline(td_color [ 27 ], 0 ) ;
	TextDrawFont(td_color [ 27 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 27 ], true ) ;

	td_color [ 28 ] = TextDrawCreate(126.000000, 175.000000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 28 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 28 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 28 ], 1 ) ;
	TextDrawColor(td_color [ 28 ], td_car_colors [ 28 ] ) ;
	TextDrawSetShadow(td_color [ 28 ], 0 ) ;
	TextDrawSetOutline(td_color [ 28 ], 0 ) ;
	TextDrawFont(td_color [ 28 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 28 ], true ) ;

	td_color [ 29 ] = TextDrawCreate(15.000000, 188.562500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 29 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 29 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 29 ], 1 ) ;
	TextDrawColor(td_color [ 29 ], td_car_colors [ 29 ] ) ;
	TextDrawSetShadow(td_color [ 29 ], 0 ) ;
	TextDrawSetOutline(td_color [ 29 ], 0 ) ;
	TextDrawFont(td_color [ 29 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 29 ], true ) ;

	td_color [ 30 ] = TextDrawCreate(33.500000, 188.562500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 30 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 30 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 30 ], 1 ) ;
	TextDrawColor(td_color [ 30 ], td_car_colors [ 30 ] ) ;
	TextDrawSetShadow(td_color [ 30 ], 0 ) ;
	TextDrawSetOutline(td_color [ 30 ], 0 ) ;
	TextDrawFont(td_color [ 30 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 30 ], true ) ;

	td_color [ 31 ] = TextDrawCreate(52.000000, 188.562500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 31 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 31 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 31 ], 1 ) ;
	TextDrawColor(td_color [ 31 ], td_car_colors [ 31 ] ) ;
	TextDrawSetShadow(td_color [ 31 ], 0 ) ;
	TextDrawSetOutline(td_color [ 31 ], 0 ) ;
	TextDrawFont(td_color [ 31 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 31 ], true ) ;

	td_color [ 32 ] = TextDrawCreate(70.500000, 188.562500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 32 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 32 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 32 ], 1 ) ;
	TextDrawColor(td_color [ 32 ], td_car_colors [ 32 ] ) ;
	TextDrawSetShadow(td_color [ 32 ], 0 ) ;
	TextDrawSetOutline(td_color [ 32 ], 0 ) ;
	TextDrawFont(td_color [ 32 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 32 ], true ) ;

	td_color [ 33 ] = TextDrawCreate(89.000000, 188.562500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 33 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 33 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 33 ], 1 ) ;
	TextDrawColor(td_color [ 33 ], td_car_colors [ 33 ] ) ;
	TextDrawSetShadow(td_color [ 33 ], 0 ) ;
	TextDrawSetOutline(td_color [ 33 ], 0 ) ;
	TextDrawFont(td_color [ 33 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 33 ], true ) ;

	td_color [ 34 ] = TextDrawCreate(107.500000, 188.562500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 34 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 34 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 34 ], 1 ) ;
	TextDrawColor(td_color [ 34 ], td_car_colors [ 34 ] ) ;
	TextDrawSetShadow(td_color [ 34 ], 0 ) ;
	TextDrawSetOutline(td_color [ 34 ], 0 ) ;
	TextDrawFont(td_color [ 34 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 34 ], true ) ;

	td_color [ 35 ] = TextDrawCreate(126.000000, 188.562500, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 35 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 35 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 35 ], 1 ) ;
	TextDrawColor(td_color [ 35 ], td_car_colors [ 35 ] ) ;
	TextDrawSetShadow(td_color [ 35 ], 0 ) ;
	TextDrawSetOutline(td_color [ 35 ], 0 ) ;
	TextDrawFont(td_color [ 35 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 35 ], true ) ;

	td_color [ 36 ] = TextDrawCreate(15.000000, 202.125000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 36 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 36 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 36 ], 1 ) ;
	TextDrawColor(td_color [ 36 ], td_car_colors [ 36 ] ) ;
	TextDrawSetShadow(td_color [ 36 ], 0 ) ;
	TextDrawSetOutline(td_color [ 36 ], 0 ) ;
	TextDrawFont(td_color [ 36 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 36 ], true ) ;

	td_color [ 37 ] = TextDrawCreate(33.500000, 202.125000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 37 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 37 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 37 ], 1 ) ;
	TextDrawColor(td_color [ 37 ], td_car_colors [ 37 ] ) ;
	TextDrawSetShadow(td_color [ 37 ], 0 ) ;
	TextDrawSetOutline(td_color [ 37 ], 0 ) ;
	TextDrawFont(td_color [ 37 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 37 ], true ) ;

	td_color [ 38 ] = TextDrawCreate(52.000000, 202.125000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 38 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 38 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 38 ], 1 ) ;
	TextDrawColor(td_color [ 38 ], td_car_colors [ 38 ] ) ;
	TextDrawSetShadow(td_color [ 38 ], 0 ) ;
	TextDrawSetOutline(td_color [ 38 ], 0 ) ;
	TextDrawFont(td_color [ 38 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 38 ], true ) ;

	td_color [ 39 ] = TextDrawCreate(71.000000, 202.125000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 39 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 39 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 39 ], 1 ) ;
	TextDrawColor(td_color [ 39 ], td_car_colors [ 39 ] ) ;
	TextDrawSetShadow(td_color [ 39 ], 0 ) ;
	TextDrawSetOutline(td_color [ 39 ], 0 ) ;
	TextDrawFont(td_color [ 39 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 39 ], true ) ;

	td_color [ 40 ] = TextDrawCreate(89.000000, 202.125000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 40 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 40 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 40 ], 1 ) ;
	TextDrawColor(td_color [ 40 ], td_car_colors [ 40 ] ) ;
	TextDrawSetShadow(td_color [ 40 ], 0 ) ;
	TextDrawSetOutline(td_color [ 40 ], 0 ) ;
	TextDrawFont(td_color [ 40 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 40 ], true ) ;

	td_color [ 41 ] = TextDrawCreate(107.500000, 202.125000, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_color [ 41 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_color [ 41 ], 16.500000, 12.250000 ) ;
	TextDrawAlignment(td_color [ 41 ], 1 ) ;
	TextDrawColor(td_color [ 41 ], td_car_colors [ 41 ] ) ;
	TextDrawSetShadow(td_color [ 41 ], 0 ) ;
	TextDrawSetOutline(td_color [ 41 ], 0 ) ;
	TextDrawFont(td_color [ 41 ], 4 ) ;
	TextDrawSetSelectable(td_color [ 41 ], true ) ;
	
	
/*

		perfomance tuning

*/

	perfomance_TD[0] = TextDrawCreate(531.3475, 102.7033, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[0], 86.0000, 275.0000);
	TextDrawAlignment(perfomance_TD[0], 1);
	TextDrawColor(perfomance_TD[0], 255);
	TextDrawBackgroundColor(perfomance_TD[0], 255);
	TextDrawFont(perfomance_TD[0], 4);
	TextDrawSetProportional(perfomance_TD[0], 0);
	TextDrawSetShadow(perfomance_TD[0], 0);

	perfomance_TD[1] = TextDrawCreate(544.9995, 129.0175, ""); // عنصر
	TextDrawTextSize(perfomance_TD[1], 59.0000, 55.0000);
	TextDrawAlignment(perfomance_TD[1], 1);
	TextDrawColor(perfomance_TD[1], -1);
	TextDrawBackgroundColor(perfomance_TD[1], -2139062017);
	TextDrawFont(perfomance_TD[1], 5);
	TextDrawSetProportional(perfomance_TD[1], 0);
	TextDrawSetShadow(perfomance_TD[1], 0);
	TextDrawSetPreviewModel(perfomance_TD[1], 19917);
	TextDrawSetPreviewRot(perfomance_TD[1], -16.0000, 0.0000, -55.0000, 0.8500);

	perfomance_TD[2] = TextDrawCreate(545.0001, 188.8733, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[2], 59.0000, 14.0000);
	TextDrawAlignment(perfomance_TD[2], 1);
	TextDrawColor(perfomance_TD[2], -2139062017);
	TextDrawBackgroundColor(perfomance_TD[2], 255);
	TextDrawFont(perfomance_TD[2], 4);
	TextDrawSetProportional(perfomance_TD[2], 0);
	TextDrawSetShadow(perfomance_TD[2], 0);
	TextDrawSetSelectable(perfomance_TD[2], true);

	perfomance_TD[3] = TextDrawCreate(558.0139, 190.1421, "engine"); // عنصر
	TextDrawLetterSize(perfomance_TD[3], 0.2325, 1.1418);
	TextDrawAlignment(perfomance_TD[3], 1);
	TextDrawColor(perfomance_TD[3], -1);
	TextDrawBackgroundColor(perfomance_TD[3], 255);
	TextDrawFont(perfomance_TD[3], 2);
	TextDrawSetProportional(perfomance_TD[3], 1);
	TextDrawSetShadow(perfomance_TD[3], 0);

	perfomance_TD[4] = TextDrawCreate(600.8822, 188.8768, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[4], 3.0000, 14.0000);
	TextDrawAlignment(perfomance_TD[4], 1);
	TextDrawColor(perfomance_TD[4], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[4], 255);
	TextDrawFont(perfomance_TD[4], 4);
	TextDrawSetProportional(perfomance_TD[4], 0);
	TextDrawSetShadow(perfomance_TD[4], 0);

	perfomance_TD[5] = TextDrawCreate(545.0659, 208.2745, ""); // عنصر
	TextDrawTextSize(perfomance_TD[5], 59.0000, 52.0000);
	TextDrawAlignment(perfomance_TD[5], 1);
	TextDrawColor(perfomance_TD[5], -1);
	TextDrawBackgroundColor(perfomance_TD[5], -2139062017);
	TextDrawFont(perfomance_TD[5], 5);
	TextDrawSetProportional(perfomance_TD[5], 0);
	TextDrawSetShadow(perfomance_TD[5], 0);
	TextDrawSetPreviewModel(perfomance_TD[5], 1945);
	TextDrawSetPreviewRot(perfomance_TD[5], 45.0000, 90.0000, -55.0000, 0.8500);

	perfomance_TD[6] = TextDrawCreate(545.0001, 266.1780, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[6], 59.0000, 14.0000);
	TextDrawAlignment(perfomance_TD[6], 1);
	TextDrawColor(perfomance_TD[6], -2139062017);
	TextDrawBackgroundColor(perfomance_TD[6], 255);
	TextDrawFont(perfomance_TD[6], 4);
	TextDrawSetProportional(perfomance_TD[6], 0);
	TextDrawSetShadow(perfomance_TD[6], 0);
	TextDrawSetSelectable(perfomance_TD[6], true);

	perfomance_TD[7] = TextDrawCreate(600.8983, 266.2546, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[7], 3.0000, 14.0000);
	TextDrawAlignment(perfomance_TD[7], 1);
	TextDrawColor(perfomance_TD[7], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[7], 255);
	TextDrawFont(perfomance_TD[7], 4);
	TextDrawSetProportional(perfomance_TD[7], 0);
	TextDrawSetShadow(perfomance_TD[7], 0);

	perfomance_TD[8] = TextDrawCreate(559.1137, 267.6467, "brake"); // عنصر
	TextDrawLetterSize(perfomance_TD[8], 0.2325, 1.1418);
	TextDrawAlignment(perfomance_TD[8], 1);
	TextDrawColor(perfomance_TD[8], -1);
	TextDrawBackgroundColor(perfomance_TD[8], 255);
	TextDrawFont(perfomance_TD[8], 2);
	TextDrawSetProportional(perfomance_TD[8], 1);
	TextDrawSetShadow(perfomance_TD[8], 0);

	perfomance_TD[9] = TextDrawCreate(545.0659, 286.0793, ""); // عنصر
	TextDrawTextSize(perfomance_TD[9], 59.0000, 52.0000);
	TextDrawAlignment(perfomance_TD[9], 1);
	TextDrawColor(perfomance_TD[9], -1);
	TextDrawBackgroundColor(perfomance_TD[9], -2139062017);
	TextDrawFont(perfomance_TD[9], 5);
	TextDrawSetProportional(perfomance_TD[9], 0);
	TextDrawSetShadow(perfomance_TD[9], 0);
	TextDrawSetPreviewModel(perfomance_TD[9], 1075);
	TextDrawSetPreviewRot(perfomance_TD[9], 0.0000, 0.0000, 90.0000, 1.0000);

	perfomance_TD[10] = TextDrawCreate(545.0001, 343.7827, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[10], 59.0000, 14.0000);
	TextDrawAlignment(perfomance_TD[10], 1);
	TextDrawColor(perfomance_TD[10], -2139062017);
	TextDrawBackgroundColor(perfomance_TD[10], 255);
	TextDrawFont(perfomance_TD[10], 4);
	TextDrawSetProportional(perfomance_TD[10], 0);
	TextDrawSetShadow(perfomance_TD[10], 0);
	TextDrawSetSelectable(perfomance_TD[10], true);

	perfomance_TD[11] = TextDrawCreate(601.2150, 343.8507, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[11], 3.0000, 14.0000);
	TextDrawAlignment(perfomance_TD[11], 1);
	TextDrawColor(perfomance_TD[11], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[11], 255);
	TextDrawFont(perfomance_TD[11], 4);
	TextDrawSetProportional(perfomance_TD[11], 0);
	TextDrawSetShadow(perfomance_TD[11], 0);

	perfomance_TD[12] = TextDrawCreate(551.6657, 345.1606, "stability"); // عنصر
	TextDrawLetterSize(perfomance_TD[12], 0.2325, 1.1418);
	TextDrawAlignment(perfomance_TD[12], 1);
	TextDrawColor(perfomance_TD[12], -1);
	TextDrawBackgroundColor(perfomance_TD[12], 255);
	TextDrawFont(perfomance_TD[12], 2);
	TextDrawSetProportional(perfomance_TD[12], 1);
	TextDrawSetShadow(perfomance_TD[12], 0);

	perfomance_TD[13] = TextDrawCreate(522.5000, 87.5925, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(perfomance_TD[13], 16.0000, 20.0000);
	TextDrawAlignment(perfomance_TD[13], 1);
	TextDrawColor(perfomance_TD[13], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[13], 255);
	TextDrawFont(perfomance_TD[13], 4);
	TextDrawSetProportional(perfomance_TD[13], 0);
	TextDrawSetShadow(perfomance_TD[13], 0);

	perfomance_TD[14] = TextDrawCreate(530.2833, 90.9036, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[14], 88.0000, 27.0000);
	TextDrawAlignment(perfomance_TD[14], 1);
	TextDrawColor(perfomance_TD[14], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[14], 255);
	TextDrawFont(perfomance_TD[14], 4);
	TextDrawSetProportional(perfomance_TD[14], 0);
	TextDrawSetShadow(perfomance_TD[14], 0);

	perfomance_TD[15] = TextDrawCreate(610.2664, 87.7926, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(perfomance_TD[15], 16.0000, 20.0000);
	TextDrawAlignment(perfomance_TD[15], 1);
	TextDrawColor(perfomance_TD[15], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[15], 255);
	TextDrawFont(perfomance_TD[15], 4);
	TextDrawSetProportional(perfomance_TD[15], 0);
	TextDrawSetShadow(perfomance_TD[15], 0);

	perfomance_TD[16] = TextDrawCreate(525.1845, 96.2035, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[16], 13.0000, 22.0000);
	TextDrawAlignment(perfomance_TD[16], 1);
	TextDrawColor(perfomance_TD[16], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[16], 255);
	TextDrawFont(perfomance_TD[16], 4);
	TextDrawSetProportional(perfomance_TD[16], 0);
	TextDrawSetShadow(perfomance_TD[16], 0);

	perfomance_TD[17] = TextDrawCreate(610.5845, 95.9294, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[17], 13.0000, 22.0000);
	TextDrawAlignment(perfomance_TD[17], 1);
	TextDrawColor(perfomance_TD[17], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[17], 255);
	TextDrawFont(perfomance_TD[17], 4);
	TextDrawSetProportional(perfomance_TD[17], 0);
	TextDrawSetShadow(perfomance_TD[17], 0);

	perfomance_TD[18] = TextDrawCreate(530.2833, 368.2177, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[18], 88.0000, 27.0000);
	TextDrawAlignment(perfomance_TD[18], 1);
	TextDrawColor(perfomance_TD[18], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[18], 255);
	TextDrawFont(perfomance_TD[18], 4);
	TextDrawSetProportional(perfomance_TD[18], 0);
	TextDrawSetShadow(perfomance_TD[18], 0);

	perfomance_TD[19] = TextDrawCreate(522.5000, 378.4071, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(perfomance_TD[19], 16.0000, 20.0000);
	TextDrawAlignment(perfomance_TD[19], 1);
	TextDrawColor(perfomance_TD[19], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[19], 255);
	TextDrawFont(perfomance_TD[19], 4);
	TextDrawSetProportional(perfomance_TD[19], 0);
	TextDrawSetShadow(perfomance_TD[19], 0);

	perfomance_TD[20] = TextDrawCreate(610.0786, 378.4071, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(perfomance_TD[20], 16.0000, 20.0000);
	TextDrawAlignment(perfomance_TD[20], 1);
	TextDrawColor(perfomance_TD[20], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[20], 255);
	TextDrawFont(perfomance_TD[20], 4);
	TextDrawSetProportional(perfomance_TD[20], 0);
	TextDrawSetShadow(perfomance_TD[20], 0);

	perfomance_TD[21] = TextDrawCreate(525.2188, 367.9930, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[21], 13.0000, 22.0000);
	TextDrawAlignment(perfomance_TD[21], 1);
	TextDrawColor(perfomance_TD[21], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[21], 255);
	TextDrawFont(perfomance_TD[21], 4);
	TextDrawSetProportional(perfomance_TD[21], 0);
	TextDrawSetShadow(perfomance_TD[21], 0);

	perfomance_TD[22] = TextDrawCreate(610.5980, 367.9930, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[22], 13.0000, 22.0000);
	TextDrawAlignment(perfomance_TD[22], 1);
	TextDrawColor(perfomance_TD[22], 1119719167);
	TextDrawBackgroundColor(perfomance_TD[22], 255);
	TextDrawFont(perfomance_TD[22], 4);
	TextDrawSetProportional(perfomance_TD[22], 0);
	TextDrawSetShadow(perfomance_TD[22], 0);

	perfomance_TD[23] = TextDrawCreate(525.2999, 118.0407, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[23], 9.0000, 250.0000);
	TextDrawAlignment(perfomance_TD[23], 1);
	TextDrawColor(perfomance_TD[23], 255);
	TextDrawBackgroundColor(perfomance_TD[23], 255);
	TextDrawFont(perfomance_TD[23], 4);
	TextDrawSetProportional(perfomance_TD[23], 0);
	TextDrawSetShadow(perfomance_TD[23], 0);

	perfomance_TD[24] = TextDrawCreate(614.3781, 118.1222, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(perfomance_TD[24], 9.0000, 250.0000);
	TextDrawAlignment(perfomance_TD[24], 1);
	TextDrawColor(perfomance_TD[24], 255);
	TextDrawBackgroundColor(perfomance_TD[24], 255);
	TextDrawFont(perfomance_TD[24], 4);
	TextDrawSetProportional(perfomance_TD[24], 0);
	TextDrawSetShadow(perfomance_TD[24], 0);

	perfomance_TD[25] = TextDrawCreate(541.3665, 98.1036, "perfomance"); // عنصر
	TextDrawLetterSize(perfomance_TD[25], 0.2682, 1.3510);
	TextDrawAlignment(perfomance_TD[25], 1);
	TextDrawColor(perfomance_TD[25], -1);
	TextDrawBackgroundColor(perfomance_TD[25], 255);
	TextDrawFont(perfomance_TD[25], 2);
	TextDrawSetProportional(perfomance_TD[25], 1);
	TextDrawSetShadow(perfomance_TD[25], 0);

	perfomance_TD[26] = TextDrawCreate(555.4995, 374.6556, "tuning"); // عنصر
	TextDrawLetterSize(perfomance_TD[26], 0.2682, 1.3510);
	TextDrawAlignment(perfomance_TD[26], 1);
	TextDrawColor(perfomance_TD[26], -1);
	TextDrawBackgroundColor(perfomance_TD[26], 255);
	TextDrawFont(perfomance_TD[26], 2);
	TextDrawSetProportional(perfomance_TD[26], 1);
	TextDrawSetShadow(perfomance_TD[26], 0);

	perfomance_TD[27] = TextDrawCreate(612.9167, 81.8889, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(perfomance_TD[27], 19.0000, 21.0000);
	TextDrawAlignment(perfomance_TD[27], 1);
	TextDrawColor(perfomance_TD[27], 255);
	TextDrawBackgroundColor(perfomance_TD[27], 255);
	TextDrawFont(perfomance_TD[27], 4);
	TextDrawSetProportional(perfomance_TD[27], 0);
	TextDrawSetShadow(perfomance_TD[27], 0);
	TextDrawSetSelectable(perfomance_TD[27], true);

	perfomance_TD[28] = TextDrawCreate(619.5834, 87.4518, "x"); // عنصر
	TextDrawLetterSize(perfomance_TD[28], 0.2287, 0.9518);
	TextDrawTextSize(perfomance_TD[28], -26.0000, 0.0000);
	TextDrawAlignment(perfomance_TD[28], 1);
	TextDrawColor(perfomance_TD[28], -1);
	TextDrawBackgroundColor(perfomance_TD[28], 255);
	TextDrawFont(perfomance_TD[28], 2);
	TextDrawSetProportional(perfomance_TD[28], 1);
	TextDrawSetShadow(perfomance_TD[28], 0);
	
/*

		Skin shop

*/
	td_skinshop[0] = TextDrawCreate(254.583587, 352.037109, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[0], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[0], 131.666702, 32.444423 ) ;
	TextDrawAlignment(td_skinshop[0], 1 ) ;
	TextDrawColor(td_skinshop[0], 269488383 ) ;
	TextDrawSetShadow(td_skinshop[0], 0 ) ;
	TextDrawSetOutline(td_skinshop[0], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[0], 255 ) ;
	TextDrawFont(td_skinshop[0], 4 ) ;
	TextDrawSetProportional(td_skinshop[0], 0 ) ;
	TextDrawSetShadow(td_skinshop[0], 0 ) ;

	td_skinshop[1] = TextDrawCreate(288.849914, 359.933319, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[1], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[1], 62.916755, 16.370449 ) ;
	TextDrawAlignment(td_skinshop[1], 1 ) ;
	TextDrawColor(td_skinshop[1], 606348543 ) ;
	TextDrawSetShadow(td_skinshop[1], 0 ) ;
	TextDrawSetOutline(td_skinshop[1], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[1], 255 ) ;
	TextDrawFont(td_skinshop[1], 4 ) ;
	TextDrawSetProportional(td_skinshop[1], 0 ) ;
	TextDrawSetShadow(td_skinshop[1], 0 ) ;
	TextDrawSetSelectable(td_skinshop[1], true ) ;

	td_skinshop[2] = TextDrawCreate(353.016662, 359.933319, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[2], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[2], 29.583435, 16.370449 ) ;
	TextDrawAlignment(td_skinshop[2], 1 ) ;
	TextDrawColor(td_skinshop[2], 606348543 ) ;
	TextDrawSetShadow(td_skinshop[2], 0 ) ;
	TextDrawSetOutline(td_skinshop[2], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[2], 255 ) ;
	TextDrawFont(td_skinshop[2], 4 ) ;
	TextDrawSetProportional(td_skinshop[2], 0 ) ;
	TextDrawSetShadow(td_skinshop[2], 0 ) ;
	TextDrawSetSelectable(td_skinshop[2], true ) ;

	td_skinshop[3] = TextDrawCreate(258.016662, 359.933288, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[3], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[3], 29.583435, 16.370449 ) ;
	TextDrawAlignment(td_skinshop[3], 1 ) ;
	TextDrawColor(td_skinshop[3], 606348543 ) ;
	TextDrawSetShadow(td_skinshop[3], 0 ) ;
	TextDrawSetOutline(td_skinshop[3], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[3], 255 ) ;
	TextDrawFont(td_skinshop[3], 4 ) ;
	TextDrawSetProportional(td_skinshop[3], 0 ) ;
	TextDrawSetShadow(td_skinshop[3], 0 ) ;
	TextDrawSetSelectable(td_skinshop[3], true ) ;

	td_skinshop[4] = TextDrawCreate(319.583679, 362.667053, "SELECT" ) ;
	TextDrawLetterSize(td_skinshop[4], 0.267082, 1.040001 ) ;
	TextDrawAlignment(td_skinshop[4], 2 ) ;
	TextDrawColor(td_skinshop[4], -1 ) ;
	TextDrawSetShadow(td_skinshop[4], 0 ) ;
	TextDrawSetOutline(td_skinshop[4], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[4], 255 ) ;
	TextDrawFont(td_skinshop[4], 1 ) ;
	TextDrawSetProportional(td_skinshop[4], 1 ) ;
	TextDrawSetShadow(td_skinshop[4], 0 ) ;

	td_skinshop[5] = TextDrawCreate(266.349884, 362.007385, "ld_beat:left" ) ;
	TextDrawLetterSize(td_skinshop[5], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[5], 11.666770, 11.703783 ) ;
	TextDrawAlignment(td_skinshop[5], 1 ) ;
	TextDrawColor(td_skinshop[5], -1 ) ;
	TextDrawSetShadow(td_skinshop[5], 0 ) ;
	TextDrawSetOutline(td_skinshop[5], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[5], 255 ) ;
	TextDrawFont(td_skinshop[5], 4 ) ;
	TextDrawSetProportional(td_skinshop[5], 0 ) ;
	TextDrawSetShadow(td_skinshop[5], 0 ) ;

	td_skinshop[6] = TextDrawCreate(362.599670, 362.007354, "ld_beat:right" ) ;
	TextDrawLetterSize(td_skinshop[6], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[6], 11.666770, 11.703783 ) ;
	TextDrawAlignment(td_skinshop[6], 1 ) ;
	TextDrawColor(td_skinshop[6], -1 ) ;
	TextDrawSetShadow(td_skinshop[6], 0 ) ;
	TextDrawSetOutline(td_skinshop[6], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[6], 255 ) ;
	TextDrawFont(td_skinshop[6], 4 ) ;
	TextDrawSetProportional(td_skinshop[6], 0 ) ;
	TextDrawSetShadow(td_skinshop[6], 0 ) ;

	td_skinshop[7] = TextDrawCreate(257.916839, 375.370422, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[7], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[7], 29.583410, 1.333415 ) ;
	TextDrawAlignment(td_skinshop[7], 1 ) ;
	TextDrawColor(td_skinshop[7], 557867519 ) ;
	TextDrawSetShadow(td_skinshop[7], 0 ) ;
	TextDrawSetOutline(td_skinshop[7], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[7], 255 ) ;
	TextDrawFont(td_skinshop[7], 4 ) ;
	TextDrawSetProportional(td_skinshop[7], 0 ) ;
	TextDrawSetShadow(td_skinshop[7], 0 ) ;

	td_skinshop[8] = TextDrawCreate(352.916809, 375.370422, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[8], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[8], 29.583410, 1.333415 ) ;
	TextDrawAlignment(td_skinshop[8], 1 ) ;
	TextDrawColor(td_skinshop[8], 557867519 ) ;
	TextDrawSetShadow(td_skinshop[8], 0 ) ;
	TextDrawSetOutline(td_skinshop[8], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[8], 255 ) ;
	TextDrawFont(td_skinshop[8], 4 ) ;
	TextDrawSetProportional(td_skinshop[8], 0 ) ;
	TextDrawSetShadow(td_skinshop[8], 0 ) ;

	td_skinshop[9] = TextDrawCreate(288.750183, 375.370422, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[9], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[9], 62.916755, 1.333415 ) ;
	TextDrawAlignment(td_skinshop[9], 1 ) ;
	TextDrawColor(td_skinshop[9], 557867519 ) ;
	TextDrawSetShadow(td_skinshop[9], 0 ) ;
	TextDrawSetOutline(td_skinshop[9], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[9], 255 ) ;
	TextDrawFont(td_skinshop[9], 4 ) ;
	TextDrawSetProportional(td_skinshop[9], 0 ) ;
	TextDrawSetShadow(td_skinshop[9], 0 ) ;

	td_skinshop[10] = TextDrawCreate(254.583297, 353.592498, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[10], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[10], 131.666763, 2.888971 ) ;
	TextDrawAlignment(td_skinshop[10], 1 ) ;
	TextDrawColor(td_skinshop[10], 606348543 ) ;
	TextDrawSetShadow(td_skinshop[10], 0 ) ;
	TextDrawSetOutline(td_skinshop[10], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[10], 255 ) ;
	TextDrawFont(td_skinshop[10], 4 ) ;
	TextDrawSetProportional(td_skinshop[10], 0 ) ;
	TextDrawSetShadow(td_skinshop[10], 0 ) ;

	td_skinshop[11] = TextDrawCreate(254.583297, 379.518310, "LD_SPAC:white" ) ;
	TextDrawLetterSize(td_skinshop[11], 0.000000, 0.000000 ) ;
	TextDrawTextSize(td_skinshop[11], 131.666763, 2.888971 ) ;
	TextDrawAlignment(td_skinshop[11], 1 ) ;
	TextDrawColor(td_skinshop[11], 606348543 ) ;
	TextDrawSetShadow(td_skinshop[11], 0 ) ;
	TextDrawSetOutline(td_skinshop[11], 0 ) ;
	TextDrawBackgroundColor(td_skinshop[11], 255 ) ;
	TextDrawFont(td_skinshop[11], 4 ) ;
	TextDrawSetProportional(td_skinshop[11], 0 ) ;
	TextDrawSetShadow(td_skinshop[11], 0 ) ;

	td_skinshop[12] = TextDrawCreate(288.000000, 380.000000, "LD_SPAC:white" ) ;
	TextDrawBackgroundColor(td_skinshop[12], 0 ) ;
	TextDrawFont(td_skinshop[12], 4 ) ;
	TextDrawLetterSize(td_skinshop[12], 0.500000, 1.000000 ) ;
	TextDrawColor(td_skinshop[12], 269488128 ) ;
	TextDrawSetOutline(td_skinshop[12], 0 ) ;
	TextDrawSetProportional(td_skinshop[12], 1 ) ;
	TextDrawSetShadow(td_skinshop[12], 1 ) ;
	TextDrawUseBox(td_skinshop[12], 1 ) ;
	TextDrawBoxColor(td_skinshop[12], 269488144 ) ;
	TextDrawTextSize(td_skinshop[12], 65.000000, 22.000000 ) ;
	TextDrawSetSelectable(td_skinshop[12], 0 ) ;

	td_skinshop[13] = TextDrawCreate(290.000000, 384.000000, "LD_SPAC:white" ) ;
	TextDrawBackgroundColor(td_skinshop[13], 0 ) ;
	TextDrawFont(td_skinshop[13], 4 ) ;
	TextDrawLetterSize(td_skinshop[13], 0.500000, 1.000000 ) ;
	TextDrawColor(td_skinshop[13], 606348543 ) ;
	TextDrawSetOutline(td_skinshop[13], 0 ) ;
	TextDrawSetProportional(td_skinshop[13], 1 ) ;
	TextDrawSetShadow(td_skinshop[13], 1 ) ;
	TextDrawUseBox(td_skinshop[13], 1 ) ;
	TextDrawBoxColor(td_skinshop[13], 255 ) ;
	TextDrawTextSize(td_skinshop[13], 61.000000, 15.000000 ) ;
	TextDrawSetSelectable(td_skinshop[13], 1 ) ;

	td_skinshop[14] = TextDrawCreate(290.000000, 397.000000, "LD_SPAC:white" ) ;
	TextDrawBackgroundColor(td_skinshop[14], 0 ) ;
	TextDrawFont(td_skinshop[14], 4 ) ;
	TextDrawLetterSize(td_skinshop[14], 0.500000, 1.000000 ) ;
	TextDrawColor(td_skinshop[14], 557867519 ) ;
	TextDrawSetOutline(td_skinshop[14], 0 ) ;
	TextDrawSetProportional(td_skinshop[14], 1 ) ;
	TextDrawSetShadow(td_skinshop[14], 1 ) ;
	TextDrawUseBox(td_skinshop[14], 1 ) ;
	TextDrawBoxColor(td_skinshop[14], 255 ) ;
	TextDrawTextSize(td_skinshop[14], 61.000000, 2.000000 ) ;
	TextDrawSetSelectable(td_skinshop[14], 0 ) ;

	td_skinshop[15] = TextDrawCreate(321.000000, 385.000000, "EXIT" ) ;
	TextDrawAlignment(td_skinshop[15], 2 ) ;
	TextDrawBackgroundColor(td_skinshop[15], -1 ) ;
	TextDrawFont(td_skinshop[15], 1 ) ;
	TextDrawLetterSize(td_skinshop[15], 0.267082, 1.040001 ) ;
	TextDrawColor(td_skinshop[15], -1 ) ;
	TextDrawSetOutline(td_skinshop[15], 0 ) ;
	TextDrawSetProportional(td_skinshop[15], 1 ) ;
	TextDrawSetShadow(td_skinshop[15], 0 ) ;
	TextDrawSetSelectable(td_skinshop[15], 0 ) ;
	
	td_skinshop[16] = TextDrawCreate(288.000000, 332.000000, "LD_SPAC:white" ) ;
	TextDrawBackgroundColor(td_skinshop[16], 0 ) ;
	TextDrawFont(td_skinshop[16], 4 ) ;
	TextDrawLetterSize(td_skinshop[16], 0.500000, 1.000000 ) ;
	TextDrawColor(td_skinshop[16], 269488128 ) ;
	TextDrawSetOutline(td_skinshop[16], 0 ) ;
	TextDrawSetProportional(td_skinshop[16], 1 ) ;
	TextDrawSetShadow(td_skinshop[16], 1 ) ;
	TextDrawUseBox(td_skinshop[16], 1 ) ;
	TextDrawBoxColor(td_skinshop[16], 269488144 ) ;
	TextDrawTextSize(td_skinshop[16], 65.000000, 22.000000 ) ;
	TextDrawSetSelectable(td_skinshop[16], 0 ) ;

	td_skinshop[17] = TextDrawCreate(288.000000, 335.000000, "LD_SPAC:white" ) ;
	TextDrawBackgroundColor(td_skinshop[17], 0 ) ;
	TextDrawFont(td_skinshop[17], 4 ) ;
	TextDrawLetterSize(td_skinshop[17], 0.500000, 1.000000 ) ;
	TextDrawColor(td_skinshop[17], 606348543 ) ;
	TextDrawSetOutline(td_skinshop[17], 0 ) ;
	TextDrawSetProportional(td_skinshop[17], 1 ) ;
	TextDrawSetShadow(td_skinshop[17], 1 ) ;
	TextDrawUseBox(td_skinshop[17], 1 ) ;
	TextDrawBoxColor(td_skinshop[17], 255 ) ;
	TextDrawTextSize(td_skinshop[17], 65.000000, 3.000000 ) ;
	TextDrawSetSelectable(td_skinshop[17], 0 ) ;

	td_skinshop[18] = TextDrawCreate(288.000000, 337.000000, "LD_SPAC:white" ) ;
	TextDrawBackgroundColor(td_skinshop[18], 0 ) ;
	TextDrawFont(td_skinshop[18], 4 ) ;
	TextDrawLetterSize(td_skinshop[18], 0.500000, 1.000000 ) ;
	TextDrawColor(td_skinshop[18], 557867519 ) ;
	TextDrawSetOutline(td_skinshop[18], 0 ) ;
	TextDrawSetProportional(td_skinshop[18], 1 ) ;
	TextDrawSetShadow(td_skinshop[18], 1 ) ;
	TextDrawUseBox(td_skinshop[18], 1 ) ;
	TextDrawBoxColor(td_skinshop[18], 255 ) ;
	TextDrawTextSize(td_skinshop[18], 65.000000, 1.000000 ) ;
	TextDrawSetSelectable(td_skinshop[18], 0 ) ;	
	
	/*
		filling
	*/
	
	filling_td[0] = TextDrawCreate(403.750000, 337.000030, "LD_SPAC:white" ) ;
	TextDrawLetterSize(filling_td[0], 0.000000, 0.000000 ) ;
	TextDrawTextSize(filling_td[0], 18.749959, 12.740736 ) ;
	TextDrawAlignment(filling_td[0], 1 ) ;
	TextDrawColor(filling_td[0], 522133503 ) ;
	TextDrawSetShadow(filling_td[0], 0 ) ;
	TextDrawSetOutline(filling_td[0], 0 ) ;
	TextDrawBackgroundColor(filling_td[0], 255 ) ;
	TextDrawFont(filling_td[0], 4 ) ;
	TextDrawSetProportional(filling_td[0], 0 ) ;
	TextDrawSetShadow(filling_td[0], 0 ) ;
	TextDrawSetSelectable(filling_td[0], true ) ;

	filling_td[1] = TextDrawCreate(412.916717, 337.777740, "+" ) ;
	TextDrawLetterSize(filling_td[1], 0.280833, 1.216295 ) ;
	TextDrawAlignment(filling_td[1], 2 ) ;
	TextDrawColor(filling_td[1], -1 ) ;
	TextDrawSetShadow(filling_td[1], 0 ) ;
	TextDrawSetOutline(filling_td[1], 0 ) ;
	TextDrawBackgroundColor(filling_td[1], 255 ) ;
	TextDrawFont(filling_td[1], 1 ) ;
	TextDrawSetProportional(filling_td[1], 1 ) ;
	TextDrawSetShadow(filling_td[1], 0 ) ;

	filling_td[2] = TextDrawCreate(216.249954, 336.999969, "LD_SPAC:white" ) ;
	TextDrawLetterSize(filling_td[2], 0.000000, 0.000000 ) ;
	TextDrawTextSize(filling_td[2], 18.749959, 12.740736 ) ;
	TextDrawAlignment(filling_td[2], 1 ) ;
	TextDrawColor(filling_td[2], 522133503 ) ;
	TextDrawSetShadow(filling_td[2], 0 ) ;
	TextDrawSetOutline(filling_td[2], 0 ) ;
	TextDrawBackgroundColor(filling_td[2], 255 ) ;
	TextDrawFont(filling_td[2], 4 ) ;
	TextDrawSetProportional(filling_td[2], 0 ) ;
	TextDrawSetShadow(filling_td[2], 0 ) ;
	TextDrawSetSelectable(filling_td[2], true ) ;

	filling_td[3] = TextDrawCreate(225.416748, 336.740661, "-" ) ;
	TextDrawLetterSize(filling_td[3], 0.280833, 1.216295 ) ;
	TextDrawAlignment(filling_td[3], 2 ) ;
	TextDrawColor(filling_td[3], -1 ) ;
	TextDrawSetShadow(filling_td[3], 0 ) ;
	TextDrawSetOutline(filling_td[3], 0 ) ;
	TextDrawBackgroundColor(filling_td[3], 255 ) ;
	TextDrawFont(filling_td[3], 1 ) ;
	TextDrawSetProportional(filling_td[3], 1 ) ;
	TextDrawSetShadow(filling_td[3], 0 ) ;

	filling_td[4] = TextDrawCreate(292.500000, 352.037048, "LD_SPAC:white" ) ;
	TextDrawLetterSize(filling_td[4], 0.000000, 0.000000 ) ;
	TextDrawTextSize(filling_td[4], 52.916637, 12.740736 ) ;
	TextDrawAlignment(filling_td[4], 1 ) ;
	TextDrawColor(filling_td[4], 522133503 ) ;
	TextDrawSetShadow(filling_td[4], 0 ) ;
	TextDrawSetOutline(filling_td[4], 0 ) ;
	TextDrawBackgroundColor(filling_td[4], 255 ) ;
	TextDrawFont(filling_td[4], 4 ) ;
	TextDrawSetProportional(filling_td[4], 0 ) ;
	TextDrawSetShadow(filling_td[4], 0 ) ;
	TextDrawSetSelectable(filling_td[4], true ) ;

	filling_td[5] = TextDrawCreate(318.750091, 352.296264, "FILL" ) ;
	TextDrawLetterSize(filling_td[5], 0.280833, 1.216295 ) ;
	TextDrawAlignment(filling_td[5], 2 ) ;
	TextDrawColor(filling_td[5], -1 ) ;
	TextDrawSetShadow(filling_td[5], 0 ) ;
	TextDrawSetOutline(filling_td[5], 0 ) ;
	TextDrawBackgroundColor(filling_td[5], 255 ) ;
	TextDrawFont(filling_td[5], 1 ) ;
	TextDrawSetProportional(filling_td[5], 1 ) ;
	TextDrawSetShadow(filling_td[5], 0 ) ;
	
	filling_td [ 6 ] = TextDrawCreate ( 213.333236, 315.740783, "LD_SPAC:white" ) ;
	TextDrawLetterSize( filling_td [ 6 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize( filling_td [ 6 ], 211.666641, 52.666671 ) ;
	TextDrawAlignment( filling_td [ 6 ], 1 ) ;
	TextDrawColor( filling_td [ 6 ], 269488383 ) ;
	TextDrawSetShadow( filling_td [ 6 ], 0 ) ;
	TextDrawSetOutline( filling_td [ 6 ], 0 ) ;
	TextDrawBackgroundColor( filling_td [ 6 ], 255 ) ;
	TextDrawFont( filling_td [ 6 ], 4 ) ;
	TextDrawSetProportional( filling_td [ 6 ], 0 ) ;
	TextDrawSetShadow( filling_td [ 6 ], 0 ) ;

	filling_td [ 7 ] = TextDrawCreate ( 236.666671, 337.000091, "LD_SPAC:white" ) ;
	TextDrawLetterSize( filling_td [ 7 ], 0.000000, 0.000000 ) ;
	TextDrawTextSize( filling_td [ 7 ], 165.416595, 12.740736 ) ;
	TextDrawAlignment( filling_td [ 7 ], 1 ) ;
	TextDrawColor( filling_td [ 7 ], 522133503 ) ;
	TextDrawSetShadow( filling_td [ 7 ], 0 ) ;
	TextDrawSetOutline( filling_td [ 7 ], 0 ) ;
	TextDrawBackgroundColor( filling_td [ 7 ], 255 ) ;
	TextDrawFont( filling_td [ 7 ], 4 ) ;
	TextDrawSetProportional( filling_td [ 7 ], 0 ) ;
	TextDrawSetShadow( filling_td [ 7 ], 0 ) ;
	
	// server . logo
	

	// slot machine
	
	sm_td [ 0 ] = TextDrawCreate ( 276.000000, 355.000000, "    SET" ) ;
	TextDrawBackgroundColor ( sm_td [ 0 ], 255 ) ;
	TextDrawFont ( sm_td [ 0 ], 2 ) ;
	TextDrawLetterSize ( sm_td [ 0 ], 0.419999, 2.099999 ) ;
	TextDrawColor ( sm_td [ 0 ], -2711041 ) ;
	TextDrawSetOutline ( sm_td [ 0 ], 0 ) ;
	TextDrawSetProportional ( sm_td [ 0 ], 1 ) ;
	TextDrawSetShadow ( sm_td [ 0 ], 1 ) ;
	TextDrawBoxColor ( sm_td [ 0 ], 255 ) ;
	TextDrawTextSize ( sm_td [ 0 ], 336.000000, 12.000000 ) ;
	TextDrawSetSelectable ( sm_td [ 0 ], 1 ) ;

	sm_td [ 1 ] = TextDrawCreate ( 375.000000, 355.000000, " RESET" ) ;
	TextDrawBackgroundColor ( sm_td [ 1 ], 255 ) ;
	TextDrawFont ( sm_td [ 1 ], 2 ) ;
	TextDrawLetterSize ( sm_td [ 1 ], 0.419999, 2.099999 ) ;
	TextDrawColor ( sm_td [ 1 ], -2711041 ) ;
	TextDrawSetOutline ( sm_td [ 1 ], 0 ) ;
	TextDrawSetProportional ( sm_td [ 1 ], 1 ) ;
	TextDrawSetShadow ( sm_td [ 1 ], 1 ) ;
	TextDrawBoxColor ( sm_td [ 1 ], 255 ) ;
	TextDrawTextSize ( sm_td [ 1 ], 436.000000, 12.000000 ) ;
	TextDrawSetSelectable ( sm_td [ 1 ], 1 ) ;

	sm_td [ 2 ] = TextDrawCreate ( 182.000000, 355.000000, "   ~r~Exit" ) ;
	TextDrawBackgroundColor ( sm_td [ 2 ], 255 ) ;
	TextDrawFont ( sm_td [ 2 ], 2 ) ;
	TextDrawLetterSize ( sm_td [ 2 ], 0.419999, 2.099999 ) ;
	TextDrawColor ( sm_td [ 2 ], -2711041 ) ;
	TextDrawSetOutline ( sm_td [ 2 ], 0 ) ;
	TextDrawSetProportional ( sm_td [ 2 ], 1 ) ;
	TextDrawSetShadow ( sm_td [ 2 ], 1 ) ;
	TextDrawBoxColor ( sm_td [ 2 ], 255 ) ;
	TextDrawTextSize ( sm_td [ 2 ], 244.000000, 12.000000 ) ;
	TextDrawSetSelectable ( sm_td [ 2 ], 1 ) ;

	sm_td [ 3 ] = TextDrawCreate (  482.000000, 355.000000, " ~g~PLAY" ) ;
	TextDrawBackgroundColor ( sm_td [ 3 ], 255 ) ;
	TextDrawFont ( sm_td [ 3 ], 2 ) ;
	TextDrawLetterSize ( sm_td [ 3 ], 0.419999, 2.099999 ) ;
	TextDrawColor ( sm_td [ 3 ], -2711041 ) ;
	TextDrawSetOutline ( sm_td [ 3 ], 0 ) ;
	TextDrawSetProportional ( sm_td [ 3 ], 1 ) ;
	TextDrawSetShadow ( sm_td [ 3 ], 1 ) ;
	TextDrawBoxColor ( sm_td [ 3 ], 255 ) ;
	TextDrawTextSize ( sm_td [ 3 ], 544.000000, 12.000000 ) ;
	TextDrawSetSelectable ( sm_td [ 3 ], 1 ) ;

	// capture

	capture_td [0] = TextDrawCreate(28.749984, 189.859329, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [0], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [0], 121.666656, 52.666679 ) ;
	TextDrawAlignment(capture_td [0], 1 ) ;
	TextDrawColor(capture_td [0], 269488383 ) ;
	TextDrawSetShadow(capture_td [0], 0 ) ;
	TextDrawSetOutline(capture_td [0], 0 ) ;
	TextDrawBackgroundColor(capture_td [0], 255 ) ;
	TextDrawFont(capture_td [0], 4 ) ;
	TextDrawSetProportional(capture_td [0], 0 ) ;
	TextDrawSetShadow(capture_td [0], 0 ) ;

	capture_td [1] = TextDrawCreate(27.499990, 188.185226, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [1], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [1], 124.999984, 12.740736 ) ;
	TextDrawAlignment(capture_td [1], 1 ) ;
	TextDrawColor(capture_td [1], 606348543 ) ;
	TextDrawSetShadow(capture_td [1], 0 ) ;
	TextDrawSetOutline(capture_td [1], 0 ) ;
	TextDrawBackgroundColor(capture_td [1], 255 ) ;
	TextDrawFont(capture_td [1], 4 ) ;
	TextDrawSetProportional(capture_td [1], 0 ) ;
	TextDrawSetShadow(capture_td [1], 0 ) ;

	capture_td [2] = TextDrawCreate(27.500000, 200.111099, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [2], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [2], 2.499978, 43.851783 ) ;
	TextDrawAlignment(capture_td [2], 1 ) ;
	TextDrawColor(capture_td [2], 606348543 ) ;
	TextDrawSetShadow(capture_td [2], 0 ) ;
	TextDrawSetOutline(capture_td [2], 0 ) ;
	TextDrawBackgroundColor(capture_td [2], 255 ) ;
	TextDrawFont(capture_td [2], 4 ) ;
	TextDrawSetProportional(capture_td [2], 0 ) ;
	TextDrawSetShadow(capture_td [2], 0 ) ;

	capture_td [3] = TextDrawCreate(150.000015, 200.629684, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [3], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [3], 2.499978, 42.814769 ) ;
	TextDrawAlignment(capture_td [3], 1 ) ;
	TextDrawColor(capture_td [3], 606348543 ) ;
	TextDrawSetShadow(capture_td [3], 0 ) ;
	TextDrawSetOutline(capture_td [3], 0 ) ;
	TextDrawBackgroundColor(capture_td [3], 255 ) ;
	TextDrawFont(capture_td [3], 4 ) ;
	TextDrawSetProportional(capture_td [3], 0 ) ;
	TextDrawSetShadow(capture_td [3], 0 ) ;

	capture_td [4] = TextDrawCreate(27.916664, 241.073867, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [4], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [4], 124.999938, 2.888833 ) ;
	TextDrawAlignment(capture_td [4], 1 ) ;
	TextDrawColor(capture_td [4], 606348543 ) ;
	TextDrawSetShadow(capture_td [4], 0 ) ;
	TextDrawSetOutline(capture_td [4], 0 ) ;
	TextDrawBackgroundColor(capture_td [4], 255 ) ;
	TextDrawFont(capture_td [4], 4 ) ;
	TextDrawSetProportional(capture_td [4], 0 ) ;
	TextDrawSetShadow(capture_td [4], 0 ) ;

	capture_td [5] = TextDrawCreate(89.583297, 190.518600, "CAPTURE_TIME:_2:28" ) ;
	TextDrawLetterSize(capture_td [5], 0.200828, 0.925924 ) ;
	TextDrawAlignment(capture_td [5], 2 ) ;
	TextDrawColor(capture_td [5], -1 ) ;
	TextDrawSetShadow(capture_td [5], 0 ) ;
	TextDrawSetOutline(capture_td [5], 0 ) ;
	TextDrawBackgroundColor(capture_td [5], 255 ) ;
	TextDrawFont(capture_td [5], 1 ) ;
	TextDrawSetProportional(capture_td [5], 1 ) ;
	TextDrawSetShadow(capture_td [5], 0 ) ;

	capture_td [6] = TextDrawCreate(34.166622, 206.851898, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [6], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [6], 85.416732, 13.259243 ) ;
	TextDrawAlignment(capture_td [6], 1 ) ;
	TextDrawColor(capture_td [6], 522133503 ) ;
	TextDrawSetShadow(capture_td [6], 0 ) ;
	TextDrawSetOutline(capture_td [6], 0 ) ;
	TextDrawBackgroundColor(capture_td [6], 255 ) ;
	TextDrawFont(capture_td [6], 4 ) ;
	TextDrawSetProportional(capture_td [6], 0 ) ;
	TextDrawSetShadow(capture_td [6], 0 ) ;

	capture_td [7] = TextDrawCreate(34.166622, 222.926025, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [7], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [7], 85.416732, 13.259243 ) ;
	TextDrawAlignment(capture_td [7], 1 ) ;
	TextDrawColor(capture_td [7], 522133503 ) ;
	TextDrawSetShadow(capture_td [7], 0 ) ;
	TextDrawSetOutline(capture_td [7], 0 ) ;
	TextDrawBackgroundColor(capture_td [7], 255 ) ;
	TextDrawFont(capture_td [7], 4 ) ;
	TextDrawSetProportional(capture_td [7], 0 ) ;
	TextDrawSetShadow(capture_td [7], 0 ) ;

	capture_td [8] = TextDrawCreate(121.666618, 206.851882, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [8], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [8], 23.750068, 13.259243 ) ;
	TextDrawAlignment(capture_td [8], 1 ) ;
	TextDrawColor(capture_td [8], 522133503 ) ;
	TextDrawSetShadow(capture_td [8], 0 ) ;
	TextDrawSetOutline(capture_td [8], 0 ) ;
	TextDrawBackgroundColor(capture_td [8], 255 ) ;
	TextDrawFont(capture_td [8], 4 ) ;
	TextDrawSetProportional(capture_td [8], 0 ) ;
	TextDrawSetShadow(capture_td [8], 0 ) ;

	capture_td [9] = TextDrawCreate(121.666610, 222.925964, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [9], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [9], 23.750068, 13.259243 ) ;
	TextDrawAlignment(capture_td [9], 1 ) ;
	TextDrawColor(capture_td [9], 522133503 ) ;
	TextDrawSetShadow(capture_td [9], 0 ) ;
	TextDrawSetOutline(capture_td [9], 0 ) ;
	TextDrawBackgroundColor(capture_td [9], 255 ) ;
	TextDrawFont(capture_td [9], 4 ) ;
	TextDrawSetProportional(capture_td [9], 0 ) ;
	TextDrawSetShadow(capture_td [9], 0 ) ;

	capture_td [10] = TextDrawCreate(34.166622, 206.851898, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [10], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [10], 2.083405, 13.259244 ) ;
	TextDrawAlignment(capture_td [10], 1 ) ;
	TextDrawColor(capture_td [10], -5963521 ) ;
	TextDrawSetShadow(capture_td [10], 0 ) ;
	TextDrawSetOutline(capture_td [10], 0 ) ;
	TextDrawBackgroundColor(capture_td [10], 255 ) ;
	TextDrawFont(capture_td [10], 4 ) ;
	TextDrawSetProportional(capture_td [10], 0 ) ;
	TextDrawSetShadow(capture_td [10], 0 ) ;

	capture_td [11] = TextDrawCreate(122.083328, 206.851882, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [11], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [11], 2.083405, 13.259244 ) ;
	TextDrawAlignment(capture_td [11], 1 ) ;
	TextDrawColor(capture_td [11], -5963521 ) ;
	TextDrawSetShadow(capture_td [11], 0 ) ;
	TextDrawSetOutline(capture_td [11], 0 ) ;
	TextDrawBackgroundColor(capture_td [11], 255 ) ;
	TextDrawFont(capture_td [11], 4 ) ;
	TextDrawSetProportional(capture_td [11], 0 ) ;
	TextDrawSetShadow(capture_td [11], 0 ) ;

	capture_td [12] = TextDrawCreate(34.166648, 222.925979, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [12], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [12], 2.083405, 13.259244 ) ;
	TextDrawAlignment(capture_td [12], 1 ) ;
	TextDrawColor(capture_td [12], 8388863 ) ;
	TextDrawSetShadow(capture_td [12], 0 ) ;
	TextDrawSetOutline(capture_td [12], 0 ) ;
	TextDrawBackgroundColor(capture_td [12], 255 ) ;
	TextDrawFont(capture_td [12], 4 ) ;
	TextDrawSetProportional(capture_td [12], 0 ) ;
	TextDrawSetShadow(capture_td [12], 0 ) ;

	capture_td [13] = TextDrawCreate(122.083328, 222.925949, "LD_SPAC:white" ) ;
	TextDrawLetterSize(capture_td [13], 0.000000, 0.000000 ) ;
	TextDrawTextSize(capture_td [13], 2.083405, 13.259244 ) ;
	TextDrawAlignment(capture_td [13], 1 ) ;
	TextDrawColor(capture_td [13], 8388863 ) ;
	TextDrawSetShadow(capture_td [13], 0 ) ;
	TextDrawSetOutline(capture_td [13], 0 ) ;
	TextDrawBackgroundColor(capture_td [13], 255 ) ;
	TextDrawFont(capture_td [13], 4 ) ;
	TextDrawSetProportional(capture_td [13], 0 ) ;
	TextDrawSetShadow(capture_td [13], 0 ) ;

	capture_td [14] = TextDrawCreate(77.916641, 209.703842, "LOS_SANTOS_VAGOS" ) ;
	TextDrawLetterSize(capture_td [14], 0.200828, 0.925924 ) ;
	TextDrawAlignment(capture_td [14], 2 ) ;
	TextDrawColor(capture_td [14], -1 ) ;
	TextDrawSetShadow(capture_td [14], 0 ) ;
	TextDrawSetOutline(capture_td [14], 0 ) ;
	TextDrawBackgroundColor(capture_td [14], 255 ) ;
	TextDrawFont(capture_td [14], 1 ) ;
	TextDrawSetProportional(capture_td [14], 1 ) ;
	TextDrawSetShadow(capture_td [14], 0 ) ;

	capture_td [15] = TextDrawCreate(77.916641, 225.259460, "GROVE_STREET" ) ;
	TextDrawLetterSize(capture_td [15], 0.200828, 0.925924 ) ;
	TextDrawAlignment(capture_td [15], 2 ) ;
	TextDrawColor(capture_td [15], -1 ) ;
	TextDrawSetShadow(capture_td [15], 0 ) ;
	TextDrawSetOutline(capture_td [15], 0 ) ;
	TextDrawBackgroundColor(capture_td [15], 255 ) ;
	TextDrawFont(capture_td [15], 1 ) ;
	TextDrawSetProportional(capture_td [15], 1 ) ;
	TextDrawSetShadow(capture_td [15], 0 ) ;

	capture_td [16] = TextDrawCreate(135.000000, 225.259445, "0" ) ;
	TextDrawLetterSize(capture_td [16], 0.200828, 0.925924 ) ;
	TextDrawAlignment(capture_td [16], 2 ) ;
	TextDrawColor(capture_td [16], -1 ) ;
	TextDrawSetShadow(capture_td [16], 0 ) ;
	TextDrawSetOutline(capture_td [16], 0 ) ;
	TextDrawBackgroundColor(capture_td [16], 255 ) ;
	TextDrawFont(capture_td [16], 1 ) ;
	TextDrawSetProportional(capture_td [16], 1 ) ;
	TextDrawSetShadow(capture_td [16], 0 ) ;

	capture_td [17] = TextDrawCreate(134.583404, 209.703887, "0" ) ;
	TextDrawLetterSize(capture_td [17], 0.200828, 0.925924 ) ;
	TextDrawAlignment(capture_td [17], 2 ) ;
	TextDrawColor(capture_td [17], -1 ) ;
	TextDrawSetShadow(capture_td [17], 0 ) ;
	TextDrawSetOutline(capture_td [17], 0 ) ;
	TextDrawBackgroundColor(capture_td [17], 255 ) ;
	TextDrawFont(capture_td [17], 1 ) ;
	TextDrawSetProportional(capture_td [17], 1 ) ;
	TextDrawSetShadow(capture_td [17], 0 ) ;

/*	capture_td[0] = TextDrawCreate(19.9999, 178.6443, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[0], 89.8793, 10.2500);
	TextDrawAlignment(capture_td[0], 1);
	TextDrawColor(capture_td[0], 0x388abaff);
	TextDrawBackgroundColor(capture_td[0], 255);
	TextDrawFont(capture_td[0], 4);
	TextDrawSetProportional(capture_td[0], 0);
	TextDrawSetShadow(capture_td[0], 0);

	capture_td[1] = TextDrawCreate(14.5333, 175.9259, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[1], 13.0000, 16.0000);
	TextDrawAlignment(capture_td[1], 1);
	TextDrawColor(capture_td[1], 0x388abaff);
	TextDrawBackgroundColor(capture_td[1], 255);
	TextDrawFont(capture_td[1], 4);
	TextDrawSetProportional(capture_td[1], 0);
	TextDrawSetShadow(capture_td[1], 0);

	capture_td[2] = TextDrawCreate(102.5322, 175.9259, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[2], 13.0000, 16.0000);
	TextDrawAlignment(capture_td[2], 1);
	TextDrawColor(capture_td[2], 0x388abaff);
	TextDrawBackgroundColor(capture_td[2], 255);
	TextDrawFont(capture_td[2], 4);
	TextDrawSetProportional(capture_td[2], 0);
	TextDrawSetShadow(capture_td[2], 0);

	capture_td[3] = TextDrawCreate(16.7332, 184.0370, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[3], 96.4400, 47.0000);
	TextDrawAlignment(capture_td[3], 1);
	TextDrawColor(capture_td[3], 623191551);
	TextDrawBackgroundColor(capture_td[3], 255);
	TextDrawFont(capture_td[3], 4);
	TextDrawSetProportional(capture_td[3], 0);
	TextDrawSetShadow(capture_td[3], 0);

	capture_td[4] = TextDrawCreate(102.3656, 223.5332, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[4], 13.0000, 16.0000);
	TextDrawAlignment(capture_td[4], 1);
	TextDrawColor(capture_td[4], 623191551);
	TextDrawBackgroundColor(capture_td[4], 255);
	TextDrawFont(capture_td[4], 4);
	TextDrawSetProportional(capture_td[4], 0);
	TextDrawSetShadow(capture_td[4], 0);

	capture_td[5] = TextDrawCreate(14.7665, 223.5332, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[5], 13.0000, 16.0000);
	TextDrawAlignment(capture_td[5], 1);
	TextDrawColor(capture_td[5], 623191551);
	TextDrawBackgroundColor(capture_td[5], 255);
	TextDrawFont(capture_td[5], 4);
	TextDrawSetProportional(capture_td[5], 0);
	TextDrawSetShadow(capture_td[5], 0);

	capture_td[6] = TextDrawCreate(20.3332, 230.9111, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[6], 89.0000, 6.0000);
	TextDrawAlignment(capture_td[6], 1);
	TextDrawColor(capture_td[6], 623191551);
	TextDrawBackgroundColor(capture_td[6], 255);
	TextDrawFont(capture_td[6], 4);
	TextDrawSetProportional(capture_td[6], 0);
	TextDrawSetShadow(capture_td[6], 0);

	capture_td[7] = TextDrawCreate(22.3332, 190.6741, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[7], 85.1800, 12.0000);
	TextDrawAlignment(capture_td[7], 1);
	TextDrawColor(capture_td[7], 0x388abaff);
	TextDrawBackgroundColor(capture_td[7], 255);
	TextDrawFont(capture_td[7], 4);
	TextDrawSetProportional(capture_td[7], 0);
	TextDrawSetShadow(capture_td[7], 0);

	capture_td[8] = TextDrawCreate(22.3332, 205.8750, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[8], 85.1800, 12.0000);
	TextDrawAlignment(capture_td[8], 1);
	TextDrawColor(capture_td[8], 0x388abaff);
	TextDrawBackgroundColor(capture_td[8], 255);
	TextDrawFont(capture_td[8], 4);
	TextDrawSetProportional(capture_td[8], 0);
	TextDrawSetShadow(capture_td[8], 0);

	capture_td[9] = TextDrawCreate(22.5333, 191.1741, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[9], 84.6499, 11.0099);
	TextDrawAlignment(capture_td[9], 1);
	TextDrawColor(capture_td[9], 623191551);
	TextDrawBackgroundColor(capture_td[9], 255);
	TextDrawFont(capture_td[9], 4);
	TextDrawSetProportional(capture_td[9], 0);
	TextDrawSetShadow(capture_td[9], 0);

	capture_td[10] = TextDrawCreate(22.5333, 206.3750, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[10], 84.6499, 11.0099);
	TextDrawAlignment(capture_td[10], 1);
	TextDrawColor(capture_td[10], 623191551);
	TextDrawBackgroundColor(capture_td[10], 255);
	TextDrawFont(capture_td[10], 4);
	TextDrawSetProportional(capture_td[10], 0);
	TextDrawSetShadow(capture_td[10], 0);

	capture_td[11] = TextDrawCreate(48.7999, 221.3703, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[11], 34.0000, 12.0000);
	TextDrawAlignment(capture_td[11], 1);
	TextDrawColor(capture_td[11], 0x388abaff);
	TextDrawBackgroundColor(capture_td[11], 255);
	TextDrawFont(capture_td[11], 4);
	TextDrawSetProportional(capture_td[11], 0);
	TextDrawSetShadow(capture_td[11], 0);

	capture_td[12] = TextDrawCreate(76.0668, 218.3701, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[12], 15.0000, 18.0000);
	TextDrawAlignment(capture_td[12], 1);
	TextDrawColor(capture_td[12], 0x388abaff);
	TextDrawBackgroundColor(capture_td[12], 255);
	TextDrawFont(capture_td[12], 4);
	TextDrawSetProportional(capture_td[12], 0);
	TextDrawSetShadow(capture_td[12], 0);

	capture_td[13] = TextDrawCreate(40.9673, 218.3701, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[13], 15.0000, 18.0000);
	TextDrawAlignment(capture_td[13], 1);
	TextDrawColor(capture_td[13], 0x388abaff);
	TextDrawBackgroundColor(capture_td[13], 255);
	TextDrawFont(capture_td[13], 4);
	TextDrawSetProportional(capture_td[13], 0);
	TextDrawSetShadow(capture_td[13], 0);

	capture_td[14] = TextDrawCreate(41.7672, 219.0702, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[14], 13.5398, 16.5998);
	TextDrawAlignment(capture_td[14], 1);
	TextDrawColor(capture_td[14], 623191551);
	TextDrawBackgroundColor(capture_td[14], 255);
	TextDrawFont(capture_td[14], 4);
	TextDrawSetProportional(capture_td[14], 0);
	TextDrawSetShadow(capture_td[14], 0);

	capture_td[15] = TextDrawCreate(76.6668, 219.0702, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[15], 13.5398, 16.5998);
	TextDrawAlignment(capture_td[15], 1);
	TextDrawColor(capture_td[15], 623191551);
	TextDrawBackgroundColor(capture_td[15], 255);
	TextDrawFont(capture_td[15], 4);
	TextDrawSetProportional(capture_td[15], 0);
	TextDrawSetShadow(capture_td[15], 0);

	capture_td[16] = TextDrawCreate(49.6665, 221.7295, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(capture_td[16], 32.9399, 11.0799);
	TextDrawAlignment(capture_td[16], 1);
	TextDrawColor(capture_td[16], 623191551);
	TextDrawBackgroundColor(capture_td[16], 255);
	TextDrawFont(capture_td[16], 4);
	TextDrawSetProportional(capture_td[16], 0);
	TextDrawSetShadow(capture_td[16], 0);

	capture_td[17] = TextDrawCreate(24.3332, 193.1629, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[17], 6.0000, 7.0000);
	TextDrawAlignment(capture_td[17], 1);
	TextDrawColor(capture_td[17], 8388863);
	TextDrawBackgroundColor(capture_td[17], 255);
	TextDrawFont(capture_td[17], 4);
	TextDrawSetProportional(capture_td[17], 0);
	TextDrawSetShadow(capture_td[17], 0);

	capture_td[18] = TextDrawCreate(24.3332, 208.5639, "LD_BEAT:CHIT"); // عنصر
	TextDrawTextSize(capture_td[18], 6.0000, 7.0000);
	TextDrawAlignment(capture_td[18], 1);
	TextDrawColor(capture_td[18], -16711681);
	TextDrawBackgroundColor(capture_td[18], 255);
	TextDrawFont(capture_td[18], 4);
	TextDrawSetProportional(capture_td[18], 0);
	TextDrawSetShadow(capture_td[18], 0);

	capture_td[19] = TextDrawCreate(33.0001, 192.1148, "groove_street"); // عنصر
	TextDrawLetterSize(capture_td[19], 0.1212, 0.8698);
	TextDrawAlignment(capture_td[19], 1);
	TextDrawColor(capture_td[19], -1);
	TextDrawBackgroundColor(capture_td[19], 255);
	TextDrawFont(capture_td[19], 2);
	TextDrawSetProportional(capture_td[19], 1);
	TextDrawSetShadow(capture_td[19], 0);

	capture_td[20] = TextDrawCreate(33.0001, 207.5158, "ballas_gang"); // عنصر
	TextDrawLetterSize(capture_td[20], 0.1212, 0.8698);
	TextDrawAlignment(capture_td[20], 1);
	TextDrawColor(capture_td[20], -1);
	TextDrawBackgroundColor(capture_td[20], 255);
	TextDrawFont(capture_td[20], 2);
	TextDrawSetProportional(capture_td[20], 1);
	TextDrawSetShadow(capture_td[20], 0);

	capture_td[21] = TextDrawCreate(58.2997, 222.9167, "00:00"); // عنصر
	TextDrawLetterSize(capture_td[21], 0.1212, 0.8698);
	TextDrawAlignment(capture_td[21], 1);
	TextDrawColor(capture_td[21], -1);
	TextDrawBackgroundColor(capture_td[21], 255);
	TextDrawFont(capture_td[21], 2);
	TextDrawSetProportional(capture_td[21], 1);
	TextDrawSetShadow(capture_td[21], 0);

	capture_td[22] = TextDrawCreate(93.5663, 192.2149, "00"); // عنصر
	TextDrawLetterSize(capture_td[22], 0.1212, 0.8698);
	TextDrawAlignment(capture_td[22], 1);
	TextDrawColor(capture_td[22], -1);
	TextDrawBackgroundColor(capture_td[22], 255);
	TextDrawFont(capture_td[22], 2);
	TextDrawSetProportional(capture_td[22], 1);
	TextDrawSetShadow(capture_td[22], 0);

	capture_td[23] = TextDrawCreate(93.5663, 207.6158, "00"); // عنصر
	TextDrawLetterSize(capture_td[23], 0.1212, 0.8698);
	TextDrawAlignment(capture_td[23], 1);
	TextDrawColor(capture_td[23], -1);
	TextDrawBackgroundColor(capture_td[23], 255);
	TextDrawFont(capture_td[23], 2);
	TextDrawSetProportional(capture_td[23], 1);
	TextDrawSetShadow(capture_td[23], 0);*/


/*	دفع */
	

	
/*	payment */
	payment_td[0] = TextDrawCreate(17.4999, 188.1851, "LD_SPAC:white"); // عنصر
	TextDrawTextSize(payment_td[0], 73.9069, 17.0000);
	TextDrawAlignment(payment_td[0], 1);
	TextDrawColor(payment_td[0], 255);
	TextDrawBackgroundColor(payment_td[0], 255);
	TextDrawFont(payment_td[0], 4);
	TextDrawSetProportional(payment_td[0], 0);
	TextDrawSetShadow(payment_td[0], 0);

	payment_td[1] = TextDrawCreate(3.9674, 184.2924, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(payment_td[1], 23.5000, 24.7098);
	TextDrawAlignment(payment_td[1], 1);
	TextDrawColor(payment_td[1], 1119719167);
	TextDrawBackgroundColor(payment_td[1], 255);
	TextDrawFont(payment_td[1], 4);
	TextDrawSetProportional(payment_td[1], 0);
	TextDrawSetShadow(payment_td[1], 0);

	payment_td[2] = TextDrawCreate(78.6669, 184.0923, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(payment_td[2], 25.0000, 25.1600);
	TextDrawAlignment(payment_td[2], 1);
	TextDrawColor(payment_td[2], 255);
	TextDrawBackgroundColor(payment_td[2], 255);
	TextDrawFont(payment_td[2], 4);
	TextDrawSetProportional(payment_td[2], 0);
	TextDrawSetShadow(payment_td[2], 0);

	payment_td[3] = TextDrawCreate(5.6673, 184.3925, "LD_BEAT:chit"); // عنصر
	TextDrawTextSize(payment_td[3], 23.5000, 24.7098);
	TextDrawAlignment(payment_td[3], 1);
	TextDrawColor(payment_td[3], 255);
	TextDrawBackgroundColor(payment_td[3], 255);
	TextDrawFont(payment_td[3], 4);
	TextDrawSetProportional(payment_td[3], 0);
	TextDrawSetShadow(payment_td[3], 0);
	
	
/* accessories */
	acc_td[0] = TextDrawCreate(205.705612, 360.916717, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[0], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[0], 210.941406, 32.249931);
	TextDrawAlignment(acc_td[0], 1);
	TextDrawColor(acc_td[0], 269488383);
	TextDrawSetShadow(acc_td[0], 0);
	TextDrawSetOutline(acc_td[0], 0);
	TextDrawBackgroundColor(acc_td[0], 255);
	TextDrawFont(acc_td[0], 4);
	TextDrawSetProportional(acc_td[0], 0);
	TextDrawSetShadow(acc_td[0], 0);

	acc_td[1] = TextDrawCreate(208.058853, 364.416992, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[1], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[1], 205.764755, 11.833348);
	TextDrawAlignment(acc_td[1], 1);
	TextDrawColor(acc_td[1], 522133503);
	TextDrawSetShadow(acc_td[1], 0);
	TextDrawSetOutline(acc_td[1], 0);
	TextDrawBackgroundColor(acc_td[1], 255);
	TextDrawFont(acc_td[1], 4);
	TextDrawSetProportional(acc_td[1], 0);
	TextDrawSetShadow(acc_td[1], 0);

	acc_td[2] = TextDrawCreate(208.058883, 378.416656, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[2], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[2], 67.411628, 11.833349);
	TextDrawAlignment(acc_td[2], 1);
	TextDrawColor(acc_td[2], 709983487);
	TextDrawSetShadow(acc_td[2], 0);
	TextDrawSetOutline(acc_td[2], 0);
	TextDrawBackgroundColor(acc_td[2], 255);
	TextDrawFont(acc_td[2], 4);
	TextDrawSetProportional(acc_td[2], 0);
	TextDrawSetShadow(acc_td[2], 0);
	TextDrawSetSelectable(acc_td[2], true);

	acc_td[3] = TextDrawCreate(277.235412, 378.416717, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[3], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[3], 67.411628, 11.833349);
	TextDrawAlignment(acc_td[3], 1);
	TextDrawColor(acc_td[3], 709983487);
	TextDrawSetShadow(acc_td[3], 0);
	TextDrawSetOutline(acc_td[3], 0);
	TextDrawBackgroundColor(acc_td[3], 255);
	TextDrawFont(acc_td[3], 4);
	TextDrawSetProportional(acc_td[3], 0);
	TextDrawSetShadow(acc_td[3], 0);
	TextDrawSetSelectable(acc_td[3], true);

	acc_td[4] = TextDrawCreate(346.412017, 378.416717, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[4], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[4], 67.411628, 11.833349);
	TextDrawAlignment(acc_td[4], 1);
	TextDrawColor(acc_td[4], 709983487);
	TextDrawSetShadow(acc_td[4], 0);
	TextDrawSetOutline(acc_td[4], 0);
	TextDrawBackgroundColor(acc_td[4], 255);
	TextDrawFont(acc_td[4], 4);
	TextDrawSetProportional(acc_td[4], 0);
	TextDrawSetShadow(acc_td[4], 0);
	TextDrawSetSelectable(acc_td[4], true);

	acc_td[5] = TextDrawCreate(208.058868, 387.167053, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[5], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[5], 67.411766, 3.083348);
	TextDrawAlignment(acc_td[5], 1);
	TextDrawColor(acc_td[5], 557867519);
	TextDrawSetShadow(acc_td[5], 0);
	TextDrawSetOutline(acc_td[5], 0);
	TextDrawBackgroundColor(acc_td[5], 255);
	TextDrawFont(acc_td[5], 4);
	TextDrawSetProportional(acc_td[5], 0);
	TextDrawSetShadow(acc_td[5], 0);

	acc_td[6] = TextDrawCreate(223.647171, 379.000091, "PREVIOUS");
	TextDrawLetterSize(acc_td[6], 0.228705, 0.777499);
	TextDrawAlignment(acc_td[6], 1);
	TextDrawColor(acc_td[6], -1);
	TextDrawSetShadow(acc_td[6], 0);
	TextDrawSetOutline(acc_td[6], 0);
	TextDrawBackgroundColor(acc_td[6], 255);
	TextDrawFont(acc_td[6], 1);
	TextDrawSetProportional(acc_td[6], 1);
	TextDrawSetShadow(acc_td[6], 0);

	acc_td[7] = TextDrawCreate(277.235412, 387.166992, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[7], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[7], 67.411766, 3.083348);
	TextDrawAlignment(acc_td[7], 1);
	TextDrawColor(acc_td[7], 557867519);
	TextDrawSetShadow(acc_td[7], 0);
	TextDrawSetOutline(acc_td[7], 0);
	TextDrawBackgroundColor(acc_td[7], 255);
	TextDrawFont(acc_td[7], 4);
	TextDrawSetProportional(acc_td[7], 0);
	TextDrawSetShadow(acc_td[7], 0);

	acc_td[8] = TextDrawCreate(346.411987, 387.167053, "LD_SPAC:white");
	TextDrawLetterSize(acc_td[8], 0.000000, 0.000000);
	TextDrawTextSize(acc_td[8], 67.411766, 3.083348);
	TextDrawAlignment(acc_td[8], 1);
	TextDrawColor(acc_td[8], 557867519);
	TextDrawSetShadow(acc_td[8], 0);
	TextDrawSetOutline(acc_td[8], 0);
	TextDrawBackgroundColor(acc_td[8], 255);
	TextDrawFont(acc_td[8], 4);
	TextDrawSetProportional(acc_td[8], 0);
	TextDrawSetShadow(acc_td[8], 0);

	acc_td[9] = TextDrawCreate(297.999969, 379.000122, "SELECT");
	TextDrawLetterSize(acc_td[9], 0.228705, 0.777499);
	TextDrawAlignment(acc_td[9], 1);
	TextDrawColor(acc_td[9], -1);
	TextDrawSetShadow(acc_td[9], 0);
	TextDrawSetOutline(acc_td[9], 0);
	TextDrawBackgroundColor(acc_td[9], 255);
	TextDrawFont(acc_td[9], 1);
	TextDrawSetProportional(acc_td[9], 1);
	TextDrawSetShadow(acc_td[9], 0);

	acc_td[10] = TextDrawCreate(371.411499, 379.000213, "NEXT");
	TextDrawLetterSize(acc_td[10], 0.228705, 0.777499);
	TextDrawAlignment(acc_td[10], 1);
	TextDrawColor(acc_td[10], -1);
	TextDrawSetShadow(acc_td[10], 0);
	TextDrawSetOutline(acc_td[10], 0);
	TextDrawBackgroundColor(acc_td[10], 255);
	TextDrawFont(acc_td[10], 1);
	TextDrawSetProportional(acc_td[10], 1);
	TextDrawSetShadow(acc_td[10], 0);	
	
	forklift_td = TextDrawCreate(526.250244, 148.259277, ""); 
	TextDrawLetterSize(forklift_td, 0.000000, 0.000000); 
	TextDrawTextSize(forklift_td, 133.750045, 129.407440); 
	TextDrawAlignment(forklift_td, 1); 
	TextDrawColor(forklift_td, -1); 
	TextDrawSetShadow(forklift_td, 0); 
	TextDrawSetOutline(forklift_td, 0); 
	TextDrawBackgroundColor(forklift_td, 0); 
	TextDrawFont(forklift_td, 5); 
	TextDrawSetProportional(forklift_td, 0); 
	TextDrawSetShadow(forklift_td, 0); 
	TextDrawSetPreviewModel(forklift_td, 530); 
	TextDrawSetPreviewRot(forklift_td, 0.000000, 0.000000, -90.000000, 1.000000); 
	TextDrawSetPreviewVehCol(forklift_td, 3, 0); 
	
	
	/*	td	*/
	PaintTextDraws = TextDrawCreate ( 483.294067, 397.249969, "_" ) ;
	TextDrawLetterSize ( PaintTextDraws, 0.265528, 1.214998 ) ;
	TextDrawAlignment ( PaintTextDraws, 1 ) ;
	TextDrawColor ( PaintTextDraws, -1 ) ;
	TextDrawSetShadow ( PaintTextDraws, 0 ) ;
	TextDrawSetOutline ( PaintTextDraws, 1 ) ;
	TextDrawBackgroundColor ( PaintTextDraws, 51 ) ;
	TextDrawFont ( PaintTextDraws, 2 ) ;
	TextDrawSetProportional ( PaintTextDraws, 1 ) ; 
	
	
	/* donate roulette */
	
	dr_td [0] = TextDrawCreate(211.249923, 155.000045, "LD_SPAC:white");
	TextDrawLetterSize(dr_td [0], 0.000000, 0.000000);
	TextDrawTextSize(dr_td [0], 229.166656, 83.777740);
	TextDrawAlignment(dr_td [0], 1);
	TextDrawColor(dr_td [0], 522133503);
	TextDrawSetShadow(dr_td [0], 0);
	TextDrawSetOutline(dr_td [0], 0);
	TextDrawBackgroundColor(dr_td [0], 255);
	TextDrawFont(dr_td [0], 4);
	TextDrawSetProportional(dr_td [0], 0);
	TextDrawSetShadow(dr_td [0], 0);

	dr_td [1] = TextDrawCreate(217.083297, 178.333389, "LD_SPAC:white");
	TextDrawLetterSize(dr_td [1], 0.000000, 0.000000);
	TextDrawTextSize(dr_td [1], 217.083206, 47.481445);
	TextDrawAlignment(dr_td [1], 1);
	TextDrawColor(dr_td [1], 269488383);
	TextDrawSetShadow(dr_td [1], 0);
	TextDrawSetOutline(dr_td [1], 0);
	TextDrawBackgroundColor(dr_td [1], 255);
	TextDrawFont(dr_td [1], 4);
	TextDrawSetProportional(dr_td [1], 0);
	TextDrawSetShadow(dr_td [1], 0);

	dr_td [2] = TextDrawCreate(261.666748, 167.444519, "LD_SPAC:white");
	TextDrawLetterSize(dr_td [2], 0.000000, 0.000000);
	TextDrawTextSize(dr_td [2], 127.916481, 9.629590);
	TextDrawAlignment(dr_td [2], 1);
	TextDrawColor(dr_td [2], 269488383);
	TextDrawSetShadow(dr_td [2], 0);
	TextDrawSetOutline(dr_td [2], 0);
	TextDrawBackgroundColor(dr_td [2], 255);
	TextDrawFont(dr_td [2], 4);
	TextDrawSetProportional(dr_td [2], 0);
	TextDrawSetShadow(dr_td [2], 0);

	dr_td [3] = TextDrawCreate(291.249969, 227.592651, "LD_SPAC:white"); // الخريطة الرادارية
	TextDrawLetterSize(dr_td [3], 0.000000, 0.000000);
	TextDrawTextSize(dr_td [3], 68.749862, 9.629590);
	TextDrawAlignment(dr_td [3], 1);
	TextDrawColor(dr_td [3], 269488383);
	TextDrawSetShadow(dr_td [3], 0);
	TextDrawSetOutline(dr_td [3], 0);
	TextDrawBackgroundColor(dr_td [3], 255);
	TextDrawFont(dr_td [3], 4);
	TextDrawSetProportional(dr_td [3], 0);
	TextDrawSetShadow(dr_td [3], 0);
	TextDrawSetSelectable(dr_td [3], true);

	dr_td [4] = TextDrawCreate(295.399932, 227.333511, "PRESS!_TO_OPEN");
	TextDrawLetterSize(dr_td [4], 0.254166, 0.967408);
	TextDrawAlignment(dr_td [4], 1);
	TextDrawColor(dr_td [4], -1);
	TextDrawSetShadow(dr_td [4], 0);
	TextDrawSetOutline(dr_td [4], 0);
	TextDrawBackgroundColor(dr_td [4], 255);
	TextDrawFont(dr_td [4], 1);
	TextDrawSetProportional(dr_td [4], 1);
	TextDrawSetShadow(dr_td [4], 0);

	dr_td [5] = TextDrawCreate(322.499755, 216.963180, "/"); // 
	TextDrawLetterSize(dr_td [5], 0.362916, 0.718519);
	TextDrawAlignment(dr_td [5], 1);
	TextDrawColor(dr_td [5], 269488383);
	TextDrawSetShadow(dr_td [5], 0);
	TextDrawSetOutline(dr_td [5], 0);
	TextDrawBackgroundColor(dr_td [5], 255);
	TextDrawFont(dr_td [5], 1);
	TextDrawSetProportional(dr_td [5], 1);
	TextDrawSetShadow(dr_td [5], 0);

	dr_td [6] = TextDrawCreate(324.583068, 216.963180, "\\_"); // 
	TextDrawLetterSize(dr_td [6], 0.362916, 0.718519);
	TextDrawAlignment(dr_td [6], 1);
	TextDrawColor(dr_td [6], 269488383);
	TextDrawSetShadow(dr_td [6], 0);
	TextDrawSetOutline(dr_td [6], 0);
	TextDrawBackgroundColor(dr_td [6], 255);
	TextDrawFont(dr_td [6], 1);
	TextDrawSetProportional(dr_td [6], 1);
	TextDrawSetShadow(dr_td [6], 0);

	dr_td [7] = TextDrawCreate(324.999755, 179.629653, "/"); // 
	TextDrawLetterSize(dr_td [7], 0.362916, 0.718519);
	TextDrawAlignment(dr_td [7], 1);
	TextDrawColor(dr_td [7], 269488383);
	TextDrawSetShadow(dr_td [7], 0);
	TextDrawSetOutline(dr_td [7], 0);
	TextDrawBackgroundColor(dr_td [7], 255);
	TextDrawFont(dr_td [7], 1);
	TextDrawSetProportional(dr_td [7], 1);
	TextDrawSetShadow(dr_td [7], 0);

	dr_td [8] = TextDrawCreate(322.499664, 179.111328, "\\_"); // 
	TextDrawLetterSize(dr_td [8], 0.362916, 0.718519);
	TextDrawAlignment(dr_td [8], 1);
	TextDrawColor(dr_td [8], 269488383);
	TextDrawSetShadow(dr_td [8], 0);
	TextDrawSetOutline(dr_td [8], 0);
	TextDrawBackgroundColor(dr_td [8], 255);
	TextDrawFont(dr_td [8], 1);
	TextDrawSetProportional(dr_td [8], 1);
	TextDrawSetShadow(dr_td [8], 0);

	dr_td [9] = TextDrawCreate(423.749969, 167.444519, "LD_SPAC:white"); // المعلومات العامة
	TextDrawLetterSize(dr_td [9], 0.000000, 0.000000);
	TextDrawTextSize(dr_td [9], 10.416533, 9.629590);
	TextDrawAlignment(dr_td [9], 1);
	TextDrawColor(dr_td [9], 269488383);
	TextDrawSetShadow(dr_td [9], 0);
	TextDrawSetOutline(dr_td [9], 0);
	TextDrawBackgroundColor(dr_td [9], 255);
	TextDrawFont(dr_td [9], 4);
	TextDrawSetProportional(dr_td [9], 0);
	TextDrawSetShadow(dr_td [9], 0);
	TextDrawSetSelectable(dr_td [9], true);

	dr_td [10] = TextDrawCreate(426.250000, 167.803710, "X");
	TextDrawLetterSize(dr_td [10], 0.254166, 0.967408);
	TextDrawAlignment(dr_td [10], 1);
	TextDrawColor(dr_td [10], -1061109505);
	TextDrawSetShadow(dr_td [10], 0);
	TextDrawSetOutline(dr_td [10], 0);
	TextDrawBackgroundColor(dr_td [10], 255);
	TextDrawFont(dr_td [10], 1);
	TextDrawSetProportional(dr_td [10], 1);
	TextDrawSetShadow(dr_td [10], 0);
/*
		mafia war
*/
	mw_td [0] = TextDrawCreate(28.749984, 189.859329, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [0], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [0], 121.666656, 52.666679 ) ;
	TextDrawAlignment(mw_td [0], 1 ) ;
	TextDrawColor(mw_td [0], 269488383 ) ;
	TextDrawSetShadow(mw_td [0], 0 ) ;
	TextDrawSetOutline(mw_td [0], 0 ) ;
	TextDrawBackgroundColor(mw_td [0], 255 ) ;
	TextDrawFont(mw_td [0], 4 ) ;
	TextDrawSetProportional(mw_td [0], 0 ) ;
	TextDrawSetShadow(mw_td [0], 0 ) ;

	mw_td [1] = TextDrawCreate(27.499990, 188.185226, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [1], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [1], 124.999984, 12.740736 ) ;
	TextDrawAlignment(mw_td [1], 1 ) ;
	TextDrawColor(mw_td [1], 606348543 ) ;
	TextDrawSetShadow(mw_td [1], 0 ) ;
	TextDrawSetOutline(mw_td [1], 0 ) ;
	TextDrawBackgroundColor(mw_td [1], 255 ) ;
	TextDrawFont(mw_td [1], 4 ) ;
	TextDrawSetProportional(mw_td [1], 0 ) ;
	TextDrawSetShadow(mw_td [1], 0 ) ;

	mw_td [2] = TextDrawCreate(27.500000, 200.111099, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [2], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [2], 2.499978, 43.851783 ) ;
	TextDrawAlignment(mw_td [2], 1 ) ;
	TextDrawColor(mw_td [2], 606348543 ) ;
	TextDrawSetShadow(mw_td [2], 0 ) ;
	TextDrawSetOutline(mw_td [2], 0 ) ;
	TextDrawBackgroundColor(mw_td [2], 255 ) ;
	TextDrawFont(mw_td [2], 4 ) ;
	TextDrawSetProportional(mw_td [2], 0 ) ;
	TextDrawSetShadow(mw_td [2], 0 ) ;

	mw_td [3] = TextDrawCreate(150.000015, 200.629684, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [3], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [3], 2.499978, 42.814769 ) ;
	TextDrawAlignment(mw_td [3], 1 ) ;
	TextDrawColor(mw_td [3], 606348543 ) ;
	TextDrawSetShadow(mw_td [3], 0 ) ;
	TextDrawSetOutline(mw_td [3], 0 ) ;
	TextDrawBackgroundColor(mw_td [3], 255 ) ;
	TextDrawFont(mw_td [3], 4 ) ;
	TextDrawSetProportional(mw_td [3], 0 ) ;
	TextDrawSetShadow(mw_td [3], 0 ) ;

	mw_td [4] = TextDrawCreate(27.916664, 241.073867, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [4], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [4], 124.999938, 2.888833 ) ;
	TextDrawAlignment(mw_td [4], 1 ) ;
	TextDrawColor(mw_td [4], 606348543 ) ;
	TextDrawSetShadow(mw_td [4], 0 ) ;
	TextDrawSetOutline(mw_td [4], 0 ) ;
	TextDrawBackgroundColor(mw_td [4], 255 ) ;
	TextDrawFont(mw_td [4], 4 ) ;
	TextDrawSetProportional(mw_td [4], 0 ) ;
	TextDrawSetShadow(mw_td [4], 0 ) ;

	mw_td [5] = TextDrawCreate(89.583297, 190.518600, "CAPTURE_TIME:_2:28" ) ;
	TextDrawLetterSize(mw_td [5], 0.200828, 0.925924 ) ;
	TextDrawAlignment(mw_td [5], 2 ) ;
	TextDrawColor(mw_td [5], -1 ) ;
	TextDrawSetShadow(mw_td [5], 0 ) ;
	TextDrawSetOutline(mw_td [5], 0 ) ;
	TextDrawBackgroundColor(mw_td [5], 255 ) ;
	TextDrawFont(mw_td [5], 1 ) ;
	TextDrawSetProportional(mw_td [5], 1 ) ;
	TextDrawSetShadow(mw_td [5], 0 ) ;

	mw_td [6] = TextDrawCreate(34.166622, 206.851898, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [6], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [6], 85.416732, 13.259243 ) ;
	TextDrawAlignment(mw_td [6], 1 ) ;
	TextDrawColor(mw_td [6], 522133503 ) ;
	TextDrawSetShadow(mw_td [6], 0 ) ;
	TextDrawSetOutline(mw_td [6], 0 ) ;
	TextDrawBackgroundColor(mw_td [6], 255 ) ;
	TextDrawFont(mw_td [6], 4 ) ;
	TextDrawSetProportional(mw_td [6], 0 ) ;
	TextDrawSetShadow(mw_td [6], 0 ) ;

	mw_td [7] = TextDrawCreate(34.166622, 222.926025, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [7], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [7], 85.416732, 13.259243 ) ;
	TextDrawAlignment(mw_td [7], 1 ) ;
	TextDrawColor(mw_td [7], 522133503 ) ;
	TextDrawSetShadow(mw_td [7], 0 ) ;
	TextDrawSetOutline(mw_td [7], 0 ) ;
	TextDrawBackgroundColor(mw_td [7], 255 ) ;
	TextDrawFont(mw_td [7], 4 ) ;
	TextDrawSetProportional(mw_td [7], 0 ) ;
	TextDrawSetShadow(mw_td [7], 0 ) ;

	mw_td [8] = TextDrawCreate(121.666618, 206.851882, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [8], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [8], 23.750068, 13.259243 ) ;
	TextDrawAlignment(mw_td [8], 1 ) ;
	TextDrawColor(mw_td [8], 522133503 ) ;
	TextDrawSetShadow(mw_td [8], 0 ) ;
	TextDrawSetOutline(mw_td [8], 0 ) ;
	TextDrawBackgroundColor(mw_td [8], 255 ) ;
	TextDrawFont(mw_td [8], 4 ) ;
	TextDrawSetProportional(mw_td [8], 0 ) ;
	TextDrawSetShadow(mw_td [8], 0 ) ;

	mw_td [9] = TextDrawCreate(121.666610, 222.925964, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [9], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [9], 23.750068, 13.259243 ) ;
	TextDrawAlignment(mw_td [9], 1 ) ;
	TextDrawColor(mw_td [9], 522133503 ) ;
	TextDrawSetShadow(mw_td [9], 0 ) ;
	TextDrawSetOutline(mw_td [9], 0 ) ;
	TextDrawBackgroundColor(mw_td [9], 255 ) ;
	TextDrawFont(mw_td [9], 4 ) ;
	TextDrawSetProportional(mw_td [9], 0 ) ;
	TextDrawSetShadow(mw_td [9], 0 ) ;

	mw_td [10] = TextDrawCreate(34.166622, 206.851898, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [10], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [10], 2.083405, 13.259244 ) ;
	TextDrawAlignment(mw_td [10], 1 ) ;
	TextDrawColor(mw_td [10], 0x388abaff ) ;
	TextDrawSetShadow(mw_td [10], 0 ) ;
	TextDrawSetOutline(mw_td [10], 0 ) ;
	TextDrawBackgroundColor(mw_td [10], 255 ) ;
	TextDrawFont(mw_td [10], 4 ) ;
	TextDrawSetProportional(mw_td [10], 0 ) ;
	TextDrawSetShadow(mw_td [10], 0 ) ;

	mw_td [11] = TextDrawCreate(122.083328, 206.851882, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [11], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [11], 2.083405, 13.259244 ) ;
	TextDrawAlignment(mw_td [11], 1 ) ;
	TextDrawColor(mw_td [11], 0x388abaff ) ;
	TextDrawSetShadow(mw_td [11], 0 ) ;
	TextDrawSetOutline(mw_td [11], 0 ) ;
	TextDrawBackgroundColor(mw_td [11], 255 ) ;
	TextDrawFont(mw_td [11], 4 ) ;
	TextDrawSetProportional(mw_td [11], 0 ) ;
	TextDrawSetShadow(mw_td [11], 0 ) ;

	mw_td [12] = TextDrawCreate(34.166648, 222.925979, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [12], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [12], 2.083405, 13.259244 ) ;
	TextDrawAlignment(mw_td [12], 1 ) ;
	TextDrawColor(mw_td [12], 8388863 ) ;
	TextDrawSetShadow(mw_td [12], 0 ) ;
	TextDrawSetOutline(mw_td [12], 0 ) ;
	TextDrawBackgroundColor(mw_td [12], 255 ) ;
	TextDrawFont(mw_td [12], 4 ) ;
	TextDrawSetProportional(mw_td [12], 0 ) ;
	TextDrawSetShadow(mw_td [12], 0 ) ;

	mw_td [13] = TextDrawCreate(122.083328, 222.925949, "LD_SPAC:white" ) ;
	TextDrawLetterSize(mw_td [13], 0.000000, 0.000000 ) ;
	TextDrawTextSize(mw_td [13], 2.083405, 13.259244 ) ;
	TextDrawAlignment(mw_td [13], 1 ) ;
	TextDrawColor(mw_td [13], 8388863 ) ;
	TextDrawSetShadow(mw_td [13], 0 ) ;
	TextDrawSetOutline(mw_td [13], 0 ) ;
	TextDrawBackgroundColor(mw_td [13], 255 ) ;
	TextDrawFont(mw_td [13], 4 ) ;
	TextDrawSetProportional(mw_td [13], 0 ) ;
	TextDrawSetShadow(mw_td [13], 0 ) ;

	mw_td [14] = TextDrawCreate(77.916641, 209.703842, "LOS_SANTOS_VAGOS" ) ;
	TextDrawLetterSize(mw_td [14], 0.200828, 0.925924 ) ;
	TextDrawAlignment(mw_td [14], 2 ) ;
	TextDrawColor(mw_td [14], -1 ) ;
	TextDrawSetShadow(mw_td [14], 0 ) ;
	TextDrawSetOutline(mw_td [14], 0 ) ;
	TextDrawBackgroundColor(mw_td [14], 255 ) ;
	TextDrawFont(mw_td [14], 1 ) ;
	TextDrawSetProportional(mw_td [14], 1 ) ;
	TextDrawSetShadow(mw_td [14], 0 ) ;

	mw_td [15] = TextDrawCreate(77.916641, 225.259460, "GROVE_STREET" ) ;
	TextDrawLetterSize(mw_td [15], 0.200828, 0.925924 ) ;
	TextDrawAlignment(mw_td [15], 2 ) ;
	TextDrawColor(mw_td [15], -1 ) ;
	TextDrawSetShadow(mw_td [15], 0 ) ;
	TextDrawSetOutline(mw_td [15], 0 ) ;
	TextDrawBackgroundColor(mw_td [15], 255 ) ;
	TextDrawFont(mw_td [15], 1 ) ;
	TextDrawSetProportional(mw_td [15], 1 ) ;
	TextDrawSetShadow(mw_td [15], 0 ) ;

	mw_td [16] = TextDrawCreate(135.000000, 225.259445, "0" ) ;
	TextDrawLetterSize(mw_td [16], 0.200828, 0.925924 ) ;
	TextDrawAlignment(mw_td [16], 2 ) ;
	TextDrawColor(mw_td [16], -1 ) ;
	TextDrawSetShadow(mw_td [16], 0 ) ;
	TextDrawSetOutline(mw_td [16], 0 ) ;
	TextDrawBackgroundColor(mw_td [16], 255 ) ;
	TextDrawFont(mw_td [16], 1 ) ;
	TextDrawSetProportional(mw_td [16], 1 ) ;
	TextDrawSetShadow(mw_td [16], 0 ) ;

	mw_td [17] = TextDrawCreate(134.583404, 209.703887, "0" ) ;
	TextDrawLetterSize(mw_td [17], 0.200828, 0.925924 ) ;
	TextDrawAlignment(mw_td [17], 2 ) ;
	TextDrawColor(mw_td [17], -1 ) ;
	TextDrawSetShadow(mw_td [17], 0 ) ;
	TextDrawSetOutline(mw_td [17], 0 ) ;
	TextDrawBackgroundColor(mw_td [17], 255 ) ;
	TextDrawFont(mw_td [17], 1 ) ;
	TextDrawSetProportional(mw_td [17], 1 ) ;
	TextDrawSetShadow(mw_td [17], 0 ) ;

	
	
	
	
