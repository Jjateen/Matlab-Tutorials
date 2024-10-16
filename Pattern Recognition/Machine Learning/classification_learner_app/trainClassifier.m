function [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% [trainedClassifier, validationAccuracy] = trainClassifier(trainingData)
% Returns a trained classifier and its accuracy. This code recreates the
% classification model trained in Classification Learner app. Use the
% generated code to automate training the same model with new data, or to
% learn how to programmatically train models.
%
%  Input:
%      trainingData: A table containing the same predictor and response
%       columns as those imported into the app.
%
%  Output:
%      trainedClassifier: A struct containing the trained classifier. The
%       struct contains various fields with information about the trained
%       classifier.
%
%      trainedClassifier.predictFcn: A function to make predictions on new
%       data.
%
%      validationAccuracy: A double containing the accuracy in percent. In
%       the app, the History list displays this overall accuracy score for
%       each model.
%
% Use the code to train the model with new data. To retrain your
% classifier, call the function from the command line with your original
% data or new data as the input argument trainingData.
%
% For example, to retrain a classifier trained with the original data set
% T, enter:
%   [trainedClassifier, validationAccuracy] = trainClassifier(T)
%
% To make predictions with the returned 'trainedClassifier' on new data T2,
% use
%   yfit = trainedClassifier.predictFcn(T2)
%
% T2 must be a table containing at least the same predictor columns as used
% during training. For details, enter:
%   trainedClassifier.HowToPredict

% Auto-generated by MATLAB on 13-Sep-2020 17:08:35


% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'trainingFeatures1', 'trainingFeatures2', 'trainingFeatures3', 'trainingFeatures4', 'trainingFeatures5', 'trainingFeatures6', 'trainingFeatures7', 'trainingFeatures8', 'trainingFeatures9', 'trainingFeatures10', 'trainingFeatures11', 'trainingFeatures12', 'trainingFeatures13', 'trainingFeatures14', 'trainingFeatures15', 'trainingFeatures16', 'trainingFeatures17', 'trainingFeatures18', 'trainingFeatures19', 'trainingFeatures20', 'trainingFeatures21', 'trainingFeatures22', 'trainingFeatures23', 'trainingFeatures24', 'trainingFeatures25', 'trainingFeatures26', 'trainingFeatures27', 'trainingFeatures28', 'trainingFeatures29', 'trainingFeatures30', 'trainingFeatures31', 'trainingFeatures32', 'trainingFeatures33', 'trainingFeatures34', 'trainingFeatures35', 'trainingFeatures36', 'trainingFeatures37', 'trainingFeatures38', 'trainingFeatures39', 'trainingFeatures40', 'trainingFeatures41', 'trainingFeatures42', 'trainingFeatures43', 'trainingFeatures44', 'trainingFeatures45', 'trainingFeatures46', 'trainingFeatures47', 'trainingFeatures48', 'trainingFeatures49', 'trainingFeatures50', 'trainingFeatures51', 'trainingFeatures52', 'trainingFeatures53', 'trainingFeatures54', 'trainingFeatures55', 'trainingFeatures56', 'trainingFeatures57', 'trainingFeatures58', 'trainingFeatures59', 'trainingFeatures60', 'trainingFeatures61', 'trainingFeatures62', 'trainingFeatures63', 'trainingFeatures64', 'trainingFeatures65', 'trainingFeatures66', 'trainingFeatures67', 'trainingFeatures68', 'trainingFeatures69', 'trainingFeatures70', 'trainingFeatures71', 'trainingFeatures72', 'trainingFeatures73', 'trainingFeatures74', 'trainingFeatures75', 'trainingFeatures76', 'trainingFeatures77', 'trainingFeatures78', 'trainingFeatures79', 'trainingFeatures80', 'trainingFeatures81', 'trainingFeatures82', 'trainingFeatures83', 'trainingFeatures84', 'trainingFeatures85', 'trainingFeatures86', 'trainingFeatures87', 'trainingFeatures88', 'trainingFeatures89', 'trainingFeatures90', 'trainingFeatures91', 'trainingFeatures92', 'trainingFeatures93', 'trainingFeatures94', 'trainingFeatures95', 'trainingFeatures96', 'trainingFeatures97', 'trainingFeatures98', 'trainingFeatures99', 'trainingFeatures100', 'trainingFeatures101', 'trainingFeatures102', 'trainingFeatures103', 'trainingFeatures104', 'trainingFeatures105', 'trainingFeatures106', 'trainingFeatures107', 'trainingFeatures108', 'trainingFeatures109', 'trainingFeatures110', 'trainingFeatures111', 'trainingFeatures112', 'trainingFeatures113', 'trainingFeatures114', 'trainingFeatures115', 'trainingFeatures116', 'trainingFeatures117', 'trainingFeatures118', 'trainingFeatures119', 'trainingFeatures120', 'trainingFeatures121', 'trainingFeatures122', 'trainingFeatures123', 'trainingFeatures124', 'trainingFeatures125', 'trainingFeatures126', 'trainingFeatures127', 'trainingFeatures128', 'trainingFeatures129', 'trainingFeatures130', 'trainingFeatures131', 'trainingFeatures132', 'trainingFeatures133', 'trainingFeatures134', 'trainingFeatures135', 'trainingFeatures136', 'trainingFeatures137', 'trainingFeatures138', 'trainingFeatures139', 'trainingFeatures140', 'trainingFeatures141', 'trainingFeatures142', 'trainingFeatures143', 'trainingFeatures144', 'trainingFeatures145', 'trainingFeatures146', 'trainingFeatures147', 'trainingFeatures148', 'trainingFeatures149', 'trainingFeatures150', 'trainingFeatures151', 'trainingFeatures152', 'trainingFeatures153', 'trainingFeatures154', 'trainingFeatures155', 'trainingFeatures156', 'trainingFeatures157', 'trainingFeatures158', 'trainingFeatures159', 'trainingFeatures160', 'trainingFeatures161', 'trainingFeatures162', 'trainingFeatures163', 'trainingFeatures164', 'trainingFeatures165', 'trainingFeatures166', 'trainingFeatures167', 'trainingFeatures168', 'trainingFeatures169', 'trainingFeatures170', 'trainingFeatures171', 'trainingFeatures172', 'trainingFeatures173', 'trainingFeatures174', 'trainingFeatures175', 'trainingFeatures176', 'trainingFeatures177', 'trainingFeatures178', 'trainingFeatures179', 'trainingFeatures180', 'trainingFeatures181', 'trainingFeatures182', 'trainingFeatures183', 'trainingFeatures184', 'trainingFeatures185', 'trainingFeatures186', 'trainingFeatures187', 'trainingFeatures188', 'trainingFeatures189', 'trainingFeatures190', 'trainingFeatures191', 'trainingFeatures192', 'trainingFeatures193', 'trainingFeatures194', 'trainingFeatures195', 'trainingFeatures196', 'trainingFeatures197', 'trainingFeatures198', 'trainingFeatures199', 'trainingFeatures200', 'trainingFeatures201', 'trainingFeatures202', 'trainingFeatures203', 'trainingFeatures204', 'trainingFeatures205', 'trainingFeatures206', 'trainingFeatures207', 'trainingFeatures208', 'trainingFeatures209', 'trainingFeatures210', 'trainingFeatures211', 'trainingFeatures212', 'trainingFeatures213', 'trainingFeatures214', 'trainingFeatures215', 'trainingFeatures216', 'trainingFeatures217', 'trainingFeatures218', 'trainingFeatures219', 'trainingFeatures220', 'trainingFeatures221', 'trainingFeatures222', 'trainingFeatures223', 'trainingFeatures224', 'trainingFeatures225', 'trainingFeatures226', 'trainingFeatures227', 'trainingFeatures228', 'trainingFeatures229', 'trainingFeatures230', 'trainingFeatures231', 'trainingFeatures232', 'trainingFeatures233', 'trainingFeatures234', 'trainingFeatures235', 'trainingFeatures236', 'trainingFeatures237', 'trainingFeatures238', 'trainingFeatures239', 'trainingFeatures240', 'trainingFeatures241', 'trainingFeatures242', 'trainingFeatures243', 'trainingFeatures244', 'trainingFeatures245', 'trainingFeatures246', 'trainingFeatures247', 'trainingFeatures248', 'trainingFeatures249', 'trainingFeatures250', 'trainingFeatures251', 'trainingFeatures252', 'trainingFeatures253', 'trainingFeatures254', 'trainingFeatures255', 'trainingFeatures256', 'trainingFeatures257', 'trainingFeatures258', 'trainingFeatures259', 'trainingFeatures260', 'trainingFeatures261', 'trainingFeatures262', 'trainingFeatures263', 'trainingFeatures264', 'trainingFeatures265', 'trainingFeatures266', 'trainingFeatures267', 'trainingFeatures268', 'trainingFeatures269', 'trainingFeatures270', 'trainingFeatures271', 'trainingFeatures272', 'trainingFeatures273', 'trainingFeatures274', 'trainingFeatures275', 'trainingFeatures276', 'trainingFeatures277', 'trainingFeatures278', 'trainingFeatures279', 'trainingFeatures280', 'trainingFeatures281', 'trainingFeatures282', 'trainingFeatures283', 'trainingFeatures284', 'trainingFeatures285', 'trainingFeatures286', 'trainingFeatures287', 'trainingFeatures288'};
predictors = inputTable(:, predictorNames);
response = inputTable.Class;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Train a classifier
% This code specifies all the classifier options and trains the classifier.
template = templateSVM(...
    'KernelFunction', 'polynomial', ...
    'PolynomialOrder', 2, ...
    'KernelScale', 'auto', ...
    'BoxConstraint', 1, ...
    'Standardize', true);
classificationSVM = fitcecoc(...
    predictors, ...
    response, ...
    'Learners', template, ...
    'Coding', 'onevsone', ...
    'ClassNames', categorical({'0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'}));

% Create the result struct with predict function
predictorExtractionFcn = @(t) t(:, predictorNames);
svmPredictFcn = @(x) predict(classificationSVM, x);
trainedClassifier.predictFcn = @(x) svmPredictFcn(predictorExtractionFcn(x));

% Add additional fields to the result struct
trainedClassifier.RequiredVariables = {'trainingFeatures1', 'trainingFeatures10', 'trainingFeatures100', 'trainingFeatures101', 'trainingFeatures102', 'trainingFeatures103', 'trainingFeatures104', 'trainingFeatures105', 'trainingFeatures106', 'trainingFeatures107', 'trainingFeatures108', 'trainingFeatures109', 'trainingFeatures11', 'trainingFeatures110', 'trainingFeatures111', 'trainingFeatures112', 'trainingFeatures113', 'trainingFeatures114', 'trainingFeatures115', 'trainingFeatures116', 'trainingFeatures117', 'trainingFeatures118', 'trainingFeatures119', 'trainingFeatures12', 'trainingFeatures120', 'trainingFeatures121', 'trainingFeatures122', 'trainingFeatures123', 'trainingFeatures124', 'trainingFeatures125', 'trainingFeatures126', 'trainingFeatures127', 'trainingFeatures128', 'trainingFeatures129', 'trainingFeatures13', 'trainingFeatures130', 'trainingFeatures131', 'trainingFeatures132', 'trainingFeatures133', 'trainingFeatures134', 'trainingFeatures135', 'trainingFeatures136', 'trainingFeatures137', 'trainingFeatures138', 'trainingFeatures139', 'trainingFeatures14', 'trainingFeatures140', 'trainingFeatures141', 'trainingFeatures142', 'trainingFeatures143', 'trainingFeatures144', 'trainingFeatures145', 'trainingFeatures146', 'trainingFeatures147', 'trainingFeatures148', 'trainingFeatures149', 'trainingFeatures15', 'trainingFeatures150', 'trainingFeatures151', 'trainingFeatures152', 'trainingFeatures153', 'trainingFeatures154', 'trainingFeatures155', 'trainingFeatures156', 'trainingFeatures157', 'trainingFeatures158', 'trainingFeatures159', 'trainingFeatures16', 'trainingFeatures160', 'trainingFeatures161', 'trainingFeatures162', 'trainingFeatures163', 'trainingFeatures164', 'trainingFeatures165', 'trainingFeatures166', 'trainingFeatures167', 'trainingFeatures168', 'trainingFeatures169', 'trainingFeatures17', 'trainingFeatures170', 'trainingFeatures171', 'trainingFeatures172', 'trainingFeatures173', 'trainingFeatures174', 'trainingFeatures175', 'trainingFeatures176', 'trainingFeatures177', 'trainingFeatures178', 'trainingFeatures179', 'trainingFeatures18', 'trainingFeatures180', 'trainingFeatures181', 'trainingFeatures182', 'trainingFeatures183', 'trainingFeatures184', 'trainingFeatures185', 'trainingFeatures186', 'trainingFeatures187', 'trainingFeatures188', 'trainingFeatures189', 'trainingFeatures19', 'trainingFeatures190', 'trainingFeatures191', 'trainingFeatures192', 'trainingFeatures193', 'trainingFeatures194', 'trainingFeatures195', 'trainingFeatures196', 'trainingFeatures197', 'trainingFeatures198', 'trainingFeatures199', 'trainingFeatures2', 'trainingFeatures20', 'trainingFeatures200', 'trainingFeatures201', 'trainingFeatures202', 'trainingFeatures203', 'trainingFeatures204', 'trainingFeatures205', 'trainingFeatures206', 'trainingFeatures207', 'trainingFeatures208', 'trainingFeatures209', 'trainingFeatures21', 'trainingFeatures210', 'trainingFeatures211', 'trainingFeatures212', 'trainingFeatures213', 'trainingFeatures214', 'trainingFeatures215', 'trainingFeatures216', 'trainingFeatures217', 'trainingFeatures218', 'trainingFeatures219', 'trainingFeatures22', 'trainingFeatures220', 'trainingFeatures221', 'trainingFeatures222', 'trainingFeatures223', 'trainingFeatures224', 'trainingFeatures225', 'trainingFeatures226', 'trainingFeatures227', 'trainingFeatures228', 'trainingFeatures229', 'trainingFeatures23', 'trainingFeatures230', 'trainingFeatures231', 'trainingFeatures232', 'trainingFeatures233', 'trainingFeatures234', 'trainingFeatures235', 'trainingFeatures236', 'trainingFeatures237', 'trainingFeatures238', 'trainingFeatures239', 'trainingFeatures24', 'trainingFeatures240', 'trainingFeatures241', 'trainingFeatures242', 'trainingFeatures243', 'trainingFeatures244', 'trainingFeatures245', 'trainingFeatures246', 'trainingFeatures247', 'trainingFeatures248', 'trainingFeatures249', 'trainingFeatures25', 'trainingFeatures250', 'trainingFeatures251', 'trainingFeatures252', 'trainingFeatures253', 'trainingFeatures254', 'trainingFeatures255', 'trainingFeatures256', 'trainingFeatures257', 'trainingFeatures258', 'trainingFeatures259', 'trainingFeatures26', 'trainingFeatures260', 'trainingFeatures261', 'trainingFeatures262', 'trainingFeatures263', 'trainingFeatures264', 'trainingFeatures265', 'trainingFeatures266', 'trainingFeatures267', 'trainingFeatures268', 'trainingFeatures269', 'trainingFeatures27', 'trainingFeatures270', 'trainingFeatures271', 'trainingFeatures272', 'trainingFeatures273', 'trainingFeatures274', 'trainingFeatures275', 'trainingFeatures276', 'trainingFeatures277', 'trainingFeatures278', 'trainingFeatures279', 'trainingFeatures28', 'trainingFeatures280', 'trainingFeatures281', 'trainingFeatures282', 'trainingFeatures283', 'trainingFeatures284', 'trainingFeatures285', 'trainingFeatures286', 'trainingFeatures287', 'trainingFeatures288', 'trainingFeatures29', 'trainingFeatures3', 'trainingFeatures30', 'trainingFeatures31', 'trainingFeatures32', 'trainingFeatures33', 'trainingFeatures34', 'trainingFeatures35', 'trainingFeatures36', 'trainingFeatures37', 'trainingFeatures38', 'trainingFeatures39', 'trainingFeatures4', 'trainingFeatures40', 'trainingFeatures41', 'trainingFeatures42', 'trainingFeatures43', 'trainingFeatures44', 'trainingFeatures45', 'trainingFeatures46', 'trainingFeatures47', 'trainingFeatures48', 'trainingFeatures49', 'trainingFeatures5', 'trainingFeatures50', 'trainingFeatures51', 'trainingFeatures52', 'trainingFeatures53', 'trainingFeatures54', 'trainingFeatures55', 'trainingFeatures56', 'trainingFeatures57', 'trainingFeatures58', 'trainingFeatures59', 'trainingFeatures6', 'trainingFeatures60', 'trainingFeatures61', 'trainingFeatures62', 'trainingFeatures63', 'trainingFeatures64', 'trainingFeatures65', 'trainingFeatures66', 'trainingFeatures67', 'trainingFeatures68', 'trainingFeatures69', 'trainingFeatures7', 'trainingFeatures70', 'trainingFeatures71', 'trainingFeatures72', 'trainingFeatures73', 'trainingFeatures74', 'trainingFeatures75', 'trainingFeatures76', 'trainingFeatures77', 'trainingFeatures78', 'trainingFeatures79', 'trainingFeatures8', 'trainingFeatures80', 'trainingFeatures81', 'trainingFeatures82', 'trainingFeatures83', 'trainingFeatures84', 'trainingFeatures85', 'trainingFeatures86', 'trainingFeatures87', 'trainingFeatures88', 'trainingFeatures89', 'trainingFeatures9', 'trainingFeatures90', 'trainingFeatures91', 'trainingFeatures92', 'trainingFeatures93', 'trainingFeatures94', 'trainingFeatures95', 'trainingFeatures96', 'trainingFeatures97', 'trainingFeatures98', 'trainingFeatures99'};
trainedClassifier.ClassificationSVM = classificationSVM;
trainedClassifier.About = 'This struct is a trained model exported from Classification Learner R2020a.';
trainedClassifier.HowToPredict = sprintf('To make predictions on a new table, T, use: \n  yfit = c.predictFcn(T) \nreplacing ''c'' with the name of the variable that is this struct, e.g. ''trainedModel''. \n \nThe table, T, must contain the variables returned by: \n  c.RequiredVariables \nVariable formats (e.g. matrix/vector, datatype) must match the original training data. \nAdditional variables are ignored. \n \nFor more information, see <a href="matlab:helpview(fullfile(docroot, ''stats'', ''stats.map''), ''appclassification_exportmodeltoworkspace'')">How to predict using an exported model</a>.');

% Extract predictors and response
% This code processes the data into the right shape for training the
% model.
inputTable = trainingData;
predictorNames = {'trainingFeatures1', 'trainingFeatures2', 'trainingFeatures3', 'trainingFeatures4', 'trainingFeatures5', 'trainingFeatures6', 'trainingFeatures7', 'trainingFeatures8', 'trainingFeatures9', 'trainingFeatures10', 'trainingFeatures11', 'trainingFeatures12', 'trainingFeatures13', 'trainingFeatures14', 'trainingFeatures15', 'trainingFeatures16', 'trainingFeatures17', 'trainingFeatures18', 'trainingFeatures19', 'trainingFeatures20', 'trainingFeatures21', 'trainingFeatures22', 'trainingFeatures23', 'trainingFeatures24', 'trainingFeatures25', 'trainingFeatures26', 'trainingFeatures27', 'trainingFeatures28', 'trainingFeatures29', 'trainingFeatures30', 'trainingFeatures31', 'trainingFeatures32', 'trainingFeatures33', 'trainingFeatures34', 'trainingFeatures35', 'trainingFeatures36', 'trainingFeatures37', 'trainingFeatures38', 'trainingFeatures39', 'trainingFeatures40', 'trainingFeatures41', 'trainingFeatures42', 'trainingFeatures43', 'trainingFeatures44', 'trainingFeatures45', 'trainingFeatures46', 'trainingFeatures47', 'trainingFeatures48', 'trainingFeatures49', 'trainingFeatures50', 'trainingFeatures51', 'trainingFeatures52', 'trainingFeatures53', 'trainingFeatures54', 'trainingFeatures55', 'trainingFeatures56', 'trainingFeatures57', 'trainingFeatures58', 'trainingFeatures59', 'trainingFeatures60', 'trainingFeatures61', 'trainingFeatures62', 'trainingFeatures63', 'trainingFeatures64', 'trainingFeatures65', 'trainingFeatures66', 'trainingFeatures67', 'trainingFeatures68', 'trainingFeatures69', 'trainingFeatures70', 'trainingFeatures71', 'trainingFeatures72', 'trainingFeatures73', 'trainingFeatures74', 'trainingFeatures75', 'trainingFeatures76', 'trainingFeatures77', 'trainingFeatures78', 'trainingFeatures79', 'trainingFeatures80', 'trainingFeatures81', 'trainingFeatures82', 'trainingFeatures83', 'trainingFeatures84', 'trainingFeatures85', 'trainingFeatures86', 'trainingFeatures87', 'trainingFeatures88', 'trainingFeatures89', 'trainingFeatures90', 'trainingFeatures91', 'trainingFeatures92', 'trainingFeatures93', 'trainingFeatures94', 'trainingFeatures95', 'trainingFeatures96', 'trainingFeatures97', 'trainingFeatures98', 'trainingFeatures99', 'trainingFeatures100', 'trainingFeatures101', 'trainingFeatures102', 'trainingFeatures103', 'trainingFeatures104', 'trainingFeatures105', 'trainingFeatures106', 'trainingFeatures107', 'trainingFeatures108', 'trainingFeatures109', 'trainingFeatures110', 'trainingFeatures111', 'trainingFeatures112', 'trainingFeatures113', 'trainingFeatures114', 'trainingFeatures115', 'trainingFeatures116', 'trainingFeatures117', 'trainingFeatures118', 'trainingFeatures119', 'trainingFeatures120', 'trainingFeatures121', 'trainingFeatures122', 'trainingFeatures123', 'trainingFeatures124', 'trainingFeatures125', 'trainingFeatures126', 'trainingFeatures127', 'trainingFeatures128', 'trainingFeatures129', 'trainingFeatures130', 'trainingFeatures131', 'trainingFeatures132', 'trainingFeatures133', 'trainingFeatures134', 'trainingFeatures135', 'trainingFeatures136', 'trainingFeatures137', 'trainingFeatures138', 'trainingFeatures139', 'trainingFeatures140', 'trainingFeatures141', 'trainingFeatures142', 'trainingFeatures143', 'trainingFeatures144', 'trainingFeatures145', 'trainingFeatures146', 'trainingFeatures147', 'trainingFeatures148', 'trainingFeatures149', 'trainingFeatures150', 'trainingFeatures151', 'trainingFeatures152', 'trainingFeatures153', 'trainingFeatures154', 'trainingFeatures155', 'trainingFeatures156', 'trainingFeatures157', 'trainingFeatures158', 'trainingFeatures159', 'trainingFeatures160', 'trainingFeatures161', 'trainingFeatures162', 'trainingFeatures163', 'trainingFeatures164', 'trainingFeatures165', 'trainingFeatures166', 'trainingFeatures167', 'trainingFeatures168', 'trainingFeatures169', 'trainingFeatures170', 'trainingFeatures171', 'trainingFeatures172', 'trainingFeatures173', 'trainingFeatures174', 'trainingFeatures175', 'trainingFeatures176', 'trainingFeatures177', 'trainingFeatures178', 'trainingFeatures179', 'trainingFeatures180', 'trainingFeatures181', 'trainingFeatures182', 'trainingFeatures183', 'trainingFeatures184', 'trainingFeatures185', 'trainingFeatures186', 'trainingFeatures187', 'trainingFeatures188', 'trainingFeatures189', 'trainingFeatures190', 'trainingFeatures191', 'trainingFeatures192', 'trainingFeatures193', 'trainingFeatures194', 'trainingFeatures195', 'trainingFeatures196', 'trainingFeatures197', 'trainingFeatures198', 'trainingFeatures199', 'trainingFeatures200', 'trainingFeatures201', 'trainingFeatures202', 'trainingFeatures203', 'trainingFeatures204', 'trainingFeatures205', 'trainingFeatures206', 'trainingFeatures207', 'trainingFeatures208', 'trainingFeatures209', 'trainingFeatures210', 'trainingFeatures211', 'trainingFeatures212', 'trainingFeatures213', 'trainingFeatures214', 'trainingFeatures215', 'trainingFeatures216', 'trainingFeatures217', 'trainingFeatures218', 'trainingFeatures219', 'trainingFeatures220', 'trainingFeatures221', 'trainingFeatures222', 'trainingFeatures223', 'trainingFeatures224', 'trainingFeatures225', 'trainingFeatures226', 'trainingFeatures227', 'trainingFeatures228', 'trainingFeatures229', 'trainingFeatures230', 'trainingFeatures231', 'trainingFeatures232', 'trainingFeatures233', 'trainingFeatures234', 'trainingFeatures235', 'trainingFeatures236', 'trainingFeatures237', 'trainingFeatures238', 'trainingFeatures239', 'trainingFeatures240', 'trainingFeatures241', 'trainingFeatures242', 'trainingFeatures243', 'trainingFeatures244', 'trainingFeatures245', 'trainingFeatures246', 'trainingFeatures247', 'trainingFeatures248', 'trainingFeatures249', 'trainingFeatures250', 'trainingFeatures251', 'trainingFeatures252', 'trainingFeatures253', 'trainingFeatures254', 'trainingFeatures255', 'trainingFeatures256', 'trainingFeatures257', 'trainingFeatures258', 'trainingFeatures259', 'trainingFeatures260', 'trainingFeatures261', 'trainingFeatures262', 'trainingFeatures263', 'trainingFeatures264', 'trainingFeatures265', 'trainingFeatures266', 'trainingFeatures267', 'trainingFeatures268', 'trainingFeatures269', 'trainingFeatures270', 'trainingFeatures271', 'trainingFeatures272', 'trainingFeatures273', 'trainingFeatures274', 'trainingFeatures275', 'trainingFeatures276', 'trainingFeatures277', 'trainingFeatures278', 'trainingFeatures279', 'trainingFeatures280', 'trainingFeatures281', 'trainingFeatures282', 'trainingFeatures283', 'trainingFeatures284', 'trainingFeatures285', 'trainingFeatures286', 'trainingFeatures287', 'trainingFeatures288'};
predictors = inputTable(:, predictorNames);
response = inputTable.Class;
isCategoricalPredictor = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

% Perform cross-validation
partitionedModel = crossval(trainedClassifier.ClassificationSVM, 'KFold', 5);

% Compute validation predictions
[validationPredictions, validationScores] = kfoldPredict(partitionedModel);

% Compute validation accuracy
validationAccuracy = 1 - kfoldLoss(partitionedModel, 'LossFun', 'ClassifError');
