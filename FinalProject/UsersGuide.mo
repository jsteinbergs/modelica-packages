within FinalProject;
package UsersGuide "User's Guide"
  extends Modelica.Icons.Information;
  annotation (preferredView="info",
  Documentation(info="<html>
<h4>Overview</h4>
<p>
The package <code>FinalProject</code> consists of models
for microgrid systems. The package contains models
at the component, sub-system, and system level, which can be used as
templates or for generating custom system models.
</p>
<p>
All models exist in the top-layer given the size of the package. The sub-package
<a href=\"modelica://FinalProject.Examples\">
FinalProject.Examples</a>
contains system models that provide examples for verifcation and 
John Steinbergs' AE 597 Final Project at Penn State.
</p>

<h4>Content Summary</h4>

<p>
This section provides a summary of the models available in the package to
help a user navigate. However, refer to the specific
documentation of the model and subpackages for further modeling and implementation details.
</p>

<table summary=\"summary\" border=\"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collapse;\">
<tr><td valign=\"top\"><b>Model Name</b>
    </td>
    <td valign=\"top\"><b>Model Description</b>
    </td>
</tr>
<tr><td valign=\"top\"
    </td>
    <a href=\"modelica://FinalProject.BackupGenerator\">BackupGenerator</a>
    </td>
    <td valign=\"top\">Fossil fuel generator with control.
    </td>
</tr>
<tr><td valign=\"top\">
    <a href=\"modelica://FinalProject.BatteryController\">BatteryController</a>
    </td>
    <td valign=\"top\">Controller for batteries integrated with PV and auxillery power.
    </td>
</tr>
<tr><td valign=\"top\">
    <a href=\"modelica://FinalProject.DistributedBuilding\">DistributedBuilding</a>
    </td>
    <td valign=\"top\">Building with PV, battery, and electrical load for distributed microgrid systems.
    </td>
</tr>
<tr><td valign=\"top\">
    <a href=\"modelica://FinalProject.CommunityLoads\">CommunityLoads</a>
    </td>
    <td valign=\"top\">Aggregated load for community with multiple buildings.
    </td>
</table>

</html>"));
end UsersGuide;
