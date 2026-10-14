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
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=0.5)
        annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
      Modelica.Electrical.Analog.Basic.Inductor inductor(L=0.05)
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
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J=0.001)
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
        annotation (Placement(transformation(extent={{2,-10},{22,10}})));
      Modelica.Blocks.Sources.Step step(startTime=0.5)
        annotation (Placement(transformation(extent={{-92,-10},{-72,10}})));
      Modelica.Blocks.Math.Feedback feedback
        annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
      Modelica.Blocks.Continuous.PID PID(
        k=10,
        Ti=2,
        Td=0.01)
        annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
      Modelica.Mechanics.Rotational.Components.IdealGear idealGear(ratio=100)
        annotation (Placement(transformation(extent={{32,-10},{52,10}})));
      Modelica.Mechanics.Rotational.Components.Inertia inertia(J=5)
        annotation (Placement(transformation(extent={{62,-10},{82,10}})));
      Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor annotation (
         Placement(transformation(
            extent={{10,-10},{-10,10}},
            rotation=0,
            origin={74,-34})));
    equation
      connect(feedback.u1, step.y)
        annotation (Line(points={{-58,0},{-71,0}}, color={0,0,127}));
      connect(feedback.y, PID.u)
        annotation (Line(points={{-41,0},{-30,0}}, color={0,0,127}));
      connect(PID.y, motor.u) annotation (Line(points={{-7,0},{-4,0},{-4,0.2},{
              -0.6,0.2}}, color={0,0,127}));
      connect(motor.flange, idealGear.flange_a) annotation (Line(points={{21.4,
              0.2},{26,0.2},{26,0},{32,0}}, color={0,0,0}));
      connect(idealGear.flange_b, inertia.flange_a)
        annotation (Line(points={{52,0},{62,0}}, color={0,0,0}));
      connect(angleSensor.phi, feedback.u2) annotation (Line(points={{63,-34},{
              -50,-34},{-50,-8}}, color={0,0,127}));
      connect(inertia.flange_b, angleSensor.flange) annotation (Line(points={{
              82,0},{94,0},{94,-34},{84,-34}}, color={0,0,0}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=100));
    end MotorDrive;
  end Tutorial2;
  annotation (uses(Modelica(version="4.0.0")));
end FM3217_2026;
