# Anti-spoofing-for-Face-Recognition

This is an anti-spoofing algorithm for face detection systems. The algorithm aims at using the sensitivity of the human eye’s pupil to light to detect if the face recognition system is being deceived by a display of a human face or not. The pupil of a live face is expected to shrink in size when light is flashed upon it. Thus in this work, a method to detect the area of the pupil has been developed. The colour information of the input image is used to derive an EyeMap that helps separate the eye region from the rest of the face. Further, a radial symmetry transform is used to locate the pupil in the eye region. As the final step, the region that corresponds to the pupil is separated from the eye region and its area is calculated. The pupil areas are calculated on images that are acquired in two different light settings. These areas are analyzed to check if the changes in the pupil area are in line with the changes in light settings. Based on this analysis a spoofed or not-spoofed decision is made. Using this approach we were able to achieve accurate performance for spoof detection on the data that we collected. 

## Data Collection

The image dataset for the project consists of 65 images of the face of 6 people. All the images contain only the face of the people and with a clear background. From everyone, approximately 10 or 11 images were captured. The light was flashed all the time during image acquisition to make the pupil visible. The variation in pupil size was induced by moving the light source towards the eye. Initially, a set of images were captured with the light source positioned in such a way that the pupil is visible in the images acquired. Another set of images was captured by moving the light source towards the eye of the individual to induce a change in pupil size. All the images were captured with the face positioned approximately 15cm to 20cm away from the camera. A close distance was maintained between the camera and the face to make sure that we can see the complete face and recognize the eye and the pupil properly. Every image has a slight variation in the head pose to improve the dataset. The images were captured on a mobile phone with a 48mp camera and each image is of 4000x1824 resolution.

## Anti-spoofing Algorithm

### Pre-processing

There should not be too much face movement during the image acquisition process. The subject moving their face towards or away from the camera will induce unnecessary changes in the area of the pupil. This must thus be kept under check. For this purpose, the SURF keypoints and descriptors calculated on the input images were used. The most strongly matched keypoints were chosen and the mean of the differences in the position of each of these matched keypoints 
was calculated to analyse the change in position of the face. A threshold was set and if this mean distance is greater than the threshold then there is too much unnecessary movement during the input image acquisition and the inputs are rejected. The second pre-processing step is to extract the face region from the two input images. An object detector based on the Viola-Jones algorithm to detect people’s faces was used. The backgrounds in the input images are discarded and only the face regions extracted from the input images are passed on for further processing. Below is the flowchart of the pre-processing steps.




