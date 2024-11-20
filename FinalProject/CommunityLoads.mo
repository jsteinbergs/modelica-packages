within FinalProject;
model CommunityLoads
  parameter Integer nu(min=0) = 0 "Number of input connections";
  parameter Modelica.Units.SI.Power P_nominal
    "Maximum electrical load";
  parameter Real pf(min=0,max=1)
    "Power factor of the load";

  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL5(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf) annotation (Placement(transformation(extent={{-10,-60},{-30,-40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Interfaces.Terminal_p terminal
    annotation (Placement(transformation(extent={{-16,-108},{4,-88}})));
  Modelica.Blocks.Sources.RealExpression loadAbs(y=abs(loadRL5.P))
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealVectorInput u[nu] annotation (Placement(
        transformation(extent={{-120,-60},{-80,60}}), iconTransformation(extent
          ={{-120,-60},{-80,60}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL1(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf)
    annotation (Placement(transformation(extent={{-10,60},{-30,80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL2(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf)
    annotation (Placement(transformation(extent={{-10,28},{-30,48}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL3(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf)
    annotation (Placement(transformation(extent={{-10,0},{-30,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL4(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf)
    annotation (Placement(transformation(extent={{-10,-30},{-30,-10}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL10(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf) annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL6(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf)
    annotation (Placement(transformation(extent={{8,60},{28,80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL7(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf)
    annotation (Placement(transformation(extent={{8,28},{28,48}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL8(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf)
    annotation (Placement(transformation(extent={{8,0},{28,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL9(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal,
    pf=pf) annotation (Placement(transformation(extent={{8,-30},{28,-10}})));
  Modelica.Blocks.Sources.RealExpression P1(y=u[1])
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.RealExpression P2(y=u[2])
    annotation (Placement(transformation(extent={{-60,28},{-40,48}})));
  Modelica.Blocks.Sources.RealExpression P3(y=0)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.RealExpression P4(y=0)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Sources.RealExpression P5(y=0)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Sources.RealExpression P6(y=0)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));
  Modelica.Blocks.Sources.RealExpression P7(y=0)
    annotation (Placement(transformation(extent={{60,28},{40,48}})));
  Modelica.Blocks.Sources.RealExpression P8(y=0)
    annotation (Placement(transformation(extent={{60,0},{40,20}})));
  Modelica.Blocks.Sources.RealExpression P9(y=0)
    annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
  Modelica.Blocks.Sources.RealExpression P10(y=0)
    annotation (Placement(transformation(extent={{60,-60},{40,-40}})));
equation
  connect(loadAbs.y, P)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(loadRL1.terminal, terminal)
    annotation (Line(points={{-10,70},{-6,70},{-6,-98}}, color={0,120,120}));
  connect(loadRL2.terminal, terminal)
    annotation (Line(points={{-10,38},{-6,38},{-6,-98}}, color={0,120,120}));
  connect(loadRL3.terminal, terminal)
    annotation (Line(points={{-10,10},{-6,10},{-6,-98}}, color={0,120,120}));
  connect(loadRL4.terminal, terminal)
    annotation (Line(points={{-10,-20},{-6,-20},{-6,-98}}, color={0,120,120}));
  connect(loadRL5.terminal, terminal)
    annotation (Line(points={{-10,-50},{-6,-50},{-6,-98}}, color={0,120,120}));
  connect(loadRL6.terminal, terminal)
    annotation (Line(points={{8,70},{-6,70},{-6,-98}}, color={0,120,120}));
  connect(loadRL7.terminal, terminal)
    annotation (Line(points={{8,38},{-6,38},{-6,-98}}, color={0,120,120}));
  connect(loadRL8.terminal, terminal)
    annotation (Line(points={{8,10},{-6,10},{-6,-98}}, color={0,120,120}));
  connect(loadRL9.terminal, terminal)
    annotation (Line(points={{8,-20},{-6,-20},{-6,-98}}, color={0,120,120}));
  connect(loadRL10.terminal, terminal)
    annotation (Line(points={{10,-50},{-6,-50},{-6,-98}}, color={0,120,120}));
  connect(P1.y, loadRL1.y)
    annotation (Line(points={{-39,70},{-30,70}}, color={0,0,127}));
  connect(P2.y, loadRL2.y)
    annotation (Line(points={{-39,38},{-30,38}}, color={0,0,127}));
  connect(P3.y, loadRL3.y)
    annotation (Line(points={{-39,10},{-30,10}}, color={0,0,127}));
  connect(P4.y, loadRL4.y)
    annotation (Line(points={{-39,-20},{-30,-20}}, color={0,0,127}));
  connect(P5.y, loadRL5.y)
    annotation (Line(points={{-39,-50},{-30,-50}}, color={0,0,127}));
  connect(P6.y, loadRL6.y)
    annotation (Line(points={{39,70},{28,70}}, color={0,0,127}));
  connect(P7.y, loadRL7.y)
    annotation (Line(points={{39,38},{28,38}}, color={0,0,127}));
  connect(P8.y, loadRL8.y)
    annotation (Line(points={{39,10},{28,10},{28,10}}, color={0,0,127}));
  connect(P9.y, loadRL9.y)
    annotation (Line(points={{39,-20},{28,-20}}, color={0,0,127}));
  connect(P10.y, loadRL10.y)
    annotation (Line(points={{39,-50},{30,-50}}, color={0,0,127}));
  annotation (Icon(graphics={
        Polygon(
          points={{-40,-40},{-40,40},{0,74},{40,40},{40,-40},{-40,-40}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-60,40},{0,74},{60,40},{-60,40}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-24,24},{26,4}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,128,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-10,-40},{10,-14}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={162,29,33},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{4,-28},{8,-32}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-88},{150,-48}},
          textColor={0,0,0},
          textString="%name"),
        Line(
          points={{-14,14},{-10,14},{-8,10},{-6,16},{-4,10},{-2,16},{0,10},{2,16},
              {4,10},{6,16},{8,10},{10,16},{12,12},{16,12}},
          color={0,0,0},
          thickness=1)}));
end CommunityLoads;
