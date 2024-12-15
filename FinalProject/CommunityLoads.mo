within FinalProject;
model CommunityLoads "Model to lump together 5 distinct inductive loads"
  parameter Integer nu(min=0) = 0 "Number of input connections";
  parameter Modelica.Units.SI.Power P_nominal[nu]
    "Maximum electrical load";
  parameter Real pf[nu](min=0,max=1)
    "Power factor of the load";

  Buildings.Electrical.AC.ThreePhasesBalanced.Interfaces.Terminal_p terminal
    annotation (Placement(transformation(extent={{-16,-108},{4,-88}})));
  Modelica.Blocks.Sources.RealExpression loadPos(y=-u*P_nominal)
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL1(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal[1],
    pf=pf[1]) annotation (Placement(transformation(extent={{-20,50},{-40,70}})));
  Modelica.Blocks.Interfaces.RealVectorInput u[nu] annotation (Placement(
        transformation(extent={{-120,-60},{-80,60}}), iconTransformation(extent
          ={{-120,-60},{-80,60}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL2(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal[2],
    pf=pf[2]) annotation (Placement(transformation(extent={{-20,20},{-40,40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL3(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal[3],
    pf=pf[3]) annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL4(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal[4],
    pf=pf[4]) annotation (Placement(transformation(extent={{-20,-40},{-40,-20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Loads.Inductive loadRL5(
    mode=Buildings.Electrical.Types.Load.VariableZ_y_input,
    P_nominal=P_nominal[5],
    pf=pf[5]) annotation (Placement(transformation(extent={{-20,-70},{-40,-50}})));
equation
  connect(loadPos.y, P)
    annotation (Line(points={{91,0},{110,0}}, color={0,0,127}));
  connect(loadRL1.terminal, terminal)
    annotation (Line(points={{-20,60},{-6,60},{-6,-98}}, color={0,120,120}));
  connect(u[2], loadRL2.y) annotation (Line(points={{-100,0},{-48,0},{-48,30},{
          -40,30}}, color={0,0,127}));
  connect(u[3], loadRL3.y)
    annotation (Line(points={{-100,0},{-40,0}}, color={0,0,127}));
  connect(u[4], loadRL4.y) annotation (Line(points={{-100,0},{-48,0},{-48,-30},
          {-40,-30}}, color={0,0,127}));
  connect(u[5], loadRL5.y) annotation (Line(points={{-100,0},{-48,0},{-48,-60},
          {-40,-60}}, color={0,0,127}));
  connect(loadRL2.terminal, terminal)
    annotation (Line(points={{-20,30},{-6,30},{-6,-98}}, color={0,120,120}));
  connect(loadRL3.terminal, terminal)
    annotation (Line(points={{-20,0},{-6,0},{-6,-98}}, color={0,120,120}));
  connect(loadRL4.terminal, terminal)
    annotation (Line(points={{-20,-30},{-6,-30},{-6,-98}}, color={0,120,120}));
  connect(loadRL5.terminal, terminal)
    annotation (Line(points={{-20,-60},{-6,-60},{-6,-98}}, color={0,120,120}));
  connect(u[1], loadRL1.y) annotation (Line(points={{-100,0},{-48,0},{-48,60},{
          -40,60}}, color={0,0,127}));
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
          thickness=1)}), Documentation(info="<html>
<p>Model to aggregate a multibuilding electrical load. </p>
<p>This model commbines the electrical loads of 5 buildings. </p>
<h4>Limitations</h4>
<p>The number of buildings in hard coded and should ideally be vectorized. </p>
<h4>Validation</h4>
<p>The model has been verified in the example, but not validated.
</html>"));
end CommunityLoads;
