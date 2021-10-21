# Google-Ignite-Tealth
This project consists of 2 components, the flutter application and the Tensorflow model.


## **Flutter Application - Tealth**
Tealth is a simple flutter application which analyzes your dental health.

Flutter version: 2.5.0

Required dependencies (listed in pubsec.yaml):

```
camera:
path_provider:
path:
image_picker: ^0.6.5
shared_preferences:
firebase_storage: any
firebase_core: any
uuid: any
font_awesome_flutter:
flutter_launcher_icons:
awesome_notifications: ^0.0.6+11
flutter_local_notifications: 8.2.0
rxdart: ^0.23.1
cupertino_icons: ^1.0.2
splashscreen: ^1.2.0
google_maps_flutter: any
geolocator: 7.6.2
provider: ^4.0.4
url_launcher: ^6.0.12
http: ^0.13.4
flutter_rating_bar: ^4.0.0
```

To run the code via terminal:
1. cd to **tealth_app** directory
2. flutter pub get
3. flutter run --no-sound-null-safety

To run the code via Android Studio:
1. Open project **tealth_app**
2. Go to **Run > Edit Configurations**
3. In the field **Additional run args**, enter **--no-sound-null-safety**
4. Apply the changes.
5. Run the project.

### Additional Notes:
The flutter application contains a Google Maps API key and google-services.json file for connecting to Firebase Storage. Both of these services shall be deactivated after 22 October 2021. If you wish to continue testing the application, please use your own Google Maps API key (enable Maps SDK for iOS, Maps SDK for Android, and Places API) and create your own Firebase project.

### Disclaimer:
The flutter application has only been tested on an Android device. There are no guarantees that it may work on an iOS device.

The flutter application is also not connected to the Tensorflow model. The results are proof-of-concept.


## **Tensorflow**
For Tensorflow, run **Copy_of_Tealth_Tensorflow.ipynb** on "Google Colab".
Download and upload "kaggle.json" file to "files" before running the code (no need to rename any files) then click "runtime" and "run all".

Dataset size: 60 total training images, 14 total validation images. Total size: 74 images

Flow of building the Tensorflow model:
1. Examine and understand data
2. Build an input pipeline
3. Build the model
4. Train the model
5. Test the model
6. Improve the model and repeat the process  (either by data augmentation or using pre-existing models like Transfer Learning)