function w = pixelclassification(a)

w = a*svc(proxm('p',5))*classc; % Trains a support vector machine
labels = a*w*labeld; % Shows the labels that the classifier assigns to objects from b