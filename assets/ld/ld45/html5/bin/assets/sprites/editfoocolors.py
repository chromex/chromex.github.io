from PIL import Image

titleIm = Image.open('C:\Users\loren\Desktop\FOO_Title.png')
width, height = titleIm.size

titleImOut = Image.new('RGBA', (width, height))

for x in range(width):
    for y in range(height):
        r,g,b,a = titleIm.getpixel((x,y))
        newPixel = 0
        if r==255 and g==0 and b==0:
            newPixel = (255,0,0,255)
        elif r==204 and g==16 and b==16:
            newPixel = (204,16,16,210)
        elif r==184 and g==57 and b==57:
            newPixel = (184,57,57,165)
        elif r==150 and g==42 and b==42:
            newPixel = (150,42,42,120)
        elif r==107 and g==64 and b==64:
            newPixel = (107,64,64,75)
        else:
            newPixel = (0,0,0,0)
        
        titleImOut.putpixel((x,y), newPixel)

titleImOut.save('C:\Users\loren\Desktop\FOO_Title_Transparent.png')