# Anti-spoofing-for-Face-Recognition

This is an anti-spoofing algorithm for face detection systems. The algorithm aims at using the sensitivity of the human eye’s pupil to light to detect if the face recognition system is being deceived by a display of a human face or not. The pupil of a live face is expected to shrink in size when light is flashed upon it. Thus in this work, a method to detect the area of the pupil has been developed. The colour information of the input image is used to derive an EyeMap that helps separate the eye region from the rest of the face. Further, a radial symmetry transform is used to locate the pupil in the eye region. As the final step, the region that corresponds to the pupil is separated from the eye region and its area is calculated. The pupil areas are calculated on images that are acquired in two different light settings. These areas are analyzed to check if the changes in the pupil area are in line with the changes in light settings. Based on this analysis a spoofed or not-spoofed decision is made. Using this approach we were able to achieve accurate performance for spoof detection on the data that we collected.

A detailed report on the algorithm can be found [here](https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Face%20Anti-spoofing%20using%20Pupil%20Response%20New.pdf).

## Data Collection

The image dataset for the project consists of 65 images of the face of 6 people. All the images contain only the face of the people and with a clear background. From everyone, approximately 10 or 11 images were captured. The light was flashed all the time during image acquisition to make the pupil visible. The variation in pupil size was induced by moving the light source towards the eye. Initially, a set of images were captured with the light source positioned in such a way that the pupil is visible in the images acquired. Another set of images was captured by moving the light source towards the eye of the individual to induce a change in pupil size. All the images were captured with the face positioned approximately 15cm to 20cm away from the camera. A close distance was maintained between the camera and the face to make sure that we can see the complete face and recognize the eye and the pupil properly. Every image has a slight variation in the head pose to improve the dataset. The images were captured on a mobile phone with a 48mp camera and each image is of 4000x1824 resolution.

## Anti-spoofing Algorithm

### Pre-processing

There should not be too much face movement during the image acquisition process. The subject moving their face towards or away from the camera will induce unnecessary changes in the area of the pupil. This must thus be kept under check. For this purpose, the SURF keypoints and descriptors calculated on the input images were used. The most strongly matched keypoints were chosen and the mean of the differences in the position of each of these matched keypoints 
was calculated to analyse the change in position of the face. A threshold was set and if this mean distance is greater than the threshold then there is too much unnecessary movement during the input image acquisition and the inputs are rejected. The second pre-processing step is to extract the face region from the two input images. An object detector based on the Viola-Jones algorithm to detect people’s faces was used. The backgrounds in the input images are discarded and only the face regions extracted from the input images are passed on for further processing. Below is the flowchart of the pre-processing steps.

<p align="center">
<img src="https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Images/flowchart_preprocessing.png" width=70% height=70% />
</p>

### Eye Detection

As the first step, the face image is split in half and the bottom half is discarded as it is a known fact that the eyes are present on the top half of the face. The next step is to convert the image from RGB to YCbCr colour space. The human skin irrespective of the skin type and colour shares similar chrominance values and thus the Cb and Cr information from the YCbCr colour space can be used to create a map where the skin regions are suppressed and the other regions in the face are highlighted. To identify the eye region a window was defined and it was moved along the created map and scores were computed. The position of the eyes is determined by sweeping through this score matrix and retrieving the regions with the highest scores. 

### Pupil Centre Detection

Fast Radial Symmetry Transform (FRST) uses the local radial symmetry to identify the centre of a bright or dark (almost) circular area that has a radius that falls within a defined set of radii. The eyes detected are cropped out of the image and the pupil centre is obtained from it using FRST. Below is an image with the pupil centres detected on a test image.

<p align="center">
<img src="https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Images/output_pupilCenter.png" width=40% height=40% />
</p>

### Pupil Area Calculation

The method used for calculating the area of the pupil can be found in the flowchart below. More details can be found in the report [here](https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Face%20Anti-spoofing%20using%20Pupil%20Response%20New.pdf).

<p align="center">
<img src="https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Images/flowchart_pupil.png" width=70% height=70% />
</p>

### Spoof Detection

There are two pupil area values obtained from each of the two input images. The areas obtained from the left eye in each of the input images and the areas obtained from the right eye are compared. The algorithm checks if the set of pupil areas obtained from the input image 1 (light source away from eyes) is significantly greater than the corresponding pupil areas obtained from image 2 (light source closer to the eye). To make sure the difference in the pupil areas is significant, a threshold value is defined. If the difference in the pupil areas is greater than the defined threshold then the algorithm declares that there is ‘no spoof’ detected. 

## Results

Below is a test image with the detected pupil areas. 

<p align="center">
<img src="https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Images/output_pupil.png" width=40% height=40% />
</p>

Manually calculating the area and error in all 65 images in the dataset is very hectic. Thus we randomly chose six images each belonging to one of the six participants that we had. Table below shows the results that were obtained from these six images. The true positive (TP) column represents the number of pupil pixels that were correctly identified by the algorithm. The false positives (FP) column represents the number of pixels that were actually not part of the pupil but were included in the pupil area by the algorithm. The false negatives (FN) column contains the number of pixels that were actually part of the pupil but were neglected and not included under the pupil area by the algorithm. True negatives (TN), the number of pixels that were correctly classified as non-pupil pixels is too large and thus it has not been taken into consideration for performance analysis. 

<p align="center">
<img src="https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Images/output_table.png" width=40% height=40% />
</p>

The below image shows the magnified version of the detected pupil area detected in eye 1 of image number 6 in the above table. This view is to show the performance of the algorithm. The performance results computed on the image shown below can be found in the table above.

<p align="center">
<img src="https://github.com/aishwaryamuthuvel/Anti-spoofing-for-Face-Recognition/blob/main/Images/output_image.png" width=60% height=60% />
</p>












