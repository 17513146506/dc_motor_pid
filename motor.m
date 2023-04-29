% 定义模型参数
R = 1; % 电机电阻
L = 0.5; % 电机电感
J = 0.01; % 电机转动惯量
b = 0.1; % 电机摩擦系数
Kp = 1; % 比例系数
Ki = 0.5; % 积分系数
Kd = 0.2; % 微分系数

% 创建模型
model = 'dc_motor_pid';
new_system(model);
set_param(model, 'Solver', 'ode4');

% 添加模块
add_block('simulink/Continuous/PID Controller', [model '/PID Controller']);
add_block('simulink/Commonly Used Blocks/Integrator', [model '/Integrator']);
add_block('simulink/Commonly Used Blocks/Sum', [model '/Sum']);
add_block('simulink/Sources/Step', [model '/Step']);
add_block('simulink/Sinks/Scope', [model '/Scope']);
add_block('simulink/Continuous/Transfer Fcn', [model '/Transfer Function']);

% 设置模块参数
set_param([model '/PID Controller'], 'P', num2str(Kp));
set_param([model '/PID Controller'], 'I', num2str(Ki));
set_param([model '/PID Controller'], 'D', num2str(Kd));
set_param([model '/Integrator'], 'InitialCondition', '0');
set_param([model '/Sum'], 'Inputs', '+-');
set_param([model '/Transfer Function'], 'Numerator', '1');
%%%set_param([model '/Transfer Function'], 'Denominator', [num2str(J*L) ' ' num2str((J*R+b*L)) ' ' num2str(R*b)]);
set_param([model '/Step'], 'Time', '0', 'After', '0.1', 'Before', '0.1', 'SampleTime', '0.01');
set_param([model '/Scope'], 'Position', [100 100 500 300]);

% 运行模型
sim(model);