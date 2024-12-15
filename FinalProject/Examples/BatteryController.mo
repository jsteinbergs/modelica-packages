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
<p>Model for a generator driven by a fossil fuel engine. </p>
<p>This model determines the output power based on the difference between the system load and renewable sources. The input parameters for engine efficiency and fuel chemistry are used to estimate fuel consumption and emissions. </p>
<h4>Limitations</h4>
<p>This model does account for varaible engine efficiency. </p>
<h4>Validation</h4>
<p>The model has been validated against the analytical solution in the example
</html>"));
end BatteryController;
