clc; clear;

% 获取当前文件夹下所有满足命名规则的 .mat 文件
fileList = dir('C:\Users\Wu Yujin\OneDrive - Nanyang Technological University\Documents\Lumerical\20250401 QCL router\4_QCL Router 20250507\3D\3D gap=2um 2000um Lc 0_0025loss.mat');  % 可修改为你自己的文件名模式
%fileList = dir('*.mat')
% 批处理每个文件
for k = 1:length(fileList)
    filename = fileList(k).name;
    disp(['Processing: ', filename]);

    % 加载数据
    data = load(filename);

    % 访问结构中的字段（根据你的结构）
    E = data.result.E;
    %Ez = data.result.Ez;
    x = data.result.x * 1e6;   % μm
    y = data.result.y * 1e6;

    % 解析 Ez 并重塑为 2D
    Ez_flat = E(:,3);
    Nx = length(x);
    Ny = length(y);
    Ez = reshape(Ez_flat, [Nx, Ny]);
    %Ez = reshape(Ez, [Nx, Ny]);
    Ez = Ez.';

    % 创建图像
    figure('Visible', 'on');  % 不显示图像窗口（节省时间）
    Ez_norm = abs(Ez) / max(abs(Ez(:)));
    imagesc(x, y, Ez_norm);
    %imagesc(x, y, abs(Ez));
    set(gca, 'YDir', 'normal');   % 解决y轴颠倒问题
    %axis xy equal tight;
    xlabel('x (μm)');
    ylabel('y (μm)');

    % 自动命名保存文件（与原始文件名相同）
    [~, name, ~] = fileparts(filename);
    title('3D |Ez| Field Distribution — ', name, 'Interpreter', 'none', 'FontSize', 14, 'FontWeight', 'bold');
    

    % Colorbar 设置
    cb = colorbar;
    cb.Label.String = '|Ez| (a.u.)';
    cb.Label.FontSize = 12;
    cb.Label.FontWeight = 'bold';
    %caxis([0, 1 * max(abs(Ez(:)))]);   % 设置对比范围
    caxis([0.002, 1]);
    colormap(turbo);                     % 配色方案
    % % colormap(parula)      % 默认，偏冷色
    % % colormap(hot)         % 亮暖色
    % % colormap(magma)       % 暗调专业风（需安装 cmocean）
    % % colormap(inferno)     % 强对比夜视风（需安装）
    set(gca, 'FontSize', 12, 'LineWidth', 1.2);

    
    saveas(gcf, ['',name, '.png']);     % 保存为 PNG
    % saveas(gcf, [name, '.pdf']);  % 或保存为 PDF
    % saveas(gcf, [name, '.eps'], 'epsc'); % EPS 彩色输出

    %close(gcf);  % 关闭当前图像窗口
end

disp('All figures processed and saved.');