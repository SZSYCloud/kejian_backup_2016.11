function n = psopendoc(f)
%PSOPENDOC    Open the file in Photoshop.
%   N = PSOPENDOC(F) F is the full path to the file. N is the resulting
%   name of the document.
%
%   Example:
%   n = psopendoc('C:\MyFile.jpg')
%
%   See also PSSETACTIVEDOC, PSCLOSEDOC, PSDOCNAMES, PSNEWDOC,
%   PSNEWDOCMATRIX, PSNUMDOCS, PSHISTOGRAM, PSDOCINFO, PSIMREAD

%   Thomas Ruark, 2/23/2006
%   Copyright 2006 Adobe Systems Incorporated

% an extra backslash on windows doesn't hurt
f = strrep(f, '\', '\\');

% build up the JavaScript
pstext = ['var result = "";' ...
    'var errorDetails = "";' ...
    'try {' ...
    '    app.open(File("' f '"));' ...
    '    result = app.activeDocument.name;' ...
    '}' ...
    'catch(e) {' ...
    '    errorDetails = e.toString();' ...
    '    result = "8F6AFB7E-EC1F-4b6f-AD15-C1AF34221EED";' ...
    '}' ...
    'var b = result + errorDetails;' ...
    'b;'];

psresult = psjavascriptu(pstext);

lo = strfind(psresult, '8F6AFB7E-EC1F-4b6f-AD15-C1AF34221EED');

if isempty(lo)
    n = psresult;
else
    error(psresult(length('8F6AFB7E-EC1F-4b6f-AD15-C1AF34221EED') + 1:end));
end

