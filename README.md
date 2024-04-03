# Modals by New Material
A lightweight alternative to system sheets on iOS.

https://github.com/newmaterialco/Modals/assets/58298401/d4931000-55e1-4dac-ba0d-240b3fb6573a

# Installation

You can add Modals to your project using Swift Package Manager.

-   From the File menu, select Add Packages...
-   Enter the repo URL

```
http://github.com/fieldday-ai/Modals.git
```

# Set Up

To set up Modals in your project, wrap the root view of your project in the `ModalStackView`. This will allow modals to be overlayed from the root level of the view hierarchy.
```swift
@main
struct ModalsExample: App {
    var body: some Scene {
        WindowGroup {
            // Wrap your root view in the ModalStackView
            ModalStackView {
                ContentView()
            }
        }
    }
}
```

# Usage

To register a modal, call the `.modal()` modifier on any `View` (just like with system sheets).

```swift 
struct ContentView: View {
    
    @State var isPresented: Bool = false
    
    var body: some View {
        Button {
            isPresented = true
        } label: {
            Text("Open")
        }
        .modal(isPresented: $isPresented) {
            Text("Modal!")
        }
    }
}
```

### Dismiss Action

To dismiss a modal programmatically from within a modal, use the `dismissAction` environment value.

```swift
struct ModalContentView: View {

    @Environment(\.dismissModal) var dismissModal
    
    var body: some View {
        Button("Dismiss this modal!") {
            dismissModal()
        }
    }
}
```

# Advanced Usage

## Modal Customization

### Size
To change the size of the modal, pass in a `ModalSize` into the `.modal()` modifier. 
```swift 
.modal(
    ...,
    size: .medium
) { 
    ...
}
```

There are `.small`, `.medium`, and `.large` default sizes, as well as custom sizes defined by a constant `.height` or a `.fraction` of the screen height (inspired by `presenationDetents` on system sheets).

### Corner Radius

To change the corner radius of the modal, use the `cornerRadius` argument in the `.modal()` modifier.

```swift 
.modal(
    ...,
    cornerRadius: 18
) { 
    ... 
}
```

### Options

You can also pass in an array of available customization options to the `.modal()` modifier.
- `.prefersDragHandle`: Replaces the default close button with a center-aligned drag handle.
- `.disableContentDragging`: Disables the ability to drag on content to dismiss the modal (sometimes useful when a ScrollView is embedded in the modal).

```swift 
.modal(
    ...,
    options: [.prefersDragHandle]
) { 
    ... 
}
```

## ModalStack Customization

The ModalStack can be customized by using a variety of supported modifers.

_In the below context, "Content" is just whatever view is being overlayed by the modal._

### Content Scaling
Content scaling can be disabled by using the `.contentScaling()` modifier.

```swift
ModalStackView {
    ...
}
.contentScaling(false)
```

### Content Saturation
Content saturation can be disabled by using the `.contentSaturation()` modifier.

```swift
ModalStackView {
    ...
}
.contentSaturation(false)
```

### Content Background Color

Content background color can be adjusted using the `.contentBackgroundColor()` modifier. This is the only way to have a background color ignore safe area completely while content scaling is enabled.

```swift
ModalStackView {
    ...
}
.contentBackgroundColor(Color.blue)
```

### Container Background Color

To change the container background color (in the video, the area that is white behind the root content & presented modals), use the `.containerBackgroundColor()` modifier.

```swift
ModalStackView {
    ...
}
.containerBackgroundColor(Color.blue)
```
