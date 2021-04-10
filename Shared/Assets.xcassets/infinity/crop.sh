for parentDir in *.imageset
do
    cd "$parentDir"
    for file in *.png
    do
        # ls "$file"
        convert "$file" -gravity center -crop 200x100+0+0 +repage "$file"
    done
    cd ..
done

#convert x000.png -gravity center -crop WxH+0+0 +repage x000.x.png
