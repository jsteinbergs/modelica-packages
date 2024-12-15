within FinalProject;
model BackupGenerator "Model of a combustion backup generator"
  parameter Real minSOC(min=0,max=1,unit="1")
    "SOC to start generator";
  parameter Real maxSOC(min=0,max=1,unit="1")
    "SOC to shutdown generator";
  parameter Modelica.Units.SI.Power chaRat(min=0)
    "Maximum battery power";
  parameter Modelica.Units.SI.Time startupTime(min=0)
    "Time generator takes to startup";
  parameter Modelica.Units.SI.Power idlePower
    "Minimum power output at idle";
  parameter Real eta(min=0,max=1,unit="1")
    "Generator overall efficiency";
  parameter Modelica.Units.SI.SpecificEnergy LHV
    "Lower heating value of the fuel";
  parameter Real CR(unit="1")
    "CO2 to fuel mass ratio";
  Modelica.StateGraph.InitialStep genOff(nOut=1, nIn=1)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.StateGraph.StepWithSignal genFull(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.StateGraph.Transition turnON(
    condition=loaDif < 0 and (batSOC < minSOC or loaDif < -chaRat),
    enableTimer=true,
    waitTime=startupTime)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Generator gen(f=60)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
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
  Modelica.Blocks.Sources.RealExpression massRatio(y=CR)
    annotation (Placement(transformation(extent={{30,-86},{50,-66}})));
  Modelica.Blocks.Sources.RealExpression idleP(y=if genIdle.active then -
        idlePower else 0)
    annotation (Placement(transformation(extent={{-60,-48},{-40,-28}})));
  Modelica.StateGraph.StepWithSignal genIdle(nIn=2, nOut=2)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.StateGraph.Transition turnOff(condition=batSOC > maxSOC,
                enableTimer=false)
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.StateGraph.Transition fullOn(condition=loaDif < -idlePower,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Modelica.StateGraph.Transition fullIdle(condition=loaDif >= -idlePower,
      enableTimer=false)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.RealExpression fullP(y=if genFull.active then loaDif
         else 0)
    annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
  Modelica.Blocks.Math.Add add(k1=-1, k2=-1)
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
equation
  connect(genOff.outPort[1], turnON.inPort)
    annotation (Line(points={{-39.5,70},{-34,70}}, color={0,0,0}));
  connect(gen.terminal, terminal) annotation (Line(points={{60,30},{40,30},{40,
          90},{0,90},{0,100},{-4,100}},
                                 color={0,120,120}));
  connect(fuelUsage, fuelUsage)
    annotation (Line(points={{-40,-110},{-40,-110}},
                                                 color={0,0,127}));
  connect(massRatio.y, co2Emissions.u2)
    annotation (Line(points={{51,-76},{58,-76}},
                                               color={0,0,127}));
  connect(co2Emissions.y, CO2) annotation (Line(points={{81,-70},{86,-70},{86,
          -96},{40,-96},{40,-110}},
                   color={0,0,127}));
  connect(turnOff.outPort, genOff.inPort[1])
    annotation (Line(points={{-68.5,70},{-61,70}}, color={0,0,0}));
  connect(turnON.outPort, genIdle.inPort[1]) annotation (Line(points={{-28.5,70},
          {-6,70},{-6,49.75},{-1,49.75}},        color={0,0,0}));
  connect(fullOn.outPort, genFull.inPort[1]) annotation (Line(points={{-68.5,30},
          {-61,30}},                                         color={0,0,0}));
  connect(genIdle.outPort[1], fullOn.inPort) annotation (Line(points={{20.5,49.875},
          {24,49.875},{24,12},{-84,12},{-84,30},{-74,30}},
                                     color={0,0,0}));
  connect(genFull.outPort[1], fullIdle.inPort) annotation (Line(points={{-39.5,30},
          {-34,30}},                      color={0,0,0}));
  connect(fullIdle.outPort, genIdle.inPort[2]) annotation (Line(points={{-28.5,30},
          {-6,30},{-6,50.25},{-1,50.25}},                          color={0,0,0}));
  connect(genIdle.outPort[2], turnOff.inPort) annotation (Line(points={{20.5,50.125},
          {30,50.125},{30,8},{-86,8},{-86,70},{-74,70}}, color={0,0,0}));
  connect(energyReq.y, fuelMass.u2)
    annotation (Line(points={{11,-56},{18,-56}}, color={0,0,127}));
  connect(fuelMass.y, co2Emissions.u1) annotation (Line(points={{41,-50},{50,-50},
          {50,-64},{58,-64}}, color={0,0,127}));
  connect(fuelMass.y, fuelUsage) annotation (Line(points={{41,-50},{50,-50},{50,
          -64},{16,-64},{16,-96},{-40,-96},{-40,-110}}, color={0,0,127}));
  connect(fullP.y, add.u1)
    annotation (Line(points={{-39,-24},{-22,-24}}, color={0,0,127}));
  connect(idleP.y, add.u2) annotation (Line(points={{-39,-38},{-28,-38},{-28,-36},
          {-22,-36}}, color={0,0,127}));
  connect(add.y, gen.P) annotation (Line(points={{1,-30},{90,-30},{90,30},{80,30}},
        color={0,0,127}));
  connect(add.y, P) annotation (Line(points={{1,-30},{90,-30},{90,0},{110,0}},
        color={0,0,127}));
  connect(add.y, fuelMass.u1) annotation (Line(points={{1,-30},{10,-30},{10,-44},
          {18,-44}}, color={0,0,127}));
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
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
    Documentation(info="<html>
<p>Model for a generator driven by a fossil fuel engine. </p>
<p>This model determines the output power based on the difference between the system load and renewable sources. The input parameters for engine efficiency and fuel chemistry are used to estimate fuel consumption and emissions. </p>
<h4>Limitations</h4>
<p>This model does account for varaible engine efficiency. </p>
<h4>Validation</h4>
<p>The model has been verified in the example, but not validated.
</html>"));
end BackupGenerator;
