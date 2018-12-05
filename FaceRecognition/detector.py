import numpy as np
import cv2
#import serial
import time

detector= cv2.CascadeClassifier('haarcascade_frontalface_default.xml')
cap = cv2.VideoCapture(0)
recognizer = cv2.face.LBPHFaceRecognizer_create()
recognizer.read('trainer/trainingData.yml')
id=0
stop=0
font=cv2.FONT_HERSHEY_COMPLEX_SMALL
#ser = serial.Serial(port='COM6', baudrate=9600)#enter comport name,baud rate
#ser.close() #closes previously open serial port

while(True):
    ret, img = cap.read()
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = detector.detectMultiScale(gray, 1.3, 5)
    for (x,y,w,h) in faces:
        cv2.rectangle(img,(x,y),(x+w,y+h),(255,0,0),2)
        id,conf=recognizer.predict(gray[y:y+h,x:x+w])

        #Check the ID if exists
        if(conf<60):
            if(id==1):
                id = "Zarka {0:.2f}".format(round(conf, 2))
                stop=1
                if (stop==1):
                    #time.sleep(0.5)
                    #ser.open()  # opens serial port
                    #ser.write(b'A') # sends a letter
                    #ser.write(b'B') # sends a letter
                    #ser.write(b'B') # sends a letter
                    #ser.write(b'B') # sends a letter
                    #ser.close()
                    stop=0
                    #time.sleep(0.5) #delaying for 8 seconds
                else:
                    stop=0
                
            elif(id==2):
                id = "Ray"
                #ser.open()  # opens serial port
                #ser.write(b'A') # sends a letter
                #ser.write(b'B') # sends a letter
                #ser.write(b'B') # sends a letter
                #ser.write(b'B') # sends a letter
                #ser.close()
        else:
            id = "Unknown"
            #ser.open()  # opens serial port
            #ser.write(b'B') # sends a letter
            #time.sleep(5) #delaying for 50 seconds
            #ser.close()

        #Put text
        cv2.putText(img, str(id), (x,y-40), font, 1, (255,0,0), 2)

    cv2.imshow('img',img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break
    
cap.release()
cv2.destroyAllWindows()
