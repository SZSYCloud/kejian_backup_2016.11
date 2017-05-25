function n = psnumdocs()
%PSNUMDOCS    Return the number of documents currently open in Photoshop.
%
%   Example:
%   n = psnumdocs
%
%   See also PSSETACTIVEDOC, PSCLOSEDOC, PSDOCNAMES, PSNEWDOC,
%   PSNEWDOCMATRIX, PSHISTOGRAM, PSOPENDOC, PSDOCINFO

%   Thomas Ruark, 2/14/2006
%   Copyright 2006 Adobe Systems Incorporated

% this should never fail (good one), no need for try catch wrapper
n = str2double(psjavascriptu('app.documents.length;'));
