within FinalProject.Examples;
model LumpedCommunity
  "Models RL load suplied by PV, battery, and grid for a single block community"
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.TimeTable loadProfile(
    table=[0,0.5; 9,0.5; 9,0.2; 11,0.2; 11,0.1; 15,0.1; 15,0.3; 18,0.3; 18,1;
        20,1; 20,0.6; 22,0.6; 24,0.6; 24,0.05; 30,0.05; 30,0.3; 32,0.3; 32,0.05;
        42,0.05; 42,0.4; 43,0.4; 43,0.8; 44,0.8; 44,0.6; 46,0.6; 46,0.2; 48,0.2;
        48,0.05; 54,0.05; 54,0.2; 56,0.2; 56,0.1; 66,0.1; 66,0.7; 69,0.7; 69,
        0.4; 71,0.4; 71,0.05; 73,0.05],
    timeScale(displayUnit="h") = 3600,
    shiftTime=518399)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  FinalProject.ControlBattery batControl(
    minCha=0,
    maxCha=0.9,
    chaRat=5000,
    deadbandFrac=0.05)
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  FinalProject.PVBatterySys community(
    SOC_start=0.2,
    EMax=36000000,
    V_nominal=480,
    P_nominal=-2000,
    A=10,
    til=0.5235987755983,
    azi=0.26179938779915)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Math.Add loadPVDiff(k1=-1)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-10,30},{30,70}}), iconTransformation(extent={{
            -282,-18},{-262,2}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid sink(f=60, V=480)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Math.Add reqBatP
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  BackupGenerator gen(
    minCha=0.2,
    startupTime=10,
    idleTime=1800,
    idlePower=100,
    eta=0.4,
    LHV(displayUnit="J/kg") = 42.6e6,
    MW=114)
    annotation (Placement(transformation(extent={{-20,-60},{-40,-40}})));
equation
  connect(community.batSOC, batControl.cha) annotation (Line(points={{21,-16},{
          50,-16},{50,-34},{41,-34}}, color={0,0,127}));
  connect(community.absLoa, loadPVDiff.u1) annotation (Line(points={{21,-4},{28,
          -4},{28,16},{38,16}}, color={0,0,127}));
  connect(community.pvP, loadPVDiff.u2) annotation (Line(points={{21,-10},{32,-10},
          {32,4},{38,4}}, color={0,0,127}));
  connect(batControl.P, community.batP) annotation (Line(points={{19,-30},{-6,-30},
          {-6,-16},{-1,-16}}, color={0,0,127}));
  connect(loadProfile.y, community.loa) annotation (Line(points={{-19,10},{-10,
          10},{-10,-4},{-1,-4}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-20,50},{10,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, community.weaBus) annotation (Line(
      points={{10,50},{10,-1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sink.terminal, community.terminal) annotation (Line(points={{-70,0},{
          -70,-10},{-0.4,-10}}, color={0,120,120}));
  connect(loadPVDiff.y, reqBatP.u1) annotation (Line(points={{61,10},{110,10},{
          110,-24},{102,-24}}, color={0,0,127}));
  connect(reqBatP.y, batControl.loaDif) annotation (Line(points={{79,-30},{60,
          -30},{60,-26},{41,-26}}, color={0,0,127}));
  connect(gen.P, reqBatP.u2) annotation (Line(points={{-41,-56},{-50,-56},{-50,
          -70},{110,-70},{110,-36},{102,-36}}, color={0,0,127}));
  connect(loadPVDiff.y, gen.loaDif) annotation (Line(points={{61,10},{70,10},{
          70,-44},{-19,-44}}, color={0,0,127}));
  connect(community.batSOC, gen.batSOC) annotation (Line(points={{21,-16},{70,
          -16},{70,-56},{-19.2,-56}}, color={0,0,127}));
  connect(gen.terminal, community.terminal) annotation (Line(points={{-29.6,-40},
          {-29.6,-10},{-0.4,-10}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -80},{120,80}})),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-80},{120,80}})),
    experiment(
      StartTime=17539200,
      StopTime=17798400,
      __Dymola_Algorithm="Dassl"));
end LumpedCommunity;
