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

  package Tutorial3
    package Components
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

      model DCMachine

        parameter Modelica.Units.SI.Resistance R = 0.5 "Resistance of the armature";

        Modelica.Electrical.Analog.Basic.Resistor resistor(R=R)
          annotation (Placement(transformation(extent={{-64,30},{-44,50}})));
        Modelica.Electrical.Analog.Basic.Inductor inductor(L=L)
          annotation (Placement(transformation(extent={{-28,30},{-8,50}})));
        Modelica.Electrical.Analog.Basic.RotationalEMF emf
          annotation (Placement(transformation(extent={{2,-8},{22,12}})));
        Modelica.Electrical.Analog.Basic.Ground ground
          annotation (Placement(transformation(extent={{-90,-64},{-70,-44}})));
        Modelica.Mechanics.Rotational.Components.Inertia Inertia(J=J)
          annotation (Placement(transformation(extent={{40,-8},{60,12}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_b flange
          "Flange of right shaft"
          annotation (Placement(transformation(extent={{84,-8},{104,12}})));
        Modelica.Electrical.Analog.Interfaces.PositivePin p
          "Positive electrical pin" annotation (Placement(transformation(extent=
                 {{-112,70},{-82,100}}), iconTransformation(extent={{-116,66},{
                  -82,100}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin n
          "Negative electrical pin" annotation (Placement(transformation(extent={{-112,
                  -50},{-84,-22}}),       iconTransformation(extent={{-114,-100},
                  {-82,-68}})));
        parameter Modelica.Units.SI.Inductance L=0.1
          "Inductance of the DC Machine";
        parameter Modelica.Units.SI.Inertia J=0.001
          "Internal inertia of the DC machine"
          annotation (Dialog(tab="Mechanical"));
      equation
        connect(resistor.n, inductor.p)
          annotation (Line(points={{-44,40},{-28,40}}, color={0,0,255}));
        connect(inductor.n, emf.p)
          annotation (Line(points={{-8,40},{12,40},{12,12}}, color={0,0,255}));
        connect(emf.flange, Inertia.flange_a)
          annotation (Line(points={{22,2},{40,2}}, color={0,0,0}));
        connect(Inertia.flange_b, flange)
          annotation (Line(points={{60,2},{94,2}}, color={0,0,0}));
        connect(resistor.p, p) annotation (Line(points={{-64,40},{-80,40},{-80,
                85},{-97,85}}, color={0,0,255}));
        connect(emf.n, n) annotation (Line(points={{12,-8},{12,-36},{-98,-36}},
              color={0,0,255}));
        connect(ground.p, n) annotation (Line(points={{-80,-44},{-80,-36},{-98,
                -36}}, color={0,0,255}));
        connect(p, p) annotation (Line(points={{-97,85},{-95.5,85},{-95.5,85},{
                -97,85}}, color={0,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                Bitmap(extent={{100,-100},{-100,100}}, fileName=
                    "modelica://FM3217_2026/Resources/Images/dc-motor.jpg")}),
                                                                       Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<h4>Tis is a model of a simpleDC machine</h4>
<p><img src=\"modelica://FM3217_2026/Resources/Images/dc-motor.jpg\"/></p>
</html>"));
      end DCMachine;

      model Rload "Resistive load"
        Modelica.Electrical.Analog.Basic.Resistor resistor(R=R_load)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-10,2})));
        Modelica.Electrical.Analog.Interfaces.PositivePin p1
                      "Positive electrical pin"
          annotation (Placement(transformation(extent={{-20,90},{0,110}})));
        Modelica.Electrical.Analog.Interfaces.NegativePin n1
                      "Negative electrical pin"
          annotation (Placement(transformation(extent={{-20,-106},{0,-86}})));
        parameter Modelica.Units.SI.Resistance R_load=0.5
          "Ohmic value of the resistive load";
      equation
        connect(resistor.p, p1)
          annotation (Line(points={{-10,12},{-10,100}}, color={0,0,255}));
        connect(resistor.n, n1)
          annotation (Line(points={{-10,-8},{-10,-96}}, color={0,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Rload;

      model RLload
        extends Rload;
        Modelica.Electrical.Analog.Basic.Inductor inductor(L=L_load)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-60,0})));
        parameter Modelica.Units.SI.Inductance L_load=0.1 "Load inductance";
      equation
        connect(inductor.p, p1) annotation (Line(points={{-60,10},{-60,56},{-10,
                56},{-10,100}}, color={0,0,255}));
        connect(inductor.n, n1) annotation (Line(points={{-60,-10},{-60,-56},{
                -10,-56},{-10,-96}}, color={0,0,255}));
      end RLload;

      model RLCload
        extends RLload;
        Modelica.Electrical.Analog.Basic.Capacitor capacitor(C=C_load)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={32,2})));
        parameter Modelica.Electrical.Spice3.Types.Capacitance C_load=0.001
          "Load capacitance";
      equation
        connect(capacitor.p, p1) annotation (Line(points={{32,12},{32,56},{-10,
                56},{-10,100}}, color={0,0,255}));
        connect(capacitor.n, n1) annotation (Line(points={{32,-8},{32,-56},{-10,
                -56},{-10,-96}}, color={0,0,255}));
      end RLCload;

      model Turbine
        Modelica.Mechanics.Rotational.Components.Inertia inertia(J=J_t)
          annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
        Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(
            tau_constant=T_t)
          annotation (Placement(transformation(extent={{60,-10},{40,10}})));
        Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a annotation (
            Placement(transformation(rotation=0, extent={{-110,-10},{-90,10}})));
        parameter Modelica.Units.SI.Inertia J_t=2 "Turbine inertia";
        parameter Modelica.Units.SI.AngularMomentum T_t=10 "Turbine torque";
      equation
        connect(constantTorque.flange, inertia.flange_b)
          annotation (Line(points={{40,0},{-8,0}}, color={0,0,0}));
        connect(flange_a, inertia.flange_a)
          annotation (Line(points={{-100,0},{-28,0}}, color={0,0,0}));
        annotation (Icon(graphics={Bitmap(extent={{-100,-100},{100,100}},
                  fileName=
                    "modelica://FM3217_2026/Resources/Images/Turbine.png")}));
      end Turbine;
    end Components;

    package Tests
      model MotorDrive
        Tutorial2.Motor motor
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

      model DCMachineTest
        Components.DCMachine dCMachine(R=1)
          annotation (Placement(transformation(extent={{-12,-10},{8,10}})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
          annotation (Placement(transformation(
              extent={{-10,10},{10,-10}},
              rotation=270,
              origin={-32,0})));
        Modelica.Blocks.Sources.Step step
          annotation (Placement(transformation(extent={{-78,-10},{-58,10}})));
        Modelica.Mechanics.Rotational.Components.Inertia inertia
          annotation (Placement(transformation(extent={{16,-10},{36,10}})));
      equation
        connect(signalVoltage.p, dCMachine.p) annotation (Line(points={{-32,10},
                {-32,20},{-16,20},{-16,8.3},{-11.9,8.3}},color={0,0,255}));
        connect(signalVoltage.n, dCMachine.n) annotation (Line(points={{-32,-10},
                {-32,-18},{-16,-18},{-16,-8.4},{-11.8,-8.4}},color={0,0,255}));
        connect(signalVoltage.v, step.y) annotation (Line(points={{-44,
                2.10942e-15},{-50,2.10942e-15},{-50,0},{-57,0}}, color={0,0,127}));
        connect(dCMachine.flange, inertia.flange_a) annotation (Line(points={{7.4,0.2},
                {12,0.2},{12,0},{16,0}},          color={0,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end DCMachineTest;

      model DCGeneratorTest
        Components.DCMachine dCMachine(R=1)
          annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        Components.RLCload rLCload
          annotation (Placement(transformation(extent={{-82,-14},{-62,6}})));
        Components.Turbine turbine annotation (Placement(transformation(
                rotation=0, extent={{-2,-10},{18,10}})));
      equation
        connect(dCMachine.flange,turbine.flange_a)  annotation (Line(points={{-22.6,
                0.2},{-18,0.2},{-18,0},{-2,0}},   color={0,0,0}));
        connect(rLCload.p1, dCMachine.p) annotation (Line(points={{-73,6},{-74,
                6},{-74,26},{-41.9,26},{-41.9,8.3}}, color={0,0,255}));
        connect(rLCload.n1, dCMachine.n) annotation (Line(points={{-73,-13.6},{
                -73,-32},{-42,-32},{-42,-8.4},{-41.8,-8.4}}, color={0,0,255}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end DCGeneratorTest;
    end Tests;
  end Tutorial3;

  package Tutorial4

    model ElectricKettle
      Modelica.Electrical.Analog.Basic.Resistor resistor(R=230^2/2000,
          useHeatPort=true)
        annotation (Placement(transformation(
            extent={{-10,10},{10,-10}},
            rotation=270,
            origin={-8,-2})));
      Modelica.Electrical.Analog.Sources.SineVoltage sineVoltage(V=sqrt(2)*230,
                                                                        f=50)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-88,0})));
      Modelica.Electrical.Analog.Basic.Ground ground
        annotation (Placement(transformation(extent={{-84,-68},{-64,-48}})));
      Modelica.Electrical.Analog.Sensors.PowerSensor powerSensor
        annotation (Placement(transformation(extent={{-38,10},{-18,30}})));
      Modelica.Blocks.Math.Mean mean(f=50) annotation (Placement(transformation(
            extent={{-4,-4},{4,4}},
            rotation=270,
            origin={-38,-2})));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor water(C=4.18e3*1.7,
          T(start=283.15, fixed=true))
        annotation (Placement(transformation(extent={{0,14},{16,30}})));
      Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor
        temperatureSensor1
        annotation (Placement(transformation(extent={{14,-10},{30,6}})));
      Modelica.Electrical.Analog.Ideal.IdealClosingSwitch switch
        annotation (Placement(transformation(extent={{-72,10},{-52,30}})));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor kettleWall(G=5)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={8,-28})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature roomTemperature(T=
            294.15) annotation (Placement(transformation(
            extent={{-8,-8},{8,8}},
            rotation=180,
            origin={28,-48})));
      Modelica.Blocks.Logical.OnOffController onOffController(bandwidth=3)
        annotation (Placement(transformation(extent={{50,-6},{70,14}})));
      Modelica.Blocks.Sources.Constant const(k=95)
        annotation (Placement(transformation(extent={{20,20},{40,40}})));
    equation
      connect(ground.p, resistor.n) annotation (Line(points={{-74,-48},{-74,-26},
              {-8,-26},{-8,-12}},
                              color={0,0,255}));
      connect(sineVoltage.n, resistor.n) annotation (Line(points={{-88,-10},{
              -88,-26},{-8,-26},{-8,-12}},
                                   color={0,0,255}));
      connect(powerSensor.nc, resistor.p)
        annotation (Line(points={{-18,20},{-8,20},{-8,8}},color={0,0,255}));
      connect(powerSensor.pv, resistor.p) annotation (Line(points={{-28,30},{
              -28,52},{-8,52},{-8,8}},color={0,0,255}));
      connect(powerSensor.nv, resistor.n) annotation (Line(points={{-28,10},{
              -28,-26},{-8,-26},{-8,-12}},
                                       color={0,0,255}));
      connect(powerSensor.power, mean.u)
        annotation (Line(points={{-38,9},{-38,2.8}},   color={0,0,127}));
      connect(water.port, resistor.heatPort)
        annotation (Line(points={{8,14},{8,-2},{2,-2}}, color={191,0,0}));
      connect(temperatureSensor1.port, resistor.heatPort)
        annotation (Line(points={{14,-2},{2,-2}}, color={191,0,0}));
      connect(sineVoltage.p, switch.p) annotation (Line(points={{-88,10},{-88,
              20},{-72,20}}, color={0,0,255}));
      connect(switch.n, powerSensor.pc)
        annotation (Line(points={{-52,20},{-38,20}}, color={0,0,255}));
      connect(kettleWall.port_a, resistor.heatPort)
        annotation (Line(points={{8,-18},{8,-2},{2,-2}}, color={191,0,0}));
      connect(roomTemperature.port, kettleWall.port_b)
        annotation (Line(points={{20,-48},{8,-48},{8,-38}}, color={191,0,0}));
      connect(temperatureSensor1.T, onOffController.u)
        annotation (Line(points={{30,-2},{48,-2}}, color={0,0,127}));
      connect(const.y, onOffController.reference) annotation (Line(points={{41,
              30},{44,30},{44,10},{48,10}}, color={0,0,127}));
      connect(onOffController.y, switch.control) annotation (Line(points={{71,4},
              {80,4},{80,58},{-62,58},{-62,32}}, color={255,0,255}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Electric Kettle</p>
<ul>
<li>Volume of 1.7 L</li>
<li>230 V mains supply</li>
<li>Power of 2000 Watt</li>
</ul>
<p><br>Question: What should the resistance of the heating resistor be?</p>
<p><br>Power = Voltage * Current</p>
<p>Resistance = Voltage/Current</p>
<p><br>This leads to:</p>
<p>For a 2000 Watt consuming resistor the resiatnce should be:</p>
<p>R = V/I = V/(P/V) = V^2/P</p>
<p><br>Heat capacity of water</p>
<p>1 calorie = heat capacity needed to heat up one gram of water by 1 kelvin</p>
<p>1 calorie = 4.18 J/(gK)</p>
</html>"),
        experiment(StopTime=600, __Dymola_NumberOfIntervals=5000));
    end ElectricKettle;
  end Tutorial4;
  annotation (uses(Modelica(version="4.0.0")));
end FM3217_2026;
