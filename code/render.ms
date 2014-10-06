-- MAXScript used in BMVC'2014 paper of "From Virtual to Reality: Fast Adaptation of Virtual Object Detectors to Real Domains"
--Copyright (c) 2014,  Baochen Sun

--categories used in the BMVC paper
categories = #("back_pack", "bike", "bike_helmet",  "bookcase", "bottle", "calculator", "desk_chair", "desk_lamp", "file_cabinet", "laptop_computer", "mobile_phone", "monitor", "mouse", "mug", "paper_notebook", "pen", "phone", "projector", "ring_binder", "ruler")
--possible viewpoints, only the first one was used in the BMVC paper(since we only used one component LDA)
viewpoints =#(#view_none, #view_left, #view_right, #view_back, #view_front) 
--background images
images_bg = getFiles "C:\\Users\\baochens\\Desktop\\photorealistic\\image_all\\*" 
--texture images
images_texture = getFiles "C:\\Users\\baochens\\Desktop\\photorealistic\\image_all\\*" 

for cat=1 to categories.count do 
(
	category = categories[cat]
	--Set up the file path
	file_path = "C:\\Users\\baochens\\Desktop\\photorealistic\\3d_models_all\\"+category+"\\*.max"  
	models_all = getFiles file_path
	
for iterator=1 to models_all.count do
(
	resetMaxFile #noPrompt
	loadMaxFile models_all[iterator]
	--omniLight()
	--radius = 500
	
	-- number of possible poses
   num_poses = 15
	-- number of light positions per pose
	num_omni_positions = 1
	
	-- group all the component to obj
    obj = #()
    for component in Geometry do
    (
	    Append obj component
    )
    select obj
	move selection [-selection.min.x,-selection.max.y,-selection.min.z]

	setRenderType  #regionselected 
	
for k=1 to 1 do
(
	--setup viewpoint
	viewport.getType
	viewport.setType viewpoints[k]
	viewport.getType
	for  i = 1 to num_poses do
	(
		-- random rotate each model(0 to 20 degree) in three directions
		randXrot = random 0 20
		randYrot = random 0 20
		randZrot = random 0 20
		rot_obj = eulerangles randXrot randYrot randZrot
		about [0, 0, 0] rotate obj rot_obj
		for j = 1 to num_omni_positions do
		(
			-- add background
			setUseEnvironmentMap true
			randBackground = random 1 images_bg.count
			environmentMap = bitmapTexture filename:images_bg[randBackground] 
			replaceinstances environmentMap.coords (StandardUVGen mappingType:1 mapping:3)
			-- add texture
			randTexture = random 1 images_texture.count
			obj_textures=bitmapTexture filename:images_texture[randTexture] 
			replaceinstances obj_textures.coords (StandardUVGen mappingType:0 mapping:2 UVW_Type:1 V_Angle:90.0 realWorldScale:true)
			obj.material = standard diffuseMap:(obj_textures)
			
			-- ramdom light position
			--new_Omni_x = random -radius radius
			--new_Omni_y = random -radius radius
			--$Omni001.pos = [new_Omni_x, new_Omni_y ,sqrt(radius^2 - new_Omni_x^2 - new_Omni_y)]
			
			-- render result
			file_name = "C:\\Users\\baochens\\Desktop\\photorealistic\\results\\"+category+"\\renderresultwithbackground\\" + category +"_" \
			+ iterator as string + "_view_" + k as string +"_pose_" + i as string + "_lit_" + j as string + "_full.jpg" 
			max zoomext sel all
			Render outputfile:file_name vfb:false
			freeSceneBitmaps() 
				
			-- a separate set of corresponding white background images were generated, these data were used for generating the bbox(find the maximum non-white area inside the whole image) for the images rendered before
			setUseEnvironmentMap false
			backgroundColor = color 255 255 255
			file_name = "C:\\Users\\baochens\\Desktop\\photorealistic\\results\\"+category+"\\renderresultwithbackground_white\\" + category +"_" \
			+ iterator as string + "_view_" + k as string +"_pose_" + i as string + "_lit_" + j as string + "_full.jpg"
			Render outputfile:file_name vfb:false
			freeSceneBitmaps()
		)
		rot_obj = eulerangles -randXrot -randYrot -randZrot
		about [0, 0, 0] rotate obj rot_obj
	)
)
)
)