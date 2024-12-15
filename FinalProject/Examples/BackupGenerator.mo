within FinalProject.Examples;
model BackupGenerator "Test model for a backup generator coupled to a battery system"
  extends Modelica.Icons.Example;
  FinalProject.BackupGenerator bacGen(
    minSOC=0.1,
    maxSOC=0.9,
    chaRat=10e3,
    startupTime=60,
    idlePower=100,
    eta=0.4,
    LHV=50e6,
    CR=2.75) annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Buildings.Electrical.AC.ThreePhasesBalanced.Sources.Grid gri(f=60, V=480)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Constant batSOC(k=0.05)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.Sine generation(amplitude=5e3, f=1e-4)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
equation
  connect(gri.terminal, bacGen.terminal)
    annotation (Line(points={{10,40},{9.6,38},{9.6,20}}, color={0,120,120}));
  connect(generation.y, bacGen.loaDif) annotation (Line(points={{-39,30},{-22,
          30},{-22,16},{-1,16}}, color={0,0,127}));
  connect(batSOC.y, bacGen.batSOC) annotation (Line(points={{-39,-10},{-20,-10},
          {-20,4},{-0.8,4}}, color={0,0,127}));
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
end BackupGenerator;
