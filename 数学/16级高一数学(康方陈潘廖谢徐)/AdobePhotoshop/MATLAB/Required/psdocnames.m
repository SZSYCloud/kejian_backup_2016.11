function n = psdocnames()
%PSDOCNAMES    Return the names of all the open documents in Photoshop.
%  [N] = PSDOCNAMES() returns a cell array containing all the document
%  names that are open in Photoshop.
%
%   Example:
%   n = psdocnames
%
%   See also PSSETACTIVEDOC, PSCLOSEDOC, PSNEWDOC, PSNEWDOCMATRIX,
%   PSNUMDOCS, PSHISTOGRAM, PSOPENDOC, PSDOCINFO

%   Thomas Ruark, 2/3/2006
%   Copyright 2006 Adobe Systems Incorporated

pssep = '8F6AFB7E-EC1F-4b6f-AD15-C1AF34221EED';

% Build up the JavaScript
pstext = ['var docnames = "";' ...
    'for (var i = 0; i < app.documents.length; i++)' ...
    '{' ...
    '     docnames += app.documents[i].name;' ...
    '     if ((i + 1) != app.documents.length) {' ...
    '        docnames += "' pssep '";'...
    '    }' ...
    '}' ...
    'docnames;'];

t = psjavascriptu(pstext);
l = strfind(t, pssep);
n = {};
if ~isempty(l)
    le = length(t);
    c = 1;
    for ii = 1:length(l)
        n{ii} = t(c:l(ii)-1);
        c = c + length(n{ii}) + length(pssep);
    end
    n{length(l)+1} = t(c:le);
else
    n{1} = t;
end
