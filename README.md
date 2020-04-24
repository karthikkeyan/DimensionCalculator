#  DimensionCalculator

`DimensionCalculator` is a useful utility for the project that has manual layout size calculation. 

If your project contains dynamic views created programatically, you may need to calculate the size of your view(s) after you set the value.

Calculating dimension of a view and subviews means calculaing it's the subcomponents of views based on the content. This calculations involves working with different types of data structure and data types like,

- `CGFloat`
- `CGSize`
- `CGRect`
- `NSConstraint`
- `String` + `UIFont`
- `NSAttributeString` + `UIFont`
- `UIEdgetInsets`
- `NSDirectionalEdgeInsets`
- Array of heights with fixed space between them
- Array of width with fixed space between them

If we were to calculate a view's height with there subview we will have to do some thing like this,

```swift
func cardDimension(for module: Product, bounds: CGRect) -> CGSize {
    let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    let descriptionFont = UIFont.systemFont(ofSize: 14, weight: .regular)
    var height: CGFloat = 0
    height += layoutMarginEdges.top
    height += imageHeight

    var size = module.title.boundingRect(
        with: bounds.size, 
        option: .usesLineFragmentOrigin, 
        attributes: [.font: font],
        context: nil
    )
    height += space
    height += size.height

    height += space
    size = module.description.boundingRect(
        with: bounds.size, 
        option: .usesLineFragmentOrigin, 
        attributes: [.font: font],
        context: nil
    )
    height += size.height

    height += space
    height += buttonHeight
    height += layoutMarginEdges.height
    return CGSize(width: bounds.width, height: height)
}
```

This calcuation logic could repeats in most of the ViewControllers and Views. `DimensionCalculator` abstracts the calculation logic behind different data structures and data types and let the callers/consumers only worry about supplying the values.

With `DimensionCalculator` the above code becomes like this,

```swift
func cardDimension(for module: Product, bounds: CGRect) -> CGSize {
    let space: CGFloat = 16
    let titleFont = UIFont.systemFont(ofSize: 18, weight: .bold)
    let descriptionFont = UIFont.systemFont(ofSize: 14, weight: .regular)

    var calculator = DimensionCalculator(constraint: .fixedWidth(bounds.width - .space))
    calculator.add(directionalInsets: NSDirectionalEdgeInsets(unit: space))
    calculator.add(height: [imageHeight, actionButtonHeight], spacing: spacing)
    calculator.add(
        texts: [ model.title: titleFont, model.description: descriptionFont ],
        spacing: space
    )
    calculator.add(height: space)
    return calculator.dimensions
}
```

## APIs

Initialize the struct with how you want to constraint the size calculation using one the below enums,

```swift
public enum SizeConstraint {
    // This will allow the width and height to grow, 
    // except the width will not outgrow the given value  
    case maximumWidth(CGFloat)
    
    // This will allow the width and height to grow, 
    // except the hight will not outgrow the given value
    case maximumHeight(CGFloat)
    
    // This will allow the height to grow with fixed with regardless of the content's height width
    case fixedWidth(CGFloat)
    
    // This will allow the height to grow with fixed with regardless of the content's width
    case fixedHeight(CGFloat)
}
```

Below are the apis `DimensionCalculator` provides at least for now. 

```swift
func add(height: CGFloat)

func add(width: CGFloat)

func add(size: CGSize)

func add(rect: CGRect)

func add(height: NSLayoutConstraint)

func add(width: NSLayoutConstraint)

func add(stack: UIStackView)

func add(heights: [CGFloat], spacing: CGFloat = 0)

func add(widths: [CGFloat], spacing: CGFloat = 0)

func add(text: String, font: UIFont)

func add(text: NSAttributedString)

func add(texts: [String: UIFont], spacing: CGFloat)

func add(texts: [NSAttributedString], spacing: CGFloat)

func add(insets: UIEdgeInsets)

func add(directionalInsets: NSDirectionalEdgeInsets)
```


> Note: The code is at the early stages, so it is still under development, this apis are likley to change. Please give me your valuable inputs if you find this useful. 
