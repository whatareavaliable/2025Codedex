clear;

% 1) Material parameters
epsilon_infinity    = 9.61;                % high‐frequency permittivity
N     = 1.7e18 * 1e6;           % [m⁻³] Doping concentration
m_eff = 0.073 * 9.10938e-31;  % [kg] effective mass
tau     = 100e-15;              % [s] scattering time
gamma     = 1/tau;                  % [s⁻¹]

% 2) Optical frequency
lambda_0    = 7.3e-6;                % [m]
omega     = 2*pi*3e8/lambda_0;          % [rad/s]

% 3) Plasma frequency
epsilon_0    = 8.8542e-12;           % [F/m]
e     = 1.602e-19;            % [C]
omega_p2   = N*e^2/(epsilon_0*m_eff);     % [rad²/s²]
omega_p    = sqrt(omega_p2);

% 4) Drude permittivity
epsilon_drude = epsilon_infinity - omega_p2./(omega^2 + 1i*(1/tau)*omega);

% 5) Refractive index
n = sqrt(epsilon_drude);

% 6) Optional: plasma‐wavelength (for reference)
lambda_p = 2*pi*3e8/omega_p;
fprintf('Plasma wavelength: %.2f µm\n', lambda_p*1e6);

% Show real and imag parts
fprintf('n = %.3f + %.3fi\n', real(n), imag(n));
