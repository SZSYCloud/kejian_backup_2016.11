function [] = psnewdocmatrix(img)
%PSNEWDOCMATRIX    Create a new document in Photoshop from a matrix.
%   PSNEWDOCMATRIX(I) I is the H-by-W-by-C matrix representing the H
%   (height), W (width), C (channels) of the document to create.
%
%   Example:
%   psnewdocmatrix(img)
%
%   See also PSSETACTIVEDOC, PSCLOSEDOC, PSDOCNAMES, PSNEWDOC, PSNUMDOCS,
%   PSHISTOGRAM, PSOPENDOC, PSDOCINFO, PSIMREAD

%   Thomas Ruark, 01/28/2007
%   Copyright 2007 Adobe Systems Incorporated

h = size(img);
if length(h) > 2
    m = h(3);
    if m == 3
        m = 'rgb';
    elseif m == 4
        m = 'cmyk';
    else
        m = 'grayscale';
    end
else
    m = 'grayscale';
end
w = h(2);
h = h(1);

ru = psconfig();

if ~strcmp(ru, 'pixels')
    psconfig('pixels');
end

% create the doc
psnewdoc(w, h, 'undefined', 'undefined', m);

% convert the mode, you need to go to 16 and then to 32
if isa(img, 'uint16') || isa(img, 'double')
    psjavascriptu('activeDocument.bitsPerChannel = BitsPerChannelType.SIXTEEN');
end

if isa(img, 'double')
    psjavascriptu('activeDocument.bitsPerChannel = BitsPerChannelType.THIRTYTWO');
end

% set the pixels
pssetpixels(img);

if ~strcmp(ru, 'pixels')
    psconfig(ru);
end
