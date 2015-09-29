From Virtual to Reality: Fast Adaptation of Virtual Object Detectors to Real Domain
========

Dataset and code for "From Virtual to Reality: Fast Adaptation of Virtual Object Detectors to Real Domains" by Baochen Sun and Kate Saenko. Published in British Machine Vision Conference(BMVC) 2014.

Paper: https://github.com/UMassLowell-Vision-Group/bmvc2014/raw/master/bmvc14_paper.pdf

Extended Abstract: https://github.com/UMassLowell-Vision-Group/bmvc2014/raw/master/bmvc14_extended_abstract.pdf

Poster: https://github.com/UMassLowell-Vision-Group/bmvc2014/raw/master/bmvc14_poster.pdf

Citation
--------------

If you find this project is useful in your research, please consider citing:

```
@inproceedings{baochen14BMVC,
    Author = {Baochen Sun and Kate Saenko},
    Title = {From Virtual to Reality: Fast Adaptation of Virtual Object Detectors to Real Domains},
    Booktitle = {British Machine Vision Conference},
    Year = {2014}
}
```

FAQ
--------------
Please go to the GitHub repo (Click the 'View on GitHub' button in the above) for source code, 3d Models, datasets, etc.

The source code is available in 'code' folder. The render.ms is the file for the rendering part. All the rendered images (with annotation) are in these two folders: 'virtual' and 'virtual_gray'. The 3D models is in the '3d_models' folder. Basically, here are the brief steps:

1. Download the 3D models

2. Run render.ms in 3ds Max (the software we used to generate the dataset)

The are also limited comments in render.ms which might help you understand the code.

To generate more realistic images (as in the 'What Do Deep CNNs Learn About Object' paper), you may need to specify different background and texture for different category/3d model. Then you need to change the 'images_bg' and 'images_texture' in the render.ms file to point to different background and textures for different category/3d model.

For now, we did not implemented the full photorealistic rendering since it is more complicated (e.g. might need to use ray-tracking algorithms to do that) and take far more time (e.g. hours) to render one image. However, as showed in the 'From-Virtual-to-Reality' paper, simple domain adaptation techniques can get same performance as training classifiers with real images (e.g. images from ImageNet).
