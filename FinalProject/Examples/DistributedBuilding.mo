within FinalProject.Examples;
model DistributedBuilding
  "Model for gird-connected residential home with PV array and battery (basis of MiniProject4)"
  extends Modelica.Icons.Example;
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.TimeTable loadProfile(
    table=[0,0.05; 9,0.05; 9,0.2; 11,0.2; 11,0.1; 15,0.1; 15,0.3; 18,0.3; 18,1;
        20,1; 20,0.6; 22,0.6; 24,0.6; 24,0.05; 30,0.05; 30,0.3; 32,0.3; 32,0.05;
        42,0.05; 42,0.4; 43,0.4; 43,0.8; 44,0.8; 44,0.6; 46,0.6; 46,0.2; 48,0.2;
        48,0.05; 54,0.05; 54,0.2; 56,0.2; 56,0.1; 66,0.1; 66,0.7; 69,0.7; 69,
        0.4; 71,0.4; 71,0.05; 72,0.05],
    timeScale(displayUnit="h") = 3600,
    shiftTime(displayUnit="s"))
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid gri(f=60, V=480)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  inner Modelica.Fluid.System system
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  FinalProject.DistributedBuilding house(
    chaRat=10e3,
    SOC_start=0.1,
    EMax=48600000,
    minSOC=0.1,
    maxSOC=0.9,
    deadbandFrac=0.05,
    V_nominal=480,
    P_nominal=-2000,
    A=20,
    til=0.5235987755983,
    azi=0.26179938779915)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-10,30},{30,70}}), iconTransformation(extent={{
            -282,-18},{-262,2}})));
  Modelica.Blocks.Sources.Constant auxPow(k=0)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
equation
  connect(gri.terminal, house.terminal) annotation (Line(points={{-70,0},{-70,
          -10},{-0.4,-10}},                     color={0,120,120}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-20,50},{10,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, house.weaBus) annotation (Line(
      points={{10,50},{10,-1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(loadProfile.y, house.loa) annotation (Line(points={{-19,10},{-10,10},
          {-10,-4},{-1,-4}}, color={0,0,127}));
  connect(auxPow.y, house.auxP) annotation (Line(points={{-19,-30},{-10,-30},{
          -10,-16},{-1,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>This example demonstrates the use <a href=\"modelica://FinalProject.DistributedBuilding\">
FinalProject.DistributedBuilding</a>. </p>
<p>The model consists of a load profile, gird block, Building's Library Chicago weather file, and no auxiliary power. This model was used to complete Mini Project 4 for AE 597 at The Pennsylvania State University. </p>
</html>"));
end DistributedBuilding;
