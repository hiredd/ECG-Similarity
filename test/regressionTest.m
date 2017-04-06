X = [1;2;3;4;5;6;7;8];
Y = [1;2;3;4;4;3;2;1];
Md1 = fitrtree(X,Y);
predictVal = predict(Md1,X)
plot(X,Y)
hold on
plot(X,predictVal)
