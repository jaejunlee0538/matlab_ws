
figure(3)
subplot(1,2,1);
[ax,h1,h2] = plotyy(t, f_s_delayed_log, t, [Es_in_log',Em_out_log']);
set(h2(1),'linewidth',3);
set(h2(2),'linewidth',3);
set(h1,'linewidth',1);
set(h1, 'color','k');
set(get(ax(1),'Ylabel'),'String','F_s delayed')
set(get(ax(1),'Ylabel'),'FontSize',15)
set(get(ax(2),'Ylabel'),'String','Energy')
set(get(ax(2),'Ylabel'),'FontSize',15)
xlabel('t(sec)','fontsize',15); 
grid on;
lh = legend( 'F_s delayed', 'Es in', 'Em out');
set(lh,'fontsize',13)
set(lh,'location','northwest')
title('Master Side Port', 'fontsize', 20);


subplot(1,2,2);
[ax,h1,h2] = plotyy(t,xd_m_delayed_log, t,[Es_in_log',Em_out_log']);
set(h2(1),'linewidth',3);
set(h2(2),'linewidth',3);
set(h1,'linewidth',1);
set(h1, 'color','k');
set(get(ax(1),'Ylabel'),'String','X_d_m delayed')
set(get(ax(1),'Ylabel'),'FontSize',15)
set(get(ax(2),'Ylabel'),'String','Energy')
set(get(ax(2),'Ylabel'),'FontSize',15)
xlabel('t(sec)','fontsize',15); 
grid on;
lh = legend('X_d_m delayed', 'Em in', 'Es out');
set(lh,'fontsize',13)
set(lh,'location','northwest')
title('Master Side Port', 'fontsize', 20);
title('Slave Side Port', 'fontsize', 20);