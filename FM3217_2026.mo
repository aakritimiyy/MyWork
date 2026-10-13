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
  end Tutorial2;
  annotation (uses(Modelica(version="4.0.0")));
end FM3217_2026;
