function [] = psclosedoc(o)
%PSCLOSEDOC    Close the active document in Photoshop.
%   PSCLOSEDOC() closes the current active document in Photoshop. If this
%   document needs saving, a dialog will pop in Photoshop.
%
%   PSCLOSEDOC(1) forces the document to close without saving changes.
%   Recommended.
%
%   PSCLOSEDOC(2) save changes to the document. A dialog will pop if this
%   document does not have a file reference.
%
%   Example:
%   psclosedoc(1)
%
%   See also PSSETACTIVEDOC, PSDOCNAMES, PSNEWDOC, PSNEWDOCMATRIX,
%   PSNUMDOCS, PSHISTOGRAM, PSOPENDOC, PSDOCINFO

%   Thomas Ruark, 2/3/2006
%   Copyright 2006 Adobe Systems Incorporated

ss = 'PROMPTTOSAVECHANGES';

if exist('o', 'var')
    if o == 1
        ss = 'DONOTSAVECHANGES';
    elseif o == 2
        ss = 'SAVECHANGES';
    end
end

% Build up the JavaScript
pstext = ['try { var result = "";' ...
    '    app.activeDocument.close(SaveOptions.' ss ');' ...
    '   result = "OK";' ...
    '}' ...
    'catch(e) { result = e.toString(); } ' ...
    'result;'];

psresult = psjavascriptu(pstext);

if ~strcmp(psresult, 'OK')
    error(psresult);
end
