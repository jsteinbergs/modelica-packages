within FinalProject;
model BackupGenerator
  parameter Real minCha(min=0,max=1)
    "Minimum SOC to start generator";
  parameter Modelica.Units.SI.Time startupTime(min=0)
    "Time generator takes to startup";
  parameter Modelica.Units.SI.Time idleTime(min=0)
    "Time generator idles before shutting down";
  parameter Modelica.Units.SI.Power idlePower
    "Idle power output";
  parameter Real eta(min=0,max=1)
    "Generator overall efficiency";
  parameter Modelica.Units.SI.SpecificEnergy LHV
    "Lower heating value of the fuel";
  parameter Real MW
    "Molar mass of fuel";
  Modelica.StateGraph.InitialStep genOff(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.StateGraph.StepWithSignal genOn(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.StateGraph.Transition turnON(
    condition=loaDif < 0 and batSOC < minCha,
    enableTimer=true,
    waitTime=startupTime)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.StateGraph.Transition turnOff(condition=loaDif >= 0,
    enableTimer=true,
    waitTime=idleTime)
              annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal(realTrue=-1)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Generator gen(f=60)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{70,70},{90,90}})));
  Modelica.Blocks.Interfaces.RealInput loaDif
    annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
  Modelica.Blocks.Interfaces.RealInput batSOC
    annotation (Placement(transformation(extent={{-128,-80},{-88,-40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Interfaces.Terminal_p terminal
    annotation (Placement(transformation(extent={{-14,90},{6,110}})));
  Modelica.Blocks.Interfaces.RealOutput fuelUsage annotation (Placement(
        transformation(extent={{100,50},{120,70}}), iconTransformation(extent={{
            100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput CO2 annotation (Placement(
        transformation(extent={{100,-10},{120,10}}), iconTransformation(extent=
            {{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput P annotation (Placement(transformation(
          extent={{100,-70},{120,-50}}), iconTransformation(extent={{100,-70},{120,
            -50}})));
  Modelica.Blocks.Sources.RealExpression energyReq(y=1/(eta*LHV))
    annotation (Placement(transformation(extent={{10,46},{30,66}})));
  Modelica.Blocks.Math.Product fuelMass
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Math.Product co2Emissions
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Modelica.Blocks.Sources.RealExpression massRatio(y=44/MW)
    annotation (Placement(transformation(extent={{40,4},{60,24}})));
  Modelica.Blocks.Logical.Switch idleSwitch
    annotation (Placement(transformation(extent={{-40,-92},{-20,-72}})));
  Modelica.Blocks.Sources.RealExpression idleP(y=-idlePower)
    annotation (Placement(transformation(extent={{-70,-100},{-50,-80}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=-idlePower)
    annotation (Placement(transformation(extent={{-70,-66},{-50,-46}})));
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
          0},{0,0},{0,100},{-4,100}},
                                 color={0,120,120}));
  connect(fuelUsage, fuelUsage)
    annotation (Line(points={{110,60},{110,60}}, color={0,0,127}));
  connect(product.y, P) annotation (Line(points={{21,-30},{30,-30},{30,-60},{110,
          -60}}, color={0,0,127}));
  connect(energyReq.y, fuelMass.u1)
    annotation (Line(points={{31,56},{38,56}}, color={0,0,127}));
  connect(product.y, fuelMass.u2) annotation (Line(points={{21,-30},{30,-30},{30,
          44},{38,44}}, color={0,0,127}));
  connect(fuelMass.y, co2Emissions.u1) annotation (Line(points={{61,50},{64,50},
          {64,26},{68,26}}, color={0,0,127}));
  connect(massRatio.y, co2Emissions.u2)
    annotation (Line(points={{61,14},{68,14}}, color={0,0,127}));
  connect(co2Emissions.y, CO2) annotation (Line(points={{91,20},{96,20},{96,0},{
          110,0}}, color={0,0,127}));
  connect(fuelMass.y, fuelUsage) annotation (Line(points={{61,50},{94,50},{94,60},
          {110,60}}, color={0,0,127}));
  connect(idleSwitch.y, product.u2) annotation (Line(points={{-19,-82},{-10,-82},
          {-10,-36},{-2,-36}}, color={0,0,127}));
  connect(idleP.y, idleSwitch.u3)
    annotation (Line(points={{-49,-90},{-42,-90}}, color={0,0,127}));
  connect(loaDif, idleSwitch.u1) annotation (Line(points={{-110,60},{-80,60},{-80,
          -74},{-42,-74}}, color={0,0,127}));
  connect(loaDif, lessThreshold.u) annotation (Line(points={{-110,60},{-80,60},{
          -80,-56},{-72,-56}}, color={0,0,127}));
  connect(lessThreshold.y, idleSwitch.u2) annotation (Line(points={{-49,-56},{-46,
          -56},{-46,-82},{-42,-82}}, color={255,0,255}));
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
