module rompcm705(
	input clk,
	input reset_n,
	output signed [31:0]addrout
);

wire signed [31:0]addr[0:704];
reg [5:0]k;
wire lrck;
always @(posedge clk or negedge reset_n)begin
	if(reset_n ==0) 
	k = 0;
	
	else
	k <= k+1;

end
assign lrck = k[5];
reg [9:0]i;
always @(posedge lrck or negedge reset_n)begin
	if(reset_n ==0)begin
		i <= 0;
	//	addrout <= 32'd0;
		end
	else if(i>=704)
		i <= 0;
	else begin
		i <= i+1;
	//	addrout <= addr[i];
		end
end

assign addrout = addr[i];

assign addr[0]= 0;
assign addr[1]= 19122533;
assign addr[2]= 38243550;
assign addr[3]= 57361534;
assign addr[4]= 76474970;
assign addr[5]= 95582342;
assign addr[6]= 114682135;
assign addr[7]= 133772834;
assign addr[8]= 152852926;
assign addr[9]= 171920898;
assign addr[10]= 190975237;
assign addr[11]= 210014433;
assign addr[12]= 229036977;
assign addr[13]= 248041359;
assign addr[14]= 267026072;
assign addr[15]= 285989613;
assign addr[16]= 304930476;
assign addr[17]= 323847160;
assign addr[18]= 342738165;
assign addr[19]= 361601993;
assign addr[20]= 380437148;
assign addr[21]= 399242136;
assign addr[22]= 418015468;
assign addr[23]= 436755653;
assign addr[24]= 455461206;
assign addr[25]= 474130644;
assign addr[26]= 492762486;
assign addr[27]= 511355255;
assign addr[28]= 529907477;
assign addr[29]= 548417680;
assign addr[30]= 566884397;
assign addr[31]= 585306164;
assign addr[32]= 603681519;
assign addr[33]= 622009006;
assign addr[34]= 640287172;
assign addr[35]= 658514567;
assign addr[36]= 676689746;
assign addr[37]= 694811267;
assign addr[38]= 712877694;
assign addr[39]= 730887594;
assign addr[40]= 748839539;
assign addr[41]= 766732106;
assign addr[42]= 784563876;
assign addr[43]= 802333434;
assign addr[44]= 820039373;
assign addr[45]= 837680287;
assign addr[46]= 855254778;
assign addr[47]= 872761453;
assign addr[48]= 890198924;
assign addr[49]= 907565806;
assign addr[50]= 924860725;
assign addr[51]= 942082308;
assign addr[52]= 959229189;
assign addr[53]= 976300009;
assign addr[54]= 993293415;
assign addr[55]= 1010208058;
assign addr[56]= 1027042599;
assign addr[57]= 1043795701;
assign addr[58]= 1060466036;
assign addr[59]= 1077052283;
assign addr[60]= 1093553126;
assign addr[61]= 1109967258;
assign addr[62]= 1126293375;
assign addr[63]= 1142530185;
assign addr[64]= 1158676398;
assign addr[65]= 1174730736;
assign addr[66]= 1190691925;
assign addr[67]= 1206558699;
assign addr[68]= 1222329801;
assign addr[69]= 1238003979;
assign addr[70]= 1253579991;
assign addr[71]= 1269056602;
assign addr[72]= 1284432584;
assign addr[73]= 1299706719;
assign addr[74]= 1314877795;
assign addr[75]= 1329944609;
assign addr[76]= 1344905966;
assign addr[77]= 1359760681;
assign addr[78]= 1374507575;
assign addr[79]= 1389145479;
assign addr[80]= 1403673233;
assign addr[81]= 1418089683;
assign addr[82]= 1432393688;
assign addr[83]= 1446584113;
assign addr[84]= 1460659832;
assign addr[85]= 1474619730;
assign addr[86]= 1488462700;
assign addr[87]= 1502187644;
assign addr[88]= 1515793473;
assign addr[89]= 1529279109;
assign addr[90]= 1542643483;
assign addr[91]= 1555885534;
assign addr[92]= 1569004214;
assign addr[93]= 1581998481;
assign addr[94]= 1594867305;
assign addr[95]= 1607609665;
assign addr[96]= 1620224553;
assign addr[97]= 1632710966;
assign addr[98]= 1645067915;
assign addr[99]= 1657294421;
assign addr[100]= 1669389513;
assign addr[101]= 1681352233;
assign addr[102]= 1693181631;
assign addr[103]= 1704876771;
assign addr[104]= 1716436725;
assign addr[105]= 1727860575;
assign addr[106]= 1739147417;
assign addr[107]= 1750296355;
assign addr[108]= 1761306505;
assign addr[109]= 1772176995;
assign addr[110]= 1782906961;
assign addr[111]= 1793495554;
assign addr[112]= 1803941934;
assign addr[113]= 1814245272;
assign addr[114]= 1824404752;
assign addr[115]= 1834419567;
assign addr[116]= 1844288924;
assign addr[117]= 1854012040;
assign addr[118]= 1863588145;
assign addr[119]= 1873016478;
assign addr[120]= 1882296293;
assign addr[121]= 1891426853;
assign addr[122]= 1900407434;
assign addr[123]= 1909237325;
assign addr[124]= 1917915825;
assign addr[125]= 1926442245;
assign addr[126]= 1934815911;
assign addr[127]= 1943036158;
assign addr[128]= 1951102334;
assign addr[129]= 1959013799;
assign addr[130]= 1966769926;
assign addr[131]= 1974370101;
assign addr[132]= 1981813720;
assign addr[133]= 1989100193;
assign addr[134]= 1996228943;
assign addr[135]= 2003199404;
assign addr[136]= 2010011024;
assign addr[137]= 2016663262;
assign addr[138]= 2023155591;
assign addr[139]= 2029487496;
assign addr[140]= 2035658475;
assign addr[141]= 2041668039;
assign addr[142]= 2047515711;
assign addr[143]= 2053201028;
assign addr[144]= 2058723538;
assign addr[145]= 2064082804;
assign addr[146]= 2069278401;
assign addr[147]= 2074309917;
assign addr[148]= 2079176953;
assign addr[149]= 2083879123;
assign addr[150]= 2088416053;
assign addr[151]= 2092787386;
assign addr[152]= 2096992772;
assign addr[153]= 2101031881;
assign addr[154]= 2104904390;
assign addr[155]= 2108609993;
assign addr[156]= 2112148396;
assign addr[157]= 2115519319;
assign addr[158]= 2118722494;
assign addr[159]= 2121757667;
assign addr[160]= 2124624598;
assign addr[161]= 2127323060;
assign addr[162]= 2129852837;
assign addr[163]= 2132213730;
assign addr[164]= 2134405552;
assign addr[165]= 2136428128;
assign addr[166]= 2138281298;
assign addr[167]= 2139964916;
assign addr[168]= 2141478848;
assign addr[169]= 2142822974;
assign addr[170]= 2143997187;
assign addr[171]= 2145001394;
assign addr[172]= 2145835515;
assign addr[173]= 2146499485;
assign addr[174]= 2146993250;
assign addr[175]= 2147316772;
assign addr[176]= 2147470025;
assign addr[177]= 2147452997;
assign addr[178]= 2147265689;
assign addr[179]= 2146908116;
assign addr[180]= 2146380306;
assign addr[181]= 2145682301;
assign addr[182]= 2144814157;
assign addr[183]= 2143775942;
assign addr[184]= 2142567738;
assign addr[185]= 2141189643;
assign addr[186]= 2139641764;
assign addr[187]= 2137924224;
assign addr[188]= 2136037160;
assign addr[189]= 2133980722;
assign addr[190]= 2131755071;
assign addr[191]= 2129360386;
assign addr[192]= 2126796855;
assign addr[193]= 2124064683;
assign addr[194]= 2121164085;
assign addr[195]= 2118095291;
assign addr[196]= 2114858546;
assign addr[197]= 2111454105;
assign addr[198]= 2107882239;
assign addr[199]= 2104143231;
assign addr[200]= 2100237377;
assign addr[201]= 2096164987;
assign addr[202]= 2091926384;
assign addr[203]= 2087521904;
assign addr[204]= 2082951896;
assign addr[205]= 2078216723;
assign addr[206]= 2073316760;
assign addr[207]= 2068252395;
assign addr[208]= 2063024031;
assign addr[209]= 2057632082;
assign addr[210]= 2052076975;
assign addr[211]= 2046359151;
assign addr[212]= 2040479063;
assign addr[213]= 2034437177;
assign addr[214]= 2028233973;
assign addr[215]= 2021869943;
assign addr[216]= 2015345591;
assign addr[217]= 2008661434;
assign addr[218]= 2001818002;
assign addr[219]= 1994815838;
assign addr[220]= 1987655498;
assign addr[221]= 1980337549;
assign addr[222]= 1972862571;
assign addr[223]= 1965231157;
assign addr[224]= 1957443913;
assign addr[225]= 1949501455;
assign addr[226]= 1941404413;
assign addr[227]= 1933153430;
assign addr[228]= 1924749160;
assign addr[229]= 1916192269;
assign addr[230]= 1907483436;
assign addr[231]= 1898623350;
assign addr[232]= 1889612716;
assign addr[233]= 1880452247;
assign addr[234]= 1871142669;
assign addr[235]= 1861684722;
assign addr[236]= 1852079154;
assign addr[237]= 1842326727;
assign addr[238]= 1832428215;
assign addr[239]= 1822384403;
assign addr[240]= 1812196087;
assign addr[241]= 1801864075;
assign addr[242]= 1791389186;
assign addr[243]= 1780772251;
assign addr[244]= 1770014111;
assign addr[245]= 1759115620;
assign addr[246]= 1748077642;
assign addr[247]= 1736901053;
assign addr[248]= 1725586737;
assign addr[249]= 1714135593;
assign addr[250]= 1702548529;
assign addr[251]= 1690826462;
assign addr[252]= 1678970324;
assign addr[253]= 1666981054;
assign addr[254]= 1654859602;
assign addr[255]= 1642606930;
assign addr[256]= 1630224009;
assign addr[257]= 1617711821;
assign addr[258]= 1605071359;
assign addr[259]= 1592303624;
assign addr[260]= 1579409630;
assign addr[261]= 1566390398;
assign addr[262]= 1553246960;
assign addr[263]= 1539980360;
assign addr[264]= 1526591649;
assign addr[265]= 1513081888;
assign addr[266]= 1499452149;
assign addr[267]= 1485703513;
assign addr[268]= 1471837070;
assign addr[269]= 1457853918;
assign addr[270]= 1443755168;
assign addr[271]= 1429541937;
assign addr[272]= 1415215352;
assign addr[273]= 1400776550;
assign addr[274]= 1386226674;
assign addr[275]= 1371566878;
assign addr[276]= 1356798326;
assign addr[277]= 1341922188;
assign addr[278]= 1326939644;
assign addr[279]= 1311851882;
assign addr[280]= 1296660098;
assign addr[281]= 1281365496;
assign addr[282]= 1265969291;
assign addr[283]= 1250472701;
assign addr[284]= 1234876957;
assign addr[285]= 1219183294;
assign addr[286]= 1203392958;
assign addr[287]= 1187507200;
assign addr[288]= 1171527280;
assign addr[289]= 1155454465;
assign addr[290]= 1139290029;
assign addr[291]= 1123035255;
assign addr[292]= 1106691431;
assign addr[293]= 1090259853;
assign addr[294]= 1073741824;
assign addr[295]= 1057138654;
assign addr[296]= 1040451659;
assign addr[297]= 1023682163;
assign addr[298]= 1006831495;
assign addr[299]= 989900992;
assign addr[300]= 972891995;
assign addr[301]= 955805854;
assign addr[302]= 938643924;
assign addr[303]= 921407564;
assign addr[304]= 904098143;
assign addr[305]= 886717032;
assign addr[306]= 869265610;
assign addr[307]= 851745261;
assign addr[308]= 834157373;
assign addr[309]= 816503342;
assign addr[310]= 798784567;
assign addr[311]= 781002454;
assign addr[312]= 763158411;
assign addr[313]= 745253855;
assign addr[314]= 727290205;
assign addr[315]= 709268885;
assign addr[316]= 691191324;
assign addr[317]= 673058956;
assign addr[318]= 654873219;
assign addr[319]= 636635554;
assign addr[320]= 618347408;
assign addr[321]= 600010231;
assign addr[322]= 581625477;
assign addr[323]= 563194603;
assign addr[324]= 544719071;
assign addr[325]= 526200347;
assign addr[326]= 507639898;
assign addr[327]= 489039196;
assign addr[328]= 470399716;
assign addr[329]= 451722937;
assign addr[330]= 433010339;
assign addr[331]= 414263405;
assign addr[332]= 395483624;
assign addr[333]= 376672482;
assign addr[334]= 357831473;
assign addr[335]= 338962090;
assign addr[336]= 320065829;
assign addr[337]= 301144190;
assign addr[338]= 282198671;
assign addr[339]= 263230775;
assign addr[340]= 244242007;
assign addr[341]= 225233873;
assign addr[342]= 206207878;
assign addr[343]= 187165532;
assign addr[344]= 168108346;
assign addr[345]= 149037829;
assign addr[346]= 129955495;
assign addr[347]= 110862856;
assign addr[348]= 91761426;
assign addr[349]= 72652720;
assign addr[350]= 53538253;
assign addr[351]= 34419541;
assign addr[352]= 15298099;
assign addr[353]= -3824555;
assign addr[354]= -22946906;
assign addr[355]= -42067438;
assign addr[356]= -61184634;
assign addr[357]= -80296978;
assign addr[358]= -99402956;
assign addr[359]= -118501051;
assign addr[360]= -137589750;
assign addr[361]= -156667539;
assign addr[362]= -175732905;
assign addr[363]= -194784336;
assign addr[364]= -213820322;
assign addr[365]= -232839354;
assign addr[366]= -251839923;
assign addr[367]= -270820523;
assign addr[368]= -289779648;
assign addr[369]= -308715795;
assign addr[370]= -327627463;
assign addr[371]= -346513152;
assign addr[372]= -365371365;
assign addr[373]= -384200606;
assign addr[374]= -402999383;
assign addr[375]= -421766204;
assign addr[376]= -440499581;
assign addr[377]= -459198030;
assign addr[378]= -477860067;
assign addr[379]= -496484213;
assign addr[380]= -515068990;
assign addr[381]= -533612926;
assign addr[382]= -552114549;
assign addr[383]= -570572393;
assign addr[384]= -588984994;
assign addr[385]= -607350893;
assign addr[386]= -625668632;
assign addr[387]= -643936759;
assign addr[388]= -662153826;
assign addr[389]= -680318388;
assign addr[390]= -698429006;
assign addr[391]= -716484242;
assign addr[392]= -734482665;
assign addr[393]= -752422848;
assign addr[394]= -770303369;
assign addr[395]= -788122810;
assign addr[396]= -805879757;
assign addr[397]= -823572802;
assign addr[398]= -841200544;
assign addr[399]= -858761583;
assign addr[400]= -876254528;
assign addr[401]= -893677991;
assign addr[402]= -911030591;
assign addr[403]= -928310952;
assign addr[404]= -945517704;
assign addr[405]= -962649481;
assign addr[406]= -979704927;
assign addr[407]= -996682688;
assign addr[408]= -1013581418;
assign addr[409]= -1030399777;
assign addr[410]= -1047136432;
assign addr[411]= -1063790055;
assign addr[412]= -1080359326;
assign addr[413]= -1096842931;
assign addr[414]= -1113239564;
assign addr[415]= -1129547923;
assign addr[416]= -1145766716;
assign addr[417]= -1161894657;
assign addr[418]= -1177930466;
assign addr[419]= -1193872873;
assign addr[420]= -1209720613;
assign addr[421]= -1225472430;
assign addr[422]= -1241127074;
assign addr[423]= -1256683304;
assign addr[424]= -1272139887;
assign addr[425]= -1287495598;
assign addr[426]= -1302749217;
assign addr[427]= -1317899537;
assign addr[428]= -1332945355;
assign addr[429]= -1347885479;
assign addr[430]= -1362718723;
assign addr[431]= -1377443913;
assign addr[432]= -1392059879;
assign addr[433]= -1406565464;
assign addr[434]= -1420959516;
assign addr[435]= -1435240896;
assign addr[436]= -1449408469;
assign addr[437]= -1463461113;
assign addr[438]= -1477397714;
assign addr[439]= -1491217166;
assign addr[440]= -1504918373;
assign addr[441]= -1518500250;
assign addr[442]= -1531961719;
assign addr[443]= -1545301713;
assign addr[444]= -1558519173;
assign addr[445]= -1571613053;
assign addr[446]= -1584582314;
assign addr[447]= -1597425926;
assign addr[448]= -1610142873;
assign addr[449]= -1622732145;
assign addr[450]= -1635192744;
assign addr[451]= -1647523683;
assign addr[452]= -1659723983;
assign addr[453]= -1671792677;
assign addr[454]= -1683728808;
assign addr[455]= -1695531430;
assign addr[456]= -1707199606;
assign addr[457]= -1718732412;
assign addr[458]= -1730128933;
assign addr[459]= -1741388265;
assign addr[460]= -1752509516;
assign addr[461]= -1763491804;
assign addr[462]= -1774334257;
assign addr[463]= -1785036017;
assign addr[464]= -1795596234;
assign addr[465]= -1806014071;
assign addr[466]= -1816288703;
assign addr[467]= -1826419313;
assign addr[468]= -1836405100;
assign addr[469]= -1846245271;
assign addr[470]= -1855939047;
assign addr[471]= -1865485657;
assign addr[472]= -1874884346;
assign addr[473]= -1884134368;
assign addr[474]= -1893234990;
assign addr[475]= -1902185490;
assign addr[476]= -1910985158;
assign addr[477]= -1919633297;
assign addr[478]= -1928129220;
assign addr[479]= -1936472255;
assign addr[480]= -1944661739;
assign addr[481]= -1952697024;
assign addr[482]= -1960577471;
assign addr[483]= -1968302457;
assign addr[484]= -1975871368;
assign addr[485]= -1983283605;
assign addr[486]= -1990538579;
assign addr[487]= -1997635716;
assign addr[488]= -2004574453;
assign addr[489]= -2011354239;
assign addr[490]= -2017974537;
assign addr[491]= -2024434822;
assign addr[492]= -2030734582;
assign addr[493]= -2036873317;
assign addr[494]= -2042850540;
assign addr[495]= -2048665778;
assign addr[496]= -2054318569;
assign addr[497]= -2059808465;
assign addr[498]= -2065135031;
assign addr[499]= -2070297844;
assign addr[500]= -2075296495;
assign addr[501]= -2080130588;
assign addr[502]= -2084799740;
assign addr[503]= -2089303579;
assign addr[504]= -2093641749;
assign addr[505]= -2097813907;
assign addr[506]= -2101819720;
assign addr[507]= -2105658873;
assign addr[508]= -2109331059;
assign addr[509]= -2112835988;
assign addr[510]= -2116173382;
assign addr[511]= -2119342977;
assign addr[512]= -2122344521;
assign addr[513]= -2125177775;
assign addr[514]= -2127842516;
assign addr[515]= -2130338532;
assign addr[516]= -2132665626;
assign addr[517]= -2134823612;
assign addr[518]= -2136812319;
assign addr[519]= -2138631591;
assign addr[520]= -2140281282;
assign addr[521]= -2141761261;
assign addr[522]= -2143071413;
assign addr[523]= -2144211631;
assign addr[524]= -2145181827;
assign addr[525]= -2145981923;
assign addr[526]= -2146611856;
assign addr[527]= -2147071575;
assign addr[528]= -2147361045;
assign addr[529]= -2147480242;
assign addr[530]= -2147429158;
assign addr[531]= -2147207795;
assign addr[532]= -2146816171;
assign addr[533]= -2146254319;
assign addr[534]= -2145522281;
assign addr[535]= -2144620117;
assign addr[536]= -2143547897;
assign addr[537]= -2142305707;
assign addr[538]= -2140893646;
assign addr[539]= -2139311824;
assign addr[540]= -2137560369;
assign addr[541]= -2135639417;
assign addr[542]= -2133549123;
assign addr[543]= -2131289651;
assign addr[544]= -2128861181;
assign addr[545]= -2126263905;
assign addr[546]= -2123498030;
assign addr[547]= -2120563774;
assign addr[548]= -2117461370;
assign addr[549]= -2114191065;
assign addr[550]= -2110753117;
assign addr[551]= -2107147800;
assign addr[552]= -2103375398;
assign addr[553]= -2099436212;
assign addr[554]= -2095330553;
assign addr[555]= -2091058747;
assign addr[556]= -2086621133;
assign addr[557]= -2082018063;
assign addr[558]= -2077249901;
assign addr[559]= -2072317026;
assign addr[560]= -2067219829;
assign addr[561]= -2061958715;
assign addr[562]= -2056534099;
assign addr[563]= -2050946413;
assign addr[564]= -2045196100;
assign addr[565]= -2039283614;
assign addr[566]= -2033209426;
assign addr[567]= -2026974017;
assign addr[568]= -2020577882;
assign addr[569]= -2014021527;
assign addr[570]= -2007305472;
assign addr[571]= -2000430250;
assign addr[572]= -1993396407;
assign addr[573]= -1986204499;
assign addr[574]= -1978855097;
assign addr[575]= -1971348784;
assign addr[576]= -1963686155;
assign addr[577]= -1955867818;
assign addr[578]= -1947894393;
assign addr[579]= -1939766511;
assign addr[580]= -1931484818;
assign addr[581]= -1923049970;
assign addr[582]= -1914462636;
assign addr[583]= -1905723497;
assign addr[584]= -1896833245;
assign addr[585]= -1887792586;
assign addr[586]= -1878602237;
assign addr[587]= -1869262926;
assign addr[588]= -1859775393;
assign addr[589]= -1850140392;
assign addr[590]= -1840358687;
assign addr[591]= -1830431052;
assign addr[592]= -1820358275;
assign addr[593]= -1810141154;
assign addr[594]= -1799780501;
assign addr[595]= -1789277136;
assign addr[596]= -1778631892;
assign addr[597]= -1767845614;
assign addr[598]= -1756919156;
assign addr[599]= -1745853385;
assign addr[600]= -1734649179;
assign addr[601]= -1723307426;
assign addr[602]= -1711829025;
assign addr[603]= -1700214886;
assign addr[604]= -1688465931;
assign addr[605]= -1676583090;
assign addr[606]= -1664567307;
assign addr[607]= -1652419534;
assign addr[608]= -1640140734;
assign addr[609]= -1627731881;
assign addr[610]= -1615193959;
assign addr[611]= -1602527962;
assign addr[612]= -1589734894;
assign addr[613]= -1576815770;
assign addr[614]= -1563771613;
assign addr[615]= -1550603460;
assign addr[616]= -1537312353;
assign addr[617]= -1523899346;
assign addr[618]= -1510365504;
assign addr[619]= -1496711899;
assign addr[620]= -1482939614;
assign addr[621]= -1469049741;
assign addr[622]= -1455043381;
assign addr[623]= -1440921645;
assign addr[624]= -1426685652;
assign addr[625]= -1412336533;
assign addr[626]= -1397875423;
assign addr[627]= -1383303471;
assign addr[628]= -1368621831;
assign addr[629]= -1353831668;
assign addr[630]= -1338934154;
assign addr[631]= -1323930471;
assign addr[632]= -1308821808;
assign addr[633]= -1293609364;
assign addr[634]= -1278294345;
assign addr[635]= -1262877964;
assign addr[636]= -1247361445;
assign addr[637]= -1231746018;
assign addr[638]= -1216032921;
assign addr[639]= -1200223400;
assign addr[640]= -1184318708;
assign addr[641]= -1168320108;
assign addr[642]= -1152228866;
assign addr[643]= -1136046260;
assign addr[644]= -1119773573;
assign addr[645]= -1103412094;
assign addr[646]= -1086963121;
assign addr[647]= -1070427959;
assign addr[648]= -1053807919;
assign addr[649]= -1037104318;
assign addr[650]= -1020318481;
assign addr[651]= -1003451738;
assign addr[652]= -986505429;
assign addr[653]= -969480895;
assign addr[654]= -952379488;
assign addr[655]= -935202562;
assign addr[656]= -917951481;
assign addr[657]= -900627612;
assign addr[658]= -883232329;
assign addr[659]= -865767010;
assign addr[660]= -848233042;
assign addr[661]= -830631814;
assign addr[662]= -812964722;
assign addr[663]= -795233167;
assign addr[664]= -777438554;
assign addr[665]= -759582296;
assign addr[666]= -741665807;
assign addr[667]= -723690509;
assign addr[668]= -705657826;
assign addr[669]= -687569189;
assign addr[670]= -669426032;
assign addr[671]= -651229794;
assign addr[672]= -632981917;
assign addr[673]= -614683849;
assign addr[674]= -596337040;
assign addr[675]= -577942945;
assign addr[676]= -559503022;
assign addr[677]= -541018735;
assign addr[678]= -522491548;
assign addr[679]= -503922930;
assign addr[680]= -485314355;
assign addr[681]= -466667297;
assign addr[682]= -447983235;
assign addr[683]= -429263651;
assign addr[684]= -410510029;
assign addr[685]= -391723856;
assign addr[686]= -372906622;
assign addr[687]= -354059819;
assign addr[688]= -335184940;
assign addr[689]= -316283484;
assign addr[690]= -297356948;
assign addr[691]= -278406834;
assign addr[692]= -259434643;
assign addr[693]= -240441882;
assign addr[694]= -221430054;
assign addr[695]= -202400669;
assign addr[696]= -183355234;
assign addr[697]= -164295260;
assign addr[698]= -145222259;
assign addr[699]= -126137743;
assign addr[700]= -107043224;
assign addr[701]= -87940218;
assign addr[702]= -68830239;
assign addr[703]= -49714802;
assign addr[704]= -30595422;
endmodule