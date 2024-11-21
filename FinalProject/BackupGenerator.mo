within FinalProject;
model BackupGenerator
  parameter Real minSOC(min=0,max=1)
    "Minimum SOC to start generator";
  parameter Real partSOC(min=0,max=1)
    "Minimum SOC to put generator into partial load";
  parameter Real maxSOC(min=0,max=1)
    "Minimum SOC to shutdown generator";
  parameter Modelica.Units.SI.Time startupTime(min=0)
    "Time generator takes to startup";
  parameter Modelica.Units.SI.Power idlePower
    "Minimum power output at idle";
  parameter Real partFrac
    "Partial load fraction";
  parameter Real eta(min=0,max=1)
    "Generator overall efficiency";
  parameter Modelica.Units.SI.SpecificEnergy LHV
    "Lower heating value of the fuel";
  parameter Real MW
    "Molar mass of fuel";
  Modelica.StateGraph.InitialStep genOff(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.StateGraph.StepWithSignal genFull(nIn=2, nOut=2)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.StateGraph.Transition turnON(
    condition=loaDif < 0 and batSOC < minSOC,
    enableTimer=true,
    waitTime=startupTime)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Modelica.StateGraph.Transition partIdle(condition=loaDif >= -idlePower,
      enableTimer=false)
    annotation (Placement(transformation(extent={{2,20},{22,40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Generator gen(f=60)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Interfaces.RealInput loaDif
    annotation (Placement(transformation(extent={{-130,40},{-90,80}})));
  Modelica.Blocks.Interfaces.RealInput batSOC
    annotation (Placement(transformation(extent={{-128,-80},{-88,-40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Interfaces.Terminal_p terminal
    annotation (Placement(transformation(extent={{-14,90},{6,110}})));
  Modelica.Blocks.Interfaces.RealOutput fuelUsage annotation (Placement(
        transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-110}),                         iconTransformation(extent={{-10,-10},
            {10,10}},
        rotation=-90,
        origin={-40,-110})));
  Modelica.Blocks.Interfaces.RealOutput CO2 annotation (Placement(
        transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,-110}),                           iconTransformation(extent={{-10,-10},
            {10,10}},
        rotation=-90,
        origin={40,-110})));
  Modelica.Blocks.Interfaces.RealOutput P annotation (Placement(transformation(
          extent={{100,-10},{120,10}}),  iconTransformation(extent={{100,-10},{
            120,10}})));
  Modelica.Blocks.Sources.RealExpression energyReq(y=1/(eta*LHV))
    annotation (Placement(transformation(extent={{-10,-66},{10,-46}})));
  Modelica.Blocks.Math.Product fuelMass
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Math.Product co2Emissions
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
  Modelica.Blocks.Sources.RealExpression massRatio(y=44/MW)
    annotation (Placement(transformation(extent={{30,-88},{50,-68}})));
  Modelica.Blocks.Sources.RealExpression idleP(y=if genIdle.active then -
        idlePower else 0)
    annotation (Placement(transformation(extent={{-60,-54},{-40,-34}})));
  Modelica.StateGraph.StepWithSignal genIdle(nIn=3, nOut=2)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.StateGraph.Transition turnOff(condition=batSOC > maxSOC,
                enableTimer=false)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.StateGraph.Transition fullOn(condition=loaDif < -idlePower,
      enableTimer=false)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica.StateGraph.StepWithSignal genPart(nIn=1, nOut=2)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.StateGraph.Transition partOn(condition=batSOC > partSOC,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.StateGraph.Transition partFull(condition=batSOC < minSOC,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.StateGraph.Transition fullIdle(condition=loaDif >= -idlePower,
      enableTimer=false)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.Blocks.Sources.RealExpression fullP(y=if genFull.active then loaDif
         else 0)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.RealExpression partP(y=if genPart.active then min(-
        idlePower, loaDif*partFrac) else 0)
    annotation (Placement(transformation(extent={{-60,-26},{-40,-6}})));
  Modelica.Blocks.Math.Add3 add3(
    k1=-1,
    k2=-1,
    k3=-1) annotation (Placement(transformation(extent={{-18,-40},{2,-20}})));
equation
  connect(genOff.outPort[1], turnON.inPort)
    annotation (Line(points={{-39.5,70},{-34,70}}, color={0,0,0}));
  connect(gen.terminal, terminal) annotation (Line(points={{60,30},{50,30},{50,28},
          {40,28},{40,90},{0,90},{0,96},{-4,96},{-4,100}},
                                 color={0,120,120}));
  connect(fuelUsage, fuelUsage)
    annotation (Line(points={{-40,-110},{-40,-110}},
                                                 color={0,0,127}));
  connect(massRatio.y, co2Emissions.u2)
    annotation (Line(points={{51,-78},{52,-76},{58,-76}},
                                               color={0,0,127}));
  connect(co2Emissions.y, CO2) annotation (Line(points={{81,-70},{86,-70},{86,
          -96},{40,-96},{40,-110}},
                   color={0,0,127}));
  connect(turnOff.outPort, genOff.inPort[1])
    annotation (Line(points={{-68.5,70},{-61,70}}, color={0,0,0}));
  connect(turnON.outPort, genIdle.inPort[1]) annotation (Line(points={{-28.5,70},
          {-24,70},{-24,69.6667},{-21,69.6667}}, color={0,0,0}));
  connect(fullOn.outPort, genFull.inPort[1]) annotation (Line(points={{11.5,70},
          {24,70},{24,48},{-64,48},{-64,29.75},{-61,29.75}}, color={0,0,0}));
  connect(genIdle.outPort[1], fullOn.inPort) annotation (Line(points={{0.5,69.875},
          {4,69.875},{4,70},{6,70}}, color={0,0,0}));
  connect(genFull.outPort[1], partOn.inPort) annotation (Line(points={{-39.5,29.875},
          {-36,29.875},{-36,30},{-34,30}}, color={0,0,0}));
  connect(partOn.outPort, genPart.inPort[1])
    annotation (Line(points={{-28.5,30},{-21,30}}, color={0,0,0}));
  connect(partFull.outPort, genFull.inPort[2]) annotation (Line(points={{-68.5,30},
          {-68,30.25},{-61,30.25}}, color={0,0,0}));
  connect(genPart.outPort[1], partFull.inPort) annotation (Line(points={{0.5,29.875},
          {4,29.875},{4,10},{-86,10},{-86,30},{-74,30}}, color={0,0,0}));
  connect(partIdle.outPort, genIdle.inPort[2]) annotation (Line(points={{13.5,30},
          {20,30},{20,52},{-20,52},{-20,64},{-21,64},{-21,70}}, color={0,0,0}));
  connect(genFull.outPort[2], fullIdle.inPort) annotation (Line(points={{-39.5,30.125},
          {-40,30.125},{-40,10},{26,10}}, color={0,0,0}));
  connect(fullIdle.outPort, genIdle.inPort[3]) annotation (Line(points={{31.5,10},
          {44,10},{44,26},{26,26},{26,52},{-21,52},{-21,70.3333}}, color={0,0,0}));
  connect(genIdle.outPort[2], turnOff.inPort) annotation (Line(points={{0.5,70.125},
          {0,70.125},{0,88},{-84,88},{-84,70},{-74,70}}, color={0,0,0}));
  connect(partP.y, add3.u1) annotation (Line(points={{-39,-16},{-28,-16},{-28,-22},
          {-20,-22}}, color={0,0,127}));
  connect(fullP.y, add3.u2)
    annotation (Line(points={{-39,-30},{-20,-30}}, color={0,0,127}));
  connect(idleP.y, add3.u3) annotation (Line(points={{-39,-44},{-28,-44},{-28,-38},
          {-20,-38}}, color={0,0,127}));
  connect(energyReq.y, fuelMass.u2)
    annotation (Line(points={{11,-56},{18,-56}}, color={0,0,127}));
  connect(add3.y, fuelMass.u1) annotation (Line(points={{3,-30},{10,-30},{10,-44},
          {18,-44}}, color={0,0,127}));
  connect(fuelMass.y, co2Emissions.u1) annotation (Line(points={{41,-50},{50,-50},
          {50,-64},{58,-64}}, color={0,0,127}));
  connect(add3.y, gen.P) annotation (Line(points={{3,-30},{90,-30},{90,30},{80,30}},
        color={0,0,127}));
  connect(add3.y, P) annotation (Line(points={{3,-30},{90,-30},{90,0},{110,0}},
        color={0,0,127}));
  connect(genPart.outPort[2], partIdle.inPort)
    annotation (Line(points={{0.5,30.125},{0,30},{8,30}}, color={0,0,0}));
  connect(fuelMass.y, fuelUsage) annotation (Line(points={{41,-50},{50,-50},{50,
          -64},{16,-64},{16,-96},{-40,-96},{-40,-110}}, color={0,0,127}));
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
