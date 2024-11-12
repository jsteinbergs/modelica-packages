within FinalProject;
model BackupGenerator
  parameter Real minCha(min=0,max=1)
    "Minimum SOC to start generator";
  parameter Modelica.Units.SI.Time startupTime(min=0)
    "Time for generator to startup";
  Modelica.StateGraph.InitialStep genOff(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.StateGraph.StepWithSignal genOn(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.StateGraph.Transition turnON(
    condition=loaDif < 0 and batSOC < minCha,
    enableTimer=true,
    waitTime=startupTime)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.StateGraph.Transition turnOff(condition=loaDif >= 0)
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=-1)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Generator gen(f=60)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Interfaces.RealInput loaDif
    annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
  Modelica.Blocks.Interfaces.RealInput batSOC
    annotation (Placement(transformation(extent={{-128,-80},{-88,-40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Interfaces.Terminal_p terminal
    annotation (Placement(transformation(extent={{-14,90},{6,110}})));
  Modelica.Blocks.Interfaces.RealOutput fuelUsage annotation (Placement(
        transformation(extent={{100,50},{120,70}}), iconTransformation(extent={{
            100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput emissions annotation (Placement(
        transformation(extent={{100,-10},{120,10}}),  iconTransformation(extent={{100,-10},
            {120,10}})));
  Modelica.Blocks.Interfaces.RealOutput P annotation (Placement(transformation(
          extent={{100,-70},{120,-50}}), iconTransformation(extent={{100,-70},{120,
            -50}})));
equation
  connect(genOff.outPort[1], turnON.inPort)
    annotation (Line(points={{-39.5,50},{-34,50}}, color={0,0,0}));
  connect(turnON.outPort, genOn.inPort[1]) annotation (Line(points={{-28.5,50},{
          -16,50},{-16,30},{-70,30},{-70,10},{-61,10}}, color={0,0,0}));
  connect(genOn.outPort[1], turnOff.inPort)
    annotation (Line(points={{-39.5,10},{-34,10}}, color={0,0,0}));
  connect(turnOff.outPort, genOff.inPort[1]) annotation (Line(points={{-28.5,10},
          {-10,10},{-10,68},{-68,68},{-68,50},{-61,50}}, color={0,0,0}));
  connect(genOn.active, booleanToReal.u) annotation (Line(points={{-50,-1},{-50,
          -30},{-42,-30}}, color={255,0,255}));
  connect(booleanToReal.y, product.u1) annotation (Line(points={{-19,-30},{-12,-30},
          {-12,-24},{-2,-24}}, color={0,0,127}));
  connect(product.y, gen.P)
    annotation (Line(points={{21,-30},{40,-30}}, color={0,0,127}));
  connect(gen.terminal, terminal) annotation (Line(points={{60,-30},{80,-30},{80,
          80},{0,80},{0,100},{-4,100}},
                                 color={0,120,120}));
  connect(fuelUsage, fuelUsage)
    annotation (Line(points={{110,60},{110,60}}, color={0,0,127}));
  connect(product.y, fuelUsage) annotation (Line(points={{21,-30},{32,-30},{32,-56},
          {94,-56},{94,60},{110,60}}, color={0,0,127}));
  connect(product.y, emissions) annotation (Line(points={{21,-30},{32,-30},{32,-56},
          {94,-56},{94,0},{110,0}},     color={0,0,127}));
  connect(loaDif, product.u2) annotation (Line(points={{-110,60},{-80,60},{-80,-60},
          {-10,-60},{-10,-36},{-2,-36}}, color={0,0,127}));
  connect(product.y, P) annotation (Line(points={{21,-30},{32,-30},{32,-56},{94,
          -56},{94,-60},{110,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-60,20},{20,-40}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={244,125,35},
          fillPattern=FillPattern.CrossDiag), Rectangle(
          extent={{20,0},{60,-20}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-88},{150,-48}},
          textColor={0,0,0},
          textString="%name")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
end BackupGenerator;
