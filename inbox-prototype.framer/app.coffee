# Setup Background Layer
bgLayer = new BackgroundLayer

# View: Detail Inbox Note View
width = Screen.width * 0.9
height = Screen.height * 0.8
# Interaction: Swipe to Scroll Inbox Notes
page = new PageComponent
	width: width
	height: Screen.height 
	scrollVertical: false
	backgroundColor: "blue"	
page.center()

# View: Multiple Inbox Notes
noteWidth = width * 0.8
noteHMargin = 0

mouseY = 0

for i in [0...5]
	layer = new Layer
		superLayer: page.content
		width: noteWidth
		height: height
		backgroundColor:'red'
		opacity: 0.5
		scale: 0.8
		x: (noteWidth + noteHMargin) * i + 50
	
	layer.centerY()
	layer.draggable.enabled = true 
	layer.draggable.horizontal = false 
	layer.on Events.DragEnd, (event, draggable, layer) ->
		print layer.draggable.velocity
		if layer.draggable.velocity.y > 2.0 || layer.draggable.velocity.y < -2.0
			this.animate
            	properties:
         	   		rotation: 360
            		curve: "spring(300,20,0)"    
			layer.on Events.AnimationEnd, ->
    	    	this.destroy()
			        
   
#TODO: CLEAN THIS CENTERING 
		
		
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
page.on ""

# Interaction: Swipe Down To Toss


# Animation: Rotate Note View based on acceleration

# Remove View