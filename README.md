# Vinted GO picker (PUDO picker)

## Introduction

Library that helps to visualise PUDO points in map.

![Simulator Screen Shot - iPhone 8 - 2022-10-12 at 14 36 09](https://user-images.githubusercontent.com/51507132/195333176-86f606c5-08ad-4d0c-951f-c8e2bbe4320d.png)

## Installation
### SPM

In Xcode File -> Add Packages -> https://github.com/vinted/vgo-picker-iOS

## Usage
### Programatic UIKit
#### Starting the picker

```Swift
let picker = VintedGOPicker(rootViewController: self)
picker.start(pickupPointResponse: pickupPointResponseStub) { selectedPickupPointCode in
    print(pickupPointCode)
}
```

#### Creating a IUViewController for embedding or presenting manually
```Swift
let viewController = MapPickerFactory.makeViewController(pickupPointsResponse: pickupPointResponse) { shippingPointCode in
    print(pickupPointCode)
}
```
