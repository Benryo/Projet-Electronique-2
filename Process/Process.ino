/////////////////////////////////////////////////////////////////////////////////
/// LIEN GITHUB DES CODES: https://github.com/Benryo/Projet-Electronique-2.git
/////////////////////////////////////////////////////////////////////////////////

#include <TimerOne.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

Adafruit_SSD1306 display(128, 64, &Wire, -1); //Initialisation de la communication I2C (SCL et SDA)

//Initialisation des Pin
const int potenpin=A1; //le potentiomètre est branché sur le pin (A1)
const int BUZZER=9; //Buzzer sur D9

float bpm;
float frequence=0;
float periode=0;
volatile int etat0;
volatile int etat1;

void setup()
{
   Serial.begin(9600);
   pinMode(potenpin,INPUT);

   if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C)){
    Serial.println(F("SSD1306 allocation failed"));
    for(;;); //Affichage d'un message d'erreur si la communication ne s'initialise pas correctement
  }

  display.setTextSize(1); //Initialisation de la taille du texte à 1
  display.setTextColor(WHITE); //Texte blanc
  display.display();

  Timer1.attachInterrupt(son); //Appel de la fonction "son"
  attachInterrupt(0,frequencia,RISING);

}

void son()
{
  Timer1.initialize(60000000/bpm); //Initialise le timer pour qu'il appel la fonction "son" tout les 6010^6/bpm Ms.
  tone(BUZZER, 3,200);
}

void frequencia()
{
  etat0=etat1;
  etat1=micros();
}


void loop() {
    bpm= analogRead(potenpin);
    bpm = (map(bpm,0,1023,0,200));

    periode = etat1-etat0;
    frequence = (1/ (periode*0.00001));
    Serial.println(frequence);
    etat1=etat0;

    display.clearDisplay();
    display.setTextSize(2);
    display.setTextColor(WHITE);
    display.setCursor(0,0);
    display.println("frequence:");
    display.setTextSize(3);
    display.setCursor(5,30);
    display.print( bpm/60.00);
    display.setTextSize(3);
    display.println("Hz");
    display.display();
    delay(100);
}
