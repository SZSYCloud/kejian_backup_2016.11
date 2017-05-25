function [w, h, r, n, m, b, a] = psdocinfo()
%PSDOCINFO    Return information for the current document in Photoshop.
%   [W] = PSDOCINFO() returns the width of the document in the current
%   units. See PSCONFIG for more information on units.
%
%   [W, H, R, N, M, B] = PSDOCINFO() returns all information for the
%   current document. W is the width, H is the height, R is the resolution,
%   N is the name, M is the mode, either 'bitmap', 'cmyk', 'duotone',
%   'grayscale', 'indexedcolor', 'lab', 'multichannel', 'rgb'. B is the
%   bits per channel or document depth. A is the aspect ratio.
%
%   Example:
%   [w, h] = psdocinfo
%   [w, h, r, n, m, b, a] = psdocinfo
%
%   See also PSSETACTIVEDOC, PSCLOSEDOC, PSDOCNAMES, PSNEWDOC,
%   PSNEWDOCMATRIX, PSNUMDOCS, PSHISTOGRAM, PSOPENDOC, PSCONFIG,
%   PSCOLORSETTINGS

%   Thomas Ruark, 2/3/2006
%   Copyright 2006 Adobe Systems Incorporated

pssep = '8F6AFB7E-EC1F-4b6f-AD15-C1AF34221EED';

% Build up the JavaScript
pstext = ['var docInfo = "";' ...
    'var psresult = "";' ...
    'try {' ...
    '     docInfo += activeDocument.width.value.toString();' ...
    '     docInfo += "' pssep '";'...
    '     docInfo += activeDocument.height.value.toString();' ...
    '     docInfo += "' pssep '";'...
    '     docInfo += activeDocument.resolution.toString();' ...
    '     docInfo += "' pssep '";'...
    '     docInfo += activeDocument.name;' ...
    '     docInfo += "' pssep '";'...
    '     docInfo += activeDocument.mode.toString();' ...
    '     docInfo += "' pssep '";'...
    '     docInfo += activeDocument.bitsPerChannel.toString();' ...
    '     docInfo += "' pssep '";'...
    '     docInfo += activeDocument.pixelAspectRatio;' ...
    '     docInfo += "' pssep '";'...
    '     var b = docInfo.toString();' ...
    '     psresult = b;' ...
    '}' ...
    'catch(e) {' ...
    '     psresult = e.toString();' ...
    '}' ...
    'psresult;'];

psresult = psjavascriptu(pstext);

l = strfind(psresult, pssep);
n = {};
if isempty(l)
    error(psresult);
else
    le = length(psresult);
    c = 1;
    for ii = 1:length(l)
        n{ii} = psresult(c:l(ii)-1);
        c = c + length(n{ii}) + length(pssep);
    end
    n{length(l)+1} = psresult(c:le);
end

a = str2num(n{7});

b = n{6};
if strcmp(b, 'BitsPerChannelType.EIGHT')
    b = 8;
elseif strcmp(b, 'BitsPerChannelType.ONE')
    b = 1;
elseif strcmp(b, 'BitsPerChannelType.SIXTEEN')
    b = 16;
elseif strcmp(b, 'BitsPerChannelType.THIRTYTWO')
    b = 32;
end

m = n{5};
m = strrep(m, 'DocumentMode.', '');
m = lower(m);

r = str2num(n{3});
h = str2num(n{2});
w = str2num(n{1});
n = n{4};
