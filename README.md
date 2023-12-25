# CoreAnimationIntroduction

Core Animation

- CABasicAnimation
- CASpringAnimation

Groups, Keyframes, Transitions
- Groups
- Keyframes
- Transitions
- Custom layer -> animation layer
- Shape layer -> animation layer
- CAReplicatorLayer

Note: 
- Create animation: keyPath, fromValue, toValue, fillMode, duration, repeatCount, autoreverse, …
- Create custom layer: name class (type of layer), frame, path, and other properties ,.. fillColor, lineWidth,…

Actions and Transactions
- Custom action animation - CAActionDelegate
- Using Transaction to create animation - CATransaction.begin(), .comit()

3D Transform
- Label.layer.transform  = customTransform
- CATransform3DScale, CATransform3DRotate, CATransform3DTranslate, …
- CAEmitterLayer(work with EmitterCell)
