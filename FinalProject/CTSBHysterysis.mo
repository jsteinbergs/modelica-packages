within FinalProject;
model CTSBHysterysis
  "Replaces state graph in ControlTwoSourceBattery with hysterysis"
  parameter Real minCha(min=0,max=1)
    "Minimum allowable charge";
  parameter Real maxCha(min=0,max=1)
    "Maximum allowable charge";
  parameter Modelica.Units.SI.Power chaRat(min=0)
    "Maximum charging rate";
  Modelica.Blocks.Logical.Switch dualModeSwitch
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Logical.Switch singleModeSwitch
    annotation (Placement(transformation(extent={{-20,-60},{0,-40}})));
  Modelica.Blocks.Sources.RealExpression chargingRate(y=max(min(chaRat, loaDif),
        0))
    annotation (Placement(transformation(extent={{-60,-52},{-40,-32}})));
  Modelica.Blocks.Sources.RealExpression dischargingRate(y=min(max(-chaRat,
        loaDif), 0))
    annotation (Placement(transformation(extent={{-60,-68},{-40,-48}})));
  Modelica.Blocks.Interfaces.RealInput loaDif
    annotation (Placement(transformation(extent={{-130,20},{-90,60}})));
  Modelica.Blocks.Interfaces.RealInput cha
    annotation (Placement(transformation(extent={{-130,-60},{-90,-20}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Logical.Hysteresis chargeOnly(
    uLow=0,
    uHigh=0.1*minCha,
    pre_y_start=true)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Logical.Hysteresis dischargeOnly(uLow=0, uHigh=0.1*maxCha)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
  Modelica.Blocks.Sources.RealExpression chaSignal(y=cha - minCha)
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Sources.RealExpression dischaSignal(y=maxCha - cha)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Logical.And and1
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(singleModeSwitch.y, dualModeSwitch.u3) annotation (Line(points={{1,-50},
          {10,-50},{10,-38},{18,-38}}, color={0,0,127}));
  connect(chargingRate.y, singleModeSwitch.u1)
    annotation (Line(points={{-39,-42},{-22,-42}},color={0,0,127}));
  connect(dischargingRate.y, singleModeSwitch.u3)
    annotation (Line(points={{-39,-58},{-22,-58}},color={0,0,127}));
  connect(loaDif, dualModeSwitch.u1) annotation (Line(points={{-110,40},{-40,40},
          {-40,-22},{18,-22}}, color={0,0,127}));
  connect(P,P)
    annotation (Line(points={{110,0},{110,0}},     color={0,0,127}));
  connect(dualModeSwitch.y, P) annotation (Line(points={{41,-30},{96,-30},{96,0},
          {110,0}}, color={0,0,127}));
  connect(dischaSignal.y, dischargeOnly.u)
    annotation (Line(points={{1,30},{18,30}}, color={0,0,127}));
  connect(chaSignal.y, chargeOnly.u)
    annotation (Line(points={{1,70},{18,70}}, color={0,0,127}));
  connect(chargeOnly.y, and1.u1) annotation (Line(points={{41,70},{48,70},{48,
          50},{58,50}}, color={255,0,255}));
  connect(dischargeOnly.y, and1.u2) annotation (Line(points={{41,30},{50,30},{
          50,42},{58,42}}, color={255,0,255}));
  connect(and1.y, dualModeSwitch.u2) annotation (Line(points={{81,50},{84,50},{
          84,-14},{10,-14},{10,-30},{18,-30}}, color={255,0,255}));
  connect(dischargeOnly.y, singleModeSwitch.u2) annotation (Line(points={{41,30},
          {50,30},{50,0},{-30,0},{-30,-50},{-22,-50}}, color={255,0,255}));
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
end CTSBHysterysis;
