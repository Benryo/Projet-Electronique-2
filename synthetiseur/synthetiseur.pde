/////////////////////////////////////////////////////////////////////////////////
/// LIEN GITHUB DES CODES: https://github.com/Benryo/Projet-Electronique-2.git
/////////////////////////////////////////////////////////////////////////////////

import processing.serial.*; //Connecte à l'arduino
Serial myPort;

import controlP5.*; //Inclure bibliothèque bouton
ControlP5 cp5;

import processing.sound.*; //Inclure bibliothèque des sons
SinOsc sin;

PFont font;
//Initialisation des Image
PImage img;
PImage img1;
PImage img2;
PImage img3;
PImage img4;
PImage img5;
PImage img6;
PImage img7;

///Initialisation des images de partition
PImage partido;
PImage partire;
PImage partimi;
PImage partifa;
PImage partisol;
PImage partila;
PImage partisi;


float val;
int slider=0;
int partition=0;


void setup()
{
  //Initialisation de la taille de la console d'éxecution
  size(1083, 720);
  //Initialisation des Image
  img = loadImage("piano_touche.png");
  img1= loadImage("piano_touche1.png");
  img2= loadImage("piano_touche2.png");
  img3= loadImage("piano_touche3.png");
  img4= loadImage("piano_touche4.png");
  img5= loadImage("piano_touche5.png");
  img6= loadImage("piano_touche6.png");
  img7= loadImage("piano_touche7.png");
  
  //Initialisation des images de partition
  partido= loadImage("PianoPartitionDO.png");
  partire= loadImage("PianoPartitionRE.png");
  partimi= loadImage("PianoPartitionMI.png");
  partifa= loadImage("PianoPartitionFA.png");
  partisol= loadImage("PianoPartitionSOL.png");
  partila= loadImage("PianoPartitionLA.png");
  partisi= loadImage("PianoPartitionSI.png");
  
  //Initialisation du port Arduino ainsi de ce qu'il reçoit
  String arduinoPort = Serial.list()[4];
  myPort=new Serial(this,arduinoPort,9600);
  myPort.bufferUntil('\n');
 
  /// SON =================================
  sin = new SinOsc(this);
  
  ///Partition ============================
  
  //Création des bouttons
  font = createFont("Calibri", 20);
  cp5 = new ControlP5(this);
  cp5.addSlider("slider").setPosition(15,355).setRange(0,2);
  
  cp5.addButton("Frere Jacques")
    .setPosition(200,135)
    .setSize(150,50)
    .setFont(font);
    
    cp5.addButton("Annuler")
    .setPosition(200,80)
    .setSize(100,50)
    .setFont(font);
}

void serialEvent (Serial myPort)
{
  //Reçoit les valeurs de l'arduino
  val = float(myPort.readStringUntil('\n'));
}

void controlEvent(ControlEvent theEvent)
{//Si on appui sur le bouton
  if(theEvent.isController())
  {
    if(theEvent.getController().getName()=="Frere Jacques")
    {
      partition=1; //Lance la partition de Frere Jacques
    }
    if(theEvent.getController().getName()=="Annuler")
    {
      partition=0; //Annule la partition
    }
  }
}

void draw()
{

   fill(255,255,255);
   textFont(font);

   if(val*10 > 4100 && val*10 <= 4500 ) //Touche DO
   {
     background(img1); //Affichage de l'image (la touche DO est appuyé)
     sin.freq(132+((132*slider+1))); //Joue la fréquence du DO officiel
     sin.play();
     fill(206);
     text(nf(val+(val*slider),0,2)+" Hertz",410, 50); //Affichage de la fréquence
     rect(0,384,155,500);
     if(partition==1||partition==4||partition==5||partition==8||partition==20||partition==26||partition==27||partition==29||partition==30||partition==32)
     partition++; //Si la touche est appuyé durant sa partition, passe a la suite
   }
   else if(val > 450 && val <= 470 ) //RE
   {
     background(img2);
     sin.freq(149+(149*slider));
     sin.play();
     fill(206);
     text(nf(val+(val*slider),0,2)+" Hertz",410, 50);
     rect(155,384,155,500);
     if(partition==2||partition==6) // RE
     partition++;
   }
   else if(val > 470 && val <= 500 ) //MI
   {
     background(img3);
     sin.freq(165+(165*slider+1));
     sin.play();
     fill(206);
     text(nf(val+(val*slider),0,2)+" Hertz",410, 50);
     rect(311,384,155,500);
     if(partition==3||partition==7||partition==9||partition==12||partition==19||partition==25)
     partition++;
   }
   else if(val > 500 && val < 535) //FA 
   {
     background(img4);
     sin.freq(176+(176*slider+1));
     sin.play();
     fill(206);
     text(nf(val+(val*slider),0,2)+" Hertz",410, 50);
     rect(469,384,155,500);
     if(partition==10||partition==13||partition==18||partition==24)
     partition++;
   }
   else if(val > 550 && val <= 580 ) //SOL
   {
     background(img5);
     sin.freq(198+(198*slider+1));
     sin.play();
     fill(206);
     text(nf(val+(val*slider),0,2)+" Hertz",410, 50);
     rect(624,384,155,500);
     if(partition==11||partition==14||partition==15||partition==17||partition==21||partition==23||partition==28||partition==31)
     partition++;
   }
   else if(val > 600 && val <620 ) //LA
   {
     background(img6);
     sin.freq(220+(220*slider+1));
     sin.play();
     fill(206);
     text(nf(val+(val*slider),0,2)+" Hertz",410, 50);
     rect(779,384,155,500);
     if(partition==16||partition==22)
     partition++;
   }
   else if(val > 650 && val < 680 ) //SI
   {
     background(img7);
     sin.freq(248+(248*slider));
     sin.play();
     fill(206);
     text(nf(val+(val*slider),0,2)+" Hertz",410, 50);
     rect(936,384,155,500);
   }
   else
   {
     background(img);
     sin.freq(0);
     sin.play();
     fill(206);
     text("0",410, 50);
   }
   
   //Affichage de la partition si Activé
   partitionPiano(); 
   
   //AFFICHAGE TEXTE NOTE
   fill(1);
   textSize(26);
   text("DO",60, 660);
   text("RE",217, 660);
   text("MI",377, 660);
   text("FA",537, 660);
   text("SOL",684, 660);
   text("LA",845, 660);
   text("SI",1000, 660);
   
   ///Affichage Note bemol
   rect(113,383,90,200,3,3,18,18);
   rect(265,383,90,200,3,3,18,18);
   rect(580,383,90,200,3,3,18,18);
   rect(735,383,90,200,3,3,18,18);
   rect(890,383,90,200,3,3,18,18);
   
   //Affichage de la fréquence:
   fill(-20);
   text("Fréquence:",280, 50);
    
   //Affichage du graphe:
   graphique();
}

void partitionPiano(){ //AFFICHAGE DE LA PARTITION
  if(partition==1||partition==4||partition==5||partition==8||partition==20||partition==26||partition==27||partition==29||partition==30||partition==32) //Faut appuyer sur: DO
  background(partido); //Affichage de l'image (fleche montrant le DO)
  else if(partition==2||partition==6) // RE
  background(partire);
  else if(partition==3||partition==7||partition==9||partition==12||partition==19||partition==25)  // MI
  background(partimi);
  else if(partition==10||partition==13||partition==18||partition==24)  // FA
  background(partifa);
  else if(partition==11||partition==14||partition==15||partition==17||partition==21||partition==23||partition==28||partition==31)  // SOL
  background(partisol);
  else if(partition==16||partition==22)  // LA
  background(partila);
}
  
void graphique(){ //AFFICHAGE DU GRAPHIQUE
  
    stroke(0);
    line(690, 170, 950, 170);    //Affichage des ordonnées
    line(690, 170, 690, 50);    //Abcsisse
    line(711, 165, 711, 175);  // Barre des 100 Hertz
    line(795, 165, 795, 175);  //Barre des 500 Hertz
    line(900, 165, 900, 175);  //Barre des 1k Hertz
   
    fill(0,128, 127);
    textSize(10);
    text("0", 688, 190);    //Affichage des hertz
    text("100", 705, 190);
    text("500", 788, 190);
    text("1K", 896, 190);
    text("Hz", 960, 170);
    
    float x = map(val+(val*slider), 0, 1000, 690, 900);  //Affichage des fréquences
    stroke(0,128, 127);
    line(x, 170, x, 120);
    stroke(0);
}
