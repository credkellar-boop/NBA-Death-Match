import bpy

def export_clay_character(name):
    # Set target scale to match Godot default (1 meter)
    bpy.ops.object.select_all(action='DESELECT')
    
    # Export to .glb with optimal settings for claymation
    bpy.ops.export_scene.gltf(
        filepath=f"C:/YourPath/NBA-Death-Match/assets/models/{name}.glb",
        export_format='GLB',
        export_animations=True,
        export_frame_step=1, # Ensures the 'stepped' look
        export_nla_strips=True,
        export_animation_mode='ACTIONS',
        export_current_frame=False
    )
    print(f"Exported {name} successfully.")

# Run this to export your current character model
# export_clay_character("Michael_Jordan_93")
