within ;
package FM3217_2026 "Collection of models as created in FM3217"

  package Tutorial1
    model SimplePendulum "Model of a simple pendulum"
      constant Modelica.Units.SI.Acceleration g = 9.81 "Gravitational constant";
      parameter Modelica.Units.SI.Length L = 1 "Length of the pendulum";

      //Now come the variables
      Modelica.Units.SI.Angle Theta(start= 0.1,
      fixed = true)
                   "Angle of pendulum";
      /* start of comment
  some comment
  */
      Modelica.Units.SI.AngularVelocity ThetaDot;
    equation
      ThetaDot = der(Theta);
      der(ThetaDot) = - g/L * sin(Theta);
    end SimplePendulum;
  end Tutorial1;

  package Tutorial2
    model Motor
      Modelica.Electrical.Analog.Basic.Resistor resistor
        annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
      Modelica.Electrical.Analog.Basic.Inductor inductor
        annotation (Placement(transformation(extent={{-28,30},{-8,50}})));
      Modelica.Electrical.Analog.Basic.RotationalEMF emf
        annotation (Placement(transformation(extent={{2,-8},{22,12}})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-86,-54},{-66,-34}})));
      Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-76,2})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia
        annotation (Placement(transformation(extent={{40,-8},{60,12}})));
      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-146,-18},{-106,22}})));
      Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
        "Flange of right shaft"
        annotation (Placement(transformation(extent={{84,-8},{104,12}})));
    equation
      connect(signalVoltage.p, resistor.p) annotation (Line(points={{-76,12},{
              -76,40},{-64,40},{-64,40}}, color={0,0,255}));
      connect(resistor.n, inductor.p)
        annotation (Line(points={{-44,40},{-28,40}}, color={0,0,255}));
      connect(inductor.n, emf.p)
        annotation (Line(points={{-8,40},{12,40},{12,12}}, color={0,0,255}));
      connect(signalVoltage.n, emf.n) annotation (Line(points={{-76,-8},{-76,
              -20},{12,-20},{12,-8}}, color={0,0,255}));
      connect(ground.p, emf.n) annotation (Line(points={{-76,-34},{-76,-20},{12,
              -20},{12,-8}}, color={0,0,255}));
      connect(emf.flange, inertia.flange_a)
        annotation (Line(points={{22,2},{40,2}}, color={0,0,0}));
      connect(inertia.flange_b, flange)
        annotation (Line(points={{60,2},{94,2}}, color={0,0,0}));
      connect(signalVoltage.v, u)
        annotation (Line(points={{-88,2},{-126,2}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Motor;

    model MotorDrive
      Motor motor
        annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end MotorDrive;
  end Tutorial2;
  annotation (uses(Modelica(version="4.0.0")));
end FM3217_2026;
