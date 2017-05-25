function o = pssetactivedoc(n)
%PSSETACTIVEDOC    Bring the document with the given name to the front.
%   Photoshop operations need to occur on the front most, or active
%   document. This routine brings the document with the given name
%   to the front. It also returns the name of the document that was
%   active, to enable switching back to the previous document.
%
%   Example:
%   o = pssetactivedoc('Fish')
%
%   See also PSCLOSEDOC, PSDOCNAMES, PSNEWDOC, PSNEWDOCMATRIX, PSNUMDOCS,
%   PSHISTOGRAM, PSOPENDOC, PSDOCINFO, PSIMREAD

%   Thomas Ruark, 2/3/2006
%   Copyright 2006 Adobe Systems Incorporated

% build up JavaScript to send to Photoshop
pstext = ['var o = "";' ...
    'var result = "";' ...
    'try {' ...
    '    o = app.activeDocument.name;' ...
    '    app.activeDocument = app.documents["' n '"];' ...
    '    result = "OK";' ...
    '}' ...
    'catch(e) {' ...
    '    o = e.toString();' ...
    '    result = "FAIL";' ...
    '}' ...
    'var b = result + o;' ...
    'b;'];

psresult = psjavascriptu(pstext);

lo = strfind(psresult, 'OK');

if isempty(lo)
    error(psresult(length('FAIL') + 1:end));
else
    o = psresult(length('OK') + 1:end);
end
