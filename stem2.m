app = gui3;
app.xdata = [1 2 3 4 5];
app.ydata = [10 20 30 40 50];
stem(app.UIAxes,app.ydata,'-o');
text(app.UIAxes,2,20,'20','HorizontalAlignment','center','Color','red','FontSize',25)
%strmin = ['Minimum = ',20];
%text(2,20,strmin,'HorizontalAlignment','left');


% pause(10)
% app.ydata = [60 70];
% plot(app.UIAxes,app.ydata);

% 
% app.ydata = 100;
% 
% plot(app.UIAxes,1,app.ydata);
% app.ydata = 300;
% hold(app.UIAxes);
% plot(app.UIAxes,2,app.ydata);
% 
% f = uifigure;
% close(f);