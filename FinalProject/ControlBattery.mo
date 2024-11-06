within FinalProject;
model ControlBattery
  parameter Real minCha(min=0,max=1)
    "Minimum allowable charge";
  parameter Real maxCha(min=0,max=1)
    "Maximum allowable charge";
  parameter Modelica.Units.SI.Power chaRat(min=0)
    "Maximum charging rate";
  parameter Real deadbandFrac(min=0.01,max=0.99)
    "Fraction of charge used to define deadband";
  Modelica.Blocks.Logical.Switch dualModeSwitch
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Logical.Switch singleModeSwitch
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.StateGraph.StepWithSignal chargeOnly(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.StateGraph.Transition T3(condition=cha > maxCha)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Modelica.StateGraph.InitialStepWithSignal dualMode(nIn=2, nOut=2)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.StateGraph.Transition T1(condition=cha < minCha)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.StateGraph.Transition T4(condition=cha < maxCha - deadbandFrac)
    annotation (Placement(transformation(extent={{60,0},{80,20}})));
  Modelica.StateGraph.Transition T2(condition=cha > minCha + deadbandFrac)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.StateGraph.Step dischargeOnly(nIn=1, nOut=1)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Sources.RealExpression chargingRate(y=max(min(chaRat, loaDif),
        0))
    annotation (Placement(transformation(extent={{-60,-52},{-40,-32}})));
  Modelica.Blocks.Sources.RealExpression dischargingRate(y=min(max(-chaRat,
        loaDif), 0))
    annotation (Placement(transformation(extent={{-60,-68},{-40,-48}})));
  inner Modelica.StateGraph.StateGraphRoot stateGraphRoot
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Interfaces.RealInput loaDif
    annotation (Placement(transformation(extent={{-130,20},{-90,60}})));
  Modelica.Blocks.Interfaces.RealInput cha
    annotation (Placement(transformation(extent={{-130,-60},{-90,-20}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.RealExpression power(y=min(chaRat, max(-chaRat,
        loaDif)))
    annotation (Placement(transformation(extent={{-60,-32},{-40,-12}})));
equation
  connect(singleModeSwitch.y, dualModeSwitch.u3) annotation (Line(points={{1,-50},
          {10,-50},{10,-38},{18,-38}}, color={0,0,127}));
  connect(dualMode.outPort[1],T1. inPort) annotation (Line(points={{0.5,29.875},
          {12,29.875},{12,50},{26,50}},            color={0,0,0}));
  connect(dualMode.outPort[2],T3. inPort) annotation (Line(points={{0.5,30.125},
          {12,30.125},{12,10},{26,10}},            color={0,0,0}));
  connect(T1.outPort,chargeOnly. inPort[1])
    annotation (Line(points={{31.5,50},{39,50}},   color={0,0,0}));
  connect(T4.outPort,dualMode. inPort[1]) annotation (Line(points={{71.5,10},{86,
          10},{86,74},{-26,74},{-26,30},{-24,30},{-24,29.75},{-21,29.75}},
        color={0,0,0}));
  connect(chargeOnly.outPort[1],T2. inPort)
    annotation (Line(points={{60.5,50},{66,50}},   color={0,0,0}));
  connect(T2.outPort,dualMode. inPort[2]) annotation (Line(points={{71.5,50},{80,
          50},{80,68},{-26,68},{-26,30},{-21,30},{-21,30.25}},      color={0,0,
          0}));
  connect(dualMode.active, dualModeSwitch.u2)
    annotation (Line(points={{-10,19},{-10,-34},{8,-34},{8,-30},{18,-30}},
                                                           color={255,0,255}));
  connect(T3.outPort,dischargeOnly. inPort[1])
    annotation (Line(points={{31.5,10},{39,10}},   color={0,0,0}));
  connect(dischargeOnly.outPort[1],T4. inPort)
    annotation (Line(points={{60.5,10},{66,10}},   color={0,0,0}));
  connect(chargeOnly.active, singleModeSwitch.u2) annotation (Line(points={{50,39},
          {50,28},{6,28},{6,-32},{-30,-32},{-30,-50},{-22,-50}},  color={255,0,255}));
  connect(chargingRate.y, singleModeSwitch.u1)
    annotation (Line(points={{-39,-42},{-22,-42}},color={0,0,127}));
  connect(dischargingRate.y, singleModeSwitch.u3)
    annotation (Line(points={{-39,-58},{-22,-58}},color={0,0,127}));
  connect(P,P)
    annotation (Line(points={{110,0},{110,0}},     color={0,0,127}));
  connect(dualModeSwitch.y, P) annotation (Line(points={{41,-30},{96,-30},{96,0},
          {110,0}}, color={0,0,127}));
  connect(power.y, dualModeSwitch.u1)
    annotation (Line(points={{-39,-22},{18,-22}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(
          extent={{-60,40},{-20,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{20,40},{60,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,20},{40,-10}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-50,24},{-38,12}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{26,-2},{38,-14}},
          lineColor={0,0,0},
          fillColor={255,255,85},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,-6},{-24,-10}},
          lineColor={0,0,0},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-34,0},{-30,-16}},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Ellipse(
          extent={{38,24},{50,12}},
          lineColor={0,0,0},
          fillColor={0,140,72},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{30,14},{36,8}},
          lineColor={0,0,0},
          fillColor={255,0,0},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,-88},{150,-48}},
          textColor={0,0,0},
          textString="%name")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
end ControlBattery;
