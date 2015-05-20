
`UIView` & `UIWindow`

View Architecture Fundamentals
---

A view object defines a rectangular region on the screen and handles the drawing and touch events in that region.

A view can also act as a parent for other views and coordinate the placement and sizing of those views.

> Managing these relationships between views

---

Views work in conjunction with **Core Animation layers** to handle the rendering and animating of a view's content.

Every view in UIKit is backed by a layer object (usually an instance of the `CALayer` class), which manages the backing store for the view and handles view-related animations.

The actual drawing code of a view object is called as little as possible, and when the code is called, the results are cached by `Core Animation` and reused as much as possible later.

View Hierarchies and Subview Management
---

Each superview stores its subviews in an ordered arra and the order in that array also affects the visibility of each subview.

When a touch occures inside a specific view, the system sends an event object with the touch information directly to that view for handling. However, if the view does not handle a particular touch event, it can pass the event object along to its superview.

The View Drawing Cycle
---

`setNeedsDisplay` or `setNeedsDisplayInRect:`

The system waits until the end of the current run loop before initiating any drawing operations.

Content Modes
---

The **content mode** of a view is applied whenever you do the following:

* Change the width or height of the view's `frame` or `bounds` rectangles.
* Assign a transform that includes a scaling factor to the view's `transform` property.

`UIViewContentModeScaleToFill`
`UIViewContentModeRedraw` => want your custom views to redraw themselves during scaling and resizing operations.

Stretchable Views
---

`contentStretch`

Built-In Animation Support
---

Among the properties you can animate on a `UIView` object are the following:

`frame` - position and size changes for the view
`bounds` - changes to the size of the view
`center` - the position of the view
`transform` - rotate or scale the view
`alpha` - change the transparency of the view
`backgroundColor` - change the background color of the view
`contentStretch` - Use this to change how the view's contents stretch

View Geometry and Coordinate Systems
---
