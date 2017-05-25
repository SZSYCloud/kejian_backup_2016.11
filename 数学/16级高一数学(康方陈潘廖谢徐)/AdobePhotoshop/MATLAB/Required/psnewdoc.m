function [] = psnewdoc(w, h, r, n, m, f, a, b, p)
%PSNEWDOC    Create a new document in Photoshop.
%   PSNEWDOC creates a new document with the default parameters.
%
%   PSNEWDOC(W,H) W and H for width and height are in the current units of
%   Photoshop. See PSCONFIG for setting and getting the current units. Pass
%   in 'undefined' as a string to skip input arguments. 504 x 360 pixels is
%   the default size. All defaults described here are for an English
%   Operating System. 
%
%   PSNEWDOC(W,H,R,N,M,F,A,B,P) R for resolution, default is 72 ppi for an
%   English Operating System. N for name, default is 'Untitled-X' where X
%   is the index for new documents. M for mode is 'rgb', 'cmyk', 'lab',
%   'bitmap', 'grayscale', default is 'rgb'. F for initial fill is
%   'backgroundcolor', 'transparent', 'white', 'white' is the default. A
%   for pixel aspect ratio, default is 1.0. B for bits per pixel, 1, 8,
%   16, 32, default is 8. P for color profile name, default is the
%   working profile for that color mode.
%
%   Example:
%   psnewdoc
%   psnewdoc(10, 10, 72, 'hi', 'cmyk', 'transparent', 2.5, 16, 'U.S. Web Coated (SWOP) v2')
%
%   See also PSSETACTIVEDOC, PSCLOSEDOC, PSDOCNAMES, PSNEWDOCMATRIX,
%   PSNUMDOCS, PSHISTOGRAM, PSOPENDOC, PSDOCINFO

%   Thomas Ruark, 3/29/2006
%   Copyright 2006 Adobe Systems Incorporated

% Build up the JavaScript
pstext = 'try { var result = "";';
pstext = [pstext 'documents.add('];

if exist('w', 'var')
    if isnumeric(w)
        w = num2str(w);
    end
    pstext = [pstext w ', '];
else
    pstext = [pstext 'undefined, '];
end

if exist('h', 'var')
    if isnumeric(h)
        h = num2str(h);
    end
    pstext = [pstext h ', '];
else
    pstext = [pstext 'undefined, '];
end

if exist('r', 'var')
    if isnumeric(r)
        r = num2str(r);
    end
    pstext = [pstext r ', '];
else
    pstext = [pstext 'undefined, '];
end

if exist('n', 'var')
    if ~strcmp(n, 'undefined')
        pstext = [pstext '"' n '", '];
    else
        pstext = [pstext 'undefined, '];
    end
else
    pstext = [pstext 'undefined, '];
end

if exist('m', 'var')
    pstext = [pstext 'NewDocumentMode.' upper(m) ', '];
else
    pstext = [pstext 'undefined, '];
end

if exist('f', 'var')
    pstext = [pstext 'DocumentFill.' upper(f) ', '];
else
    pstext = [pstext 'undefined, '];
end

if exist('a', 'var')
    pstext = [pstext num2str(a) ', '];
else
    pstext = [pstext 'undefined, '];
end

if exist('b', 'var')
    if ~isnumeric(b)
        b = str2num(b);
    end
    if b == 1
        b = 'ONE';
    elseif b == 16
        b = 'SIXTEEN';
    elseif b == 32
        b = 'THIRTYTWO';
    else
        b = 'EIGHT';
    end
    pstext = [pstext 'BitsPerChannelType.' b ', '];
else
    pstext = [pstext 'undefined, '];
end

if exist('p', 'var')
    if ~strcmp(n, 'undefined')
        pstext = [pstext '"' p '", '];
    else
        pstext = [pstext 'undefined, '];
    end
end

pstext = [pstext ');'];


% footer start, wrap in try catch block
pstext = [pstext ' result = "OK";'];
pstext = [pstext '}'];
pstext = [pstext 'catch(e) { result = e.toString(); } '];
pstext = [pstext 'result;'];
% footer end, wrap in try catch block

psresult = psjavascriptu(pstext);

if ~strcmp(psresult, 'OK')
    error(psresult);
end
