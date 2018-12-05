import serial
import logging
import time
from tkinter import *

# |*******************************************************|
# |** All of the global variables to keep track of what **|
# |** state all devices in the network are in           **|
# |*******************************************************|
led1 = 0                                                    # globals for status of each device
led2 = 0
led3 = 0
led4 = 0
door = 0
tv = 0
washer = 0
fan = 0

lastSlider1 = 0                                             # led1
lastSlider2 = 0                                             # led2
lastSlider3 = 0                                             # led3
lastSlider4 = 0                                             # led4
lastSlider5 = 0                                             # door
lastSlider6 = 0                                             # TV
lastSlider7 = 0                                             # washer
lastSlider8 = 0                                             # fan

locationTracking = 0

lastLocation = 0.0
locationData = [0.0, 0.0, 0.0, 0.0, 0.0]
locationData2 = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
locationDataAverages = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
locationDataPlace = 0
lastAverage = 0.0
newAverage = 0.0

# |*******************************************************|
# |** Setting up serial devices and logging             **|
# |*******************************************************|
XBee = serial.Serial('COM17', 9600)                         # XBee serial port
ToF = serial.Serial('COM20', 115200)                        # CC2640R2 Serial port
logging.basicConfig(
    format='%(asctime)s %(levelname)-10s %(message)s',      # configuring logs
    datefmt='%m/%d/%Y %I:%M:%S %p', level=logging.INFO,     # using info for logging network
    filename=time.strftime("my-%Y-%m-%d.log"))              # changing format of log messages
logging.info("Program Started")                             # notify log we are running


root = Tk()                                                 # start program


# |*******************************************************|
# |** Function that gets user input from the entry form **|
# |** and writes the data to the XBee module to         **|
# |** broadcast to the rest of the Zigbee Network       **|
# |*******************************************************|
def sendChar(inputChar):
    XBee.write(inputChar)
    logging.info("Sending command: " + inputChar.decode())


# |*******************************************************|
# |** Function that reads data from the serial port.    **|
# |** the inWaiting() serial function checks if there   **|
# |** is data being received by the XBee module from    **|
# |** the rest of the network. the                      **|
# |** root.after(ms,callBack) function tells the        **|
# |** function to run every x amount of ms, and to call **|
# |** the function defined                              **|
# |*******************************************************|
def readData():
    while XBee.inWaiting():
        ser = XBee.read()
        logging.info("Data received: " + ser.decode())
        checkInput(ser)

    root.after(500, readData)


# |*******************************************************|
# |** Function that checks if the received char is      **|
# |** recognized, if so update the label                **|
# |*******************************************************|
def checkInput(user_input):
    global lastSlider1
    global lastSlider2
    global lastSlider3
    global lastSlider4
    global lastSlider5
    global lastSlider6
    global lastSlider7
    global lastSlider8

    if user_input == b'2' and lastSlider1 == 0:
        lastSlider1 = 1
        slider1.config(troughcolor='green')
        slider1.set(1)
    elif user_input == b'1' and lastSlider1 == 1:
        lastSlider1 = 0
        slider1.config(troughcolor='red')
        slider1.set(0)
    if user_input == b'4' and lastSlider2 == 0:
        lastSlider2 = 1
        slider2.config(troughcolor='green')
        slider2.set(1)
    elif user_input == b'3' and lastSlider2 == 1:
        lastSlider2 = 0
        slider2.config(troughcolor='red')
        slider2.set(0)
    if user_input == b'6' and lastSlider3 == 0:
        lastSlider3 = 1
        slider3.config(troughcolor='green')
        slider3.set(1)
    elif user_input == b'5' and lastSlider3 == 1:
        lastSlider3 = 0
        slider3.config(troughcolor='red')
        slider3.set(0)
    if user_input == b'8' and lastSlider4 == 0:
        lastSlider4 = 1
        slider4.config(troughcolor='green')
        slider4.set(1)
    elif user_input == b'7' and lastSlider4 == 1:
        lastSlider4 = 0
        slider4.config(troughcolor='red')
        slider4.set(0)
    if user_input == b'A' and lastSlider5 == 0:
        lastSlider5 = 1
        slider5.config(troughcolor='green')
        slider5.set(1)
    elif user_input == b'B' and lastSlider5 == 1:
        lastSlider5 = 0
        slider5.config(troughcolor='red')
        slider5.set(0)
    if user_input == b'C' and lastSlider6 == 0:
        lastSlider6 = 1
        slider6.config(troughcolor='green')
        slider6.set(1)
    elif user_input == b'D' and lastSlider6 == 1:
        lastSlider6 = 0
        slider6.config(troughcolor='red')
        slider6.set(0)
    if user_input == b'E' and lastSlider7 == 0:
        lastSlider7 = 1
        slider7.config(troughcolor='green')
        slider7.set(1)
    elif user_input == b'F' and lastSlider7 == 1:
        lastSlider7 = 0
        slider7.config(troughcolor='red')
        slider7.set(0)
    if user_input == b'G' and lastSlider8 != 1:
        lastSlider8 = 1
        slider8.config(troughcolor='yellow')
        slider8.set(1)
    elif user_input == b'H' and lastSlider8 != 2:
        lastSlider8 = 2
        slider8.config(troughcolor='green')
        slider8.set(2)
    elif user_input == b'I' and lastSlider8 != 0:
        lastSlider8 = 0
        slider8.config(troughcolor='red')
        slider8.set(0)


# |*******************************************************|
# |** Function that checks if the sliders have changed. **|
# |** If so, send characters to network for control of  **|
# |** devices                                           **|
# |*******************************************************|
def checkSliders():
    global lastSlider1
    global lastSlider2
    global lastSlider3
    global lastSlider4
    global lastSlider5
    global lastSlider6
    global lastSlider7
    global lastSlider8

    if slider1.get() == 1 and lastSlider1 == 0:             # turn on LED 1
        slider1.config(troughcolor='green')
        lastSlider1 = 1
        sendChar(b'2')
    elif slider1.get() == 0 and lastSlider1 == 1:           # turn off LED 1
        lastSlider1 = 0
        slider1.config(troughcolor='red')
        sendChar(b'1')
    if slider2.get() == 1 and lastSlider2 == 0:             # turn on LED 2
        lastSlider2 = 1
        slider2.config(troughcolor='green')
        sendChar(b'4')
    elif slider2.get() == 0 and lastSlider2 == 1:           # turn off LED 2
        lastSlider2 = 0
        slider2.config(troughcolor='red')
        sendChar(b'3')
    if slider3.get() == 1 and lastSlider3 == 0:             # turn on LED 3
        lastSlider3 = 1
        slider3.config(troughcolor='green')
        sendChar(b'6')
    elif slider3.get() == 0 and lastSlider3 == 1:           # turn off LED 3
        lastSlider3 = 0
        slider3.config(troughcolor='red')
        sendChar(b'5')
    if slider4.get() == 1 and lastSlider4 == 0:             # turn on LED 4
        lastSlider4 = 1
        slider4.config(troughcolor='green')
        sendChar(b'8')
    elif slider4.get() == 0 and lastSlider4 == 1:           # turn off LED 4
        lastSlider4 = 0
        slider4.config(troughcolor='red')
        sendChar(b'7')
    if slider5.get() == 1 and lastSlider5 == 0:             # open door
        lastSlider5 = 1
        slider5.config(troughcolor='green')
        sendChar(b'A')
    elif slider5.get() == 0 and lastSlider5 == 1:           # close door
        lastSlider5 = 0
        slider5.config(troughcolor='red')
        sendChar(b'B')
    if slider6.get() == 1 and lastSlider6 == 0:             # turn on TV
        lastSlider6 = 1
        slider6.config(troughcolor='green')
        sendChar(b'C')
    elif slider6.get() == 0 and lastSlider6 == 1:           # turn off TV
        lastSlider6 = 0
        slider6.config(troughcolor='red')
        sendChar(b'D')
    if slider7.get() == 1 and lastSlider7 == 0:             # turn on washer
        lastSlider7 = 1
        slider7.config(troughcolor='green')
        sendChar(b'E')
    elif slider7.get() == 0 and lastSlider7 == 1:           # turn off washer
        lastSlider7 = 0
        slider7.config(troughcolor='red')
        sendChar(b'F')
    if slider8.get() == 1 and lastSlider8 != 1:             # turn fan on low
        lastSlider8 = 1
        slider8.config(troughcolor='yellow')
        sendChar(b'G')
    elif slider8.get() == 2 and lastSlider8 != 2:           # turn fan on high
        lastSlider8 = 2
        slider8.config(troughcolor='green')
        sendChar(b'H')
    elif slider8.get() == 0 and lastSlider8 != 0:           # turn fan to idle
        lastSlider8 = 0
        slider8.config(troughcolor='red')
        sendChar(b'I')
    root.after(500, checkSliders)


# |*******************************************************|
# |** Resets all devices to off                         **|
# |*******************************************************|
def resetAllDevices():
    logging.info("Sending Reset Command")
    sendChar(b'1')
    sendChar(b'3')
    sendChar(b'5')
    sendChar(b'7')
    sendChar(b'B')
    sendChar(b'D')
    sendChar(b'F')
    sendChar(b'I')


def locationOn():
    global locationTracking
    locationTracking = 1


def locationOff():
    global locationTracking
    locationTracking = 0


def checkLocation():
    while ToF.in_waiting:
        start = ToF.read()
        if start == b'<':
            distance = float((ToF.readline().decode()))
           # print(distance)
            checkLocationData(distance)

    root.after(1500, checkLocation)


def checkLocationData(location):
    global locationDataPlace
    global locationData2
    global lastAverage
    global newAverage
    locationData2[9] = locationData2[8]
    locationData2[8] = locationData2[7]
    locationData2[7] = locationData2[6]
    locationData2[6] = locationData2[5]
    locationData2[5] = locationData2[4]
    locationData2[4] = locationData2[3]
    locationData2[3] = locationData2[2]
    locationData2[2] = locationData2[1]
    locationData2[1] = locationData2[0]
    locationData2[0] = location
    average2 = (locationData2[9] + locationData2[8] +
                locationData2[7] + locationData2[6] +
                locationData2[5] + locationData2[4] +
                locationData2[3] + locationData2[2] +
                locationData2[1] + locationData2[0]) / 10
    newAverage = (lastAverage + average2) / 2
    locationDataAverages[9] = locationDataAverages[8]
    locationDataAverages[8] = locationDataAverages[7]
    locationDataAverages[7] = locationDataAverages[6]
    locationDataAverages[6] = locationDataAverages[5]
    locationDataAverages[5] = locationDataAverages[4]
    locationDataAverages[4] = locationDataAverages[3]
    locationDataAverages[3] = locationDataAverages[2]
    locationDataAverages[2] = locationDataAverages[1]
    locationDataAverages[1] = locationDataAverages[0]
    locationDataAverages[0] = newAverage
    lastAverage = newAverage
    average3 = (locationDataAverages[9] + locationDataAverages[8] +
                locationDataAverages[7] + locationDataAverages[6] +
                locationDataAverages[5] + locationDataAverages[4] +
                locationDataAverages[3] + locationDataAverages[2] +
                locationDataAverages[1] + locationDataAverages[0]) / 10
    print(average3)
    if locationTracking:
        determineLocationAction(average3)


def determineLocationAction(currentLocation):
    global lastSlider1
    global lastSlider2
    global lastSlider3
    global lastSlider4
    global lastSlider6
    global lastSlider7
    global lastSlider8
    if 3 > currentLocation > 0 and lastSlider1 != 1:
        logging.info("LOCATION DATA - > Turning on Light 1")
        sendChar(b'2')                                          # turn on LED 1
        sendChar(b'3')                                          # turn off LED 2
        sendChar(b'5')                                          # turn off LED 3
        sendChar(b'7')                                          # turn off LED 4
        sendChar(b'I')                                          # turn fan to idle
       # sendChar(b'F')                                          # turn washer off
        #sendChar(b'D')                                          # turn TV off
        lastSlider1 = 1
        slider1.set(1)
        slider1.config(troughcolor='green')
        lastSlider2 = 0
        slider2.set(0)
        slider2.config(troughcolor='red')
        lastSlider3 = 0
        slider3.set(0)
        slider3.config(troughcolor ='red')
        lastSlider4 = 0
        slider4.set(0)
        slider4.config(troughcolor='red')
        lastSlider8 = 0
        slider8.set(0)
        slider8.config(troughcolor='red')
        lastSlider7 = 0
        slider7.set(0)
        slider7.config(troughcolor='red')
        lastSlider6 = 0
        slider6.set(0)
        slider6.config(troughcolor='red')
    elif 6 > currentLocation > 3 and lastSlider2 != 1:
        logging.info("LOCATION DATA - > Turning on Light 2")
        sendChar(b'4')                                          # turn on LED 2
        sendChar(b'1')                                          # turn off LED 1
        sendChar(b'5')                                          # turn off LED 3
        sendChar(b'7')                                          # turn off LED 4
        sendChar(b'H')                                          # turn fan on High
       # sendChar(b'F')                                          # turn washer off
       # sendChar(b'D')                                          # turn TV off
        lastSlider2 = 1
        slider2.set(1)
        slider2.config(troughcolor='green')
        lastSlider8 = 2
        slider8.set(2)
        slider8.config(troughcolor='green')
        lastSlider1 = 0
        slider1.set(0)
        slider1.config(troughcolor='red')
        lastSlider3 = 0
        slider3.set(0)
        slider3.config(troughcolor='red')
        lastSlider4 = 0
        slider4.set(0)
        slider4.config(troughcolor='red')
        lastSlider7 = 0
        slider7.set(0)
        slider7.config(troughcolor='red')
        lastSlider6 = 0
        slider6.set(0)
        slider6.config(troughcolor='red')
    elif 9> currentLocation > 6 and lastSlider3 != 1:
        logging.info("LOCATION DATA - > Turning on Light 3")
        sendChar(b'6')                                          # turn on LED 3
        sendChar(b'1')                                          # turn off LED 1
        sendChar(b'3')                                          # turn off LED 2
        sendChar(b'7')                                          # turn off LED 4
        sendChar(b'I')                                          # turn fan to idle
       # sendChar(b'F')                                          # turn washer off
        #sendChar(b'C')                                          # turn TV on
        lastSlider3 = 1
        slider3.set(1)
        slider3.config(troughcolor='green')
        lastSlider6 = 1
        slider6.set(1)
        slider6.config(troughcolor='green')
        lastSlider1 = 0
        slider1.set(0)
        slider1.config(troughcolor='red')
        lastSlider2 = 0
        slider2.set(0)
        slider2.config(troughcolor='red')
        lastSlider4 = 0
        slider4.set(0)
        slider4.config(troughcolor='red')
        lastSlider8 = 0
        slider8.set(0)
        slider8.config(troughcolor='red')
        lastSlider7 = 0
        slider7.set(0)
        slider7.config(troughcolor='red')
    elif currentLocation > 9 and lastSlider4 != 1:
        logging.info("LOCATION DATA - > Turning on Light 4")
        sendChar(b'8')                                          # turn on led 4
        sendChar(b'5')                                          # turn off LED 3
        sendChar(b'1')                                          # turn off LED 1
        sendChar(b'3')                                          # turn off LED 2
        sendChar(b'I')                                          # turn fan to idle
       # sendChar(b'E')                                          # turn on washer
       # sendChar(b'D')                                          # turn TV off
        lastSlider4 = 1
        slider4.set(1)
        slider4.config(troughcolor='green')
        lastSlider7 = 1
        slider7.set(1)
        slider7.config(troughcolor='green')
        lastSlider3 = 0
        slider3.set(0)
        slider3.config(troughcolor='red')
        lastSlider1 = 0
        slider1.set(0)
        slider1.config(troughcolor='red')
        lastSlider2 = 0
        slider2.set(0)
        slider2.config(troughcolor='red')
        lastSlider8 = 0
        slider8.set(0)
        slider8.config(troughcolor='red')
        lastSlider6 = 0
        slider6.set(0)
        slider6.config(troughcolor='red')


slider1 = Scale(root, from_=0, to=1, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider2 = Scale(root, from_=0, to=1, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider3 = Scale(root, from_=0, to=1, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider4 = Scale(root, from_=0, to=1, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider5 = Scale(root, from_=0, to=1, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider6 = Scale(root, from_=0, to=1, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider7 = Scale(root, from_=0, to=1, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider8 = Scale(root, from_=0, to=2, orient=HORIZONTAL, length=100, width=10, sliderlength=50, troughcolor='red')
slider1.set(0)
slider2.set(0)
slider3.set(0)
slider4.set(0)
slider5.set(0)
slider6.set(0)
slider7.set(0)
slider8.set(0)

resetButton = Button(text='Reset', command=resetAllDevices)
locationOn = Button(text='Turn on Location Tracking', command=locationOn)
locationOff = Button(text='Turn off Location Tracking', command=locationOff)

Label_1 = Label(root, text="Room 1 Light")
Label_2 = Label(root, text="Room 2 Light")
Label_3 = Label(root, text="Room 3 Light")
Label_4 = Label(root, text="Room 4 Light")
Label_5 = Label(root, text="Door")
Label_6 = Label(root, text="TV")
Label_7 = Label(root, text="Washer")
Label_8 = Label(root, text="Fan")
Label_9 = Label(root, text="Reset All Devices")

Label_1.grid(row=0, column=0)
slider1.grid(row=1, column=0)
Label_2.grid(row=2, column=0)
slider2.grid(row=3, column=0)
Label_3.grid(row=4, column=0)
slider3.grid(row=5, column=0)
Label_4.grid(row=6, column=0)
slider4.grid(row=7, column=0)
Label_5.grid(row=0, column=1)
slider5.grid(row=1, column=1)
Label_6.grid(row=2, column=1)
slider6.grid(row=3, column=1)
Label_7.grid(row=4, column=1)
slider7.grid(row=5, column=1)
Label_8.grid(row=6, column=1)
slider8.grid(row=7, column=1)


locationOn.grid(row=1, column=2)
locationOff.grid(row=2,column=2)
resetButton.grid(row=4, column=2)

root.after(500, checkSliders)
root.after(500, readData)
root.after(1500, checkLocation)
root.mainloop()
