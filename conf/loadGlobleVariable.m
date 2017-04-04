global AllRRType;
AllRRType = ['!' '/' 'A' 'E' 'F' 'J' 'L' 'N' 'R'  'V' 'a' 'f' 'j'];

global NumOfRRType;
NumOfRRType = length(AllRRType);

global RRTypeMap;
RRTypeMap = containers.Map;
for j = 1 : NumOfRRType
    RRTypeMap(AllRRType(j)) = j;
end

global AllFileNumber;
AllFileNumber = 100 : 109;
AllFileNumber = [AllFileNumber, 111:119];
AllFileNumber = [AllFileNumber, 121:124];
AllFileNumber = [AllFileNumber, 200:203];
AllFileNumber = [AllFileNumber, 205:205];
AllFileNumber = [AllFileNumber, 207:210];
AllFileNumber = [AllFileNumber, 212:215];
AllFileNumber = [AllFileNumber, 217:217];
AllFileNumber = [AllFileNumber, 219:223];
AllFileNumber = [AllFileNumber, 228:228];
AllFileNumber = [AllFileNumber, 230:234];

global NumOfTamplet;
NumOfTamplet = 10;

global NumOfTrainData;
NumOfTrainData = 2000;
