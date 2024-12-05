within FinalProject.Examples;
model DistributedCommunity
  "Model of a community with seperate houses containing an incutive load, PV array, and battery that share resources among members and utilize a backup generator"
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "C:/Users/jrs7827/OneDrive - The Pennsylvania State University/Coursework/AE 597 - Modeilica/Final Project/weatherdata/COL_Bogota.802220_IWEC.mos")
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  PVBatterySys              community(
    chaRat=5000,
    SOC_start=0.2,
    EMax=18000000,
    minCha=0,
    maxCha=0.9,
    deadbandFrac=0.05,
    V_nominal=480,
    P_nominal=-2000,
    A=50,
    til=1.5707963267949,
    azi=0.26179938779915)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Math.Add loadPVDiff(k1=-1)
    annotation (Placement(transformation(extent={{60,6},{80,26}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid sink(f=60, V=480)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  BackupGenerator gen(
    minCha=0.1,
    startupTime=10,
    idleTime=1800,
    idlePower=100,
    eta=0.4,
    LHV(displayUnit="J/kg") = 42.6e6,
    MW=114)
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  Modelica.Blocks.Sources.TimeTable loadProfile(
    table=[0,0.05; 9,0.05; 9,0.2; 11,0.2; 11,0.1; 15,0.1; 15,0.3; 18,0.3; 18,1;
        20,1; 20,0.6; 22,0.6; 24,0.6; 24,0.05; 30,0.05; 30,0.3; 32,0.3; 32,0.05;
        42,0.05; 42,0.4; 43,0.4; 43,0.8; 44,0.8; 44,0.6; 46,0.6; 46,0.2; 48,0.2;
        48,0.05; 54,0.05; 54,0.2; 56,0.2; 56,0.1; 66,0.1; 66,0.7; 69,0.7; 69,
        0.4; 71,0.4; 71,0.05; 72,0.05; 78,0.05; 78,0.3; 80,0.3; 80,0.05; 90,
        0.05; 90,0.4; 91,0.4; 91,0.8; 92,0.8; 92,0.6; 94,0.6; 94,0.2; 96,0.2;
        96,0.05; 102,0.05; 102,0.2; 104,0.2; 104,0.1; 114,0.1; 114,0.7; 117,0.7;
        117,0.4; 119,0.4; 119,0.05; 120,0.05; 126,0.05; 126,0.3; 128,0.3; 128,
        0.05; 138,0.05; 138,0.4; 139,0.4; 139,0.8; 140,0.8; 140,0.6; 142,0.6;
        142,0.2; 144,0.2; 144,0.05; 150,0.05; 150,0.2; 152,0.2; 152,0.1; 162,
        0.1; 162,0.7; 165,0.7; 165,0.4; 167,0.4; 167,0.05; 168,0.05],
    timeScale(displayUnit="h") = 3600,
    shiftTime(displayUnit="s"))
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Continuous.Integrator fuelTot
    annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
  Modelica.Blocks.Math.Gain kg2gal(k=0.3019)
    annotation (Placement(transformation(extent={{-62,-40},{-82,-20}})));
  Modelica.Blocks.Continuous.Integrator co2Tot
    annotation (Placement(transformation(extent={{-20,-80},{-40,-60}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{10,50},{50,90}}),  iconTransformation(extent={{
            -282,-18},{-262,2}})));
equation
  connect(community.absLoa,loadPVDiff. u1) annotation (Line(points={{41,16},{54,
          16},{54,22},{58,22}}, color={0,0,127}));
  connect(community.pvP,loadPVDiff. u2) annotation (Line(points={{41,10},{58,10}},
                          color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{0,70},{30,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus,community. weaBus) annotation (Line(
      points={{30,70},{30,19}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sink.terminal,community. terminal) annotation (Line(points={{-50,20},
          {-50,10},{19.6,10}},  color={0,120,120}));
  connect(loadPVDiff.y,gen. loaDif) annotation (Line(points={{81,16},{90,16},{
          90,-24},{41,-24}},  color={0,0,127}));
  connect(community.batSOC,gen. batSOC) annotation (Line(points={{41,4},{50,4},
          {50,-36},{40.8,-36}},       color={0,0,127}));
  connect(gen.terminal,community. terminal) annotation (Line(points={{30.4,-20},
          {30.4,-10},{-10,-10},{-10,10},{19.6,10}},
                                   color={0,120,120}));
  connect(loadProfile.y,community. loa) annotation (Line(points={{1,30},{10,30},
          {10,16},{19,16}},      color={0,0,127}));
  connect(gen.fuelUsage,fuelTot. u) annotation (Line(points={{34,-41},{8,-41},{
          8,-30},{-18,-30}},    color={0,0,127}));
  connect(fuelTot.y,kg2gal. u)
    annotation (Line(points={{-41,-30},{-60,-30}},   color={0,0,127}));
  connect(gen.CO2,co2Tot. u) annotation (Line(points={{26,-41},{-10,-41},{-10,
          -70},{-18,-70}}, color={0,0,127}));
  connect(gen.P,community. auxP) annotation (Line(points={{19,-30},{10,-30},{10,
          4},{19,4}},         color={0,0,127}));
  annotation (Diagram(coordinateSystem(extent={{-120,-100},{120,100}})), Icon(
        coordinateSystem(extent={{-120,-100},{120,100}})));
end DistributedCommunity;
