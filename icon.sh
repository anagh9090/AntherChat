#!/bin/bash
# Verify logo.png exists in root
if [ -f "logo.png" ]; then
    DPI_MAP=(
        "mdpi:48"
        "hdpi:72"
        "xhdpi:96"
        "xxhdpi:144"
        "xxxhdpi:192"
    )

    # All resource directories in SchildiChat/Element
    RES_DIRS=(
        "vector-app/src/main/res"
        "vector/src/main/res"
        "vector-app/src/sc/res"
        "vector-app/src/gplay/res"
        "vector-app/src/fdroid/res"
    )

    for RES_DIR in "${RES_DIRS[@]}"; do
        if [ -d "$RES_DIR" ]; then
            for entry in "${DPI_MAP[@]}"; do
                IFS=":" read -r dpi size <<< "$entry"
                MIPMAP_DIR="$RES_DIR/mipmap-$dpi"
                DRAWABLE_DIR="$RES_DIR/drawable-$dpi"
                
                mkdir -p "$MIPMAP_DIR"
                mkdir -p "$DRAWABLE_DIR"
                
                # Launcher icons
                convert logo.png -resize "${size}x${size}" "$MIPMAP_DIR/ic_launcher.png"
                convert logo.png -resize "${size}x${size}" "$MIPMAP_DIR/ic_launcher_sc.png"
                convert logo.png -resize "${size}x${size}" "$MIPMAP_DIR/ic_launcher_round.png"
                convert logo.png -resize "${size}x${size}" "$MIPMAP_DIR/ic_launcher_sc_round.png"
                convert logo.png -resize "${size}x${size}" "$MIPMAP_DIR/ic_launcher_foreground.png"
                
                # Splash screen / logo drawables
                convert logo.png -resize "${size}x${size}" "$DRAWABLE_DIR/logo.png"
                convert logo.png -resize "${size}x${size}" "$DRAWABLE_DIR/ic_logo.png"
            done
        fi
    done

    echo "✅ App icons successfully applied everywhere!"
else
    echo "❌ logo.png not found in root directory!"
fi
