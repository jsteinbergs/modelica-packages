within FinalProject.Examples;
model LumpedCommunity "Model for distinct community loads sharing a backup generator, PV array, and battery"
  extends Modelica.Icons.Example;
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        "C:/Users/jrs7827/OneDrive - The Pennsylvania State University/Coursework/AE 597 - Modeilica/Final Project/weatherdata/COL_ATL_Barranquilla-Cortissoz.Intl.AP.800280_TMYx.2009-2023.mos")
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{80,60},{100,80}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{10,46},{50,86}}),  iconTransformation(extent={{
            -282,-18},{-262,2}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid sink(f=60, V=480)
    annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
  BackupGenerator gen(
    minSOC=0.1,
    maxSOC=0.2,
    chaRat=0.95*batController.chaRat,
    startupTime=30,
    idlePower=100,
    eta=0.4,
    LHV(displayUnit="J/kg") = 46e6,
    CR=3)
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Storage.Battery bat(
    SOC_start=0.2,
    EMax=48600000,
    V_nominal=480)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.PVSimpleOriented pv(
    A=55,
    til=0.43633231299858,
    azi=0,
    V_nominal=480)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  BatteryController batController(
    minSOC=0,
    maxSOC=0.95,
    chaRat=11.5e3,
    deadbandFrac=0.05)
    annotation (Placement(transformation(extent={{-40,-50},{-60,-30}})));
  CommunityLoads loads(
    nu=5,
    P_nominal={-200,-200,-200,-200,-2000},
    pf={0.8,0.8,0.8,0.8,0.8})
            annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  Modelica.Blocks.Math.Add solarMinusLoad(k2=-1)
    annotation (Placement(transformation(extent={{80,6},{100,26}})));
  Modelica.Blocks.Math.Add netP
    annotation (Placement(transformation(extent={{0,-46},{-20,-26}})));
  Modelica.Blocks.Continuous.Integrator fuelTot(k=1)
    annotation (Placement(transformation(extent={{80,-100},{100,-80}})));
  Modelica.Blocks.Continuous.Integrator co2Tot
    annotation (Placement(transformation(extent={{40,-100},{60,-80}})));
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
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
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
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
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
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
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
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
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
    startTime=1.728e5,
    shiftTime(displayUnit="s"))
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Continuous.Integrator eTot(k=1/(3600*1000))
    annotation (Placement(transformation(extent={{80,-26},{100,-6}})));
  Modelica.Blocks.Continuous.Integrator genTot(k=1/(3600*1000))
    annotation (Placement(transformation(extent={{0,-100},{-20,-80}})));
equation
  connect(loads.P, eTot.u) annotation (Line(points={{1,10},{70,10},{70,-16},{78,
          -16}},                           color={0,0,127},
      pattern=LinePattern.Dot));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{0,70},{6,70},{6,66},{30,66}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bat.SOC,batController.SOC)  annotation (Line(points={{-59,-64},{-30,-64},
          {-30,-44},{-39,-44}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(batController.P, bat.P)
    annotation (Line(points={{-61,-40},{-70,-40},{-70,-60}}, color={0,0,127}));
  connect(weaBus, pv.weaBus) annotation (Line(
      points={{30,66},{30,39}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pv.P, solarMinusLoad.u1)
    annotation (Line(points={{41,37},{60,37},{60,22},{78,22}},
                                                             color={0,0,127}));
  connect(solarMinusLoad.y, gen.loaDif) annotation (Line(points={{101,16},{104,16},
          {104,2},{41,2},{41,-24}},color={0,0,127}));
  connect(netP.y, batController.loaDif) annotation (Line(points={{-21,-36},{-39,
          -36}},                     color={0,0,127}));
  connect(solarMinusLoad.y, netP.u2) annotation (Line(points={{101,16},{110,16},
          {110,-42},{2,-42}},                    color={0,0,127}));
  connect(bat.terminal, loads.terminal) annotation (Line(points={{-80,-70},{-90,
          -70},{-90,-10},{-10.6,-10},{-10.6,0.2}},   color={0,120,120}));
  connect(sink.terminal, loads.terminal) annotation (Line(points={{-110,-50},{-110,
          -60},{-90,-60},{-90,-10},{-10.6,-10},{-10.6,0.2}},        color={0,
          120,120}));
  connect(pv.terminal, loads.terminal) annotation (Line(points={{20,30},{10,30},
          {10,-10},{-10.6,-10},{-10.6,0.2}},   color={0,120,120}));
  connect(gen.terminal, loads.terminal) annotation (Line(points={{30.4,-20},{30.4,
          -10},{-10.6,-10},{-10.6,0.2}},        color={0,120,120}));
  connect(gen.CO2,co2Tot. u) annotation (Line(points={{26,-41},{26,-90},{38,-90}},
                           color={0,0,127},
      pattern=LinePattern.Dot));
  connect(loadHouse1.y, loads.u[1]) annotation (Line(points={{-39,70},{-30,70},{
          -30,7.6},{-20,7.6}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(loadHouse2.y, loads.u[2]) annotation (Line(points={{-39,30},{-30,30},{
          -30,8.8},{-20,8.8}},      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(loadHouse3.y, loads.u[3]) annotation (Line(points={{-79,70},{-68,70},{
          -68,50},{-30,50},{-30,10},{-20,10}},    color={0,0,127},
      pattern=LinePattern.Dash));
  connect(loadHouse4.y, loads.u[4]) annotation (Line(points={{-79,30},{-68,30},{
          -68,50},{-30,50},{-30,11.2},{-20,11.2}},  color={0,0,127},
      pattern=LinePattern.Dash));
  connect(loadRestaurant1.y, loads.u[5]) annotation (Line(points={{-99,50},{-30,
          50},{-30,12.4},{-20,12.4}},     color={0,0,127},
      pattern=LinePattern.Dash));
  connect(gen.P, genTot.u) annotation (Line(
      points={{19,-30},{10,-30},{10,-90},{2,-90}},
      color={28,108,200},
      pattern=LinePattern.Dot));
  connect(gen.P, netP.u1)
    annotation (Line(points={{19,-30},{2,-30}},  color={0,0,127}));
  connect(loads.P, solarMinusLoad.u2)
    annotation (Line(points={{1,10},{78,10}},   color={0,0,127}));
  connect(gen.fuelUsage, fuelTot.u) annotation (Line(
      points={{34,-41},{34,-60},{70,-60},{70,-90},{78,-90}},
      color={0,0,127},
      pattern=LinePattern.Dot));
  connect(bat.SOC, gen.batSOC) annotation (Line(
      points={{-59,-64},{50,-64},{50,-36},{40.8,-36}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}})),                                  Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-120},{120,
            100}})),
    experiment(
      StartTime=17539200,
      StopTime=17798400,
      __Dymola_Algorithm="Dassl"));
end LumpedCommunity;
