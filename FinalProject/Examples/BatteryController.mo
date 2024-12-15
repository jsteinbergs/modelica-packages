within FinalProject.Examples;
model BatteryController "Test model for a battery controller"
  extends Modelica.Icons.Example;
  Buildings.Electrical.AC.ThreePhasesBalanced.Storage.Battery bat(
    SOC_start=0.05,
    EMax=48600000,
    V_nominal=480)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  FinalProject.BatteryController batCon(
    minSOC=0.4,
    maxSOC=0.9,
    chaRat=10e3,
    deadbandFrac=0.05)
    annotation (Placement(transformation(extent={{40,20},{20,40}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid gri(f=60, V=480)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Sine load(amplitude=5e3, f=1e-4)
    annotation (Placement(transformation(extent={{80,24},{60,44}})));
equation
  connect(batCon.P, bat.P)
    annotation (Line(points={{19,30},{10,30},{10,0}}, color={0,0,127}));
  connect(bat.SOC, batCon.SOC) annotation (Line(points={{21,-4},{52,-4},{52,26},
          {41,26}}, color={0,0,127}));
  connect(bat.terminal, gri.terminal)
    annotation (Line(points={{0,-10},{-30,-10},{-30,0}}, color={0,120,120}));
  connect(load.y, batCon.loaDif)
    annotation (Line(points={{59,34},{41,34}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This example demonstrates the use <a href=\"modelica://FinalProject.BatteryController\">
FinalProject.BatteryController</a>. </p>
<p>The model consists of a load difference varying with the sine function and a grid block. </p>
</html>"));
end BatteryController;
