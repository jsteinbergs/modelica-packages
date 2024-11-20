within FinalProject.Examples;
model DistributedCommunity
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "C:/Users/jrs7827/OneDrive - The Pennsylvania State University/Coursework/AE 597 - Modeilica/Final Project/weatherdata/COL_Bogota.802220_IWEC.mos")
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  FinalProject.PVBatterySys build01(
    chaRat=5000,
    SOC_start=0.2,
    EMax=18000000,
    minCha=0,
    maxCha=0.9,
    deadbandFrac=0.05,
    V_nominal=480,
    P_nominal=-2000,
    A=15,
    til=1.5707963267949,
    azi=0.26179938779915)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Math.Add loadPVDiff(k1=-1)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid sink(f=60, V=480)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  FinalProject.BackupGenerator
                  gen(
    minCha=0.2,
    startupTime=10,
    idleTime=1800,
    idlePower=100,
    eta=0.4,
    LHV(displayUnit="J/kg") = 42.6e6,
    MW=114)
    annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
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
    annotation (Placement(transformation(extent={{-62,-22},{-82,-2}})));
  Modelica.Blocks.Math.Gain kg2gal(k=0.3019)
    annotation (Placement(transformation(extent={{-100,-22},{-120,-2}})));
  Modelica.Blocks.Continuous.Integrator co2Tot
    annotation (Placement(transformation(extent={{-60,-62},{-80,-42}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{10,50},{50,90}}),  iconTransformation(extent={{
            -282,-18},{-262,2}})));
  PVBatterySys build02(
    chaRat=5000,
    SOC_start=0.2,
    EMax=18000000,
    minCha=0,
    maxCha=0.9,
    deadbandFrac=0.05,
    V_nominal=480,
    P_nominal=-1000,
    A=10,
    til=1.5707963267949,
    azi=0.26179938779915)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  PVBatterySys build03(
    chaRat=5000,
    SOC_start=0.2,
    EMax=36000000,
    minCha=0,
    maxCha=0.9,
    deadbandFrac=0.05,
    V_nominal=480,
    P_nominal=-500,
    A=20,
    til=1.5707963267949,
    azi=0.26179938779915)
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Blocks.Math.Add loadPVDiff1(k1=-1)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Math.Add loadPVDiff2(k1=-1)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Math.MultiSum multiSum(nu=3)
    annotation (Placement(transformation(extent={{104,-36},{116,-24}})));
  Modelica.Blocks.Math.MultiSum multiSum1(nu=3)
    annotation (Placement(transformation(extent={{164,-56},{176,-44}})));
  Modelica.Blocks.Math.Gain gain(k=1/3)
    annotation (Placement(transformation(extent={{176,-92},{156,-72}})));
  Modelica.Blocks.Math.Gain gain1(k=1/3)
    annotation (Placement(transformation(extent={{-48,-90},{-28,-70}})));
equation
  connect(build01.absLoa, loadPVDiff.u1)
    annotation (Line(points={{41,16},{58,16}}, color={0,0,127}));
  connect(build01.pvP, loadPVDiff.u2)
    annotation (Line(points={{41,10},{52,10},{52,4},{58,4}}, color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{0,70},{30,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, build01.weaBus) annotation (Line(
      points={{30,70},{30,19}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sink.terminal, build01.terminal)
    annotation (Line(points={{-50,20},{-50,10},{19.6,10}}, color={0,120,120}));
  connect(gen.terminal, build01.terminal) annotation (Line(points={{-29.6,-20},
          {-29.6,10},{19.6,10}}, color={0,120,120}));
  connect(loadProfile.y, build01.loa) annotation (Line(points={{1,30},{10,30},{
          10,16},{19,16}}, color={0,0,127}));
  connect(gen.fuelUsage,fuelTot. u) annotation (Line(points={{-41,-30},{-50,-30},
          {-50,-12},{-60,-12}}, color={0,0,127}));
  connect(fuelTot.y,kg2gal. u)
    annotation (Line(points={{-83,-12},{-98,-12}},   color={0,0,127}));
  connect(gen.CO2,co2Tot. u) annotation (Line(points={{-41,-36},{-48,-36},{-48,
          -52},{-58,-52}}, color={0,0,127}));
  connect(loadProfile.y, build02.loa) annotation (Line(points={{1,30},{10,30},{
          10,-24},{19,-24}}, color={0,0,127}));
  connect(loadProfile.y, build03.loa) annotation (Line(points={{1,30},{10,30},{
          10,-64},{19,-64}}, color={0,0,127}));
  connect(build02.absLoa, loadPVDiff1.u1)
    annotation (Line(points={{41,-24},{58,-24}}, color={0,0,127}));
  connect(build02.pvP, loadPVDiff1.u2) annotation (Line(points={{41,-30},{48,
          -30},{48,-36},{58,-36}}, color={0,0,127}));
  connect(build03.absLoa, loadPVDiff2.u1)
    annotation (Line(points={{41,-64},{58,-64},{58,-64}}, color={0,0,127}));
  connect(build03.pvP, loadPVDiff2.u2) annotation (Line(points={{41,-70},{48,
          -70},{48,-76},{58,-76}}, color={0,0,127}));
  connect(loadPVDiff1.y, multiSum.u[1]) annotation (Line(points={{81,-30},{92,
          -30},{92,-31.4},{104,-31.4}}, color={0,0,127}));
  connect(loadPVDiff.y, multiSum.u[2]) annotation (Line(points={{81,10},{86,10},
          {86,-30},{92,-30},{92,-32},{100,-32},{100,-30},{104,-30}}, color={0,0,
          127}));
  connect(loadPVDiff2.y, multiSum.u[3]) annotation (Line(points={{81,-70},{94,
          -70},{94,-30},{100,-30},{100,-28.6},{104,-28.6}}, color={0,0,127}));
  connect(multiSum.y, gen.loaDif) annotation (Line(points={{117.02,-30},{122,
          -30},{122,-86},{-10,-86},{-10,-24},{-19,-24}}, color={0,0,127}));
  connect(build01.batSOC, multiSum1.u[1]) annotation (Line(points={{41,4},{48,4},
          {48,-8},{158,-8},{158,-51.4},{164,-51.4}}, color={0,0,127}));
  connect(build02.batSOC, multiSum1.u[2]) annotation (Line(points={{41,-36},{46,
          -36},{46,-50},{164,-50}}, color={0,0,127}));
  connect(build03.batSOC, multiSum1.u[3]) annotation (Line(points={{41,-76},{46,
          -76},{46,-48.6},{164,-48.6}}, color={0,0,127}));
  connect(multiSum1.y, gain.u) annotation (Line(points={{177.02,-50},{186,-50},
          {186,-82},{178,-82}}, color={0,0,127}));
  connect(gain.y, gen.batSOC) annotation (Line(points={{155,-82},{124,-82},{124,
          -88},{-14,-88},{-14,-44},{-12,-44},{-12,-36},{-19.2,-36}}, color={0,0,
          127}));
  connect(gen.P, gain1.u) annotation (Line(points={{-41,-24},{-56,-24},{-56,-36},
          {-86,-36},{-86,-80},{-50,-80}}, color={0,0,127}));
  connect(gain1.y, build01.auxP) annotation (Line(points={{-27,-80},{6,-80},{6,
          -18},{12,-18},{12,4},{19,4}}, color={0,0,127}));
  connect(gain1.y, build02.auxP) annotation (Line(points={{-27,-80},{6,-80},{6,
          -36},{19,-36}}, color={0,0,127}));
  connect(gain1.y, build03.auxP) annotation (Line(points={{-27,-80},{6,-80},{6,
          -76},{19,-76}}, color={0,0,127}));
  connect(build02.terminal, sink.terminal) annotation (Line(points={{19.6,-30},
          {-6,-30},{-6,10},{-50,10},{-50,20}}, color={0,120,120}));
  connect(build03.terminal, sink.terminal) annotation (Line(points={{19.6,-70},
          {-18,-70},{-18,20},{-50,20}}, color={0,120,120}));
  connect(weaBus, build02.weaBus) annotation (Line(
      points={{30,70},{30,26},{46,26},{46,-14},{30,-14},{30,-21}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(weaBus, build03.weaBus) annotation (Line(
      points={{30,70},{30,26},{46,26},{46,-28},{50,-28},{50,-46},{30,-46},{30,
          -61}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Diagram(coordinateSystem(extent={{-140,-100},{200,100}})), Icon(
        coordinateSystem(extent={{-140,-100},{200,100}})));
end DistributedCommunity;
