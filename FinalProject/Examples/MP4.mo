within FinalProject.Examples;
model MP4
  "Models RL load suplied by PV, battery, and grid for a residential home."
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_NY_Elmira.Rgnl.AP.725156_TMY3.mos"))
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.TimeTable loadProfile(
    table=[0,0.05; 9,0.05; 9,0.2; 11,0.2; 11,0.1; 15,0.1; 15,0.3; 18,0.3; 18,1;
        20,1; 20,0.6; 22,0.6; 24,0.6; 24,0.05; 30,0.05; 30,0.3; 32,0.3; 32,0.05;
        42,0.05; 42,0.4; 43,0.4; 43,0.8; 44,0.8; 44,0.6; 46,0.6; 46,0.2; 48,0.2;
        48,0.05; 54,0.05; 54,0.2; 56,0.2; 56,0.1; 66,0.1; 66,0.7; 69,0.7; 69,
        0.4; 71,0.4; 71,0.05; 72,0.05],
    timeScale(displayUnit="h") = 3600,
    shiftTime(displayUnit="s") = 518399)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid gri(f=60, V=480)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  FinalProject.ControlBattery control(
    minCha=0.1,
    maxCha=0.9,
    chaRat=5000,
    deadbandFrac=0.05)
    annotation (Placement(transformation(extent={{40,-40},{20,-20}})));
  FinalProject.PVBatterySys house(
    SOC_start=0.1,
    EMax=32400000,
    V_nominal=480,
    P_nominal=-2000,
    A=9.2,
    til=0.5235987755983,
    azi=0.26179938779915)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Math.Add loadPVDiff(k1=-1, k2=+1)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-10,30},{30,70}}), iconTransformation(extent={{
            -282,-18},{-262,2}})));
equation
  connect(gri.terminal, house.terminal) annotation (Line(points={{-70,-40},{-70,
          -44},{-10,-44},{-10,-10},{-0.4,-10}}, color={0,120,120}));
  connect(house.batSOC, control.cha) annotation (Line(points={{21,-16},{50,-16},
          {50,-34},{41,-34}}, color={0,0,127}));
  connect(house.absLoa, loadPVDiff.u1) annotation (Line(points={{21,-4},{28,-4},
          {28,16},{38,16}}, color={0,0,127}));
  connect(house.pvP, loadPVDiff.u2) annotation (Line(points={{21,-10},{32,-10},
          {32,4},{38,4}}, color={0,0,127}));
  connect(loadPVDiff.y, control.loaDif) annotation (Line(points={{61,10},{72,10},
          {72,-26},{41,-26}}, color={0,0,127}));
  connect(control.P, house.batP) annotation (Line(points={{19,-30},{-6,-30},{-6,
          -16},{-1,-16}}, color={0,0,127}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-20,50},{10,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(loadProfile.y, house.loa) annotation (Line(points={{-59,10},{-40,10},
          {-40,-4},{-1,-4}}, color={0,0,127}));
  connect(weaBus, house.weaBus) annotation (Line(
      points={{10,50},{10,-1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -60},{80,100}})),                                    Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-60},{80,100}})),
    experiment(
      StartTime=17539200,
      StopTime=17798400,
      __Dymola_Algorithm="Dassl"));
end MP4;
