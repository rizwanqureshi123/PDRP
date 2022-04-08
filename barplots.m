X = categorical({'KNN','SVM','RF','XGboost', 'Neural Network'});
X = reordercats(X,{'KNN','SVM','RF','XGboost', 'Neural Network'});
Y = [0.55 0.87 0.557 0.6857 0.5785 0.64;0.564 0.72 0.585 0.6857 0.5571 0.75 ; 0.464 0.9214 0.5357 0.5357 0.55 0.94 ; 0.55 0.93 0.535 0.9285 0.557 0.97; 0.7143 0.9286 0.5 0.9286 0.7857 0.95]
legend('Personal', 'Geometric', 'Energy' , 'Personal + Geometric' , 'Personal + Energy' , 'Personal + Energy + Geometric')
bar(X,Y)
title('Contribution of differnt Features in Accuracy')

 
    

 
    
