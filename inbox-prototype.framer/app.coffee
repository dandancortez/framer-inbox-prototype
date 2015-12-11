# Setup Background Layer
bgLayer = new BackgroundLayer

# View: Detail Inbox Note View
width = Screen.width * 0.9
height = Screen.height * 0.5

#Constants
noteWidth = width * 0.8
mouseY = 0
tossVelocityThreshold = 1.0
# Interaction: Swipe to Scroll Inbox Notes
page = new PageComponent
	width: width
	height: Screen.height 
	scrollVertical: false
page.center()

for i in [0...50]
	layer = new Layer
		superLayer: page.content
		width: noteWidth
		height: height
		backgroundColor: Utils.randomColor(1.0)
		opacity: 0.5
		scale: 0.8
		x: noteWidth  * i + 50
	
	layer.centerY()

	# Save Default 
	layer.states.add
		defaultState: 
			x: layer.x
			y: layer.y
			opacity: 1.0
			rotation: 0
	layer.states.animationOptions =
   	 curve: "spring(100, 10, 0)"
   	 
   	# Set Up Dragging 
	layer.draggable.enabled = true 
	layer.draggable.momentum = true
	layer.draggable.momentumOptions =
    	friction: 0.5
    	tolerance: 0.1
	layer.draggable.horizontal = false 
	layer.draggable.speedY = 0.5
	
	layer.on Events.DragStart, (event, draggable, layer) ->
		layer.draggable.speedX = 0 # Temp While dragging

	
	layer.on Events.DragMove, (event, draggable, layer) ->
  		this.rotation = (page.midY- this.midY) * 0.05
	layer.on Events.DragEnd, (event, draggable, layer) ->
		velocity = this.draggable.velocity.y
		if velocity > tossVelocityThreshold || velocity < -tossVelocityThreshold
			this.animate
            	properties:
         	   		rotation: -velocity * 120
					repeat:0
		else 
			layer.states.switch("defaultState")
		page.scrollHorizontal = true # Temp While dragging

						
	layer.on "change:y", ->
		if this.states.current == "	defaultState"
			return 
		if this.midY < 0 || this.midY > Screen.height
			this.on Events.AnimationEnd,(animation, layer) ->
				this.destroy()
				page.snapToPage(page.closestPage)
			this.animate
				properties:
					opacity: 0.0
				time: 0.1	

page.currentPage.opacity = 1
page.currentPage.scale = 1.0

page.on "change:currentPage", ->
	page.previousPage.animate
		properties:
			opacity:0.3
			scale: 0.8
		time: 0.3
	
	page.currentPage.animate
		properties:
			opacity: 1
			scale: 1
		time: 0.4 
# Interaction: Swipe Up To Toss

# Interaction: Swipe Down To Toss


# Animation: Rotate Note View based on acceleration

# Remove View