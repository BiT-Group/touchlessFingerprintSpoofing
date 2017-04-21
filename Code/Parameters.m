classdef Parameters
    %Parameters is the class responsible for global parameters
    %   Although global variables are not recomended, this class will make
    %   it easier to change parameters
    
    properties (Access = public, Constant = true)
        %% Code parameters
        diskFilterRadius = 70;
        thresholdPrecision = 0.00001;
        quantDimension = 91; %expected to be an odd value
        ILBPNeighborhoodDimension = 3; %expected to be an odd value
        foldersWithRealFingers = [1]; %these folders (from the "Samples" folder) will be concatenated into one single final folder (as one class)
                                          % FOLDER 1 MUST ALWAYS BE REAL
                                          % FINGERS
        numberOfSamplesEachClass = 20;
        numberPCAToUse = 1;
        
        %% Data to be displayed
        showOriginalImage = false;
        showBlurredImage = false;
        showRawAOIMask = false;
        showAOIMask = false;
        showAOI = false;
        showEqualizedAOI = false;
        showTextureDescriptor = false;
        showNormalizedTextureDescriptor = false;
        
        %% Parallelism parameters
        useParallel = true;
        useSpecificPoolSize = false; % matlab uses a default number of pools
                                    % if it is not specified
        poolSize = 4;
        
        %% MEX-files parameters
        useMEXFiles = true;
        MEXFilesList = cellstr(['getILBPBinaryWord_'; 'getPossibleCodes_ '; 'decideQuant_      ']);
    end
    
    methods
    end
    
end

