function [face] = detectFace(I)

 FaceDetect = vision.CascadeObjectDetector('FrontalFaceCART');
 faceROI = FaceDetect(I);
 
 if isempty(faceROI)
     error('No face detected.')
 else
    face = imcrop(I,faceROI);
 end
end

