#include <OneWire.h>
#include <DallasTemperature.h>

// Data wire is plugged into port 2 on the Arduino
#define ONE_WIRE_BUS 2
#define TEMPERATURE_PRECISION 12

// Setup a oneWire instance to communicate with any OneWire devices (not just Maxim/Dallas temperature ICs)
OneWire oneWire(ONE_WIRE_BUS);

// Pass our oneWire reference to Dallas Temperature. 
DallasTemperature sensors(&oneWire);

// arrays to hold device addresses
DeviceAddress thermometerOne, thermometerTwo, thermometerThree, thermometerFour, thermometerFive;

//A0(14) and A1(15) are assigned to thermistor 1 and 2
int thermistor1=14, thermistor2=15;

int mode=-1;    //this will be used for selecting the information that the computer demands

void setup(void)
{
  // start serial port
  Serial.begin(9600);
  
  //serial communication checking routine
  Serial.println('a');  //Sending a charecter to the PC to see if it is actually recieved
  
  char serialCheck= 'b';
  while (serialCheck != 'a'){    //while loop runs until the commputer sends 'a'
    serialCheck=Serial.read();
  } 
  
  Serial.println(serialCheck);  //when data is recieved from the computer, it is echoed back to confirm that it has been recieved in the arduino
  
  //Initialising the thermometers and libraries and finding devicesLoc

  // Start up the devices
  sensors.begin();
  
  // search for devices on the bus and assign based on an index.
  
  // method 1: by index
  sensors.getAddress(thermometerOne, 0); 
  sensors.getAddress(thermometerTwo, 1);
  sensors.getAddress(thermometerThree, 2);
  sensors.getAddress(thermometerFour, 3);
  sensors.getAddress(thermometerFive, 4);

  // set the resolution to 12 bit
  sensors.setResolution(thermometerOne, TEMPERATURE_PRECISION);
  sensors.setResolution(thermometerTwo, TEMPERATURE_PRECISION);
  sensors.setResolution(thermometerThree, TEMPERATURE_PRECISION);
  sensors.setResolution(thermometerFour, TEMPERATURE_PRECISION);
  sensors.setResolution(thermometerFive, TEMPERATURE_PRECISION);

  Serial.println('a');  //sent to matlab in order to let it know that the set up has been completed
}

// function to print a device address
void printAddress(DeviceAddress deviceAddress)
{
  for (uint8_t i = 0; i < 8; i++)
  {
    // zero pad the address if necessary
    if (deviceAddress[i] < 16) Serial.print("0");
    Serial.print(deviceAddress[i], HEX);
  }
}

// function to print the temperature for a device
void printTemperature(DeviceAddress deviceAddress)
{
  float tempC = sensors.getTempC(deviceAddress);
  Serial.println(tempC);
  Serial.println(' ');        //This is the terminator that the matlab recognises as end of data package
}

// main function to print information about a device
void printData(DeviceAddress deviceAddress)
{
  printAddress(deviceAddress);
  printTemperature(deviceAddress);
}

//function to print the analog read of thermisters
double Thermister(int port) {
  double RawADC=analogRead(port);

  Serial.print(RawADC);
  Serial.println(' ');        //This is the terminator that the matlab recognises as end of data package
}


void loop(void)
{ 
  if(Serial.available()>0){   //this waits until a request comes from the computer
        mode=Serial.read();  //the request is stored in this variable
        switch (mode){        //with the variable, the info that must be sent is selected (either temperature or time)
          case 'T':   

              
              // call sensors.requestTemperatures() to issue a global temperature 
              // request to all devices on the bus
              sensors.requestTemperatures();
              
              // print the device information
              printTemperature(thermometerOne);
              printTemperature(thermometerTwo);
              printTemperature(thermometerThree);
              printTemperature(thermometerFour);
              printTemperature(thermometerFive);
              Thermister(thermistor1);
              Thermister(thermistor2);
              break;
              
          case 'M':
              //send the time info
              Serial.println(millis());
              Serial.println(' ');
              break;
        }
        
        delay(20);  //a small delay is set up in order to avoid analogRead errors
  }

}

