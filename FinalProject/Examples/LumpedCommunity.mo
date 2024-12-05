within FinalProject.Examples;
model LumpedCommunity
  "Model for distinct community loads sharing a backup generator, PV array, and battery"
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "C:/Users/jrs7827/OneDrive - The Pennsylvania State University/Coursework/AE 597 - Modeilica/Final Project/weatherdata/COL_Bogota.802220_IWEC.mos")
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{10,26},{50,66}}),  iconTransformation(extent={{
            -282,-18},{-262,2}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid sink(f=60, V=480)
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  BackupGenerator gen(
    minSOC=0.1,
    maxSOC=0.7,
    startupTime=30,
    idlePower=100,
    eta=0.4,
    LHV(displayUnit="J/kg") = 46e6,
    MW=44.1)
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Storage.Battery bat(
    SOC_start=0.2,
    EMax=48600000,
    V_nominal=480)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.PVSimpleOriented pv(
    A=75,
    til=1.5707963267949,
    azi=0.26179938779915,
    V_nominal=480)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  ControlBattery batController(
    minSOC=0,
    maxSOC=0.95,
    chaRat=11500,
    deadbandFrac=0.05)
    annotation (Placement(transformation(extent={{-20,-60},{-40,-40}})));
  CommunityLoads loads(
    nu=5,
    P_nominal={-150,-150,-150,-150,-2000},
    pf={0.8,0.8,0.8,0.8,0.8})
            annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  Modelica.Blocks.Math.Add solarMinusLoad(k2=-1)
    annotation (Placement(transformation(extent={{80,-14},{100,6}})));
  Modelica.Blocks.Math.Add netP
    annotation (Placement(transformation(extent={{20,-60},{0,-40}})));
  Modelica.Blocks.Continuous.Integrator fuelTot(k=1)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Continuous.Integrator co2Tot
    annotation (Placement(transformation(extent={{80,-130},{100,-110}})));
  Modelica.Blocks.Sources.TimeTable loadHouse1(
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
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.TimeTable loadHouse2(
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
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.TimeTable loadHouse3(
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
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.TimeTable loadHouse4(
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
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.TimeTable loadRestaurant1(
    table=[0,0.1; 24,0.1; 33,0.1; 33,0.5; 35,0.5; 35,0.7; 39,0.7; 39,1; 45,1;
        45,0.4; 48,0.4; 48,0.1; 57,0.1; 57,0.5; 59,0.5; 59,0.7; 63,0.7; 63,1;
        69,1; 69,0.4; 72,0.4; 72,0.1; 81,0.1; 81,0.5; 83,0.5; 83,0.7; 87,0.7;
        87,1; 93,1; 93,0.4; 96,0.4; 96,0.1; 105,0.1; 105,0.5; 107,0.5; 107,0.7;
        111,0.7; 111,1; 117,1; 117,0.4; 120,0.4; 120,0.1; 129,0.1; 129,0.5; 131,
        0.5; 131,0.7; 135,0.7; 135,1; 141,1; 141,0.4; 144,0.4; 144,0.1; 153,0.1;
        153,0.5; 155,0.5; 155,0.7; 159,0.7; 159,1; 165,1; 165,0.4; 168,0.4; 168,
        0.1],
    timeScale(displayUnit="h") = 3600,
    shiftTime(displayUnit="s"))
    annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
  Modelica.Blocks.Continuous.Integrator eTot(k=1/(3600*1000))
    annotation (Placement(transformation(extent={{20,-100},{0,-80}})));
  Modelica.Blocks.Sources.RealExpression chaRat(y=0.95*batController.chaRat)
    annotation (Placement(transformation(extent={{32,-46},{52,-26}})));
  Modelica.Blocks.Continuous.Integrator genTot(k=1/(3600*1000))
    annotation (Placement(transformation(extent={{20,-130},{0,-110}})));
equation
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{0,50},{6,50},{6,46},{30,46}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bat.SOC,batController.SOC)  annotation (Line(points={{-59,-64},{-12,
          -64},{-12,-54},{-19,-54}}, color={0,0,127}));
  connect(batController.P, bat.P)
    annotation (Line(points={{-41,-50},{-70,-50},{-70,-60}}, color={0,0,127}));
  connect(weaBus, pv.weaBus) annotation (Line(
      points={{30,46},{30,19}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(loads.P, solarMinusLoad.u2)
    annotation (Line(points={{1,-10},{78,-10}}, color={0,0,127}));
  connect(pv.P, solarMinusLoad.u1)
    annotation (Line(points={{41,17},{60,17},{60,2},{78,2}}, color={0,0,127}));
  connect(solarMinusLoad.y, gen.loaDif) annotation (Line(points={{101,-4},{110,
          -4},{110,-44},{81,-44}}, color={0,0,127}));
  connect(bat.SOC, gen.batSOC) annotation (Line(points={{-59,-64},{-12,-64},{
          -12,-70},{90,-70},{90,-56},{80.8,-56}}, color={0,0,127}));
  connect(netP.y, batController.loaDif) annotation (Line(points={{-1,-50},{-12,
          -50},{-12,-46},{-19,-46}}, color={0,0,127}));
  connect(gen.P, netP.u1) annotation (Line(points={{59,-50},{40,-50},{40,-44},{
          22,-44}}, color={0,0,127}));
  connect(solarMinusLoad.y, netP.u2) annotation (Line(points={{101,-4},{110,-4},
          {110,-68},{40,-68},{40,-56},{22,-56}}, color={0,0,127}));
  connect(bat.terminal, loads.terminal) annotation (Line(points={{-80,-70},{-84,
          -70},{-84,-26},{-10.6,-26},{-10.6,-19.8}}, color={0,120,120}));
  connect(sink.terminal, loads.terminal) annotation (Line(points={{-110,-40},{
          -110,-44},{-84,-44},{-84,-26},{-10.6,-26},{-10.6,-19.8}}, color={0,
          120,120}));
  connect(pv.terminal, loads.terminal) annotation (Line(points={{20,10},{14,10},
          {14,-26},{-10.6,-26},{-10.6,-19.8}}, color={0,120,120}));
  connect(gen.terminal, loads.terminal) annotation (Line(points={{70.4,-40},{
          70.4,-26},{-10.6,-26},{-10.6,-19.8}}, color={0,120,120}));
  connect(gen.fuelUsage, fuelTot.u)
    annotation (Line(points={{74,-61},{74,-90},{78,-90}}, color={0,0,127}));
  connect(gen.CO2,co2Tot. u) annotation (Line(points={{66,-61},{66,-120},{78,
          -120}},          color={0,0,127}));
  connect(loadHouse1.y, loads.u[1]) annotation (Line(points={{-39,50},{-30,50},
          {-30,-12.4},{-20,-12.4}}, color={0,0,127}));
  connect(loadHouse2.y, loads.u[2]) annotation (Line(points={{-39,10},{-30,10},
          {-30,-11.2},{-20,-11.2}}, color={0,0,127}));
  connect(loadHouse3.y, loads.u[3]) annotation (Line(points={{-79,50},{-68,50},
          {-68,30},{-30,30},{-30,-10},{-20,-10}}, color={0,0,127}));
  connect(loadHouse4.y, loads.u[4]) annotation (Line(points={{-79,10},{-68,10},
          {-68,30},{-30,30},{-30,-8.8},{-20,-8.8}}, color={0,0,127}));
  connect(loadRestaurant1.y, loads.u[5]) annotation (Line(points={{-119,30},{
          -30,30},{-30,-7.6},{-20,-7.6}}, color={0,0,127}));
  connect(loads.P, eTot.u) annotation (Line(points={{1,-10},{28,-10},{28,-90},{
          22,-90}},                        color={0,0,127}));
  connect(chaRat.y, gen.chaRat)
    annotation (Line(points={{53,-36},{62,-36},{62,-39.2}}, color={0,0,127}));
  connect(gen.P, genTot.u) annotation (Line(points={{59,-50},{56,-50},{56,-120},
          {22,-120}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
            -140},{120,80}})),                                   Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-140},{120,80}})),
    experiment(
      StartTime=17539200,
      StopTime=17798400,
      __Dymola_Algorithm="Dassl"));
end LumpedCommunity;
