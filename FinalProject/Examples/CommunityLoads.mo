within FinalProject.Examples;
model CommunityLoads "Model for multi-building community electrical load"
  extends Modelica.Icons.Example;
  FinalProject.CommunityLoads comLoa(
    nu=5,
    P_nominal={-200,-500,-5000,-50,-2000},
    pf={0.8,0.8,0.8,0.8,0.8})
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid gri(f=60, V=480)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Sources.Sine sin(
    amplitude=0.5,
    f=1e-4,
    offset=0.5)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant con(k=0.5)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.TimeTable timTab(
    table=[0,0; 6,0; 6,0.6; 12,0.6; 12,0.3; 24,1],
    timeScale(displayUnit="h") = 3600,
    shiftTime(displayUnit="s"))
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Pulse pul(
    amplitude=1,
    width=20,
    period=1800)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.Ramp ram(height=1, duration=5.76e4)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(gri.terminal, comLoa.terminal) annotation (Line(points={{30,-40},{30,
          -44},{9.4,-44},{9.4,0.2}}, color={0,120,120}));
  connect(sin.y, comLoa.u[1]) annotation (Line(points={{-39,80},{-10,80},{-10,
          7.6},{0,7.6}}, color={0,0,127}));
  connect(con.y, comLoa.u[2]) annotation (Line(points={{-39,40},{-10,40},{-10,
          8.8},{0,8.8}}, color={0,0,127}));
  connect(timTab.y, comLoa.u[3]) annotation (Line(points={{-39,0},{-10,0},{-10,
          10},{0,10}}, color={0,0,127}));
  connect(pul.y, comLoa.u[4]) annotation (Line(points={{-39,-40},{-10,-40},{-10,
          11.2},{0,11.2}}, color={0,0,127}));
  connect(ram.y, comLoa.u[5]) annotation (Line(points={{-39,-80},{-10,-80},{-10,
          12.4},{0,12.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end CommunityLoads;
