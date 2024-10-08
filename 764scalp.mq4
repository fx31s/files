//+------------------------------------------------------------------+
//| Benoit Mandelbrot                                   764scalp.mq4 |
//| Albert Einstein                                             Alpc |
//| Mehmet Özhan Hastaoğlu                Kaptanın Anısına 22/9/2020 |
//+------------------------------------------------------------------+
#property copyright "Alpc"
#property link      "puzzle tamamlandı"
#property version   "1.10.2020 Complate"
#property strict

string Trend_List[2000];
string Last_Trend = "";
int Trend_Num=0;
int Trend_Total=-1;

string Expansion_List[20];
string Last_Expansion = "";
color renk_sec=clrBlack;
int renk_sayisi = 10;

double Lot=0.01;

double dip_prc;
double tepe_prc;
string line_name;
datetime start_time,tepe_time,dip_time,finish_time;
double fibo_886,fibo_707,fibo_764,fibo_735,fibo_382,fibo_618,fibo_114,fibo_118,fibo_171,fibo_228,fibo_342,fibo_500,fibo_236,fibo_1772,fibo_772,fibo_s1772,fibo_s772;

double dips_prc;
double tepes_prc;
string lines_name;
datetime starts_time,tepes_time,dips_time,finishs_time;
double fibos_886,fibos_707,fibos_764,fibos_735,fibos_382,fibos_618,fibos_114,fibos_118,fibos_171,fibos_228,fibos_342,fibos_500,fibos_236,fibos_1772,fibos_772,fibos_s1772,fibos_s772;

int ObjTotal = ObjectsTotal();
string last_object="";

bool formasyon=false;

//string buton_list[11]={"76.4","73.5","70.7","88.6","38.2","11.4","17.1","22.8","61.8","34.2","50.0"};
string buton_list[12]={"76.4","7C","70.7","88.6","38.2","11.4","SC","SL","61.8","SL2","50.0","23.6"};
int buton_sayisi=11;

double price_list[13];
double prices_list[13];

double last_price;
int last_price_num;
string last_price_name;

string butons_list[12]={"PEN","HUNT","CLOSE PEN","CLOSE APEN","CLOSE ALIVE","CLOSE LIVE","SPREAD","SCALP BUY","SCALP SELL","AUTO CLOSE","SHOW HIDE","NEXT"};
int butons_sayisi=11;

string butonz_list[10]={"M1","M5","M15","M30","H1","H4","D1","W1","MN1"};
int butonz_sayisi=9;
int zaman_list[10]={PERIOD_M1,PERIOD_M5,PERIOD_M15,PERIOD_M30,PERIOD_H1,PERIOD_H4,PERIOD_D1,PERIOD_W1,PERIOD_MN1};
datetime set_time;
int set_time_period;
//int set_time_shift;


int slip;
input int MagicNumber=520;
bool TRADE_LEVELS=true;
int Ekran_Last=1;

bool Chart_Forward = false;
 bool Chart_Rewind = false;
    int Chart_Pos = -1;
long currChart=ChartID();

double cls_buy_prc=-1;
double cls_sell_prc=-1;
extern int order_point=10;
double Profit=1; 
bool fiboset=true;

color FiboLevelColor=clrNONE;

////////////////////////////////////////////////////////////



extern double min_profit=-3;
bool order_close_complate=true;
extern int order_mode=OP_SELL;
int Orders=OrdersTotal();
int Order_Total=1;
double order_prc_ticket[20,5];
extern int min_total_order = 3;



bool lineset=false;


bool FeBrainSystem=true;
double FeLot=0.10;
double Fe5FarkOran = 10;

/////////////////////////////////////////////////////////////
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

bool ExpertTradeAlert = false;


double Price_Close=Ask;
double Price_Open=Ask;
double Price_Low=Ask;
double Price_High=Ask;
int price_shf=0;
datetime Price_Time=Time[0];



  

int OnInit()
  {
  
  
  
        string LabelChart="PeriodBilgisis";
        ObjectDelete(ChartID(),LabelChart);
     
        LabelChart="PeriodBilgisi";
        ObjectDelete(ChartID(),LabelChart);
        
        if ( Period() != PERIOD_M15 ) {
        
        string PeriodBilgisi=TFtoStr(Period());
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkRed);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 33);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30); 
     
         
     } else {     
     LabelChart="PeriodBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     } 
     }
  
  
  
  //FiboChannel();
  
  //ChartSetInteger(ChartID(),CHART_SCALE,0,3);
  //ChartSetSymbolPeriod(ChartID(),NULL,PERIOD_M15);
  
  
ObjectsDeleteAlls(ChartID(),"Trendline 24345",0,OBJ_TREND);
ObjectsDeleteAlls(ChartID(),"Trendline 24345",0,OBJ_TREND);
ObjectsDeleteAlls(ChartID(),"Trendline 24345",0,OBJ_TEXT);
ObjectsDeleteAlls(ChartID(),"Trendline 24345",0,OBJ_TRENDBYANGLE);
ObjectsDeleteAlls(ChartID(),"Trendline 24345",0,OBJ_RECTANGLE);
ObjectsDeleteAlls(ChartID(),"Trendline 24345",0,OBJ_VLINE);
ObjectsDeleteAlls(ChartID(),"Trendline 24345",0,OBJ_HLINE);

  if ( ObjectFind("PriceLine") == -1 ) ObjectCreate(ChartID(),"PriceLine",OBJ_HLINE,0,Time[0],Ask);
  ObjectSetInteger(ChartID(),"PriceLine",OBJPROP_COLOR,clrNONE);
  
  
       if ( ChartID() == ChartFirst() && FeBrainSystem ) {
     
     if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 0 && ExpertTradeAlert == false ) Alert("Ticaret İzni Kapalı");
     if (!IsTradeAllowed()  && ExpertTradeAlert == false) Alert("Expert İzni Kapalı");     
     //Alert("Main"+Symbol());
     
     ExpertTradeAlert=true;
     
     
     } else {
  //if ( ChartID() != 0 ) {
  
  //Alert("Other"+Symbol()+" ");
  
 // }
  }
   
   /*if ( ChartID() != ChartFirst() && FeBrainSystem ) {
   FeAnaliz();        
   }*/
    

   
   
   
   
  
  
  long currChart=ChartID();
   string LabelChartR="Renk";
  //color Renkler[11];
  //Renkler[1]=
  
  

  
color Renkler[11]={clrWhite,clrSnow,clrOrange,clrGold,clrLawnGreen,clrYellow,clrCrimson,clrDodgerBlue,clrTurquoise,clrDarkViolet,clrBlack};

    string filenamess = "\\Images\\fish.bmp";
    ObjectDelete("fish");
    ObjectCreate( 0, "fish", OBJ_BITMAP, 0, TimeCurrent(), Ask );
    ObjectSetString( 0, "fish", OBJPROP_BMPFILE, filenamess );
    ObjectSetInteger(0,"fish",OBJPROP_BACK,true);
    ObjectSetInteger(0,"fish",OBJPROP_XDISTANCE,300);
    ObjectSetInteger(0,"fish",OBJPROP_YDISTANCE,300);
    ObjectSetInteger(0,"fish",OBJPROP_SELECTABLE,true);
    ObjectSetInteger(0,"fish",OBJPROP_SELECTED,false);
    ObjectSetInteger(0,"fish",OBJPROP_HIDDEN,true);
  
  for (int t=0;t<=renk_sayisi;t++) {

     
     LabelChartR="Renk"+t;
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,"");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 1);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, Renkler[t]);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 60+(t*25));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 5);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 20); 
     //ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

  }
  
  
  for (int t=0;t<=buton_sayisi;t++) {

     
     LabelChartR="Buton"+t;
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,buton_list[t]);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrFireBrick);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 10+(t*40));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 60);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 35); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

  }
  
   for (int t=0;t<=buton_sayisi;t++) {

     
     LabelChartR="Butons"+t;
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,buton_list[t]);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrBisque);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 10+(t*40));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 40);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 35); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

  }
  
  
   for (int t=0;t<=butons_sayisi;t++) {

     
     LabelChartR=butons_list[t];
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,butons_list[t]);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 0);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrOliveDrab);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 85+(t*25));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 75); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);+(t*80)
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

  }
  
     string LabelChartP="LotSize";
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,Lot);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkBlue);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 30);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 35); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Lot");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     Lot=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);
     
     
     
   for (int t=1;t<=buton_sayisi;t++) {

     
     LabelChartR="Lotx"+t;
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,DoubleToString(0.05*t,2));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrDarkBlue);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 10+(t*40));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 30);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 35); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

  }
  
     LabelChartP="ProfitVol";
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,Profit);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 55);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 35); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Profit");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     Profit=ObjectGetString(ChartID(),"ProfitVol",OBJPROP_TEXT,0);  
     
     
     LabelChartP="OrderPoint";
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,order_point);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGreen);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 35); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"OrderPoint");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     order_point=ObjectGetString(ChartID(),"OrderPoint",OBJPROP_TEXT,0);    
     
     
     LabelChartP="Fe5FarkOran";
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,Fe5FarkOran);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkRed);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 55);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 35); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Fe5FarkOran");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     Fe5FarkOran=ObjectGetString(ChartID(),"OrderPoint",OBJPROP_TEXT,0);   
     
     
          
       
  
    for (int t=1;t<=buton_sayisi;t++) {

     
     LabelChartR="Profitx"+t;
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,DoubleToString(0.10*t,2));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 10+(t*40));
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 55);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 35); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     
     //ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"BUY LOT");
     //LOTS=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

  }
    
     
  ObjectCreate(ChartID(),"PLINE",OBJ_HLINE,0,TimeCurrent(),Ask);
  ObjectSetInteger(ChartID(),"PLINE",OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),"PLINE",OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"PLINE",OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  
 //////////////////////////////////////////////////////////////////////////////////
 
     LabelChartP="MinProfitVol";
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,min_profit);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 50);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 105);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 35); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Min Profit");
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     min_profit=ObjectGetString(ChartID(),"MinProfitVol",OBJPROP_TEXT,0);
 
     LabelChartP="MinOrderVol";
     ObjectDelete(LabelChartP);
     ObjectCreate(currChart,LabelChartP, OBJ_EDIT,0 , 0, 0);
     ObjectSetString(currChart,LabelChartP,OBJPROP_TEXT,min_total_order);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartP, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_COLOR, clrGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_BGCOLOR, clrDarkGray);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_YDISTANCE, 105);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_XSIZE, 35); 
     ObjectSetString(currChart,LabelChartP,OBJPROP_TOOLTIP,"Min Order");
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, -1);
     min_total_order=ObjectGetString(ChartID(),"MinOrderVol",OBJPROP_TEXT,0);  
 
 
      LabelChartR="ButonWBUY";
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,"W BUY");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrFireBrick);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 125);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 65); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
 
      LabelChartR="ButonWSELL";
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,"W SELL");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrFireBrick);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 80);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 125);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 65); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
 
 
     LabelChartR="ButonWCOMPLATE";
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_BUTTON,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,"W COMPLATE");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrFireBrick);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 150);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 125);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 95); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //ObjectSetInteger(currChart,LabelChartP, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);  
  
     LabelChartR="ButonWCOMMMENT";
     ObjectDelete(LabelChartR);
     ObjectCreate(currChart,LabelChartR, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,"");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_CORNER, 2);
     ObjectSetString(currChart,LabelChartR, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_BGCOLOR, clrFireBrick);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XDISTANCE, 90);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_YDISTANCE, 103);
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_XSIZE, 95); 
     ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1);
     //ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //if ( t != 0 ) ObjectSetInteger(currChart,LabelChartR, OBJPROP_TIMEFRAMES, -1); 
 
 ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,"walter vannelli");
 
 string WCOMMMENT="Complate(d):"+order_close_complate+" Min Order:"+min_total_order;
 
  ObjectSetString(currChart,LabelChartR,OBJPROP_TEXT,WCOMMMENT);
 
 AlertOrder();
 /////////////////////////////////////////////////////////////////////////////////////
 

  double Pips_Price_valued;    
  double minumum_pip = 1; 
for (int t=1;t<=10;t++){
Pips_Price_valued = PipPrice(Symbol(),0,t,MarketInfo(Symbol(),MODE_MINLOT));
if ( Pips_Price_valued > 0 ) {minumum_pip=t;break;}
} 
  

   double onelot = MarketInfo(Symbol(),MODE_MARGINREQUIRED);
//--- create timer

   EventSetTimer(10);
  Comment("Alpc Scalp 764 Fibo:J Formasyon:CapsLock Button:B OneLot:",onelot,"/",MarketInfo(Symbol(),MODE_MINLOT)," Min Pip:",minumum_pip," İşlem Gizle:R, Show/Hide:S PipPrice:", PipPrice(Symbol(),0,1,1));
   ObjTotal = ObjectsTotal();
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
  //Print("tick");
  ObjectSetDouble(ChartID(),"fish",OBJPROP_PRICE,Bid);
  ObjectSetInteger(ChartID(),"fish",OBJPROP_TIME,Time[0]-2*PeriodSeconds());
  ChartRedraw();
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
int FeOrderToplam=-1;//OrdersTotal();
void OnTimer()
  {
  
//---
   //Print("Selam");
   
   
   ////////////////////////////////////////////////////////////////////
   // FE AI
   ////////////////////////////////////////////////////////////////////
     if ( ChartID() == ChartFirst() ) {
     
     if ( OrdersTotal() > 0 && FeBrainSystem ) FeBrain();
     
     //Alert("Main"+Symbol());     
    
     }/*i else {
  f ( ChartID() != 0 ) {
  
  //Alert("Other"+Symbol()+" ");
  
  }
  }*/
   

   ////////////////////////////////////////////////////////////////////
   if ( FeBrainSystem ){
   if ( FeOrderToplam!=OrdersTotal() ) {   
   FeOrderToplam=OrdersTotal();
   ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);
   FeAnaliz();
   }
   }   
   ////////////////////////////////////////////////////////////////////
 
 
 
   
        string LabelChart="SpreadBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 16);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 10);      
     } else {     
     LabelChart="SpreadBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_SPREAD));
     } 
     

     
  datetime bar_start_time=Time[0];
  datetime bar_end_time=bar_start_time+PeriodSeconds();
  int seconds_remaining=bar_end_time-TimeCurrent();  
       
        LabelChart="ZamanBilgisi";
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,seconds_remaining);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 9);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 55);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);     
     } else {     
     LabelChart="ZamanBilgisi";
     string ZamanBilgisi=TimeToStr(seconds_remaining,TIME_MINUTES|TIME_SECONDS);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,ZamanBilgisi);
     }      
   
       if ( ObjTotal!=ObjectsTotal(ChartID()) ) AlertObject();
 ObjTotal = ObjectsTotal(ChartID());
 
 //if( OrderCommetssType(OP_BUY) == 0 ) seconds_remaining
  if (ObjectGetInteger(ChartID(),"SCALP BUY",OBJPROP_STATE) ){
//Print("scalp buy");
if ( OrderCommets("BUY") == 0 && (MathAbs(cls_buy_prc - Close[0])/Point > order_point || cls_buy_prc == -1)) int tic=OrderSend(NULL,OP_BUY,Lot,Ask,slip,0,0,"BUY",MagicNumber,0,clrBlue);
if (OrderTotalProfit(OP_BUY) >= Profit  ) {CloseTrades("BUY","LIVE");
//Print("buy kapa");
cls_buy_prc=Close[0];
}
}
 
  if (ObjectGetInteger(ChartID(),"SCALP SELL",OBJPROP_STATE) ){
if ( OrderCommets("SELL") == 0 && ( MathAbs(Close[0] - cls_sell_prc)/Point > order_point  || cls_sell_prc == -1) ) int tic=OrderSend(NULL,OP_SELL,Lot,Bid,slip,0,0,"SELL",MagicNumber,0,clrBlue);
if (OrderTotalProfit(OP_SELL) >= Profit  ) {CloseTrades("SELL","LIVE");
//Print("kapa");}
cls_sell_prc=Close[0];
}
}  
// MANUEL İŞLEMDE KAPATICI 
if (ObjectGetInteger(ChartID(),"AUTO CLOSE",OBJPROP_STATE) ){
if (OrderTotalProfit(OP_SELL) >= Profit  ) CloseTrades("SELL","LIVE");
if (OrderTotalProfit(OP_BUY) >= Profit  ) CloseTrades("BUY","LIVE");
}



/////////////////////////////////////////////////////////////////////////////////////////////// 
 if (ObjectGetInteger(ChartID(),"HUNT",OBJPROP_STATE)){
 
 double prc=NormalizeDouble(last_price,Digits);

 if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE) ){
prc=prc+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
}
  
 if ( Close[1] > prc && Low[1] > prc && Bid <= prc  ){
 int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,slip,0,0,last_price_name,MagicNumber,0,clrYellow);
 ObjectSetInteger(ChartID(),"HUNT",OBJPROP_STATE,false);
 }
 
 
 prc=NormalizeDouble(last_price,Digits);

 if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE) ){
prc=prc-(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
}
  
 if ( Close[1] < prc && High[1] < prc && Ask > prc  ){
 int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,slip,0,0,last_price_name,MagicNumber,0,clrYellow);
 ObjectSetInteger(ChartID(),"HUNT",OBJPROP_STATE,false);
 }

   }
//////////////////////////////////////////////////////////////////////////////////////////////   
   
   RiskManagement();
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+

bool PaLine=false;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  
  
  if ( sparam == 45 ) ObjectsDeleteAll();
  
  
//---

//if ( sparam == "PRICE-LINE" ) 

//Print(sparam);

if ( sparam == 43 && id == CHARTEVENT_KEYDOWN && PaLine==true ) FiboChannel(0);



if ( sparam == 53 && id == CHARTEVENT_KEYDOWN && PaLine==true ) {
PaLine=false;
FiboChannel(4);
Comment("PaLine:",PaLine);
} else {
if ( sparam == 53 && id == CHARTEVENT_KEYDOWN ) {
PaLine=true;
FiboChannel(4);
Comment("PaLine:",PaLine);
}
}

  ////////////////////////////////////////////////////////////////////
  if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 0 ) {
   // EventKillTimer();
    EventSetTimer(10);
  } else {
    EventSetTimer(1);
  }
  ///////////////////////////////////////////////////////////////////
  
  


  int indexfe3 = StringFind(sparam," FE 3.0", 0);
  int indexfesl200 = StringFind(sparam," FE SL 200", 0);
  int indexfebro = StringFind(sparam," Bro", 0);
  int indexfebrofinish = StringFind(sparam," BroFinish", 0);
  int indexfebrostart = StringFind(sparam," BroStart", 0);

    
  if ( indexfe3 != -1 || indexfesl200 != -1 || indexfebro != -1) {
  //Alert("Fe3");
  if ( indexfebrofinish == -1 && indexfebrostart == -1 ) Fe3Strategy(sparam);

  }
  
  

  
  if ( ChartGetInteger(currChart,CHART_AUTOSCROLL) ) {
  price_shf=0;
  Price_Close=Close[price_shf];
  Price_Open=Open[price_shf];
  Price_High=High[price_shf];
  Price_Low=Low[price_shf];
  Price_Time=Time[price_shf]; 
  } else {
  price_shf=WindowFirstVisibleBar()-WindowBarsPerChart();
  if ( price_shf > -1 ) {
  //Alert(price_shf);
  ObjectSetDouble(ChartID(),"PriceLine",OBJPROP_PRICE,Close[price_shf]);
  Price_Close=Close[price_shf];
  Price_Open=Open[price_shf];
  Price_High=High[price_shf];
  Price_Low=Low[price_shf];
  Price_Time=Time[price_shf];
  } else {
  price_shf=1;
  Price_Close=Close[price_shf];
  Price_Open=Open[price_shf];
  Price_High=High[price_shf];
  Price_Low=Low[price_shf];
  Price_Time=Time[price_shf];  
  }
  }  
  



  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_ARROW ) {
  
  //Alert("Sparam",sparam);
  
////////////////////////////////////////////////////////////////////////////      
   string sym_line="";
   string ord="";
   
   //if ( sym_periyod == "" ) {  
   string sep=" ";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(sparam,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   //sym_line = results[0];
   ord = results[0]; 
   
   int indextic = StringFind(sparam,"#", 0);
   int indexsym = StringFind(sparam,Symbol(), 0);
   
   if ( indextic != -1 && indexsym != -1 ) {
   
   int replaced=StringReplace(ord,"#",""); 
   
   //Alert(ord); 
   
   
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);  
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);          
      Sleep(100);
      FeAnaliz();

   
     
   }  
     
   }
   
   
   
   //}
       
   //Print(sym,"/",sym_line);  
///////////////////////////////////////////////////////////////////////////   
  }


//Print("Sparam",sparam,"/",id);
//////////////////////////////////////////////////////////////////////
int indexfel = StringFind(sparam,"FeOrderLoad", 0);
int indexfes = StringFind(sparam,"FeOrderSave", 0);
int indexfed = StringFind(sparam,"FeOrderDelete", 0);

// Normal çalışması için OrderTicket yerine Symbol konulabilinir.

if ( indexfes != -1 && id==1) {

//Alert("Selam");

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderSave","");
      
    
       string tpl_files = ord +"-"+Period()+"-.tpl";
//Alert("TPL:",tpl_files);

      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);

      //FileDelete("\\Files\\"+tpl_files,1);
      FileDelete(tpl_files,1);
      Sleep(100);
      //ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      ChartSaveTemplate(ChartID(),"\\Files\\"+tpl_files);
      
               
      Print("OrderTicket",ord);
      
      //ObjectDelete("FeOrderLoad"+ord);
      //ObjectDelete("FeOrderSave"+ord);
      //ObjectDelete("FeOrderDelete"+ord);
      Sleep(100);
      FeAnaliz();
      
      
}




if ( indexfed != -1 && id==1) {



         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderDelete","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1) && Period() == 1 ) {
    tpl_files = tpl_files +"-1-.tpl";
    FileDelete(tpl_files,1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = tpl_files +"-5-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1) && Period() == 15) {
    tpl_files = tpl_files +"-15-.tpl";
    FileDelete(tpl_files,1);
    }     
                

    if(FileIsExist(tpl_files +"-30-.tpl",1) && Period() == 30) {
    tpl_files = tpl_files +"-30-.tpl";
    FileDelete(tpl_files,1);
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = tpl_files +"-60-.tpl";
    FileDelete(tpl_files,1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = tpl_files +"-240-.tpl";
    FileDelete(tpl_files,1);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1) && Period() == 1440 ) {
    tpl_files = tpl_files +"-1440-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)  && Period() == 10080) {
    tpl_files = tpl_files +"-10080-.tpl";
    FileDelete(tpl_files,1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = tpl_files +"-43200-.tpl";
    FileDelete(tpl_files,1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);            
      Sleep(100);
      FeAnaliz();
      
      
}



if ( indexfel != -1 && id==1) {

         string ord = sparam;
      int replacedz = StringReplace(ord,"FeOrderLoad","");
      
      Print("OrderTicket",ord);
      
long sinyal_charid;
string tpl_files=ord;
//int replaced=StringReplace(tpl_files,"-Load","");    
    /*if(FileIsExist(tpl_files +".tpl",1)) {
    tpl_files = "\\Files\\"+tpl_files +".tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    //sinyal_charid=ChartOpen(Symbol(),Period());    
    //ChartApplyTemplate(sinyal_charid,tpl_files);
    //ChartSetSymbolPeriod(sinyal_charid,Symbol(),Period());
    }  */
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)  && Period() == 1) {
    tpl_files = "\\Files\\"+tpl_files +"-1-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)  && Period() == 5) {
    tpl_files = "\\Files\\"+tpl_files +"-5-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M5);
    }     
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)  && Period() == 15) {
    tpl_files = "\\Files\\"+tpl_files +"-15-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M15);
    }     
            

    if(FileIsExist(tpl_files +"-30-.tpl",1)  && Period() == 30) {
    tpl_files = "\\Files\\"+tpl_files +"-30-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M30);
    }     
    
    if(FileIsExist(tpl_files +"-60-.tpl",1)  && Period() == 60) {
    tpl_files = "\\Files\\"+tpl_files +"-60-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H1);
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)  && Period() == 240) {
    tpl_files = "\\Files\\"+tpl_files +"-240-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_H4);
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)  && Period() == 1440) {
    tpl_files = "\\Files\\"+tpl_files +"-1440-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_D1);
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1) && Period() == 10080) {
    tpl_files = "\\Files\\"+tpl_files +"-10080-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_W1);
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)  && Period() == 43200) {
    tpl_files = "\\Files\\"+tpl_files +"-43200-.tpl";
    ChartApplyTemplate(ChartID(),tpl_files);
    ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_MN1);
    } 
        
        
      ObjectDelete("FeOrderLoad"+ord);
      ObjectDelete("FeOrderSave"+ord);
      ObjectDelete("FeOrderDelete"+ord);
      ObjectsDeleteAlls(ChartID(),"FeOrder",0,-1);            
      Sleep(100);
      FeAnaliz();
      
      
}
////////////////////////////////////////////////////////////////////////////




// iptal

      /*if(id==CHARTEVENT_OBJECT_CREATE)
      {
      ChartRedraw();
      }*/

int indexo = StringFind(sparam,"#", 0);
if ( indexo != -1 ) {
         string ord = sparam;
      int replacedz = StringReplace(ord,"#","");
         int indexb = StringFind(sparam," ", 0);
  string ord_ticket = StringSubstr(ord,0,indexb);
     int ord_ticets = StringToInteger(ord_ticket);
  //Alert(ord_ticket);
  
  if(OrderSelect(ord_ticket, SELECT_BY_TICKET, MODE_HISTORY)){
  
  int gecen_sure = (OrderCloseTime() - OrderOpenTime()) / 60;
  double kazanc_pip;
  if ( OrderType() == OP_BUY ) kazanc_pip=OrderClosePrice()-OrderOpenPrice();
  if ( OrderType() == OP_SELL ) kazanc_pip=OrderOpenPrice()-OrderClosePrice();
  
  double order_pos;
  if ( OrderType() == OP_BUY ) order_pos=OrderClosePrice()+50*Point;
  if ( OrderType() == OP_SELL ) order_pos=OrderClosePrice()-50*Point;
    
  
  string order_bilgi = ("Süre:"+gecen_sure+" .dk/ Pip:"+int(kazanc_pip/Point));
  
  
         string  LabelChart="OrderBilgisi"+ord_ticets;
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {     
     ObjectCreate(ChartID(),LabelChart, OBJ_TEXT,0 , OrderCloseTime()+5*PeriodSeconds(), order_pos);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,order_bilgi);
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 9);
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 55);
    // ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);     
     } else {     
     //string ZamanBilgisi=TimeToStr(seconds_remaining,TIME_MINUTES|TIME_SECONDS);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,ZamanBilgisi);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,order_bilgi);
     }   
     

int  shift=iBarShift(Symbol(),Period(),OrderOpenTime()); 
double carpan = 0;
shift = (shift+carpan)*-1;
      ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
      ChartSetInteger(ChartID(),CHART_SHIFT,true);
      //ChartSetInteger(ChartID(),CHART_MODE,CHART_LINE);
      //ResetLastError();
     /* ChartNavigate(ChartID(),CHART_BEGIN,WindowFirstVisibleBar()-100);*/
     
     ChartNavigate(currChart,CHART_END,shift);
     
     
     
  
  }
  
  
}


 if ( sparam == "ButonWCOMPLATE") { // dsparam == 32 || 
  
  if ( order_close_complate ) {order_close_complate = false;AlertOrder();} else {order_close_complate = true;}
  Comment(" Complate:",order_close_complate);
  Sleep(500);
  ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
  }
  
  if ( sparam == "ButonWSELL") { // d
  order_mode = OP_SELL;
  //if ( order_mode == OP_BUY ) {order_mode = OP_SELL;} else {order_mode = OP_BUY;}
  Comment(" Order Mode :",order_mode);
  Sleep(500);
  ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
  AlertOrder();
  }
   
  if ( sparam == "ButonWBUY") { // d
  order_mode = OP_BUY;
  //if ( order_mode == OP_BUY ) {order_mode = OP_SELL;} else {order_mode = OP_BUY;}
  Comment(" Order Mode :",order_mode);
  Sleep(500);
  ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
  AlertOrder();
  }
  
  
if ( sparam == "MinProfitVol"  ) {
min_profit=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
ObjectSetString(ChartID(),"ProfitVol",OBJPROP_TEXT,min_profit);
//Alert("selam",Lot); Comment("Lot:",Lot);
Sleep(500);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);

}

if ( sparam == "MinOrderVol"  ) {
min_total_order=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
ObjectSetString(ChartID(),"ProfitVol",OBJPROP_TEXT,min_total_order);
//Alert("selam",Lot); Comment("Lot:",Lot);
Sleep(500);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);

}
  



    if ( id == 9 ) {
    
  //  TFBars = Bars(Symbol,Period());
//BarsCounted = TFBars-MathMax(IndS2,IndS1+1);&& Time[WindowFirstVisibleBar()] != NULL


if ( Bars > 1000 ) {
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //Print(WindowFirstVisibleBar(),"Bars",Bars);
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }
  
  
  
/////////////////////////////////////////////////////////////  
if ( Chart_Pos < right_bound ) 
{
Chart_Rewind = true;
Chart_Forward=false;
//Print("Geri Gidiyor");
ChartSetInteger(currChart,CHART_AUTOSCROLL,false);
}
else 
{
Chart_Rewind = false;Chart_Forward=true;
//Print("İleri Gidiyor");
if (Chart_Pos < 0 ) ChartSetInteger(currChart,CHART_AUTOSCROLL,true);
}
Chart_Pos = right_bound;
//Print(right_bound);

}


}

/////////////////////////////////////////////////////////////
  if ( sparam == 36  ) {
  
  Print("L-Param",sparam,"/ J /",fiboset);
  
  if ( fiboset ) {
  fiboset=false;
  
  Comment("Fibo 764 Set:",fiboset," / Scale:",ChartGetInteger(0,CHART_SCALE));} 
  else {
  fiboset=true;
  lineset=false;
  Comment("Fibo 764 Set:",fiboset," / Scale:",ChartGetInteger(0,CHART_SCALE));
  }
  
  
  }
  
  
  if ( sparam == 32 ) { // Objeyi Seç D harfine bas
  
Comment("Last Object",last_object);
//if ( ObjectFind(ChartID(),last_object) == -1 ) { 
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TREND);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TEXT);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TRENDBYANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_RECTANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_VLINE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_HLINE);
//}
  
  
  }

//Print("L-Param",sparam,"/ J /",lineset);
/////////////////////////////////////////////////////////////
  if ( sparam == 37  ) {
  
  Print("L-Param",sparam,"/ K /",lineset);
  
  if ( lineset ) {
  lineset=false;  
  Comment("Line Set:",lineset," / Scale:",ChartGetInteger(0,CHART_SCALE));} 
  else {
  lineset=true;
  fiboset=false;
  Comment("Line Set:",lineset," / Scale:",ChartGetInteger(0,CHART_SCALE));
  }
  
  
  }
  
  

  ////////////////////////////////////////////////////////////////////
  /*if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 0 ) {
    EventKillTimer();
    Print(Symbol()+": Timer Kapandı");
    Ekran_Last=0;
  } else {
    if ( Ekran_Last != 1 ) {
    EventSetTimer(1);
    Print(Symbol()+": Timer Açıldı");    
    Ekran_Last=1;
    }
  }*/
  ///////////////////////////////////////////////////////////////////
  if ( sparam == 19 ) { // r
  if ( TRADE_LEVELS ) { TRADE_LEVELS=false; 
  ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,false);
  } else { TRADE_LEVELS=true;
  ChartSetInteger(0,CHART_SHOW_TRADE_LEVELS,true);
  }
  
  Comment("TRADE_LEVELS:",TRADE_LEVELS);
  }    
    

if ( sparam == "LotSize" ) {

Lot=ObjectGetString(ChartID(),"LotSize",OBJPROP_TEXT,0);

}

if ( sparam == "ProfitVol" ) {

Profit=ObjectGetString(ChartID(),"ProfitVol",OBJPROP_TEXT,0);

}

if ( sparam == "OrderPoint" ) {
order_point=ObjectGetString(ChartID(),"OrderPoint",OBJPROP_TEXT,0); 
}


if ( sparam == "Fe5FarkOran" ) {
Fe5FarkOran=ObjectGetString(ChartID(),"Fe5FarkOran",OBJPROP_TEXT,0); 
Comment("Fe5FarkOran",Fe5FarkOran);
}




if (ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_BUTTON ) {






if ( sparam == "PEN" ) {


        double price1 = ObjectGetDouble(ChartID(),last_object,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(ChartID(),last_object,OBJPROP_PRICE2,0);




        
if ( price1 > price2 ) {
//Alert("1>2");
double sl=0;
bool stop=true;

if ( last_price > Bid ) {
double prc=NormalizeDouble(last_price,Digits);
if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE)){
prc=prc-(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))*2;
}

if ( stop ) {
if ( last_price_name == "SC" ) sl=fibos_342;
if ( last_price_name == "SL" ) sl=fibos_342;
if ( last_price_name == "11.4" ) sl=fibos_342;
if ( last_price_name == "88.6" ) sl=fibos_114;
//if ( last_price_name == "88.6" ) sl=fibos_886+((fibos_886-fibos_764)/2);;
if ( last_price_name == "76.4" ) sl=fibos_764+((fibos_886-fibos_764)/2);//fibos_886;
if ( last_price_name == "61.8" ) sl=fibos_764+((fibos_886-fibos_764)/2);//fibos_886;
if ( last_price_name == "70.7" ) sl=fibos_764+((fibos_886-fibos_764)/2);//
if ( last_price_name == "7C" ) sl=fibos_764+((fibos_886-fibos_764)/2);
//Alert(sl,"/",last_price_name,"/",fibo_764);

if (ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) && sl != 0 ){
sl=sl+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
}

}

int ticket=OrderSend(Symbol(),OP_SELLLIMIT,Lot,prc,slip,sl,0,last_price_name+"-"+TFtoStr(Period()),MagicNumber,0,clrYellow);
}


if ( last_price < Bid ) {
double prc=NormalizeDouble(last_price,Digits);
if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE)){
prc=prc+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))*2;
}

double sl=0;
bool stop=true;

if ( stop ) {
if ( last_price_name == "SL2" ) sl=fibo_228;
if ( last_price_name == "SC" ) sl=fibos_114;
if ( last_price_name == "SL" ) sl=fibos_114;
if ( last_price_name == "11.4" ) sl=fibos_886;
if ( last_price_name == "88.6" ) sl=fibos_764;
//if ( last_price_name == "88.6" ) sl=fibo_886-((fibo_886-fibo_114)/2);//fibos_886;
if ( last_price_name == "76.4" ) sl=fibos_764-((fibos_886-fibos_764)/2);//fibos_886;
if ( last_price_name == "61.8" ) sl=fibos_764-((fibos_886-fibos_764)/2);//fibos_886;
if ( last_price_name == "70.7" ) sl=fibos_618-((fibos_886-fibos_764)/2);//fibos_886;
//if ( last_price_name == "70.7" ) sl=fibo_764;
if ( last_price_name == "7C" ) sl=fibos_764-((fibos_886-fibos_764)/2);
//Alert(sl,"/",last_price_name,"/",fibo_764);

if (ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) && sl != 0 ){
sl=sl-(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
}

}
sl=NormalizeDouble(sl,Digits);
//Alert(sl);

int ticket=OrderSend(Symbol(),OP_BUYLIMIT,Lot,prc,slip,sl,0,last_price_name+"-"+TFtoStr(Period()),MagicNumber,0,clrYellow);
}





}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ( price2 > price1 ) {
//Alert("2>1");

if ( last_price < Bid ) {
double prc=NormalizeDouble(last_price,Digits);
if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE)){
prc=prc+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))*2;
}

double sl=0;
bool stop=true;

if ( stop ) {
if ( last_price_name == "SC" ) sl=fibo_342;
if ( last_price_name == "SL" ) sl=fibo_342;
if ( last_price_name == "11.4" ) sl=fibo_342;
if ( last_price_name == "88.6" ) sl=fibo_114;
//if ( last_price_name == "88.6" ) sl=fibo_886-((fibo_886-fibo_114)/2);//fibos_886;
if ( last_price_name == "76.4" ) sl=fibo_764-((fibo_764-fibo_886)/2);//fibos_886;
//if ( last_price_name == "61.8" ) sl=fibo_764-((fibo_764-fibo_886)/2);//fibos_886;
if ( last_price_name == "61.8" ) sl=fibo_618-((fibo_618-fibo_707)/2);//fibos_886;
if ( last_price_name == "70.7" ) sl=fibo_764-((fibo_764-fibo_886)/2);//fibos_886;
if ( last_price_name == "50.0" ) sl=fibo_500-((fibo_500-fibo_618)/2);//fibo_618;
if ( last_price_name == "7C" ) sl=fibo_764-((fibo_764-fibo_886)/2);
//Alert(sl,"/",last_price_name,"/",fibo_764);

if (ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) && sl != 0 ){
sl=sl-(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
}

}
ag(Time[0],prc);
sl=NormalizeDouble(sl,Digits);
int ticket=OrderSend(Symbol(),OP_BUYLIMIT,Lot,prc,slip,sl,0,last_price_name+"-"+TFtoStr(Period()),MagicNumber,0,clrYellow);
}




if ( last_price > Bid ) {


double sl=0;
bool stop=true;

double prc=NormalizeDouble(last_price,Digits);
if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE)){
prc=prc-(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))*2;
}

if ( stop ) {
if ( last_price_name == "SL2" ) sl=fibo_228;
if ( last_price_name == "SC" ) sl=fibo_114;
if ( last_price_name == "SL" ) sl=fibo_114;
if ( last_price_name == "11.4" ) sl=fibo_886;
if ( last_price_name == "88.6" ) sl=fibo_764;
//if ( last_price_name == "88.6" ) sl=fibos_886+((fibos_886-fibos_764)/2);;
if ( last_price_name == "76.4" ) sl=fibo_618-((fibo_764-fibo_886)/2);//fibos_886;
if ( last_price_name == "61.8" ) sl=fibo_764+((fibo_764-fibo_886)/2);//fibos_886;
if ( last_price_name == "70.7" ) sl=fibo_618;
if ( last_price_name == "7C" ) sl=fibo_764+((fibo_764-fibo_886)/2);
//Alert(sl,"/",last_price_name,"/",fibo_764);

if (ObjectGetInteger(ChartID(),sparam,OBJPROP_STATE) && sl != 0 ){
sl=sl+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
}

}
sl=NormalizeDouble(sl,Digits);
int ticket=OrderSend(Symbol(),OP_SELLLIMIT,Lot,prc,slip,sl,0,last_price_name+"-"+TFtoStr(Period()),MagicNumber,0,clrYellow);
}




}
 
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
}

if ( sparam == "CLOSE PEN" ) {
 CloseTrades(last_price_name,"PEN");
 ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
}


if ( sparam == "CLOSE LIVE") {
 CloseTrades(last_price_name,"LIVE");
 ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
}

if ( sparam == "CLOSE ALIVE") {
 //Alert("alive");
 CloseTrades("","LIVE");
 ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
}

if ( sparam == "CLOSE APEN") {
 //Alert("alive");
 CloseTrades("","PEN");
 ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
}



 int indexb = StringFind(sparam,"Buton", 0); 
int indexbs = StringFind(sparam,"Butons", 0);
int indexl = StringFind(sparam,"Lotx", 0);
int indexp = StringFind(sparam,"Profitx", 0);

        string obj_id = sparam;
      


        //string obj_id = sparam;
if ( indexp != -1  ) {
Profit=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
ObjectSetString(ChartID(),"ProfitVol",OBJPROP_TEXT,Profit);
//Alert("selam",Lot); Comment("Lot:",Lot);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);

}

      
if ( indexl != -1  ) {
Lot=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
ObjectSetString(ChartID(),"LotSize",OBJPROP_TEXT,Lot);
//Alert("selam",Lot); Comment("Lot:",Lot);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);

}
       
if ( indexb != -1 && indexbs == -1 ) { 
 int replaced=StringReplace(obj_id,"Buton","");
int obj_num = StringToInteger(obj_id);

ObjectSetDouble(ChartID(),"PLINE",OBJPROP_PRICE,price_list[obj_num]);
last_price=price_list[obj_num];
last_price_num=obj_num;
last_price_name=buton_list[obj_num];

if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE)){
double prc=NormalizeDouble(last_price,Digits);
if ( Bid > last_price )prc=prc+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
if ( last_price > Bid )prc=prc-(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
ObjectSetDouble(ChartID(),"PLINE",OBJPROP_PRICE,prc);
}

//Alert("Buy sparam:",sparam,"/",obj_id);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
} 


if ( indexbs != -1 ) { 
 int replaced=StringReplace(obj_id,"Butons","");
int obj_num = StringToInteger(obj_id);
ObjectSetDouble(ChartID(),"PLINE",OBJPROP_PRICE,prices_list[obj_num]);
last_price=prices_list[obj_num];
last_price_num=obj_num;
last_price_name=buton_list[obj_num];

if (ObjectGetInteger(ChartID(),"SPREAD",OBJPROP_STATE)){
double prc=NormalizeDouble(last_price,Digits);
//prc=prc+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
if ( Bid > last_price )prc=prc+(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
if ( last_price > Bid )prc=prc-(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID));
ObjectSetDouble(ChartID(),"PLINE",OBJPROP_PRICE,prc);
}


//Alert("Sell sparam:",sparam,"/",obj_id);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
} 


//Alert(sparam);
Comment(last_price_name);

}




if(sparam==58){ // cAPSLOCK F33

             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(i);
        
  int index = StringFind(name,"FOR", 0); 
  int indexl = StringFind(name,last_object, 0);

  if ( index != -1 && indexl != -1) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
  }
  
  
}

//Print(sparam,"/",lparam);
if(sparam=="SHOW HIDE" || lparam == 83 ){ // s

             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(i);
        
  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
  }
  
  
}



//Print(sparam,"/",lparam);
if(sparam=="LEVEL COLOR" || sparam == 49 ){ // n

             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(i);
        
  /*int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);*/

  if ( //index != -1 && last_object_len != object_len
  
  ObjectGetInteger(0,name, OBJPROP_TYPE) == OBJ_TEXT
  
  ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_COLOR) == clrWhite ) {
     ObjectSetInteger(0,name,OBJPROP_COLOR,clrNONE);
     FiboLevelColor=clrNONE;
     } else {
     ObjectSetInteger(0,name,OBJPROP_COLOR,clrWhite);
     FiboLevelColor=clrWhite;
     }  
  
   }  
   
  }
  
  
}





if ( sparam == 51 ) { // ö





        string SetTimeBilgisi=TimeToStr(set_time,TIME_DATE|TIME_MINUTES|TIME_SECONDS);
        Comment("Analiz Zamanı:",SetTimeBilgisi);   
        

int  shift=iBarShift(Symbol(),Period(),set_time); 
int  shiftold=iBarShift(Symbol(),set_time_period,set_time); 
//Alert(shift,"/",set_time_period,"/",Period(),"/",shiftold);
double carpan = 0;
shift = (shift+carpan)*-1;
/*ChartNavigate(currChart,CHART_BEGIN,shift);
*/
//Alert("Analiz Zamanı:",SetTimeBilgisi,"/",shiftold,"/",shift);
//int      right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
//datetime right=Time[right_bound]+Period()*60;
//shift=iBarShift(ChartSymbol(ChartID()),ChartPeriod(ChartID()),right);   
//shift = (shift+carpan)*-1;
//datetime right=Time[right_bound]+Period()*60;

      ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
      ChartSetInteger(ChartID(),CHART_SHIFT,true);
      //ChartSetInteger(ChartID(),CHART_MODE,CHART_LINE);
      //ResetLastError();
     /* ChartNavigate(ChartID(),CHART_BEGIN,WindowFirstVisibleBar()-100);*/
     
     ChartNavigate(currChart,CHART_END,shift);
     
     
  //datetime bar_start_time=Time[0];
  //datetime bar_end_time=bar_start_time+PeriodSeconds();
  //int seconds_remaining=bar_end_time-TimeCurrent(); 
  
 //int shift1=iBarShift(Symbol(),set_time_period,Time[set_time]);
string namet=last_object;

        datetime bar_end_time=set_time+(set_time_period/Period())*PeriodSeconds();
        shift=iBarShift(Symbol(),set_time_period,set_time); 
        //Alert(bar_end_time);

  ObjectDelete(ChartID(),"CLOSETIMEFORS"+namet);
  ObjectCreate(ChartID(),"CLOSETIMEFORS"+namet,OBJ_TREND,0,bar_end_time,iHigh(Symbol(),set_time_period,shiftold),bar_end_time,iLow(Symbol(),set_time_period,shiftold));
  ObjectSetInteger(ChartID(),"CLOSETIMEFORS"+namet,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"CLOSETIMEFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"CLOSETIMEFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"CLOSETIMEFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"CLOSETIMEFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"CLOSETIMEFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
     
     
     
      
}



if(sparam==48){

             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(i);
        
  int index = StringFind(name,"Renk", 0); 


  if ( index == -1 ) {
  if (ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_BUTTON || ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_EDIT || ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_LABEL) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //ObjectSetInteger(0,"ButonWCOMMMENT", OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     //ObjectSetInteger(0,"ButonWCOMMMENT", OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   }
  }
  
  
}
/*
Print("Obje:",sparam,"/lparam",lparam);

if ( ObjectFind(sparam +" FE 6" ) != -1 && FeBrain ) {

double FeSLPrice=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
FeBrainChangeSL(sparam,FeSLPrice,Symbol());
}*/


  int indexoffe6 = StringFind(sparam," FE 6", 0);                   
  int indexoffe7 = StringFind(sparam," FE 7", 0);                   
  int indexoffe8 = StringFind(sparam," FE 8", 0);                   
  int indexoffe5 = StringFind(sparam," FE 5.5", 0);
  
  if ( (indexoffe6 != -1 || indexoffe7 != -1 || indexoffe8 != -1 || indexoffe5 != -1 ) && (ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_HLINE ) ) {
  
  double feprice = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  string festr = ObjectGetString(ChartID(),sparam+" Text",OBJPROP_TEXT);
  
  //Alert("Selam2",feprice);
  
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Line Değeri Hafızaya Volüme - Price Seç Tıkla Hline
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          //if(ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_HLINE  && ObjectGetInteger(currChart,sparam,OBJPROP_SELECTED) ) {
          string HLinePrice = DoubleToString(feprice,MarketInfo(Symbol(),MODE_DIGITS));
          //CopyTextToClipboard(HLinePrice);
          //Alert(sparam,"/",HLinePrice);
          Comment(festr," Fiyat Hafızası:",HLinePrice);
          
         double FeSLPrice=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
         FeBrainChangeSL(sparam,FeSLPrice,Symbol());
         //Alert(sparam,"/",FeSLPrice,"/",Symbol()); 
          //}
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              
  
  //Alert(sparam);
  
  }
  

  int indexoffe4 = StringFind(sparam," FE 4", 0);                   
  int indexoffe4236 = StringFind(sparam," FE 4.236", 0);                   
  int indexoffe45 = StringFind(sparam," FE 4.5", 0);                   
  int indexoffe4736 = StringFind(sparam," FE 4.736", 0);
  
  if ( (indexoffe4 != -1 || indexoffe4236 != -1 || indexoffe45 != -1 || indexoffe4736 != -1 ) && (ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_HLINE ) ) {
  
  double feprice = ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  string festr = ObjectGetString(ChartID(),sparam+" Text",OBJPROP_TEXT);
  
  //Alert("Selam2",feprice);
  
          /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          // Line Değeri Hafızaya Volüme - Price Seç Tıkla Hline
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
          //if(ObjectGetInteger(currChart,sparam,OBJPROP_TYPE) == OBJ_HLINE  && ObjectGetInteger(currChart,sparam,OBJPROP_SELECTED) ) {
          string HLinePrice = DoubleToString(feprice,MarketInfo(Symbol(),MODE_DIGITS));
          //CopyTextToClipboard(HLinePrice);
          //Alert(sparam,"/",HLinePrice);
          Comment(festr," Fiyat Hafızası:",HLinePrice);
          
         double FeSLPrice=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
         FeBrainChangeTPLine(sparam,FeSLPrice,Symbol());
         //Alert(sparam,"/",FeSLPrice,"/",Symbol()); 
          //}
          ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
              
  
  //Alert(sparam);
  
  }
  
  
  
  
  
/*
string sparams=sparam;

int indexoffe225 = StringFind(sparams," FE 2.25", 0); 

int replaced=StringReplace(sparams," FE 2.25","");

if ( indexoffe225 != -1 ) {
Alert("Sparam İşlem Aç",sparams);
return;
}
//return;

int indexoffe275 = StringFind(sparams," FE 2.75", 0); 

int replaced=StringReplace(sparams," FE 2.75","");

if ( indexoffe275 != -1 ) {
Alert("Sparam İşlem Kapa",sparams);
return;
}*/








int indexoffe225 = StringFind(sparam," FE 2.25", 0); 
int indexoffe275 = StringFind(sparam," FE 2.75", 0); 


  //if((ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_FIBO) && ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) ) {
  
if((ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_FIBO) && (ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) || indexoffe225 != -1 || indexoffe275 !=-1) ) {  
  
  
ObjectSetInteger(ChartID(),last_object,OBJPROP_WIDTH,1);
last_object=sparam;
Comment("Seçilen Obje:",sparam);
ObjectSetInteger(ChartID(),last_object,OBJPROP_WIDTH,2);


/////////////////////////////////////////////////////////////////////////////////////////////////////
/// FeBrain DAĞIN ZİRVESİNDEKİ SON MUZ KABUĞU
/////////////////////////////////////////////////////////////////////////////////////////////////////

string sparams=sparam;

//Alert(sparams);

int replaced=StringReplace(sparams," FE 2.25","");
/*
if ( indexoffe225 != -1 ) {
//Alert("Sparam İşlem Aç",sparams);
//return;
}
//return;*/

replaced=+StringReplace(sparams," FE 2.75","");

if ( indexoffe275 != -1 && FeBrainSystem ) {
//Alert("Sparam İşlem Kapa",sparams);

  int totalii = OrdersTotal();
  for(int iii=0;iii<=OrdersTotal()-1;iii++)
  {
    OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    int indexdel = StringFind(commentsi,sparams, 0); 
    int indexde5 = StringFind(commentsi,sparams+"Fe5-", 0); 
    int indexde5236 = StringFind(commentsi,sparams+"Fe5236-", 0);     
    
    /*if ( indexdel != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }*/
    if ( indexde5 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }    
    if ( indexde5236 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }       
    
    
    
    }
    return;
}



if ( ObjectFind(sparams + " FE 5 ARZ") != -1 && FeBrainSystem && indexoffe225 != -1 ) {


if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 0 ) return;

if (!IsTradeAllowed()) return;


double FePrice1 = ObjectGetDouble(ChartID(),sparams,OBJPROP_PRICE1);
double FePrice2 = ObjectGetDouble(ChartID(),sparams,OBJPROP_PRICE2);
   

FeLot=Lot;

//Alert("Selam");

string Fe5=sparams + " FE 5 ARZ";
double Fe5Price=ObjectGetDouble(ChartID(),Fe5,OBJPROP_PRICE);

string Fe5236=sparams + " FE 5.236 ARZ";
double Fe5236Price=ObjectGetDouble(ChartID(),Fe5236,OBJPROP_PRICE);

string Fe55=sparams + " FE 5.5 ARZ";
double Fe55Price=ObjectGetDouble(ChartID(),Fe55,OBJPROP_PRICE);

string Fe45=sparams + " FE 4.5";
double Fe45Price=ObjectGetDouble(ChartID(),Fe45,OBJPROP_PRICE1);

string Fe4736=sparams + " FE 4.736";
double Fe4736Price=ObjectGetDouble(ChartID(),Fe4736,OBJPROP_PRICE1);

string Fe6=sparams + " FE 6";
double Fe6Price=ObjectGetDouble(ChartID(),Fe6,OBJPROP_PRICE1);

string Fe7=sparams + " FE 7";
double Fe7Price=ObjectGetDouble(ChartID(),Fe7,OBJPROP_PRICE1);

string Fe8=sparams + " FE 8";
double Fe8Price=ObjectGetDouble(ChartID(),Fe8,OBJPROP_PRICE1);

double FeSL=Fe6Price;
FeSL=Fe55Price;

int Spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
bool FeFark=false;

double Fe5Fark;
//Fe5FarkOran = 10;
double Fe5FarkYuzdePoint=0;
int Fe5FarkYuzdePip=0;

if ( Fe5FarkOran > 0 ) {
//if ( Fe5Price > Fe5236Price ) Fe5Fark = Fe5Price-Fe5236Price;
//if ( Fe5236Price > Fe5Price ) Fe5Fark = Fe5236Price-Fe5Price;

if ( Fe45Price > Fe5Price ) Fe5Fark = Fe45Price-Fe5Price;
if ( Fe5Price > Fe45Price ) Fe5Fark = Fe5Price-Fe45Price;




//Alert(Fe5Fark,"/",Fe5FarkOran);

double Fe5FarkYuzde=Fe5Fark/100;
Fe5FarkYuzdePoint = Fe5FarkYuzde*Fe5FarkOran;
Fe5FarkYuzdePip = Fe5FarkYuzdePoint/Point;
//Fe5Fark=true;
}



//Alert("Fark%10Pip Hedef Küçültme",Fe5FarkYuzdePip);


if ( Bid > Fe5Price && FePrice1 > FePrice2) {


////////////////////////////////////////////////////////////
// Sperad Küçültme Ecn hesaplarda işe yaramıyor
////////////////////////////////////////////////////////////
if ( FeFark ) {
Fe5Price=Fe5Price+Spread*Point;
Fe5236Price=Fe5236Price+Spread*Point;
FeSL=FeSL-Spread*Point;
}

////////////////////////////////////////////////////////////
// Hedef Küçülme %10
////////////////////////////////////////////////////////////
if ( Fe5FarkOran > 0 ) {
Fe5Price=Fe5Price+Fe5FarkYuzdePip*Point;
Fe5236Price=Fe5236Price+Fe5FarkYuzdePip*Point;
FeSL=FeSL-Fe5FarkYuzdePip*Point;
Fe4736Price=Fe4736Price-Fe5FarkYuzdePip*Point;
Fe45Price=Fe45Price-Fe5FarkYuzdePip*Point;
}



string cmt1=sparams + "Fe5-"+Symbol();
if (OrderCommetbs(cmt1,Symbol())==0 && OrderCommetlive(cmt1,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,Fe5Price,0,FeSL,Fe45Price,cmt1,0,0,clrNONE);
//OrderModify(ticket,Fe5Price,Fe55Price,Fe4736Price,0,clrNONE);

string cmt2=sparams + "Fe5236-"+Symbol();
if (OrderCommetbs(cmt2,Symbol())==0 && OrderCommetlive(cmt2,Symbol())==0) int tickets=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,Fe5236Price,0,FeSL,Fe4736Price,cmt2,0,0,clrNONE);

//Alert("Evet Var",Fe5Price,"/",Fe5236Price,"/",Fe55Price,"/",Fe45Price,"/",Fe4736Price,"/",Fe6Price);
}

if ( Bid < Fe5Price && FePrice1 < FePrice2 ) {

////////////////////////////////////////////////////////////
// Sperad Küçültme Ecn hesaplarda işe yaramıyor
////////////////////////////////////////////////////////////
if ( FeFark ) {
Fe5Price=Fe5Price-Spread*Point;
Fe5Price=Fe5236Price-Spread*Point;
FeSL=FeSL+Spread*Point;
}

////////////////////////////////////////////////////////////
// Hedef Küçülme %10
////////////////////////////////////////////////////////////
if ( Fe5FarkOran > 0 ) {
Fe5Price=Fe5Price-Fe5FarkYuzdePip*Point; // Tp
Fe5236Price=Fe5236Price-Fe5FarkYuzdePip*Point; // Tp
FeSL=FeSL+Fe5FarkYuzdePip*Point;
Fe4736Price=Fe4736Price+Fe5FarkYuzdePip*Point; // İşleme Giriş
Fe45Price=Fe45Price+Fe5FarkYuzdePip*Point; // İşleme Giriş
}
////////////////////////////////////////////////////////




string cmt1=sparams + "Fe5-"+Symbol();
if (OrderCommetbs(cmt1,Symbol())==0 && OrderCommetlive(cmt1,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,Fe5Price,0,FeSL,Fe45Price,cmt1,0,0,clrNONE);
//OrderModify(ticket,Fe5Price,Fe55Price,Fe4736Price,0,clrNONE);

string cmt2=sparams + "Fe5236-"+Symbol();
if (OrderCommetbs(cmt2,Symbol())==0 && OrderCommetlive(cmt2,Symbol())==0 ) int tickets=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,Fe5236Price,0,FeSL,Fe4736Price,cmt2,0,0,clrNONE);

//Alert("Evet Var",Fe5Price,"/",Fe5236Price,"/",Fe55Price,"/",Fe45Price,"/",Fe4736Price,"/",Fe6Price);
}









}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  }
  

  int indexofrenk = StringFind(sparam,"Renk", 0); 
  if ( indexofrenk != -1 ) {  
  renk_sec=ObjectGetInteger(ChartID(),sparam,OBJPROP_BGCOLOR);  
  //Alert("Renk",renk_sec);  
  for (int t=1;t<=renk_sayisi;t++) {
  ObjectSetInteger(ChartID(),"Renk"+t,OBJPROP_STATE,false);
  }
  ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,true);
  //renk_sec=clrWhite;
  }
  
  if ( sparam == "Renk0" ) {
  
  
         int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     int indexofrenk = StringFind(name,"Renk", 0); 
     
     if ( name != "Renk0" && indexofrenk != -1 ) {
     
     //if ( lineset || fiboset == false ) {
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }
     //}
     
     
     }
     
     }
     
  
  }
  
  
if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND ) {
   
       /* double price1 = ObjectGetDouble(ChartID(),last_object,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(ChartID(),last_object,OBJPROP_PRICE2,0);
  && price1 != price2*/
  ///////////////////////////////////////////////////////////////////////////////////////////
           
           int trn_say=0;
           
           int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     int indexofexp = StringFind(name,"Trend", 0); 
     int indexofexw = StringFind(name,"W", 0);
     
     
     if ( indexofexw==-1 && indexofexp != -1 && (ObjectFind(ChartID(),"T764S"+name) != -1 || ObjectFind(ChartID(),"T764"+name) != -1 ) ) {
     trn_say=trn_say+1;
     Trend_List[trn_say]=name; 
     //Alert(name);    
     }
     
     


     
     }
     Trend_Total=trn_say;
     //last_object=name;
     Trend_Num=Trend_Total;
     //Alert(trn_say);
     
}
//////////////////////////////////////////////////////////////////////////////////////////////   

 if ( sparam == "NEXT" || sparam==49 ) {


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(i);
        
  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
  }

 Trend_Num=Trend_Num+1;
 
 if(Trend_Num>Trend_Total)Trend_Num=1;
 ObjectSetInteger(ChartID(),Trend_List[Trend_Num],OBJPROP_SELECTED,true);
 ObjectSetInteger(ChartID(),Trend_List[Trend_Num],OBJPROP_WIDTH,2);
 ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);
 //Alert(Trend_Num,"/",Trend_List[Trend_Num]);
 
 //last_object=Trend_List[Trend_Num];
 
 //Print(Trend_Total,"/",Trend_Num,"/",Trend_List[Trend_Num]);

    if(Trend_Num>1 && Trend_Num <= Trend_Total){
 ObjectSetInteger(ChartID(),Trend_List[Trend_Num-1],OBJPROP_SELECTED,false);
 ObjectSetInteger(ChartID(),Trend_List[Trend_Num-1],OBJPROP_WIDTH,1);
 }
 if(Trend_Num==1){
 ObjectSetInteger(ChartID(),Trend_List[Trend_Total],OBJPROP_SELECTED,false);
 ObjectSetInteger(ChartID(),Trend_List[Trend_Total],OBJPROP_WIDTH,1);
 }
 if(Trend_Num==Trend_Total){
 ObjectSetInteger(ChartID(),Trend_List[Trend_Total-1],OBJPROP_SELECTED,false);
 ObjectSetInteger(ChartID(),Trend_List[Trend_Total-1],OBJPROP_WIDTH,1);
 }

 string last_objects=Trend_List[Trend_Num];
              //int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        string name = ObjectName(i);
        
  int index = StringFind(name,last_objects, 0); 
  int last_object_len=StringLen(last_objects);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
  }
 
 }
  ////////////////////////////////////////////////////////////////////
  // EXPENSION GIZLE 
  ////////////////////////////////////////////////////////////////////
  if ( int(sparam) > 1 && int(sparam) < 11 ) {
  
  int exp_num = sparam;
  
  //Print("sparam",sparam,"lparam",lparam);

     if ( ObjectGetInteger(0,Expansion_List[exp_num], OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,Expansion_List[exp_num], OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,Expansion_List[exp_num], OBJPROP_TIMEFRAMES, -1);
     }
  
  }
  ///////////////////////////////////////////////////////////////////
  
 
 
   
///////////////////////////////////////////////////////////////////////////////////////////////////
  if(ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_EXPANSION ) {
  
  ///////////////////////////////////////////////////////////////////////////////////////////
           
           int exp_say=1;
           
           int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     int indexofexp = StringFind(name,"Expansion", 0); 
     
     if ( indexofexp != -1 ) {
     exp_say=exp_say+1;
     Expansion_List[exp_say]=name;     
     }
     
     


     
     }
     

//////////////////////////////////////////////////////////////////////////////////////////////     
     
     
     
  
  
  if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_SELECTED) ) {
  
  //ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELWIDTH,2);
  if ( renk_sec != clrWhite ) {ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELCOLOR,renk_sec);
  renk_sec=clrWhite;
  ObjectSetInteger(ChartID(),"Renk1",OBJPROP_STATE,true);
  }
  
  //Last_Expansion != "" && 
  if ( Last_Expansion != sparam ) {
   //ObjectSetInteger(ChartID(),Last_Expansion,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),Last_Expansion,OBJPROP_LEVELWIDTH,1);
   if ( renk_sec != clrWhite ) {ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELCOLOR,renk_sec);
   renk_sec=clrWhite;
   ObjectSetInteger(ChartID(),"Renk0",OBJPROP_STATE,true);
   }
   Last_Expansion=sparam;
  }
  
  //Alert(sparam);
    
  
  } else {
  ObjectSetInteger(ChartID(),sparam,OBJPROP_LEVELWIDTH,1);
  }
  
  }
  
  
//////////////////////////////////////////////////////////////////////////////
           string namet=sparam;
         long currChart=ChartID();
         
         int indexofexps = StringFind(sparam,"T618EXP", 0); 
         int indexoffors = StringFind(sparam,"FOR", 0); 
         int indexoftlines = StringFind(sparam,"Trendline", 0); 
         
         int indexofglines = StringFind(sparam,"Gann Line", 0);
         
         //fiboset=true;
         
if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_TREND && indexofexps == -1 && indexoffors == -1 && lineset && indexoftlines == 0) {         
//if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_GANNLINE && indexofexps == -1 && indexoffors == -1 && fiboset && indexofglines == 0) {

        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        //double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        //datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);



  string namesx =  "LOWCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);   
   namesx =  "OPENLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx); 
   namesx =  "OPENCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
   namesx =  "LOWOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  namesx =  "OPENLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);
   namesx =  "OPENOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);   

  namesx =  "LOWCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);   
   namesx =  "OPENLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx); 
   namesx =  "OPENCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
   namesx =  "LOWOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  namesx =  "OPENLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);
   namesx =  "OPENOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx); 

   namesx =  "HIGHCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
   namesx =  "CLOSEHIGHFORS"+namet;
  ObjectDelete(ChartID(),namesx);  
   namesx =  "CLOSEOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);           
  
   namesx =  "HIGHOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);  
   namesx =  "OPENHIGHFORS"+namet;
  ObjectDelete(ChartID(),namesx);  
   namesx =  "OPENCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);  
   namesx =  "CLOSEOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx); 
   namesx =  "OPENCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
   namesx =  "HIGHOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);  
   namesx =  "HIGHCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);    
   namesx =  "OPENHIGHFORS"+namet;
  ObjectDelete(ChartID(),namesx);
   namesx =  "OPENOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx); 
   namesx =  "CLOSELOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);             
   
   namesx =  "LOWLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);  
   namesx =  "HIGHHIGHFORS"+namet;
  ObjectDelete(ChartID(),namesx);    

   ///////////////////////////////////////////////////////////////////////////////////////

   if ( Close [shift1] > Open[shift1] ) {
   //Alert("Selam");
   //if ( price1 < price2 ) {
   ObjectMove(ChartID(),namet,0,time1,Low[shift1]);
   ObjectMove(ChartID(),namet,1,time2,Low[shift2]);
   

  string namesx =  "LOWLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Low[shift1],time2,Low[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_BACK,true); 
   
   if ( Open[shift2] > Close [shift2] ) {
   
   //Alert(3);
   
  string namesx =  "LOWCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Low[shift1],time2,Close[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     


   namesx =  "OPENLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Low[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     

   namesx =  "OPENCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Close[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);    
  
   /*namesx =  "CLOSELOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Close[shift1],time2,Low[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);   */   
   
   
      
   
   }
   
   if ( Close [shift2] > Open[shift2] ) {
   
   //Alert(4);
   
   string namesx =  "LOWOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Low[shift1],time2,Open[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     


   namesx =  "OPENLOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Low[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     

   namesx =  "OPENOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Open[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  

   /*namesx =  "CLOSELOWFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Close[shift1],time2,Low[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);*/   
  
           
   
   }
   
   
   
   
   //}   
   }
      
   if ( Open[shift1] > Close [shift1] ) {
   
   //if ( price2 < price1 ) {
   ObjectMove(ChartID(),namet,0,time1,High[shift1]);
   ObjectMove(ChartID(),namet,1,time2,High[shift2]);
   //}  
   
   
  string namesx =  "HIGHHIGHFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,High[shift1],time2,High[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
  ObjectSetInteger(ChartID(),namesx,OBJPROP_BACK,true); 


   
   
   if ( Open[shift2] > Close [shift2] ) {
   
   //Alert(1);
   
  string namesx =  "HIGHOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,High[shift1],time2,Open[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     


   namesx =  "OPENHIGHFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,High[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     

   namesx =  "OPENCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Close[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     

   namesx =  "OPENOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Open[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   
      
   
      
   
   }
   
   if ( Close [shift2] > Open[shift2] ) {
   
   //Alert(2);
   
   
   string namesx =  "HIGHCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,High[shift1],time2,Close[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     


   namesx =  "OPENHIGHFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,High[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);     

   namesx =  "OPENCLOSEFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Close[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);       


   namesx =  "OPENOPENFORS"+namet;
  ObjectDelete(ChartID(),namesx);
  ObjectCreate(ChartID(),namesx,OBJ_TREND,0,time1,Open[shift1],time2,Open[shift2]);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),namesx,OBJPROP_RAY,true);  
  ObjectSetInteger(ChartID(),namesx,OBJPROP_STYLE,STYLE_DASHDOTDOT);  
  
  
   
   }   
   
   
   
   
   
   
   
   
   
   
   
   
   
   }
   /////////////////////////////////////////////////////////////////////////////////////////
   
   


//Alert(indexofglines,"/",namet);

}
         
         //fiboset=false;
if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_TREND && indexofexps == -1 && indexoffors == -1 && fiboset && indexoftlines == 0) {

//Alert(indexoftlines);
        
        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        //double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        //datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        
        if ( time1 == time2 && Period() == PERIOD_H4 
        
        ) {set_time = time1;
        string SetTimeBilgisi=TimeToStr(set_time,TIME_DATE|TIME_MINUTES|TIME_SECONDS);
        Comment("Analiz Zamanı:",SetTimeBilgisi);        
        //Alert("Analiz Zamanı",SetTimeBilgisi);
        set_time_period=Period();
        
   ///////////////////////////////////////////////////////////////////////////////////////
   if ( Close [shift1] > Open[shift1] ) {
   if ( price1 < price2 ) {
   ObjectMove(ChartID(),namet,0,time1,Close[shift1]);
   ObjectMove(ChartID(),namet,1,time1,Open[shift1]);
   }   
   }
      
   if ( Open[shift1] > Close [shift1] ) {
   if ( price2 < price1 ) {
   ObjectMove(ChartID(),namet,0,time1,Close[shift1]);
   ObjectMove(ChartID(),namet,1,time1,Open[shift1]);
   }  
   }
   /////////////////////////////////////////////////////////////////////////////////////////
        price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);        
  
  ObjectDelete(ChartID(),"OPENFORS"+namet);
  ObjectCreate(ChartID(),"OPENFORS"+namet,OBJ_TREND,0,time1,Open[shift1],time1+300*PeriodSeconds(),Open[shift1]);
  ObjectSetInteger(ChartID(),"OPENFORS"+namet,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"OPENFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"OPENFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"OPENFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"OPENFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"OPENFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT);  
  
         

  if ( Close[shift1] > Open[shift1] ) {
  /**/
  
  ObjectDelete(ChartID(),"CLOSEFORS"+namet);
  ObjectCreate(ChartID(),"CLOSEFORS"+namet,OBJ_TREND,0,time1,Close[shift1],time1+300*PeriodSeconds(),Close[shift1]);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT);  
  
  ObjectDelete(ChartID(),"HIGHFORS"+namet);
  ObjectCreate(ChartID(),"HIGHFORS"+namet,OBJ_TREND,0,time1,High[shift1],time1+300*PeriodSeconds(),High[shift1]);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_COLOR,clrDarkGreen);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT);  
  
  ObjectDelete(ChartID(),"LOWFORS"+namet);
  ObjectCreate(ChartID(),"LOWFORS"+namet,OBJ_TREND,0,time1,Low[shift1],time1+300*PeriodSeconds(),Low[shift1]);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
  
  }
  
  if ( Open[shift1] > Close[shift1] ) {
  ObjectDelete(ChartID(),"CLOSEFORS"+namet);
  ObjectCreate(ChartID(),"CLOSEFORS"+namet,OBJ_TREND,0,time1,Close[shift1],time1+300*PeriodSeconds(),Close[shift1]);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"CLOSEFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  ObjectDelete(ChartID(),"LOWFORS"+namet);
  ObjectCreate(ChartID(),"LOWFORS"+namet,OBJ_TREND,0,time1,Low[shift1],time1+300*PeriodSeconds(),Low[shift1]);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_COLOR,clrDarkRed);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"LOWFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT); 
  
  ObjectDelete(ChartID(),"HIGHFORS"+namet);
  ObjectCreate(ChartID(),"HIGHFORS"+namet,OBJ_TREND,0,time1,High[shift1],time1+300*PeriodSeconds(),High[shift1]);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"HIGHFORS"+namet,OBJPROP_STYLE,STYLE_DASHDOTDOT);           
        
  
  
  }      
        
        
        } else {
        ObjectDelete(ChartID(),"HIGHFORS"+namet);
        ObjectDelete(ChartID(),"LOWFORS"+namet);
        ObjectDelete(ChartID(),"OPENFORS"+namet);
        ObjectDelete(ChartID(),"CLOSEFORS"+namet);
        ObjectDelete(ChartID(),"CLOSETIMEFORS"+namet);
        }
        
        
        
        
        
        if ( price1 > price2 ) {
        
        ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        //ObjectMove(currChart,namet,2,time3,price2+(((price1-price2)/100)*61.8));
        //int Fark=(((price1-price2)*4.5)-(((price1-price2)/100)*61.8))/Point;
        //Comment(Fark);
        
        
        
        
        
  
  tepes_prc=Low[shift2];  
  dips_prc=High[shift1];
  starts_time=time1;
  finishs_time=time2;
  lines_name=namet;//IntegerToString(Time[1]); 
  
  int BigBarVolume=(Open[shift1]-Close[shift1])/Point;
  int BigBarVol=Volume[shift1]/10;
  int BigBarHL=(High[shift1]-Low[shift1])/Point;
  
  int profitur = MarketInfo(Symbol(),MODE_PROFITCALCMODE);
  
  if ( profitur == 1 ) {
  BigBarVol=BigBarVol/10;
  BigBarVolume=BigBarVolume/10;  
  BigBarHL=BigBarHL/10;
  }

  
//Alert("Selam:",BigBarVolume,"/",Open[shift1],Close[shift1],"/",BigBarVol);

  ObjectDelete(ChartID(),"TPOWERFORS"+lines_name);
  if ( shift1-BigBarVolume > 0 ) {
  ObjectCreate(ChartID(),"TPOWERFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],Time[shift1-BigBarVolume],High[shift1-BigBarVolume]);
  } else {
  ObjectCreate(ChartID(),"TPOWERFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],starts_time+BigBarVolume*PeriodSeconds(),Low[shift1]);
 }
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_RAY,0);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_COLOR,clrBisque);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/
  
  ObjectDelete(ChartID(),"TPOWERHLFORS"+lines_name);
  if ( shift1-BigBarHL > 0 ) {
  ObjectCreate(ChartID(),"TPOWERHLFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],Time[shift1-BigBarHL],High[shift1-BigBarHL]);
  } else {
  ObjectCreate(ChartID(),"TPOWERHLFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],starts_time+BigBarHL*PeriodSeconds(),Low[shift1]);
 }
  ObjectSetInteger(ChartID(),"TPOWERHLFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TPOWERHLFORS"+lines_name,OBJPROP_RAY,0);
  ObjectSetInteger(ChartID(),"TPOWERHLFORS"+lines_name,OBJPROP_COLOR,clrBisque);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/
  
    
  
  
  
  
  ObjectDelete(ChartID(),"TPOWEREDFORS"+lines_name);  
  
  int BigBarVolumeRed;
  if ( Open[shift1+1] > Close[shift1+1] ) {
  BigBarVolumeRed=(Low[shift1+1]-Close[shift1])/Point;  
  //Alert("Evet2",Low[shift1+1],"/",BigBarVolumeRed,"*",starts_time+(BigBarVol*PeriodSeconds()));

 if ( Low[shift1+1]==Close[shift1+1] && High[shift1] > Close[shift1+1] ) {
  //Alert("Evet Küçük2");
  BigBarVolumeRed=(High[shift1]-Close[shift1])/Point;  
  }



  if ( profitur == 1 ) {
  BigBarVolumeRed=BigBarVolumeRed/10;
  }
  
  
  
  
  if ( shift1-BigBarVolumeRed > 0 ) {
  ObjectCreate(ChartID(),"TPOWEREDFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],Time[shift1-BigBarVolumeRed],High[shift1-BigBarVolumeRed]);
  } else {
  ObjectCreate(ChartID(),"TPOWEREDFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],Time[shift1]+BigBarVolumeRed*PeriodSeconds(),Low[shift1]);
  }
  ObjectSetInteger(ChartID(),"TPOWEREDFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TPOWEREDFORS"+lines_name,OBJPROP_RAY,0);
  ObjectSetInteger(ChartID(),"TPOWEREDFORS"+lines_name,OBJPROP_COLOR,clrRed);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/
  }  
  
  

  ObjectDelete(ChartID(),"TVOLFORS"+lines_name);
  if ( shift1-BigBarVol > 0 ) {
  ObjectCreate(ChartID(),"TVOLFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],Time[shift1-BigBarVol],High[shift1-BigBarVol]);
  } else {
  ObjectCreate(ChartID(),"TVOLFORS"+lines_name,OBJ_TREND,0,starts_time,Open[shift1],starts_time+(BigBarVol*PeriodSeconds()),Low[shift1]); 
  }
  ObjectSetInteger(ChartID(),"TVOLFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TVOLFORS"+lines_name,OBJPROP_RAY,0);
  ObjectSetInteger(ChartID(),"TVOLFORS"+lines_name,OBJPROP_COLOR,clrLightBlue);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/
    
  
  
  
  
  //ObjectsDeleteAlls(ChartID(),lines_name,0,-1); 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  
  int BarSize=0;
  int BarShift=0;
  for ( int t=shift2;t<=shift1-1;t++){
  
  
  
  if ( (Open[t] > Close[t] &&  Open[t+1] > Close[t+1]) || (Open[t] > Close[t] &&  Open[t-1] > Close[t-1] ) ) {  
  if ( (Open[t]-Close[t])/Point > BarSize ) {  
  BarShift=t;
  BarSize=(Open[t]-Close[t])/Point;
  //Print("Bar",t,"/",BarSize,"/",Open[t],"/",Close[t]);  
  }  
  }   
  }


  ObjectDelete(ChartID(),"TSDBFORS"+lines_name);
  ObjectCreate(ChartID(),"TSDBFORS"+lines_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]);
 
  ObjectSetInteger(ChartID(),"TSDBFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBFORS"+lines_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TSDBFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TSDBFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TSDBFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());
  
  ObjectDelete(ChartID(),"TSDBOHFORS"+lines_name);
  ObjectCreate(ChartID(),"TSDBOHFORS"+lines_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]);
 
  ObjectSetInteger(ChartID(),"TSDBOHFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGOHFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBOHFORS"+lines_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBOHFORS"+lines_name,OBJPROP_PRICE1,Open[BarShift]); 
  ObjectSetDouble(ChartID(),"TSDBOHFORS"+lines_name,OBJPROP_PRICE2,High[BarShift]); 
  ObjectSetInteger(ChartID(),"TSDBOHFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TSDBOHFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());
  
  ObjectDelete(ChartID(),"TSDBCLFORS"+lines_name);    
  if (Open[BarShift+1] > Close[BarShift+1]) {
  ObjectCreate(ChartID(),"TSDBCLFORS"+lines_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]); 
  ObjectSetInteger(ChartID(),"TSDBCLFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBCLFORS"+lines_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBCLFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift+1]); 
  ObjectSetDouble(ChartID(),"TSDBCLFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift+1]); 
  ObjectSetInteger(ChartID(),"TSDBCLFORS"+lines_name,OBJPROP_TIME1,Time[BarShift+1]);
  ObjectSetInteger(ChartID(),"TSDBCLFORS"+lines_name,OBJPROP_TIME2,Time[BarShift+1]+3000*PeriodSeconds());
  }  
  
  if ( BarShift != 0 ) {
  ObjectDelete(ChartID(),"TSDBCLSFORS"+lines_name);    
  if (Open[BarShift-1] > Close[BarShift-1]) {
  ObjectCreate(ChartID(),"TSDBCLSFORS"+lines_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]); 
  ObjectSetInteger(ChartID(),"TSDBCLSFORS"+lines_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBCLSFORS"+lines_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBCLSFORS"+lines_name,OBJPROP_PRICE1,Open[BarShift-1]); 
  ObjectSetDouble(ChartID(),"TSDBCLSFORS"+lines_name,OBJPROP_PRICE2,High[BarShift-1]); 
  ObjectSetInteger(ChartID(),"TSDBCLSFORS"+lines_name,OBJPROP_TIME1,Time[BarShift-1]);
  ObjectSetInteger(ChartID(),"TSDBCLSFORS"+lines_name,OBJPROP_TIME2,Time[BarShift-1]+3000*PeriodSeconds());
  }  
  }
  


  
  
  /*
  ObjectDelete(ChartID(),"TSDFORS"+lines_name);
  ObjectCreate(ChartID(),"TSDFORS"+lines_name,OBJ_HLINE,0,Time[shift1],Close[BarShift]);

  ObjectDelete(ChartID(),"TSDLOWFORS"+lines_name);
  ObjectCreate(ChartID(),"TSDLOWFORS"+lines_name,OBJ_HLINE,0,Time[shift1],Low[BarShift]);  
  
  ObjectDelete(ChartID(),"TSDLOWSFORS"+lines_name);
  ObjectCreate(ChartID(),"TSDLOWSFORS"+lines_name,OBJ_HLINE,0,Time[shift1],Low[BarShift+1]);  
    

  ObjectDelete(ChartID(),"TSDHIGHFORS"+lines_name);
  ObjectCreate(ChartID(),"TSDHIGHFORS"+lines_name,OBJ_HLINE,0,Time[shift1],High[BarShift]);  

  ObjectDelete(ChartID(),"TSDOPENFORS"+lines_name);
  ObjectCreate(ChartID(),"TSDOPENFORS"+lines_name,OBJ_HLINE,0,Time[shift1],Open[BarShift]);  
  */

  
  


  
  Print("BarShift",BarShift,"/ BarSize:",BarSize,"/",shift1-shift2,"/",shift2,"/",shift1);
  
//////////////////////////////////////////////////////////////////////////////////////////////////////////////  

  ObjectDelete(ChartID(),"TANGFORS"+lines_name);
  ObjectCreate(ChartID(),"TANGFORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
  
  
  int green_bar=0;
  int red_bar=0;
  bool red_high=false;
  bool green_low=false;
  double last_close=-1;
  double last_high=-1;
  double last_open=-1;
  double last_low=-1;
for ( int t=shift1;t<=shift1+50;t++){
ObjectDelete(ChartID(),t+"TANGFORS"+lines_name);
if ( //Open[t] > High[shift1] && High[t] > High[shift1] && 
///////////////////Close[t] < High[shift1] && //Low[t] > Low[shift1] &&

Close[t] > Open[t] && red_bar < 3

&& ( last_open == -1 || (last_open > Open[t] && last_open != -1 ))
&& ( last_low == -1 || (last_low > Low[t] && last_low != -1 ))

) {
Print(t);
 
 
 if (
 Open[t+2]  > Close[t+2]&& Open[t+1]  > Close[t+1]
 
 ){
  /*ObjectDelete(ChartID(),t+"TANGFORS"+lines_name);
  ObjectCreate(ChartID(),t+"TANGFORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
 
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetDouble(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_PRICE1,Low[t]); 
  ObjectSetDouble(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_PRICE2,Low[t]); 
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_TIME1,Time[t]);
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_TIME2,Time[t]+3000*PeriodSeconds());*/
  
  ObjectDelete(ChartID(),t+"TANGFORS"+lines_name);
  ObjectCreate(ChartID(),t+"TANGFORS"+lines_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]);
 
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  //ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_PRICE1,Low[t]); 
  ObjectSetDouble(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_PRICE2,Low[t+1]); 
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_TIME1,Time[t]);
  ObjectSetInteger(ChartID(),t+"TANGFORS"+lines_name,OBJPROP_TIME2,Time[t]+3000*PeriodSeconds());
    
  }
  
  
  green_low=true;
  last_open=Open[t];
  last_low=Low[t];
}
 
if ( Low[t] > Low[shift1] && Close[t] < Low[shift1] && Open[t] > Close[t]  && green_low == true &&

Low[t+1] > Low[shift1] && Close[t+1] < Low[shift1] && Open[t+1]  > Close[t+1] && 
Low[t+2] > Low[shift1] && //Close[t+2] < Low[shift1] && 
Open[t+2]  > Close[t+2] 


&& Close[t] < Close[t+1] //&& Close[t+1] < Close[t+2]
) {
red_bar=red_bar+3;

}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  
  
  /*ObjectCreate(ChartID(),"VLINES"+lines_name,OBJ_VLINE,0,Time[1],Ask);
  ObjectSetInteger(ChartID(),"VLINES"+lines_name,OBJPROP_COLOR,clrYellow);

  ObjectCreate(ChartID(),"HLINES"+lines_name,OBJ_HLINE,0,Time[1],Open[1]);
  ObjectSetInteger(ChartID(),"HLINES"+lines_name,OBJPROP_COLOR,clrWhite);
  
  
  ObjectCreate(ChartID(),"TLINES"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TLINES"+lines_name,OBJPROP_COLOR,clrWhite);*/


  ObjectCreate(ChartID(),"T886S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T886S"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T886S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T886S"+lines_name,OBJPROP_SELECTED,0);  

  ObjectCreate(ChartID(),"T707S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T707S"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T707S"+lines_name,OBJPROP_WIDTH,2);

  ObjectCreate(ChartID(),"T735"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T735"+lines_name,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"T735"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T735"+lines_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"T735"+lines_name,OBJPROP_WIDTH,1);  
  ObjectSetInteger(ChartID(),"T735"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);  

  ObjectCreate(ChartID(),"T764S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T764S"+lines_name,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"T764S"+lines_name,OBJPROP_WIDTH,2);
  
  ObjectCreate(ChartID(),"T-5-2-9-S"+lines_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T-5-2-9-S"+lines_name,OBJPROP_BGCOLOR,clrBisque);
  ObjectSetInteger(ChartID(),"T-5-2-9-S"+lines_name,OBJPROP_COLOR,clrBisque);
  //ObjectSetInteger(ChartID(),"T-5-2-9-S"+lines_name,OBJPROP_WIDTH,2); 
  
  
  ObjectCreate(ChartID(),"T618S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T618S"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T618S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T618S"+lines_name,OBJPROP_SELECTED,0);
  
  ObjectCreate(ChartID(),"T618EXPS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T618EXPS"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T618EXPS"+lines_name,OBJPROP_RAY,false); 
  ObjectSetInteger(ChartID(),"T618EXPS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T618EXPS"+lines_name,OBJPROP_SELECTED,0);

  ObjectCreate(ChartID(),"T382S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T382S"+lines_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T382S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T382S"+lines_name,OBJPROP_SELECTED,0);
  
  ObjectCreate(ChartID(),"T236S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T236S"+lines_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T236S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T236S"+lines_name,OBJPROP_SELECTED,0);  

  ObjectCreate(ChartID(),"T118S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T118S"+lines_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T118S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T118S"+lines_name,OBJPROP_SELECTED,0);   

  ObjectCreate(ChartID(),"T114S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T114S"+lines_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T114S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T114S"+lines_name,OBJPROP_SELECTED,0);
  
  ObjectCreate(ChartID(),"T171"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T171"+lines_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T171"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T171"+lines_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"T171"+lines_name,OBJPROP_WIDTH,1);  
  ObjectSetInteger(ChartID(),"T171"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
    
  ObjectCreate(ChartID(),"T228S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T228S"+lines_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T228S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T228S"+lines_name,OBJPROP_SELECTED,0);
  
  
  ObjectCreate(ChartID(),"T500S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T500S"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"T500S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T500S"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T500S"+lines_name,OBJPROP_WIDTH,2);
  
  ObjectCreate(ChartID(),"T700S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T700S"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"T700S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T700S"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T700S"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T700S"+lines_name,OBJPROP_STYLE,STYLE_DOT);  
  
  ObjectCreate(ChartID(),"T790S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T790S"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"T790S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T790S"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T790S"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T790S"+lines_name,OBJPROP_STYLE,STYLE_DOT);  
  
      
  
  
  ObjectCreate(ChartID(),"T342S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T342S"+lines_name,OBJPROP_COLOR,clrGray);
  ObjectSetInteger(ChartID(),"T342S"+lines_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"T342S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T342S"+lines_name,OBJPROP_SELECTED,0);
  
  
  ObjectCreate(ChartID(),"T228FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T228FORS"+lines_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T228FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T228FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T228FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T228FORS"+lines_name,OBJPROP_WIDTH,2);
  
  ObjectCreate(ChartID(),"T382FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T382FORS"+lines_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T382FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T382FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T382FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T382FORS"+lines_name,OBJPROP_WIDTH,2);
  
  
  ObjectCreate(ChartID(),"T618FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T618FORS"+lines_name,OBJPROP_COLOR,clrLimeGreen);
  ObjectSetInteger(ChartID(),"T618FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T618FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T618FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T618FORS"+lines_name,OBJPROP_WIDTH,2);
  
  
  ObjectCreate(ChartID(),"T764FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T764FORS"+lines_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T764FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T764FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T764FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T764FORS"+lines_name,OBJPROP_WIDTH,2);
  
  
  ObjectCreate(ChartID(),"T886FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T886FORS"+lines_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T886FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T886FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T886FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T886FORS"+lines_name,OBJPROP_WIDTH,2);    

  ///////////////////////////////////////////////////////////////////////////////////////////
  // Rick and Morty
  ////////////////////////////////////////////////////////////////////////////////////////////  

  ObjectCreate(ChartID(),"T772S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T772S"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T772S"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T772S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T772S"+lines_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"T772S"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   

  ObjectCreate(ChartID(),"T1772S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T1772S"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T1772S"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772S"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772S"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
  
  ObjectCreate(ChartID(),"T1772L2"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T1772L2"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T1772L2"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772L2"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772L2"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772L2"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
  
  ObjectCreate(ChartID(),"TS772S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TS772S"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS772S"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS772S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS772S"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TS772S"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);     

  ObjectCreate(ChartID(),"TS1772S"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TS1772S"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS1772S"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772S"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772S"+lines_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"TS1772S"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
  
  ObjectCreate(ChartID(),"TS1772L2"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TS1772L2"+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS1772L2"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772L2"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772L2"+lines_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"TS1772L2"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   

///////////////////////////////////////////////////////////////////////////////////////////////////  
  ObjectCreate(ChartID(),"TD117FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  ObjectCreate(ChartID(),"TD133FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_SELECTED,0);    
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  ObjectCreate(ChartID(),"TF113FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);

  ObjectCreate(ChartID(),"TD017FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  ObjectCreate(ChartID(),"TD013FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 
  
  ObjectCreate(ChartID(),"TF017FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
  
  
  ObjectCreate(ChartID(),"TF004FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_COLOR,clrGold);
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOT);   
  
  ObjectCreate(ChartID(),"TF008FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_COLOR,clrGold);
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
  
  ObjectCreate(ChartID(),"TF012FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   

  ObjectCreate(ChartID(),"TF016FORS"+lines_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
  
  //Alert("Selam");
  
  ObjectCreate(ChartID(),"TLIBRAFORS"+lines_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TLIBRAFORS"+lines_name,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),"TLIBRAFORS"+lines_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TLIBRAFORS"+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TLIBRAFORS"+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TLIBRAFORS"+lines_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TLIBRAFORS"+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 
  
  
  
///////////////////////////////////////////////////////////////////////////////////////////////////  


  
  double fractal0133s=(tepes_prc-dips_prc)*0.133;
         fractal0133s=tepes_prc-fractal0133s;

  ObjectMove("TD013FORS"+lines_name,0,finishs_time,tepes_prc);
  ObjectMove("TD013FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*1.3),fractal0133s);
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD013FORS"+lines_name,OBJPROP_SELECTED,0);  
  
  double fractal017s=(tepes_prc-dips_prc)*0.17;
         fractal017s=tepes_prc-fractal017s;

  ObjectMove("TD017FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)*1.3),fractal0133s);
  ObjectMove("TD017FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*1.8),fractal017s);
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD017FORS"+lines_name,OBJPROP_SELECTED,0);   


  
   /*double fractal133=(tepe_prc-dip_prc)*1.133;
         fractal133=tepe_prc-fractal133;

  ObjectMove("TD133FORS"+lines_name,0,finish_time,tepe_prc);
  ObjectMove("TD133FORS"+lines_name,1,finish_time+((finish_time-start_time)*1.3),fractal133);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_SELECTED,0);  
  
  double fractal117=(tepe_prc-dip_prc)*1.17;
         fractal117=tepe_prc-fractal117;

  ObjectMove("TD117FORS"+lines_name,0,finish_time+((finish_time-start_time)*1.3),fractal133);
  ObjectMove("TD117FORS"+lines_name,1,finish_time+((finish_time-start_time)*1.8),fractal117);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_SELECTED,0); */
  
  
   double fractal133s=(tepes_prc-dips_prc)*1.133;
         fractal133s=dips_prc+fractal133s;

  ObjectMove("TD133FORS"+lines_name,0,finishs_time,tepes_prc);
  ObjectMove("TD133FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*1.3),fractal133s);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD133FORS"+lines_name,OBJPROP_SELECTED,0);  
  
  double fractal117s=(tepes_prc-dips_prc)*1.17;
         fractal117s=dips_prc+fractal117s;

  ObjectMove("TD117FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)*1.3),fractal133s);
  ObjectMove("TD117FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*300),fractal117s);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD117FORS"+lines_name,OBJPROP_SELECTED,0);        


  ObjectMove("TF113FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)*1.3),fractal133s);
  ObjectMove("TF113FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*300),fractal133s);
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF113FORS"+lines_name,OBJPROP_SELECTED,0);  
  
  ObjectMove("TF017FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)*1.8),fractal017s);
  ObjectMove("TF017FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*300),fractal017s);
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF017FORS"+lines_name,OBJPROP_SELECTED,0);  
  
  double fractal004s=fractal133s-(fractal017s-fractal133s);
         

  ObjectMove("TF004FORS"+lines_name,0,finishs_time,fractal004s);
  ObjectMove("TF004FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*300),fractal004s);
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF004FORS"+lines_name,OBJPROP_SELECTED,0); 
  
  double fractal008s=fractal133s-(fractal017s-fractal133s)*2;
         

  ObjectMove("TF008FORS"+lines_name,0,finishs_time,fractal008s);
  ObjectMove("TF008FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*300),fractal008s);
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF008FORS"+lines_name,OBJPROP_SELECTED,0);     
    
  double fractal012s=fractal133s-(fractal017s-fractal133s)*3;
         

  ObjectMove("TF012FORS"+lines_name,0,finishs_time,fractal012s);
  ObjectMove("TF012FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*300),fractal012s);
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF012FORS"+lines_name,OBJPROP_SELECTED,0);   
  
  double fractal016s=fractal133s-(fractal017s-fractal133s)*4;

  ObjectMove("TF016FORS"+lines_name,0,finishs_time,fractal016s);
  ObjectMove("TF016FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*300),fractal016s);
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF016FORS"+lines_name,OBJPROP_SELECTED,0);     
      
  string name="TX382S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"38.2");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    

  name="TX236S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"23.6");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);   
  
  name="TX118S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"11.8");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);   

  name="TX500S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"50.0");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    
      
  name="TX618S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"61.8");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    


  name="TX764S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"76.4");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    
  
  name="TX707S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"70.7");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    

  name="TX886S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"88.6");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor); 
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);       

  name="TX114S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"11.4");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);       
  
  name="TX228S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"SL");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);      
  
  name="TX342S"+lines_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"SL 2");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor); 
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);       
  

  name="W1S"+lines_name;
  ObjectCreate(0,name,OBJ_TRIANGLE,0,Time[0],Bid);
  //ObjectSetString(0,name,OBJPROP_TEXT,"88.6");
  //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  //ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  //ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  //ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow); 
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    
        
        
  ObjectMove("TLINES"+lines_name,0,starts_time,Low[1]);
  ObjectMove("TLINES"+lines_name,1,Time[1],Low[1]);
  
  //tepes_prc=Low[1];
  tepes_time=Time[1];  
  
  //fibos_886 = ((tepes_prc - dips_prc)/100)*11.4;
  fibos_886 = ((tepes_prc - dips_prc)/100)*(100-88.6);
  fibos_886 = dips_prc+fibos_886;
 
  ObjectMove("T886S"+lines_name,0,starts_time,fibos_886);
  ObjectMove("T886S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_886);
  

  fibos_707 = ((tepes_prc - dips_prc)/100)*(100-70.7);
  fibos_707 = dips_prc+fibos_707;
 
  ObjectMove("T707S"+lines_name,0,starts_time,fibos_707);
  ObjectMove("T707S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_707);  

  double libra;
  if ( Close[shift2] > Open[shift2] ) {
  libra=Open[shift2];
  } else {
  libra=Close[shift2];
  }


  ObjectMove("TLIBRAFORS"+lines_name,0,starts_time,libra);
  ObjectMove("TLIBRAFORS"+lines_name,1,+starts_time+300*PeriodSeconds(),libra-(fibos_707-libra));
  

 //Alert("Selam");
//////////////////////////////////////////////////////////////////////////////////
    
  fibos_1772 = ((tepes_prc - dips_prc)/100)*(177.20045);
  fibos_1772 = dips_prc-fibos_1772;  

  ObjectMove("T1772S"+lines_name,0,starts_time,fibos_1772);
  ObjectMove("T1772S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_1772);    
  
  fibos_772 = ((tepes_prc - dips_prc)/100)*(77.20045);
  fibos_772 = dips_prc-fibos_772;  
  
  ObjectMove("T772S"+lines_name,0,starts_time,fibos_772);
  ObjectMove("T772S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_772);  
  

//Alert("Selam");

  double fibos_1772L2 = dips_prc-((fibos_772-fibos_1772)*3);
  double fibos_1772L2s = fibos_1772-((fibos_772-fibos_1772)*1);

  ObjectMove("T1772L2"+lines_name,0,starts_time,fibos_1772L2s);
  ObjectMove("T1772L2"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_1772L2s);    

for (int level=-1;level<=20;level++){

double fibos_level = fibos_1772-((fibos_772-fibos_1772)*level);

  ObjectDelete(ChartID(),"T1772Lv"+level+lines_name);
  ObjectCreate(ChartID(),"T1772Lv"+level+lines_name,OBJ_TREND,0,starts_time,fibos_level,Time[1]+1*PeriodSeconds(),fibos_level);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772Lv"+level+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 


  fibos_level = fibos_level-((fibos_772-fibos_1772)/2);

  ObjectDelete(ChartID(),"T1772Lvp"+level+lines_name);
  ObjectCreate(ChartID(),"T1772Lvp"+level+lines_name,OBJ_TREND,0,starts_time,fibos_level,Time[1]+1*PeriodSeconds(),fibos_level);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+lines_name,OBJPROP_COLOR,clrBisque);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+lines_name,OBJPROP_STYLE,STYLE_SOLID); 
  

}





  fibos_s1772 = ((tepes_prc - dips_prc)/100)*(177.20045);
  fibos_s1772 = tepes_prc+fibos_s1772;  

  ObjectMove("TS1772S"+lines_name,0,starts_time,fibos_s1772);
  ObjectMove("TS1772S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_s1772);    
  
  fibos_s772 = ((tepes_prc - dips_prc)/100)*(77.20045);
  fibos_s772 = tepes_prc+fibos_s772;  
  
  ObjectMove("TS772S"+lines_name,0,starts_time,fibos_s772);
  ObjectMove("TS772S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_s772);  
  
  
  double fibos_1772SL2 = tepes_prc+((fibos_s1772-fibos_s772)*3);
  double fibos_1772SL2s = fibos_s1772+((fibos_s1772-fibos_s772)*1);

  ObjectMove("TS1772L2"+lines_name,0,starts_time,fibos_1772SL2s);
  ObjectMove("TS1772L2"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_1772SL2s);    


for (int level=0;level<=20;level++){ //2 

double fibos_level = fibos_s1772+((fibos_s1772-fibos_s772)*level);

  ObjectDelete(ChartID(),"TS1772Lv"+level+lines_name);
  ObjectCreate(ChartID(),"TS1772Lv"+level+lines_name,OBJ_TREND,0,starts_time,fibos_level,Time[1]+1*PeriodSeconds(),fibos_level);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+lines_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+lines_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 


  fibos_level = fibos_level+((fibos_s1772-fibos_s772)/2);

  ObjectDelete(ChartID(),"TS1772Lvp"+level+lines_name);
  ObjectCreate(ChartID(),"TS1772Lvp"+level+lines_name,OBJ_TREND,0,starts_time,fibos_level,Time[1]+1*PeriodSeconds(),fibos_level);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+lines_name,OBJPROP_COLOR,clrBisque);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+lines_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+lines_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+lines_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+lines_name,OBJPROP_STYLE,STYLE_SOLID); 
  

}


////////////////////////////////////////////////////////////////////
// SYM UPDATE
////////////////////////////////////////////////////////////////////

//Alert("Selam");


  double fibo_1168 = ((dips_prc-tepes_prc)/100)*(16.8);
  fibo_1168 = tepes_prc-fibo_1168; 
  
ObjectDelete(ChartID(),"RSYM-1168"+lines_name);  
ObjectCreate(ChartID(),"RSYM-1168"+lines_name,OBJ_TREND,0,finish_time,fibo_1168,Time[1]+1*PeriodSeconds(),fibo_1168);
ObjectSetInteger(ChartID(),"RSYM-1168"+lines_name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"RSYM-1168"+lines_name,OBJPROP_FILL,true);
ObjectSetInteger(ChartID(),"RSYM-1168"+lines_name,OBJPROP_WIDTH,2);
   
  double fibo_13236 = ((dips_prc-tepes_prc)/100)*(32.36);
  fibo_13236 = tepes_prc-fibo_13236; 
  
ObjectDelete(ChartID(),"RSYM-13236"+lines_name);  
ObjectCreate(ChartID(),"RSYM-13236"+lines_name,OBJ_TREND,0,finish_time,fibo_13236,Time[1]+1*PeriodSeconds(),fibo_13236);
ObjectSetInteger(ChartID(),"RSYM-13236"+lines_name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"RSYM-13236"+lines_name,OBJPROP_FILL,true);
   
  double fibo_14854 = ((dips_prc-tepes_prc)/100)*(48.54);
  fibo_14854 = tepes_prc-fibo_14854; 
  
ObjectDelete(ChartID(),"RSYM-14854"+lines_name);  
ObjectCreate(ChartID(),"RSYM-14854"+lines_name,OBJ_TREND,0,finish_time,fibo_14854,Time[1]+1*PeriodSeconds(),fibo_14854);
ObjectSetInteger(ChartID(),"RSYM-14854"+lines_name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"RSYM-14854"+lines_name,OBJPROP_FILL,true);




  double fibos_700 = ((tepes_prc - dips_prc)/100)*(100-30);
  fibos_700 = dips_prc+fibos_700;  
  
  ObjectMove("T700S"+lines_name,0,starts_time,fibos_700);
  ObjectMove("T700S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_700); 
  
  double fibos_790 = ((tepes_prc - dips_prc)/100)*(100-21);
  fibos_790 = dips_prc+fibos_790;  
  
  ObjectMove("T790S"+lines_name,0,starts_time,fibos_790);
  ObjectMove("T790S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_790); 

ObjectDelete(ChartID(),"RSYMS"+lines_name);  
ObjectCreate(ChartID(),"RSYMS"+lines_name,OBJ_RECTANGLE,0,starts_time,fibos_700,Time[1]+1*PeriodSeconds(),fibos_790);
ObjectSetInteger(ChartID(),"RSYMS"+lines_name,OBJPROP_COLOR,clrLightSkyBlue);
ObjectSetInteger(ChartID(),"RSYMS"+lines_name,OBJPROP_FILL,true);  
////////////////////////////////////////////////////////////////////////////  
  
  

  
  ////////////////////////////////////////////////////////////////////////////////////

  
  fibos_735 = ((tepes_prc - dips_prc)/100)*(100-73.55);
  fibos_735 = dips_prc+fibos_735;  
  
  ObjectMove("T735"+lines_name,0,starts_time,fibos_735);
  ObjectMove("T735"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_735); 
  
  
  fibos_764 = ((tepes_prc - dips_prc)/100)*(100-76.4);
  fibos_764 = dips_prc+fibos_764;
 
  ObjectMove("T764S"+lines_name,0,starts_time,fibos_764);
  ObjectMove("T764S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_764); 
  
  ObjectMove("T-5-2-9-S"+lines_name ,0,starts_time,fibos_707);
  ObjectMove("T-5-2-9-S"+lines_name ,1,finishs_time+((finishs_time-starts_time)*20),fibos_764); 
 
  
  
  fibos_382 = ((tepes_prc - dips_prc)/100)*(100-38.2);
  fibos_382 = dips_prc+fibos_382;
 
  ObjectMove("T382S"+lines_name,0,starts_time,fibos_382);
  ObjectMove("T382S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_382); 
  
  fibos_236 = ((tepes_prc - dips_prc)/100)*(100-23.6);
  fibos_236 = dips_prc+fibos_236;
 
  ObjectMove("T236S"+lines_name,0,starts_time,fibos_236);
  ObjectMove("T236S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_236);   
  
  fibos_118 = ((tepes_prc - dips_prc)/100)*(100-11.8);
  fibos_118 = dips_prc+fibos_118;
 
  ObjectMove("T118S"+lines_name,0,starts_time,fibos_118);
  ObjectMove("T118S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_118);    
 
  fibos_618 = ((tepes_prc - dips_prc)/100)*(100-61.8);
  fibos_618 = dips_prc+fibos_618;
 
  ObjectMove("T618S"+lines_name,0,starts_time,fibos_618);
  ObjectMove("T618S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_618);
  
  ObjectMove("T618EXPS"+lines_name,0,finishs_time,tepes_prc);
  ObjectMove("T618EXPS"+lines_name,1,finishs_time+((finishs_time-starts_time)/2),fibos_618);    
  
  fibos_500 = ((tepes_prc - dips_prc)/100)*(100-50);
  fibos_500 = dips_prc+fibos_500;
 
  ObjectMove("T500S"+lines_name,0,starts_time,fibos_500);
  ObjectMove("T500S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_500); 
    
  
  fibos_114 = ((tepes_prc - dips_prc)/100)*11.4;
  fibos_114 = dips_prc-fibos_114;
 
  ObjectMove("T114S"+lines_name,0,starts_time,fibos_114);
  ObjectMove("T114S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_114); 
  
  fibos_171 = ((tepes_prc - dips_prc)/100)*(17.1);
  fibos_171 = dips_prc-fibos_171;  
  
  ObjectMove("T171"+lines_name,0,starts_time,fibos_171);
  ObjectMove("T171"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_171);    
  
  
  fibos_228 = ((tepes_prc - dips_prc)/100)*22.8;
  fibos_228 = dips_prc-fibos_228;
 
  ObjectMove("T228S"+lines_name,0,starts_time,fibos_228);
  ObjectMove("T228S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_228); 
  
  fibos_342 = ((tepes_prc - dips_prc)/100)*34.2;
  fibos_342 = dips_prc-fibos_342;
 
  ObjectMove("T342S"+lines_name,0,starts_time,fibos_342);
  ObjectMove("T342S"+lines_name,1,Time[1]+1*PeriodSeconds(),fibos_342); 
    
    
  
  ObjectMove("TX382S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_382);
  ObjectMove("TX618S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_618);
  ObjectMove("TX707S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_707);
  ObjectMove("TX764S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_764);
  ObjectMove("TX886S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_886);
  ObjectMove("TX114S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_114);
  ObjectMove("TX228S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_228);
  ObjectMove("TX342S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_342);
  ObjectMove("TX500S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_500);
  ObjectMove("TX236S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_236);
  ObjectMove("TX118S"+lines_name,0,starts_time-2*PeriodSeconds(),fibos_118);
  
prices_list[0]=fibos_764;
prices_list[1]=fibos_735;
prices_list[2]=fibos_707;
prices_list[3]=fibos_886;
prices_list[4]=fibos_382;
prices_list[5]=fibos_114;
prices_list[6]=fibos_171;
prices_list[7]=fibos_228;
prices_list[8]=fibos_618;
prices_list[9]=fibos_342;
prices_list[10]=fibos_500;
prices_list[11]=fibos_236;
prices_list[12]=fibos_118;

  ObjectMove("T764FORS"+lines_name,0,finishs_time,tepes_prc);
  ObjectMove("T764FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)/2),fibos_764);   
  
  ObjectSetInteger(ChartID(),"T64FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T64FORS"+lines_name,OBJPROP_SELECTED,0);  
  
  
  ObjectMove("T382FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)/2),fibos_764); 
  ObjectMove("T382FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*1),fibos_382);
  
  ObjectSetInteger(ChartID(),"T382FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T382FORS"+lines_name,OBJPROP_SELECTED,0);  
  
   
  ObjectMove("T886FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)*1),fibos_382);
  ObjectMove("T886FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*1.7),fibos_886);
  
  ObjectSetInteger(ChartID(),"T886FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T886FORS"+lines_name,OBJPROP_SELECTED,0);
  
  
  ObjectMove("T228FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)*1.7),fibos_886);
  ObjectMove("T228FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*1.8),fibos_228);
  
  ObjectSetInteger(ChartID(),"T228FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T228FORS"+lines_name,OBJPROP_SELECTED,0);   
  
  
  
  ObjectMove("T618FORS"+lines_name,0,finishs_time+((finishs_time-starts_time)*1.8),fibos_228);
  ObjectMove("T618FORS"+lines_name,1,finishs_time+((finishs_time-starts_time)*2.3),fibos_618);
  
  ObjectSetInteger(ChartID(),"T618FORS"+lines_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T618FORS"+lines_name,OBJPROP_SELECTED,0); 
    
        
        }
        
        if ( price2 > price1 ) {
        
        ObjectMove(currChart,namet,0,time1,Low[shift1]);
        ObjectMove(currChart,namet,1,time2,High[shift2]);
        //ObjectMove(currChart,namet,2,time3,price2-(((price2-price1)/100)*61.8));
        //int Fark=(((price2-price1)*4.5)-(((price2-price1)/100)*61.8))/Point;
        //Comment(Fark);


//Alert("selam1 p2>p1");




  tepe_prc=High[shift2];  
  dip_prc=Low[shift1];
  start_time=time1;
  finish_time=time2;
  line_name=namet;//IntegerToString(Time[1]);
  


  int BigBarVolume=(Close[shift1]-Open[shift1])/Point;
  int BigBarVol=Volume[shift1]/10;
  int BigBarHL=(High[shift1]-Low[shift1])/Point;
  
  int profitur = MarketInfo(Symbol(),MODE_PROFITCALCMODE);
  
  if ( profitur == 1 ) {
  BigBarVol=BigBarVol/10;
  BigBarVolume=BigBarVolume/10;
  BigBarHL=BigBarHL/10;
  }
  
  
//Alert("Selam2",BigBarVolume,"/",Open[shift1],Close[shift1],"/",BigBarVol);


  ObjectDelete(ChartID(),"TPOWERFOR"+line_name);
  
  if ( shift1-BigBarVolume > 0 ) {
  ObjectCreate(ChartID(),"TPOWERFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],Time[shift1-BigBarVolume],Low[shift1-BigBarVolume]);
  } else {
  ObjectCreate(ChartID(),"TPOWERFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],start_time+BigBarVolume*PeriodSeconds(),High[shift1]);
  }
 
  ObjectSetInteger(ChartID(),"TPOWERFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TPOWERFOR"+line_name,OBJPROP_RAY,0);
  ObjectSetInteger(ChartID(),"TPOWERFOR"+line_name,OBJPROP_COLOR,clrBisque);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/


  ObjectDelete(ChartID(),"TPOWERHLFOR"+line_name);
  
  if ( shift1-BigBarHL > 0 ) {
  ObjectCreate(ChartID(),"TPOWERHLFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],Time[shift1-BigBarHL],Low[shift1-BigBarHL]);
  } else {
  ObjectCreate(ChartID(),"TPOWERHLFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],start_time+BigBarHL*PeriodSeconds(),High[shift1]);
  }
 
  ObjectSetInteger(ChartID(),"TPOWERHLFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TPOWERHLFOR"+line_name,OBJPROP_RAY,0);
  ObjectSetInteger(ChartID(),"TPOWERHLFOR"+line_name,OBJPROP_COLOR,clrBisque);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/








  ObjectDelete(ChartID(),"TVOLFOR"+line_name);
  
  if ( shift1-BigBarVol > 0 ) {
  ObjectCreate(ChartID(),"TVOLFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],Time[shift1-BigBarVol],Low[shift1-BigBarVol]);
  } else {
  ObjectCreate(ChartID(),"TVOLFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],start_time+BigBarVol*PeriodSeconds(),High[shift1]);
  }
 
 
  ObjectSetInteger(ChartID(),"TVOLFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TVOLFOR"+line_name,OBJPROP_RAY,0);
  ObjectSetInteger(ChartID(),"TVOLFOR"+line_name,OBJPROP_COLOR,clrLightBlue);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/
  


  ObjectDelete(ChartID(),"TPOWEREDFOR"+line_name);  
  
  int BigBarVolumeRed;
  if ( Close[shift1+1] > Open[shift1+1] ) {
  //BigBarVolumeRed=(High[shift1+1]-Close[shift1])/Point;  
  BigBarVolumeRed=(Close[shift1]-High[shift1+1])/Point;  
  //Alert("Evet1:",Low[shift1+1],"/",BigBarVolumeRed);
  
  if ( Close[shift1+1]==High[shift1+1] && Low[shift1] < Close[shift1+1] ) {
  //Alert("Evet Küçük");
  BigBarVolumeRed=(Close[shift1]-Low[shift1])/Point;  
  }
  
  
  if ( profitur == 1 ) {
  BigBarVolumeRed=BigBarVolumeRed/10;
  }  
  
 if ( shift1-BigBarVolumeRed > 0 ) {
  ObjectCreate(ChartID(),"TPOWEREDFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],Time[shift1-BigBarVolumeRed],Low[shift1-BigBarVolumeRed]);
 } else {
 ObjectCreate(ChartID(),"TPOWEREDFOR"+line_name,OBJ_TREND,0,start_time,Open[shift1],start_time+BigBarVolumeRed*PeriodSeconds(),High[shift1]);
 }
 
  ObjectSetInteger(ChartID(),"TPOWEREDFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TPOWEREDFOR"+line_name,OBJPROP_RAY,0);
  //ObjectSetInteger(ChartID(),"TPOWEREDFOR"+line_name,OBJPROP_RAY_RIGHT,true);
  ObjectSetInteger(ChartID(),"TPOWEREDFOR"+line_name,OBJPROP_COLOR,clrRed);
  /*ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TPOWERFORS"+lines_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());*/
  }  
  
  
    
  
  

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  /*ObjectDelete(ChartID(),"TANGFORS"+line_name);
  ObjectCreate(ChartID(),"TANGFORS"+lines_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TANGFORS"+line_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TANGFORS"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TANGFORS"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TANGFORS"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TANGFORS"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TANGFORS"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); */    
  
  int BarSize=0;
  int BarShift=0;
  for ( int t=shift2;t<=shift1-1;t++){

  if ( (Close[t] > Open[t] && Close[t+1] > Open[t+1])  || (Close[t] > Open[t] && Close[t-1] > Open[t-1]) ) {  
  if ( (Close[t]-Open[t])/Point > BarSize ) {  
  BarShift=t;
  BarSize=(Close[t]-Open[t])/Point;
  //Print("Bar",t,"/",BarSize,"/",Open[t],"/",Close[t]);  
  }  
  }   
  }


  ObjectDelete(ChartID(),"TSDBFOR"+line_name);
  ObjectCreate(ChartID(),"TSDBFOR"+line_name,OBJ_RECTANGLE,0,start_time,Close[1],Time[1],Close[1]);
 
  ObjectSetInteger(ChartID(),"TSDBFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFORS"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBFOR"+line_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBFOR"+line_name,OBJPROP_PRICE1,Open[BarShift]); 
  ObjectSetDouble(ChartID(),"TSDBFOR"+line_name,OBJPROP_PRICE2,Low[BarShift]); 
  ObjectSetInteger(ChartID(),"TSDBFOR"+line_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TSDBFOR"+line_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());
  
  ObjectDelete(ChartID(),"TSDBOHFOR"+line_name);
  ObjectCreate(ChartID(),"TSDBOHFOR"+line_name,OBJ_RECTANGLE,0,start_time,Close[1],Time[1],Close[1]);
 
  ObjectSetInteger(ChartID(),"TSDBOHFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGOHFOR"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBOHFOR"+line_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBOHFOR"+line_name,OBJPROP_PRICE1,Close[BarShift]); 
  ObjectSetDouble(ChartID(),"TSDBOHFOR"+line_name,OBJPROP_PRICE2,High[BarShift]); 
  ObjectSetInteger(ChartID(),"TSDBOHFOR"+line_name,OBJPROP_TIME1,Time[BarShift]);
  ObjectSetInteger(ChartID(),"TSDBOHFOR"+line_name,OBJPROP_TIME2,Time[BarShift]+3000*PeriodSeconds());
  
  ObjectDelete(ChartID(),"TSDBCLFOR"+line_name);
  if ( Close[BarShift+1] > Open[BarShift+1])  {   
  ObjectCreate(ChartID(),"TSDBCLFOR"+line_name,OBJ_RECTANGLE,0,start_time,Close[1],Time[1],Close[1]);
 
  ObjectSetInteger(ChartID(),"TSDBCLFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFOR"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBCLFOR"+line_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBCLFOR"+line_name,OBJPROP_PRICE1,Close[BarShift+1]); 
  ObjectSetDouble(ChartID(),"TSDBCLFOR"+line_name,OBJPROP_PRICE2,High[BarShift+1]); 
  ObjectSetInteger(ChartID(),"TSDBCLFOR"+line_name,OBJPROP_TIME1,Time[BarShift+1]);
  ObjectSetInteger(ChartID(),"TSDBCLFOR"+line_name,OBJPROP_TIME2,Time[BarShift+1]+3000*PeriodSeconds());
  }

  ObjectDelete(ChartID(),"TSDBCLSFOR"+line_name);
  if ( BarShift != 0 ) {
  if ( Close[BarShift-1] > Open[BarShift-1])  {   
  ObjectCreate(ChartID(),"TSDBCLSFOR"+line_name,OBJ_RECTANGLE,0,start_time,Close[1],Time[1],Close[1]); 
  ObjectSetInteger(ChartID(),"TSDBCLSFOR"+line_name,OBJPROP_WIDTH,2);
  //ObjectSetInteger(ChartID(),"TANGFOR"+lines_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TSDBCLSFOR"+line_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),"TSDBCLSFOR"+line_name,OBJPROP_PRICE1,Open[BarShift-1]); 
  ObjectSetDouble(ChartID(),"TSDBCLSFOR"+line_name,OBJPROP_PRICE2,Low[BarShift-1]); 
  ObjectSetInteger(ChartID(),"TSDBCLSFOR"+line_name,OBJPROP_TIME1,Time[BarShift-1]);
  ObjectSetInteger(ChartID(),"TSDBCLSFOR"+line_name,OBJPROP_TIME2,Time[BarShift-1]+3000*PeriodSeconds());  
  }
  }
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

//////////////////////////////////////////////////////////////////////////////////////////////////////////////  
  ObjectDelete(ChartID(),"TANGFOR"+line_name);
  ObjectCreate(ChartID(),"TANGFOR"+line_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TANGFOR"+line_name,OBJPROP_COLOR,clrNONE);
  ObjectSetInteger(ChartID(),"TANGFOR"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TANGFOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TANGFOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TANGFOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TANGFOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
  
  int green_bar=0;
  bool red_high=false;
  double last_close=-1;
  double last_high=-1;
  double last_open=-1;
for ( int t=shift1;t<=shift1+50;t++){
ObjectDelete(ChartID(),t+"TANGFOR"+line_name);
if ( //Open[t] > High[shift1] && High[t] > High[shift1] && 
//////////////////Open[t] > Low[shift1] && //Low[t] > Low[shift1] &&

Open[t] > Close[t] && green_bar < 3

&& ( last_open == -1 || (last_open < Open[t] && last_open != -1 ))
&& ( last_high == -1 || (last_high < High[t] && last_high != -1 ))
) {
Print(t);


  if ( Close[t+1]  > Open[t+1] && Close[t+2]  > Open[t+2] ){
  /*ObjectDelete(ChartID(),t+"TANGFOR"+line_name);
  ObjectCreate(ChartID(),t+"TANGFOR"+line_name,OBJ_TREND,0,starts_time,Close[1],Time[1],Close[1]);
  
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetDouble(ChartID(),t+"TANGFOR"+line_name,OBJPROP_PRICE1,High[t]); 
  ObjectSetDouble(ChartID(),t+"TANGFOR"+line_name,OBJPROP_PRICE2,High[t]); 
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_TIME1,Time[t]);
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_TIME2,Time[t]+3000*PeriodSeconds());*/
  
  ObjectDelete(ChartID(),t+"TANGFOR"+line_name);
  ObjectCreate(ChartID(),t+"TANGFOR"+line_name,OBJ_RECTANGLE,0,starts_time,Close[1],Time[1],Close[1]);
  
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_COLOR,clrNONE);
  //ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_COLOR,clrBisque);
  ObjectSetDouble(ChartID(),t+"TANGFOR"+line_name,OBJPROP_PRICE1,High[t]); 
  ObjectSetDouble(ChartID(),t+"TANGFOR"+line_name,OBJPROP_PRICE2,High[t+1]); 
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_TIME1,Time[t]);
  ObjectSetInteger(ChartID(),t+"TANGFOR"+line_name,OBJPROP_TIME2,Time[t]+3000*PeriodSeconds());  
  
  }
  
  
  
  red_high=true;
  last_open=Open[t];
  last_high=High[t];
}
 
if ( High[t] < High[shift1] && Close[t] > High[shift1] && Close[t]  > Open[t] && red_high == true &&

High[t+1] < High[shift1] && Close[t+1] > High[shift1] && Close[t+1]  > Open[t+1] && 
High[t+2] < High[shift1] && //Close[t+2] > High[shift1] && 
Close[t+2]  > Open[t+2] 


&& Close[t] > Close[t+1] //&& Close[t+1] > Close[t+2]
) {
green_bar=green_bar+3;

}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////  

//ObjectsDeleteAlls(ChartID(),lines_name,0,-1); 

  /*ObjectCreate(ChartID(),"HLINETEPE"+IntegerToString(Time[1]),OBJ_HLINE,0,Time[1],tepe_prc);
  ObjectSetInteger(ChartID(),"HLINETEPE"+IntegerToString(Time[1]),OBJPROP_COLOR,clrWhite);
  
  ObjectCreate(ChartID(),"HLINEDIP"+IntegerToString(Time[1]),OBJ_HLINE,0,Time[1],dip_prc);
  ObjectSetInteger(ChartID(),"HLINEDIP"+IntegerToString(Time[1]),OBJPROP_COLOR,clrGray);  */
  
  /*ObjectCreate(ChartID(),"VLINE"+line_name,OBJ_VLINE,0,Time[1],Ask);
  ObjectSetInteger(ChartID(),"VLINE"+line_name,OBJPROP_COLOR,clrYellow);

  ObjectCreate(ChartID(),"HLINE"+line_name,OBJ_HLINE,0,Time[1],Open[1]);
  ObjectSetInteger(ChartID(),"HLINE"+line_name,OBJPROP_COLOR,clrWhite);
  
  
  ObjectCreate(ChartID(),"TLINE"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TLINE"+line_name,OBJPROP_COLOR,clrWhite);*/


  ObjectCreate(ChartID(),"T886"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T886"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T886"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T886"+line_name,OBJPROP_SELECTED,0); 
  
  ObjectCreate(ChartID(),"T886FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T886FOR"+line_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T886FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T886FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T886FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T886FOR"+line_name,OBJPROP_WIDTH,2);     




    
  ObjectCreate(ChartID(),"T707"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T707"+line_name,OBJPROP_COLOR,clrFireBrick);
  ObjectSetInteger(ChartID(),"T707"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T707"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T707"+line_name,OBJPROP_WIDTH,2);
  
  ObjectCreate(ChartID(),"T764"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T764"+line_name,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"T764"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T764"+line_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"T764"+line_name,OBJPROP_WIDTH,2);
  
  ObjectCreate(ChartID(),"T735"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T735"+line_name,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"T735"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T735"+line_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"T735"+line_name,OBJPROP_WIDTH,1);  
  ObjectSetInteger(ChartID(),"T735"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);  
  
  ObjectCreate(ChartID(),"T764FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T764FOR"+line_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T764FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T764FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T764FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T764FOR"+line_name,OBJPROP_WIDTH,2);


  ObjectCreate(ChartID(),"T-5-2-9"+line_name,OBJ_RECTANGLE,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T-5-2-9"+line_name,OBJPROP_BGCOLOR,clrBisque);
  ObjectSetInteger(ChartID(),"T-5-2-9"+line_name,OBJPROP_COLOR,clrBisque);
  //ObjectSetInteger(ChartID(),"T-5-2-9-S"+lines_name,OBJPROP_WIDTH,2); 
  
   
  ObjectCreate(ChartID(),"T618"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T618"+line_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T618"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T618"+line_name,OBJPROP_SELECTED,0);  
  
  ObjectCreate(ChartID(),"T618EXP"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T618EXP"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T618EXP"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T618EXP"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T618EXP"+line_name,OBJPROP_SELECTED,0);
  
  ObjectCreate(ChartID(),"T618FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T618FOR"+line_name,OBJPROP_COLOR,clrLimeGreen);
  ObjectSetInteger(ChartID(),"T618FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T618FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T618FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T618FOR"+line_name,OBJPROP_WIDTH,2);  

  ObjectCreate(ChartID(),"T382"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T382"+line_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T382"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T382"+line_name,OBJPROP_SELECTED,0);
  
  ObjectCreate(ChartID(),"T236"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T236"+line_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T236"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T236"+line_name,OBJPROP_SELECTED,0);  
  
  ObjectCreate(ChartID(),"T118"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T118"+line_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T118"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T118"+line_name,OBJPROP_SELECTED,0);    

  ObjectCreate(ChartID(),"T382FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T382FOR"+line_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T382FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T382FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T382FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T382FOR"+line_name,OBJPROP_WIDTH,2);
  
  
  ObjectCreate(ChartID(),"T114"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T114"+line_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T114"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T114"+line_name,OBJPROP_SELECTED,0);
  
  ObjectCreate(ChartID(),"T171"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T171"+line_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T171"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T171"+line_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"T171"+line_name,OBJPROP_WIDTH,1);  
  ObjectSetInteger(ChartID(),"T171"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);    

  ObjectCreate(ChartID(),"T228"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T228"+line_name,OBJPROP_COLOR,clrLightBlue);
  ObjectSetInteger(ChartID(),"T228"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T228"+line_name,OBJPROP_SELECTED,0);
  
  
  ObjectCreate(ChartID(),"T228FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T228FOR"+line_name,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),"T228FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"T228FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T228FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T228FOR"+line_name,OBJPROP_WIDTH,2);
  
    
  
  ObjectCreate(ChartID(),"T500"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T500"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"T500"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T500"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T500"+line_name,OBJPROP_WIDTH,2);
  
  
  ObjectCreate(ChartID(),"T700"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T700"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"T700"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T700"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T700"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T700"+line_name,OBJPROP_STYLE,STYLE_DOT);

  ObjectCreate(ChartID(),"T790"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T790"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"T790"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T790"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T790"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T790"+line_name,OBJPROP_STYLE,STYLE_DOT);    
  
  
  
  ObjectCreate(ChartID(),"T342"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T342"+line_name,OBJPROP_COLOR,clrGray);
  ObjectSetInteger(ChartID(),"T342"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"T342"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T342"+line_name,OBJPROP_SELECTED,0);
  
  ///////////////////////////////////////////////////////////////////////////////////////////
  // Rick and Morty
  ////////////////////////////////////////////////////////////////////////////////////////////
  ObjectCreate(ChartID(),"T772"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T772"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T772"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T772"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T772"+line_name,OBJPROP_SELECTED,0); 
  ObjectSetInteger(ChartID(),"T772"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);    

  ObjectCreate(ChartID(),"T1772"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T1772"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T1772"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   

  ObjectCreate(ChartID(),"T1772L2"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"T1772L2"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T1772L2"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772L2"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772L2"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772L2"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);    
  
  ObjectCreate(ChartID(),"TS772"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TS772"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS772"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS772"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS772"+line_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"TS772"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   

  ObjectCreate(ChartID(),"TS1772"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TS1772"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS1772"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TS1772"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);   
    
  ObjectCreate(ChartID(),"TS1772L2"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TS1772L2"+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS1772L2"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772L2"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772L2"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TS1772L2"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 
    
///////////////////////////////////////////////////////////////////////////////////////////////////  
  ObjectCreate(ChartID(),"TD117FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  ObjectCreate(ChartID(),"TD133FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_SELECTED,0);    
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  ObjectCreate(ChartID(),"TF113FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);

  ObjectCreate(ChartID(),"TD017FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_SELECTED,0);  
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);
  
  ObjectCreate(ChartID(),"TD013FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 
  
  ObjectCreate(ChartID(),"TF017FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT);  
  
  ObjectCreate(ChartID(),"TF004FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_COLOR,clrGold);
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOT);   
  
  ObjectCreate(ChartID(),"TF008FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_COLOR,clrGold);
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOT); 
  
  ObjectCreate(ChartID(),"TF012FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOT);     
 
 
  ObjectCreate(ChartID(),"TF016FOR"+line_name,OBJ_TREND,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOT);  
  
  ObjectCreate(ChartID(),"TLIBRAFOR"+line_name,OBJ_RECTANGLE,0,start_time,Close[1],Time[1],Close[1]);
  ObjectSetInteger(ChartID(),"TLIBRAFOR"+line_name,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),"TLIBRAFOR"+line_name,OBJPROP_WIDTH,2);
  ObjectSetInteger(ChartID(),"TLIBRAFOR"+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TLIBRAFOR"+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TLIBRAFOR"+line_name,OBJPROP_RAY,false);  
  ObjectSetInteger(ChartID(),"TLIBRAFOR"+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 
      
///////////////////////////////////////////////////////////////////////////////////////////////////  


  
  double fractal0133=(tepe_prc-dip_prc)*0.133;
         fractal0133=tepe_prc-fractal0133;

  ObjectMove("TD013FOR"+line_name,0,finish_time,tepe_prc);
  ObjectMove("TD013FOR"+line_name,1,finish_time+((finish_time-start_time)*1.3),fractal0133);
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD013FOR"+line_name,OBJPROP_SELECTED,0);  
  
  double fractal017=(tepe_prc-dip_prc)*0.17;
         fractal017=tepe_prc-fractal017;

  ObjectMove("TD017FOR"+line_name,0,finish_time+((finish_time-start_time)*1.3),fractal0133);
  ObjectMove("TD017FOR"+line_name,1,finish_time+((finish_time-start_time)*1.8),fractal017);
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD017FOR"+line_name,OBJPROP_SELECTED,0);   
  
   /*double fractal133=(tepe_prc-dip_prc)*1.133;
         fractal133=tepe_prc-fractal133;

  ObjectMove("TD133FOR"+line_name,0,finish_time,tepe_prc);
  ObjectMove("TD133FOR"+line_name,1,finish_time+((finish_time-start_time)*1.3),fractal133);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_SELECTED,0);  
  
  double fractal117=(tepe_prc-dip_prc)*1.17;
         fractal117=tepe_prc-fractal117;

  ObjectMove("TD117FOR"+line_name,0,finish_time+((finish_time-start_time)*1.3),fractal133);
  ObjectMove("TD117FOR"+line_name,1,finish_time+((finish_time-start_time)*1.8),fractal117);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_SELECTED,0); */


   
  
  


  
  
   double fractal133=(tepe_prc-dip_prc)*1.133;
         fractal133=dip_prc+fractal133;

  ObjectMove("TD133FOR"+line_name,0,finish_time,tepe_prc);
  ObjectMove("TD133FOR"+line_name,1,finish_time+((finish_time-start_time)*1.3),fractal133);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD133FOR"+line_name,OBJPROP_SELECTED,0);  
  
  double fractal117=(tepe_prc-dip_prc)*1.17;
         fractal117=dip_prc+fractal117;

  ObjectMove("TD117FOR"+line_name,0,finish_time+((finish_time-start_time)*1.3),fractal133);
  ObjectMove("TD117FOR"+line_name,1,finish_time+((finish_time-start_time)*300),fractal117);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TD117FOR"+line_name,OBJPROP_SELECTED,0);        


  ObjectMove("TF113FOR"+line_name,0,finish_time+((finish_time-start_time)*1.3),fractal133);
  ObjectMove("TF113FOR"+line_name,1,finish_time+((finish_time-start_time)*300),fractal133);
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF113FOR"+line_name,OBJPROP_SELECTED,0);  
  
  ObjectMove("TF017FOR"+line_name,0,finish_time+((finish_time-start_time)*1.8),fractal017);
  ObjectMove("TF017FOR"+line_name,1,finish_time+((finish_time-start_time)*300),fractal017);
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF017FOR"+line_name,OBJPROP_SELECTED,0);    
  
  
  double fractal004=fractal133-(fractal017-fractal133);
         
  //ObjectMove("TF004FOR"+line_name,0,finish_time+((finish_time-start_time)*1.8),fractal004);
  ObjectMove("TF004FOR"+line_name,0,finish_time,fractal004);
  ObjectMove("TF004FOR"+line_name,1,finish_time+((finish_time-start_time)*300),fractal004);
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF004FOR"+line_name,OBJPROP_SELECTED,0);     
  
  double fractal008=fractal133-(fractal017-fractal133)*2;
         

  ObjectMove("TF008FOR"+line_name,0,finish_time,fractal008);
  ObjectMove("TF008FOR"+line_name,1,finish_time+((finish_time-start_time)*300),fractal008);
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF008FOR"+line_name,OBJPROP_SELECTED,0);    
  
  double fractal012=fractal133-(fractal017-fractal133)*3;
         

  ObjectMove("TF012FOR"+line_name,0,finish_time,fractal012);
  ObjectMove("TF012FOR"+line_name,1,finish_time+((finish_time-start_time)*300),fractal012);
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF012FOR"+line_name,OBJPROP_SELECTED,0);  
  
  double fractal016=fractal133-(fractal017-fractal133)*4;

  ObjectMove("TF016FOR"+line_name,0,finish_time,fractal016);
  ObjectMove("TF016FOR"+line_name,1,finish_time+((finish_time-start_time)*300),fractal016);
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"TF016FOR"+line_name,OBJPROP_SELECTED,0);             


 
  string name="TX382"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"38.2");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);
  
  name="TX236"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"23.6");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    
  
  name="TX118"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"11.8");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);       

  name="TX500"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"50.0");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);  
  
        
  name="TX618"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"61.8");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);  

  name="TX764"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"76.4");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);  

  
  name="TX707"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"70.7");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);  
  
  
  name="TX886"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"88.6");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor); 
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);       

  name="TX114"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"11.4");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);   
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);    
  
  name="TX228"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"SL");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);        
  
  name="TX342"+line_name;
  ObjectCreate(0,name,OBJ_TEXT,0,Time[0],Bid);
  ObjectSetString(0,name,OBJPROP_TEXT,"SL 2");
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,FiboLevelColor); 
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);       
  

  name="W1"+line_name;
  ObjectCreate(0,name,OBJ_TRIANGLE,0,Time[0],Bid);
  //ObjectSetString(0,name,OBJPROP_TEXT,"88.6");
  //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  //ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  //ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  //ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,clrYellow);     
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);        
        
        
////////////////////////////////////////////////////////////////////
// SYM UPDATE
////////////////////////////////////////////////////////////////////

//Alert("Selam");

  double fibo_1168 = ((tepe_prc - dip_prc)/100)*(16.8);
  fibo_1168 = tepe_prc+fibo_1168; 
  
ObjectDelete(ChartID(),"RSYM-1168"+line_name);  
ObjectCreate(ChartID(),"RSYM-1168"+line_name,OBJ_TREND,0,finish_time,fibo_1168,Time[1]+1*PeriodSeconds(),fibo_1168);
ObjectSetInteger(ChartID(),"RSYM-1168"+line_name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"RSYM-1168"+line_name,OBJPROP_FILL,true);
ObjectSetInteger(ChartID(),"RSYM-1168"+line_name,OBJPROP_WIDTH,2);
   
  double fibo_13236 = ((tepe_prc - dip_prc)/100)*(32.36);
  fibo_13236 = tepe_prc+fibo_13236; 
  
ObjectDelete(ChartID(),"RSYM-13236"+line_name);  
ObjectCreate(ChartID(),"RSYM-13236"+line_name,OBJ_TREND,0,finish_time,fibo_13236,Time[1]+1*PeriodSeconds(),fibo_13236);
ObjectSetInteger(ChartID(),"RSYM-13236"+line_name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"RSYM-13236"+line_name,OBJPROP_FILL,true);
   
  double fibo_14854 = ((tepe_prc - dip_prc)/100)*(48.54);
  fibo_14854 = tepe_prc+fibo_14854; 
  
ObjectDelete(ChartID(),"RSYM-14854"+line_name);  
ObjectCreate(ChartID(),"RSYM-14854"+line_name,OBJ_TREND,0,finish_time,fibo_14854,Time[1]+1*PeriodSeconds(),fibo_14854);
ObjectSetInteger(ChartID(),"RSYM-14854"+line_name,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"RSYM-14854"+line_name,OBJPROP_FILL,true);
   



  

  double fibo_700 = ((tepe_prc - dip_prc)/100)*(100-30);
  fibo_700 = dip_prc+fibo_700;  
  
  ObjectMove("T700"+line_name,0,start_time,fibo_700);
  ObjectMove("T700"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_700);
  
  double fibo_790 = ((tepe_prc - dip_prc)/100)*(100-21);
  fibo_790 = dip_prc+fibo_790;  
  
  ObjectMove("T790"+line_name,0,start_time,fibo_790);
  ObjectMove("T790"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_790);
  
ObjectDelete(ChartID(),"RSYM"+line_name);  
ObjectCreate(ChartID(),"RSYM"+line_name,OBJ_RECTANGLE,0,start_time,fibo_700,Time[1]+1*PeriodSeconds(),fibo_790);
ObjectSetInteger(ChartID(),"RSYM"+line_name,OBJPROP_COLOR,clrLightSkyBlue);
ObjectSetInteger(ChartID(),"RSYM"+line_name,OBJPROP_FILL,true);



///////////////////////////////////////////////////////////////////////  
  
          
        
    //if ( price2 > price1 ) {
  
  ObjectMove("TLINE"+line_name,0,start_time,High[1]);
  ObjectMove("TLINE"+line_name,1,Time[1],High[1]);
  
  //tepe_prc=High[1];
  tepe_time=Time[1];  
  
  //fibo_886 = ((tepe_prc - dip_prc)/100)*11.4;
  fibo_886 = ((tepe_prc - dip_prc)/100)*(100-88.6);
  fibo_886 = dip_prc+fibo_886;

  ObjectMove("T886"+line_name,0,start_time,fibo_886);
  ObjectMove("T886"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_886);
  

  fibo_707 = ((tepe_prc - dip_prc)/100)*(100-70.7);
  fibo_707 = dip_prc+fibo_707;  
  
  ObjectMove("T707"+line_name,0,start_time,fibo_707);
  ObjectMove("T707"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_707);


  double libra;
  if ( Close[shift2] > Open[shift2] ) {
  libra=Close[shift2];
  } else {
  libra=Open[shift2];
  }


  //ObjectMove("TLIBRAFOR"+lines_name,0,start_time,libra);
  ObjectMove("TLIBRAFOR"+line_name,0,start_time,libra);
  ObjectMove("TLIBRAFOR"+line_name,1,+start_time+300*PeriodSeconds(),libra+(libra-fibo_707));
  
  

  

  fibo_764 = ((tepe_prc - dip_prc)/100)*(100-76.4);
  fibo_764 = dip_prc+fibo_764;  
  
  ObjectMove("T764"+line_name,0,start_time,fibo_764);
  ObjectMove("T764"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_764);  

  ObjectMove("T764FOR"+line_name,0,finish_time,tepe_prc);
  ObjectMove("T764FOR"+line_name,1,finish_time+((finish_time-start_time)/2),fibo_764);   
  
  ObjectSetInteger(ChartID(),"T64FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T64FOR"+line_name,OBJPROP_SELECTED,0);    
  
  ObjectMove("T-5-2-9"+line_name ,0,start_time,fibo_707);
  ObjectMove("T-5-2-9"+line_name ,1,finish_time+((finish_time-start_time)*20),fibo_764); 
   

  fibo_735 = ((tepe_prc - dip_prc)/100)*(100-73.55);
  fibo_735 = dip_prc+fibo_735;  
  
  ObjectMove("T735"+line_name,0,start_time,fibo_735);
  ObjectMove("T735"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_735); 
  
  
  //Alert("Selam");

  fibo_1772 = ((tepe_prc - dip_prc)/100)*(177.20045);
  fibo_1772 = dip_prc-fibo_1772;  

  ObjectMove("T1772"+line_name,0,start_time,fibo_1772);
  ObjectMove("T1772"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_1772);    

  fibo_772 = ((tepe_prc - dip_prc)/100)*(77.20045);
  fibo_772 = dip_prc-fibo_772;  
  
  ObjectMove("T772"+line_name,0,start_time,fibo_772);
  ObjectMove("T772"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_772);  


//Alert("Selam");

  double fibo_1772L2 = dip_prc-((fibo_772-fibo_1772)*3);
  double fibo_1772L2s = fibo_1772-((fibo_772-fibo_1772)*1);

  ObjectMove("T1772L2"+line_name,0,start_time,fibo_1772L2s);
  ObjectMove("T1772L2"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_1772L2s);  
  
  
for (int level=-1;level<=20;level++){

double fibo_level = fibo_1772-((fibo_772-fibo_1772)*level);

  ObjectDelete(ChartID(),"T1772Lv"+level+line_name);
  ObjectCreate(ChartID(),"T1772Lv"+level+line_name,OBJ_TREND,0,start_time,fibo_level,Time[1]+1*PeriodSeconds(),fibo_level);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772Lv"+level+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772Lv"+level+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 


  fibo_level = fibo_level-((fibo_772-fibo_1772)/2);

  ObjectDelete(ChartID(),"T1772Lvp"+level+line_name);
  ObjectCreate(ChartID(),"T1772Lvp"+level+line_name,OBJ_TREND,0,start_time,fibo_level,Time[1]+1*PeriodSeconds(),fibo_level);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+line_name,OBJPROP_COLOR,clrBisque);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"T1772Lvp"+level+line_name,OBJPROP_STYLE,STYLE_SOLID); 
  

}

  
  
  

  fibo_s1772 = ((tepe_prc - dip_prc)/100)*(177.20045);
  fibo_s1772 = tepe_prc+fibo_s1772;  

  ObjectMove("TS1772"+line_name,0,start_time,fibo_s1772);
  ObjectMove("TS1772"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_s1772);    
  
  fibo_s772 = ((tepe_prc - dip_prc)/100)*(77.20045);
  fibo_s772 = tepe_prc+fibo_s772;  
  
  ObjectMove("TS772"+line_name,0,start_time,fibo_s772);
  ObjectMove("TS772"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_s772);  
  

  double fibo_1772SL2 = tepe_prc+((fibo_s1772-fibo_s772)*3);
  double fibo_1772SL2s =fibo_s1772+((fibo_s1772-fibo_s772)*1);

  ObjectMove("TS1772L2"+line_name,0,start_time,fibo_1772SL2s);
  ObjectMove("TS1772L2"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_1772SL2s);  



for (int level=0;level<=20;level++){

double fibo_level = fibo_s1772+((fibo_s1772-fibo_s772)*level);

  ObjectDelete(ChartID(),"TS1772Lv"+level+line_name);
  ObjectCreate(ChartID(),"TS1772Lv"+level+line_name,OBJ_TREND,0,start_time,fibo_level,Time[1]+1*PeriodSeconds(),fibo_level);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+line_name,OBJPROP_COLOR,clrOrange);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TS1772Lv"+level+line_name,OBJPROP_STYLE,STYLE_DASHDOTDOT); 


fibo_level = fibo_level+((fibo_s1772-fibo_s772)/2);

  ObjectDelete(ChartID(),"TS1772Lvp"+level+line_name);
  ObjectCreate(ChartID(),"TS1772Lvp"+level+line_name,OBJ_TREND,0,start_time,fibo_level,Time[1]+1*PeriodSeconds(),fibo_level);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+line_name,OBJPROP_COLOR,clrBisque);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+line_name,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+line_name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+line_name,OBJPROP_SELECTED,0);
  ObjectSetInteger(ChartID(),"TS1772Lvp"+level+line_name,OBJPROP_STYLE,STYLE_SOLID); 
  
  

}





  

  fibo_236 = ((tepe_prc - dip_prc)/100)*(100-23.6);
  fibo_236 = dip_prc+fibo_236;  
  
  ObjectMove("T236"+line_name,0,start_time,fibo_236);
  ObjectMove("T236"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_236); 
  
  fibo_118 = ((tepe_prc - dip_prc)/100)*(100-11.8);
  fibo_118 = dip_prc+fibo_118;  
  
  ObjectMove("T118"+line_name,0,start_time,fibo_118);
  ObjectMove("T118"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_118); 

  fibo_382 = ((tepe_prc - dip_prc)/100)*(100-38.2);
  fibo_382 = dip_prc+fibo_382;  
  
  ObjectMove("T382"+line_name,0,start_time,fibo_382);
  ObjectMove("T382"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_382);  
  
  ObjectMove("T382FOR"+line_name,0,finish_time+((finish_time-start_time)/2),fibo_764); 
  ObjectMove("T382FOR"+line_name,1,finish_time+((finish_time-start_time)*1),fibo_382);
  
  ObjectSetInteger(ChartID(),"T382FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T382FOR"+line_name,OBJPROP_SELECTED,0);  
  
   
  ObjectMove("T886FOR"+line_name,0,finish_time+((finish_time-start_time)*1),fibo_382);
  ObjectMove("T886FOR"+line_name,1,finish_time+((finish_time-start_time)*1.7),fibo_886);
  
  ObjectSetInteger(ChartID(),"T886FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T886FOR"+line_name,OBJPROP_SELECTED,0);    
  

  fibo_618 = ((tepe_prc - dip_prc)/100)*(100-61.8);
  fibo_618 = dip_prc+fibo_618;  
  
  ObjectMove("T618"+line_name,0,start_time,fibo_618);
  ObjectMove("T618"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_618); 
    
  ObjectMove("T618EXP"+line_name,0,finish_time,tepe_prc);
  ObjectMove("T618EXP"+line_name,1,finish_time+((finish_time-start_time)/2),fibo_618);   

  ObjectSetInteger(ChartID(),"T618EXP"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T618EXP"+line_name,OBJPROP_SELECTED,0);

  fibo_500 = ((tepe_prc - dip_prc)/100)*(100-50);
  fibo_500 = dip_prc+fibo_500;  
  
  ObjectMove("T500"+line_name,0,start_time,fibo_500);
  ObjectMove("T500"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_500);    
  
  
  
  fibo_114 = ((tepe_prc - dip_prc)/100)*(11.4);
  fibo_114 = dip_prc-fibo_114;  
  
  ObjectMove("T114"+line_name,0,start_time,fibo_114);
  ObjectMove("T114"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_114);  
  
  fibo_171 = ((tepe_prc - dip_prc)/100)*(17.1);
  fibo_171 = dip_prc-fibo_171;  
  
  ObjectMove("T171"+line_name,0,start_time,fibo_171);
  ObjectMove("T171"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_171);    
  
  fibo_228 = ((tepe_prc - dip_prc)/100)*(22.8);
  fibo_228 = dip_prc-fibo_228;  
  
  ObjectMove("T228"+line_name,0,start_time,fibo_228);
  ObjectMove("T228"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_228);    
  
  
  ObjectMove("T228FOR"+line_name,0,finish_time+((finish_time-start_time)*1.7),fibo_886);
  ObjectMove("T228FOR"+line_name,1,finish_time+((finish_time-start_time)*1.8),fibo_228);
  
  ObjectSetInteger(ChartID(),"T228FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T228FOR"+line_name,OBJPROP_SELECTED,0);    
  
    

  fibo_342 = ((tepe_prc - dip_prc)/100)*(34.2);
  fibo_342 = dip_prc-fibo_342;  
  
  ObjectMove("T342"+line_name,0,start_time,fibo_342);
  ObjectMove("T342"+line_name,1,Time[1]+1*PeriodSeconds(),fibo_342);    
    
  
  
  ObjectMove("T618FOR"+line_name,0,finish_time+((finish_time-start_time)*1.8),fibo_228);
  ObjectMove("T618FOR"+line_name,1,finish_time+((finish_time-start_time)*2.3),fibo_618);
  
  ObjectSetInteger(ChartID(),"T618FOR"+line_name,OBJPROP_SELECTABLE,0);
  ObjectSetInteger(ChartID(),"T618FOR"+line_name,OBJPROP_SELECTED,0); 
  

  ObjectMove("TX382"+line_name,0,start_time-2*PeriodSeconds(),fibo_382);
  ObjectMove("TX618"+line_name,0,start_time-2*PeriodSeconds(),fibo_618);
  ObjectMove("TX707"+line_name,0,start_time-2*PeriodSeconds(),fibo_707);
  ObjectMove("TX764"+line_name,0,start_time-2*PeriodSeconds(),fibo_764);
  ObjectMove("TX886"+line_name,0,start_time-2*PeriodSeconds(),fibo_886);
  ObjectMove("TX114"+line_name,0,start_time-2*PeriodSeconds(),fibo_114);
  ObjectMove("TX228"+line_name,0,start_time-2*PeriodSeconds(),fibo_228);
  ObjectMove("TX342"+line_name,0,start_time-2*PeriodSeconds(),fibo_342);
  ObjectMove("TX500"+line_name,0,start_time-2*PeriodSeconds(),fibo_500);
  ObjectMove("TX236"+line_name,0,start_time-2*PeriodSeconds(),fibo_236);
  ObjectMove("TX118"+line_name,0,start_time-2*PeriodSeconds(),fibo_118);

price_list[0]=fibo_764;
price_list[1]=fibo_735;
price_list[2]=fibo_707;
price_list[3]=fibo_886;
price_list[4]=fibo_382;
price_list[5]=fibo_114;
price_list[6]=fibo_171;
price_list[7]=fibo_228;
price_list[8]=fibo_618;
price_list[9]=fibo_342;
price_list[10]=fibo_500;
price_list[11]=fibo_236;
price_list[12]=fibo_118;

//string buton_list[10]={"76.4","73.5","70.7","88.6","38.2","11.4","17.1","22.8","61.8","34.2","50.0"};    
    
  
  //Comment(tepe_prc,"\n",dip_prc,"\n",fibo_886);
    
  
  //}             
        
        }
        
        }
        
       
           
         
         
   
   
        if(ObjectGetInteger(currChart,namet,OBJPROP_TYPE) == OBJ_EXPANSION  ) {
        
        //ObjectSetInteger(currChart,namet,OBJPROP_LEVELCOLOR,clrNONE);
        
        double price1 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE1,0);
        double price2 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE2,0);
        double price3 = ObjectGetDouble(currChart,namet,OBJPROP_PRICE3,0);   
        
        datetime time1 = ObjectGetInteger(currChart,namet,OBJPROP_TIME1,0);
        datetime time2 = ObjectGetInteger(currChart,namet,OBJPROP_TIME2,0);
        datetime time3 = ObjectGetInteger(currChart,namet,OBJPROP_TIME3,0);
        
        int shift1=iBarShift(NULL,PERIOD_CURRENT,time1);
        int shift2=iBarShift(NULL,PERIOD_CURRENT,time2);
        //int shift3=iBarShift(NULL,PERIOD_CURRENT,time3);
        
        if ( price1 > price2 ) {
        
        ObjectMove(currChart,namet,0,time1,High[shift1]);
        ObjectMove(currChart,namet,1,time2,Low[shift2]);
        //ObjectMove(currChart,namet,2,time3,High[shift3]);
        ObjectMove(currChart,namet,2,time3,price2+(((price1-price2)/100)*61.8));
        int Fark=(((price1-price2)*4.5)-(((price1-price2)/100)*61.8))/Point;
        Comment(Fark);
        }
        
        if ( price2 > price1 ) {
        
        ObjectMove(currChart,namet,0,time1,Low[shift1]);
        ObjectMove(currChart,namet,1,time2,High[shift2]);
        ObjectMove(currChart,namet,2,time3,price2-(((price2-price1)/100)*61.8));
        int Fark=(((price2-price1)*4.5)-(((price2-price1)/100)*61.8))/Point;
        Comment(Fark);
       
        
        }
        
        }
        
        
  }
//+------------------------------------------------------------------+
/*
void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}*/



void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  //Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }
ChartRedraw();

}
   
    
    
void AlertObject(){

//Alert("Last_Object",last_object);

if ( ObjectFind(ChartID(),last_object) == -1 ) { 
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TREND);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TEXT);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TRENDBYANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_RECTANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_VLINE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_HLINE);




////////////////////////////////////////////////////////////////////////////      
/*if ( Fe3OrderLine != "" ) {
   //string sym_line="";
   string Fe3Ord="";
   
   //if ( sym_periyod == "" ) {  
   string sep=" ";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(last_object,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   //sym_line = results[0];
   Fe3Ord = results[0]+" "+results[1]; 
   }
   
   Alert("Fe3Ord",Fe3Ord);
   
   
int indexdeord = StringFind(Fe3OrderLine,Fe3Ord, 0); 
   
if ( indexdeord == -1 ) {
Fe3Order=false;
Fe3OrderLine="";
Alert("Silindi");
}
}*/
/////////////////////////////////////////////////////////////////////////////////







}







             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        string sparam = ObjectName(i);
        
        

int indexo = StringFind(sparam,"#", 0);
if ( indexo != -1 ) {
         string ord = sparam;
      int replacedz = StringReplace(ord,"#","");
         int indexb = StringFind(sparam," ", 0);
  string ord_ticket = StringSubstr(ord,0,indexb);
     int ord_ticets = StringToInteger(ord_ticket);
  //Alert(ord_ticket);
  
  if(OrderSelect(ord_ticket, SELECT_BY_TICKET, MODE_HISTORY)){
  
  int gecen_sure = (OrderCloseTime() - OrderOpenTime()) / 60;
  double kazanc_pip;
  if ( OrderType() == OP_BUY ) kazanc_pip=OrderClosePrice()-OrderOpenPrice();
  if ( OrderType() == OP_SELL ) kazanc_pip=OrderOpenPrice()-OrderClosePrice();
  
  double order_pos;
  if ( OrderType() == OP_BUY ) order_pos=OrderClosePrice()+50*Point;
  if ( OrderType() == OP_SELL ) order_pos=OrderClosePrice()-50*Point;
    
  
  string order_bilgi = ("Süre:"+gecen_sure+" .dk/ Pip:"+int(kazanc_pip/Point));
  
  
         string  LabelChart="OrderBilgisi"+ord_ticets;
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {     
     ObjectCreate(ChartID(),LabelChart, OBJ_TEXT,0 , OrderCloseTime()+5*PeriodSeconds(), order_pos);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,order_bilgi);
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 1);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 9);
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 55);
    // ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);     
     } else {     
     //string ZamanBilgisi=TimeToStr(seconds_remaining,TIME_MINUTES|TIME_SECONDS);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,ZamanBilgisi);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,order_bilgi);
     }   
     

int  shift=iBarShift(Symbol(),Period(),OrderOpenTime()); 
double carpan = 0;
shift = (shift+carpan)*-1;
      ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
      ChartSetInteger(ChartID(),CHART_SHIFT,true);
      //ChartSetInteger(ChartID(),CHART_MODE,CHART_LINE);
      //ResetLastError();
     /* ChartNavigate(ChartID(),CHART_BEGIN,WindowFirstVisibleBar()-100);*/
     
     ////ChartNavigate(currChart,CHART_END,shift);
     /// İptal
     
     
  
  }
  
  
}


        
        
  /*int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   } */ 
   
  }













}    




void CloseTrades(string cmt,string islem)
 {
 
 //return;
 
 
 bool sil=false;
 
 
 if ( islem == "PEN" ) { 
 
 
    /////////////////////////////////////////////////////////////////////
   if ( OrdersTotal() == 1 ) {

      if(OrderSelect(0,SELECT_BY_POS))
        {
         int typ   = OrderType();
 
        //Alert("Evet 1 İşlem Ticket:",OrderTicket());
        
          int index=StringFind(OrderComment(), cmt, 0);
          if ( index != -1 || cmt == "") {
          
          //if(OrderType()==OP_BUY || OrderType()==OP_SELL){
          
          //if ( profit && OrderProfit() < 0 ) continue;
          
          if ( OrderType() == typ && OrderSymbol() == Symbol()){ 
          
          //Alert(OrderTicket());
          
          OrderDelete( OrderTicket());
               int Err=GetLastError();
          
          
          } 
        
        }
   
   }
   }
   ///////////////////////////////////////////////////////////////////
 
 //if((cmt=="ALL" || cmt=="PEN") && OrderSymbol() == Symbol()){sil=true;}; // Hepsi veya Pending
 
   int total = OrdersTotal();
   for(int i=total-1;i>=0;i--)
  //for(int i=total;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
    int type   = OrderType();
    
   /* 

    

    
if(index!=-1 && OrderSymbol() == Symbol()){sil=true;};

};

if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){sil=true;};
if(cmt=="*" && OrderSymbol() == Symbol()){sil=true;};*/
       
    int index=StringFind(OrderComment(), cmt, 0);
    if ( cmt !="") {
    if(index==-1) continue;
    }
    sil=true;
      
          

    bool result = false;
    if ( Symbol()==OrderSymbol() ) {
    switch(type)
    {
      //Close opened long positions
      //case OP_BUYSTOP    : result = OrderDelete( OrderTicket());
      //                    break;
      
      //Close opened short positions
      case OP_SELLSTOP   : if (sil==true)result = OrderDelete( OrderTicket());
                           break;
            //Close opened long positions
      case OP_BUYLIMIT    : if (sil==true)result = OrderDelete( OrderTicket());
                          break;
      
      //Close opened short positions
      case OP_SELLLIMIT   : if (sil==true)result = OrderDelete( OrderTicket());
                          break;
      case OP_BUYSTOP    : if (sil==true)result = OrderDelete( OrderTicket());
                          break;
    }
    };
    
    //if(result == false)
    //{
      //Alert("Order " , OrderTicket() , " All Pending Orders Removed " );
    //  break;
    //}  
  }
 
 }
 
 
 
sil=false;
 int ind;
 
 if ( islem == "LIVE" ) {
 
 //if((cmt=="ALL" || cmt=="OPEN") ){sil=true;}; // Hepsi veya Acik
 
 //Alert("Sil Live:",sil,OrdersTotal()-1);
 

 if ( cmt=="" ) {sil=true;}
 
  int Attempts=0;
  bool AllClosed=false;
  while(AllClosed==false && Attempts<500)
   { 
   int counter =0;
   
   /////////////////////////////////////////////////////////////////////
   if ( OrdersTotal() == 1 ) {

      if(OrderSelect(0,SELECT_BY_POS,MODE_TRADES))
        {
         int typ   = OrderType();
 
        //Alert("Evet 1 İşlem Ticket:",OrderTicket());
        
          int index=StringFind(OrderComment(), cmt, 0);
          if ( index != -1 || cmt == "") {
          
          //if(OrderType()==OP_BUY || OrderType()==OP_SELL){
          
          //if ( profit && OrderProfit() < 0 ) continue;
          
          if ( OrderType() == typ && OrderSymbol() == Symbol()){ 
          
          //Alert(OrderTicket());
          
          OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed);
               int Err=GetLastError();
          
          
          } 
        
        }
   
   }
   }
   
   if ( OrdersTotal() == 2 ) {

      if(OrderSelect(1,SELECT_BY_POS,MODE_TRADES))
        {
         int typ   = OrderType();
 
        //Alert("Evet 1 İşlem Ticket:",OrderTicket());
        
          int index=StringFind(OrderComment(), cmt, 0);
          if ( index != -1 || cmt == "") {
          
          //if(OrderType()==OP_BUY || OrderType()==OP_SELL){
          
          //if ( profit && OrderProfit() < 0 ) continue;
          
          if ( OrderType() == typ && OrderSymbol() == Symbol()){ 
          
          //Alert(OrderTicket());
          
          OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed);
               int Err=GetLastError();
          
          
          } 
        
        }
   
   }
   
   
      if(OrderSelect(0,SELECT_BY_POS,MODE_TRADES))
        {
         int typ   = OrderType();
 
        //Alert("Evet 1 İşlem Ticket:",OrderTicket());
        
          int index=StringFind(OrderComment(), cmt, 0);
          if ( index != -1 || cmt == "") {
          
          //if(OrderType()==OP_BUY || OrderType()==OP_SELL){
          
          //if ( profit && OrderProfit() < 0 ) continue;
          
          if ( OrderType() == typ && OrderSymbol() == Symbol()){ 
          
          //Alert(OrderTicket());
          
          OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed);
               int Err=GetLastError();
          
          
          } 
        
        }
   
   }
   
      
   }   
   ///////////////////////////////////////////////////////////////////
    int typ   = OrderType();
 
   for(int index=OrdersTotal()-1;index>=0;index--)   
     {
      if(!OrderSelect(index,SELECT_BY_POS,MODE_TRADES))
        {
         int typ   = OrderType();
 
    int index=StringFind(OrderComment(), cmt, 0);
    
    //if(index==-1) continue;
    
    sil=true;


   //Alert("Sil Live:",sil,"CMT");


        
         //Print("Error with OrderSelect-",ErrorDescription(GetLastError()));
         counter++;
         continue;
        }
        //OrderMagicNumber()==MagicNumber && 
        
        //if ( profit && OrderProfit() < 0 ) continue;
        
        
      if(OrderSymbol()==Symbol() && sil==true)
         {
         if(OrderType()==typ || OrderType()==typ //|| OrderType() == OP_BUYSTOP || OrderType() == OP_SELLSTOP || OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT 
         
         )
            {
            if(!OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),50,clrRed))
               {
               int Err=GetLastError();
               //Print("Error closing order ",OrderTicket(),". Error code ",Err,". ",ErrorDescription(Err));
               counter++;
               }
            }
         
         /*else
            {
            if(!OrderDelete(OrderTicket()))
               {
               int Err=GetLastError();
               //Print("Error deleting order ",OrderTicket(),". Error code ",Err,". ",ErrorDescription(Err));
               counter++;
               }
            
            }*/
         
         }
     }
  Attempts++ ;
  if(counter==0)
    AllClosed=true;
  else
    Sleep(5000);
  }
  
  }
  
  
 }            
 
 
 ////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {



string OrderSymbols = sym;
double sonuc = 0;

if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = (BS_spread_price / BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    //Alert(Order_Profit);
    
    
    if ( BS_spread_one == 0 ) {//Alert("BS_spread_one Hatasi:",OrderSymbols);
    return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = fiyat/BS_spread_one;   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kac piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kac $ kazandirir ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}




return sonuc;


}
//////////////////////////////////////////////////
// Canli islem Sembol Kontrollu 
//////////////////////////////////////////////////
int OrderCommetssType(int typ){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( ( OrderType() == typ ) && OrderSymbol() == Symbol() ) {

/*if ( OrderSymbol() == sym ) {
Print("Sym",sym,"/",OrderSymbol(),"Comment",cmt,"/",OrderComment(),"Index:",index);
com++;
}*/

com++;

///if(index!=-1 && (OrderSymbol() == sym || sym == "*")){com++;}; // Hatali Calisiyor
//if(OrderComment()==cmt){com++;};
///if(OrderComment()=="" && cmt=="" && (OrderSymbol() == sym || sym == "*") ){com++;};


}
}



return com;
};

///////////////////////////////////////////////////////////////////////  
// PROFIT  
/////////////////////////////////////////////////////////////////////// 
double OrderTotalProfit(int typ)
{

double profits=0;

//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {


    if ( (OrderType() == typ ) && OrderSymbol() == Symbol() ) {      
    profits=profits+OrderProfit();
    }

  
              
   }
   
}

return profits;

}
  int OrderCommets(string cmt){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazanıyor diye onun için instr veya indexof yapıp comment içinde arama yapıyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if(index!=-1 && OrderSymbol() == Symbol()){com++;}; // Hatali Calisiyor
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){com++;};
}
}



return com;
};
//////////////////////////////////////////////////////////////////////
string TFtoStr(int period) {
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader

bool balikagi=true;
void ag(datetime zaman,double fiyat){

if (balikagi==false) return;

    string filenamess = "\\Images\\ag.bmp";
    string name=fiyat;
    ObjectDelete(name);
    ObjectCreate( ChartID(), name, OBJ_BITMAP, 0, zaman, fiyat );
    ObjectSetString( ChartID(), name, OBJPROP_BMPFILE, filenamess );
    ObjectSetInteger(ChartID(), name,OBJPROP_BACK,true);
    ObjectSetInteger(ChartID(), name,OBJPROP_XDISTANCE,300);
    ObjectSetInteger(ChartID(), name,OBJPROP_YDISTANCE,300);
    ObjectSetInteger(ChartID(), name,OBJPROP_SELECTABLE,true);
    ObjectSetInteger(ChartID(), name,OBJPROP_SELECTED,false);
    ObjectSetInteger(ChartID(), name,OBJPROP_HIDDEN,true);




}
//////////////////////////////////////////////////////////////////////////////////
  void AlertOrder() {
  
      Order_Total=0;
   for(int index=0;index<=OrdersTotal()-1;index++)   
     {
      if(OrderSelect(index,SELECT_BY_POS,MODE_TRADES))
        {
         int typ   = OrderType();
         
         if( OrderSymbol() != Symbol()) continue;
         if( OrderType() != order_mode) continue;
         
         Order_Total=Order_Total+1;
         }
         }  
 //Alert(Order_Total);
//ArrayResize(order_prc_ticket,OrdersTotal(),5);
ArrayResize(order_prc_ticket,Order_Total,5);
///Comment("Complate(d):",order_close_complate," Min Order:",min_total_order," Order Total:",Order_Total);
//ObjectsDeleteAll();

 string WCOMMMENT="Complate(d):"+order_close_complate+" , Min Order:"+min_total_order+" Order Total:"+Order_Total;
 
  ObjectSetString(currChart,"ButonWCOMMMENT",OBJPROP_TEXT,WCOMMMENT);

}
  
  
  
void RiskManagement()
  {
//---
     if (Orders!=OrdersTotal()) AlertOrder();
     Orders=OrdersTotal();
         
         //Comment("Complate(d):",order_close_complate," Min Order:",min_total_order," Order Mode:",order_mode," Min Close Profit:",min_profit,"$ Order Total:",Order_Total);
   
   string order_modes="";
   if ( order_mode == OP_SELL ) order_modes="SELL";
   if ( order_mode == OP_BUY ) order_modes="BUY";
   
        
   //string WCOMMMENT="Complate(d):"+order_close_complate+" , Min Order:"+min_total_order+" Order Mode:"+order_modes+" Min Close Profit:"+min_profit+"$ Order Total:"+Order_Total;
   string WCOMMMENT="Complate:"+order_close_complate+", Order:"+min_total_order+" Mode:"+order_modes+", Profit:"+min_profit+"$ Total:"+Order_Total;
  ObjectSetString(currChart,"ButonWCOMMMENT",OBJPROP_TEXT,WCOMMMENT);
      
         
         
   
   if ( Order_Total >= min_total_order ) {
   
   //Print("Selam",OrdersTotal(),"/");
   
       int indexo=-1;
 
   for(int index=0;index<=OrdersTotal()-1;index++)   
     {
     //Print(index);
     
      if(OrderSelect(index,SELECT_BY_POS,MODE_TRADES))
        {
         int typ   = OrderType();
         
         if( OrderSymbol() != Symbol()) continue;
         if( OrderType() != order_mode) continue;
         
         indexo=indexo+1;
         //Order_Total=Order_Total+1;
         //Print(index,"/",OrderTicket());
         
         /*profits[index]=OrderProfit();
         tickets[index]=OrderTicket();
         lots[index]=OrderLots();
         closeprc[index]=OrderClosePrice();
         openprc[index]=OrderOpenPrice();*/
         order_prc_ticket[indexo,0]=OrderOpenPrice();
         order_prc_ticket[indexo,1]=OrderTicket();
         order_prc_ticket[indexo,2]=OrderProfit();
         order_prc_ticket[indexo,3]=OrderLots();
         order_prc_ticket[indexo,4]=OrderClosePrice();
         
  string name="TXOrder"+OrderTicket();
  ObjectCreate(0,name,OBJ_TEXT,0,OrderOpenTime(),OrderOpenPrice());
  ObjectSetString(0,name,OBJPROP_TEXT,index);
  ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_CENTER);  
  ObjectSetDouble(0,name,OBJPROP_SCALE,true); 
  ObjectSetString(0,name,OBJPROP_FONT,"Arial");
  ObjectSetInteger(0,name,OBJPROP_FONTSIZE,8);
  ObjectSetInteger(0,name,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTABLE,0);  
  ObjectSetInteger(ChartID(),name,OBJPROP_SELECTED,0);         
         
         }
         }
   
   /*double profitw=profits[0]+profits[1];
   if ( profitw > min_profit && order_close_complate == false) {
   OrderClose(tickets[0],lots[0],closeprc[0],50,clrRed);
   OrderClose(tickets[1],lots[1],closeprc[1],50,clrRed);
   order_close_complate=true;
   }*/

   
   if ( order_mode == OP_SELL ) ArraySort(order_prc_ticket,WHOLE_ARRAY,0,MODE_ASCEND);
   if ( order_mode == OP_BUY ) ArraySort(order_prc_ticket,WHOLE_ARRAY,0,MODE_DESCEND);
   
   double profitw=order_prc_ticket[0,2]+order_prc_ticket[1,2];
   if ( profitw > min_profit && order_close_complate == false) {
   OrderClose(int(order_prc_ticket[0,1]),order_prc_ticket[0,3],order_prc_ticket[0,4],50,clrRed);
   OrderClose(int(order_prc_ticket[1,1]),order_prc_ticket[1,3],order_prc_ticket[1,4],50,clrRed);
   order_close_complate=true;
   Print("ticket",int(order_prc_ticket[0,1]));
   }
   
   
//   CloseTrades("SELL","LIVE");
   profitw=NormalizeDouble(profitw,2);
   //Comment(profitw," Complate:",order_close_complate);
   Comment(profitw,"Complate(d):",order_close_complate," Min Order:",min_total_order," Order Mode:",order_mode," Min Close Profit:",min_profit,"$ Order Total:",Order_Total);
   }
   
   
  }  
  
  
  


int OrderCommetb(string cmt){

int com = 0;


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

  
   if ( type == OP_BUYLIMIT || type == OP_BUYSTOP || type == OP_SELLLIMIT || type == OP_SELLSTOP ) {
   
int index=StringFind(OrderComment(), cmt, 0);

if(index!=-1 && OrderSymbol() == Symbol()){com++;};
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){com++;};
 
 }
 }
return com;
};

///////////////////////////////////////////////
// Symbol Bekleyen Emir
///////////////////////////////////////////////
int OrderCommetbs(string cmt,string sym){

int com = 0;


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

  
   if ( type == OP_BUYLIMIT || type == OP_BUYSTOP || type == OP_SELLLIMIT || type == OP_SELLSTOP ) {
   
//int index=StringFind(OrderComment(), cmt, 0);

if ( OrderComment() == cmt && sym == OrderSymbol() ) com= 1;


/*
if(index!=-1 && (OrderSymbol() == sym || sym == "*") ){com++;};
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){com++;};
*/
 
 }
 }
return com;
};



/*
//////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
string OrderCommetbs(){

string coms = 0;


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

  
   if ( type == OP_BUYLIMIT || type == OP_BUYSTOP || type == OP_SELLLIMIT || type == OP_SELLSTOP ) {
   
   coms = coms + comments + ",";

 }
 }
return coms;
};*/

//////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
int OrderCommetlive(string cmt,string sym){

int coms = 0;



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

   if ( comments == cmt && OrderSymbol() == sym && (type == OP_BUY || type == OP_SELL) ) {
   
   coms = coms +1;

 }
 }
 
 //Print("Live:",coms);
 
return coms;
};



//////////////////////////////////////////////
// Fe5 TP'sini Fe236'nın Tp'si Yapar
///////////////////////////////////////////////
void FeBrainChangeSL(string cmt,double sl,string sym){

//int coms = 0;

//Alert(cmt);

         //string ord = comments;
      int replacedz = StringReplace(cmt," FE 6","Fe5");
          replacedz += StringReplace(cmt," FE 7","Fe5");
          replacedz += StringReplace(cmt," FE 8","Fe5");
          replacedz += StringReplace(cmt," FE 5.5","Fe5");
          replacedz += StringReplace(cmt," ARZ","");
      

  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
    int index=StringFind(OrderComment(), cmt, 0);
//comments == cmt
   if ( index != -1  && OrderSymbol() == sym ) {
   
   if ( OrderStopLoss() != sl ) OrderModify(OrderTicket(),OrderOpenPrice(),sl,OrderTakeProfit(),0,clrNONE);

 }
 }
 
 //Print("Live:",coms);
 
//return coms;
};

//////////////////////////////////////////////
// Fe5 TP'sini Fe236'nın Tp'si Yapar
///////////////////////////////////////////////
void FeBrainChangeTPLine(string cmt,double tp,string sym){

//int coms = 0;


//return;

         //string ord = comments;
      int replacedz = StringReplace(cmt," FE 4.236","Fe5");          
          replacedz += StringReplace(cmt," FE 4.5","Fe5");
          replacedz += StringReplace(cmt," FE 4.736","Fe5");
          replacedz += StringReplace(cmt," FE 4","Fe5");
          replacedz += StringReplace(cmt," ARZ","");
          
         //Alert(cmt,"/",tp); 
      

  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
    int index=StringFind(OrderComment(), cmt, 0);
//comments == cmt
   if ( index != -1  && OrderSymbol() == sym ) {
   
   if ( OrderTakeProfit() != tp ) OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),tp,0,clrNONE);

 }
 }
 
 //Print("Live:",coms);
 
//return coms;
};










//////////////////////////////////////////////
// Fe5 TP'sini Fe236'nın Tp'si Yapar
///////////////////////////////////////////////
void FeBrainChangeTP(string cmt,double tp,string sym){

//int coms = 0;



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();



   if ( comments == cmt && OrderSymbol() == sym && (type == OP_BUY || type == OP_SELL) ) {
   
   if ( OrderTakeProfit() != tp ) OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),tp,0,clrNONE);

 }
 }
 
 //Print("Live:",coms);
 
//return coms;
};


//////////////////////////////////////////////
// Fe5 TP'sini Fe236'nın Tp'si Yapar Bekleyen
///////////////////////////////////////////////
void FeBrainChangePendingTP(string cmt,double tp,string sym){

//int coms = 0;



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();

   if ( comments == cmt && OrderSymbol() == sym && (type == OP_BUYLIMIT || type == OP_SELLLIMIT) ) {
   
//return;
   if ( OrderTakeProfit() != tp ) {OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),tp,0,clrNONE);
   //Print(cmt,"/",tp);
   }

 }
 }
 
 //Print("Live:",coms);
 
//return coms;
};




//////////////////////////////////////////////
// Fe5 TP'sini Fe236'nın Tp'si Yapar
///////////////////////////////////////////////
int FeBrainGetTicket(string cmt,string sym){

//int coms = 0;

int ticket=-1;

  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();



   if ( comments == cmt && OrderSymbol() == sym  ) {
   
   ticket=OrderTicket();

 }
 }
 
 
 //Print("Live:",coms);
 
return ticket;
};







///////////////////////////////////////////////
// FeBrain
///////////////////////////////////////////////
string brmodify_list="|";

void FeBrain(){

//Print(TerminalInfoInteger(TERMINAL_TRADE_ALLOWED));

if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 0 ) return;

   if (!IsTradeAllowed()) return;
   
/////////////////////////////////////////////////////////////////////////////////////////////////////////   
// Manuel Trade Break Even Strategy
/////////////////////////////////////////////////////////////////////////////////////////////////////////
bool ManuelTraderBreakEven=true;

if ( ManuelTraderBreakEven) {

double fe2brprc=-1;
double fe3brprc=-1;
double fe6brprc=-1;
double fe4brprc=-1;
double fe618brprc=-1;
datetime febrtime=-1;

double febrprc1=-1;
double febrprc2=-1;
string febrline="";

      long currChart=0,prevChart=ChartFirst();
   int i=-1,limit=100;
//   Print("ChartFirst =",ChartSymbol(prevChart)," ID =",prevChart);

   while(i<limit)// We have certainly not more than 100 open charts
     {
      if ( i > 0 ) currChart=ChartNext(prevChart); // Get the new chart ID by using the previous chart ID

      if(currChart<0) break; 
      
      //Print(ChartSymbol(currChart),"/",ChartID());

      
fe2brprc=-1;
fe3brprc=-1;
fe6brprc=-1;
fe4brprc=-1;
fe618brprc=-1;


             //int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(currChart,0);i>=0;i--)
        {
        string name = ObjectName(currChart,i);
        
  int index4 = StringFind(name,"FE 4 ARZ", 0); 
  
  int indext = StringFind(name,"Text", 0); 
  
  if ( index4 != -1 && indext == -1 ) {
  febrline=name;
  int replacedz = StringReplace(febrline," FE 4 ARZ","");
  
  
  febrprc1=ObjectGetDouble(currChart,febrline,OBJPROP_PRICE1);
  febrprc2=ObjectGetDouble(currChart,febrline,OBJPROP_PRICE2);
  //Alert(febrline,"/",febrprc1,"/",febrprc2);
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
  fe4brprc=ObjectGetDouble(currChart,name,OBJPROP_PRICE);
  
   }  
   
   
   
   
  int index3 = StringFind(name,"FE 3.0", 0); 
  
  // 
  if ( index3 != -1 && indext == -1 ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
  fe3brprc=ObjectGetDouble(currChart,name,OBJPROP_PRICE1);
  //Alert(name,"/",febrprc);
  
   }  
   
  int index2 = StringFind(name,"FE 2.0", 0); 
  
  // 
  if ( index2 != -1 && indext == -1 ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
  fe2brprc=ObjectGetDouble(currChart,name,OBJPROP_PRICE1);
  //Alert(name,"/",febrprc);
  
   }  
   
   
      
   
   
   int index6 = StringFind(name,"FE 6", 0);    
   
  if ( index6 != -1 && indext == -1 ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
  fe6brprc=ObjectGetDouble(currChart,name,OBJPROP_PRICE1);
  //Alert(name,"/",fe6brprc);
  
   } 
   
  
  int index618 = StringFind(name,"FE 61.8", 0);  
   
  if ( index618 != -1 && indext == -1 && ChartSymbol(currChart)=="GBPUSD") {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
  fe618brprc=ObjectGetDouble(currChart,name,OBJPROP_PRICE1);
  
  
   }  
   
      
   

   
  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
    
 
  for(int ic=0;ic<=OrdersTotal()-1;ic++)
  {
    OrderSelect(ic, SELECT_BY_POS);
    
    if ( ChartSymbol(currChart) == OrderSymbol() && OrderComment() == "" ) {
    
    //Print("OrderTicket",OrderTicket(),febrprc);
    
  int indexmodify = StringFind(brmodify_list,OrderTicket(), 0);  
    
  if ( fe3brprc != -1 && indexmodify == -1 ) {  
  
   double vbid    = MarketInfo(OrderSymbol(),MODE_BID);
   double vask    = MarketInfo(OrderSymbol(),MODE_ASK);
  
  
  //Alert(fe6brprc,"/",OrderSymbol(),"/",fe3brprc,"/",OrderClosePrice(),"/",OrderProfit());
  if ( febrprc1 > febrprc2 &&
  OrderOpenPrice() > fe2brprc && // Açılış fiyatı 2 den büyük
  OrderOpenPrice() < febrprc1 && // 1 in altında açıldıysa
  OrderClosePrice() <= fe3brprc && // 3 ün altına geçiyse
  fe6brprc < vbid && // bid 6 nin üstündeyse
  OrderClosePrice() > fe6brprc && 
  OrderProfit() > 0 && OrderType() == OP_SELL && OrderStopLoss() != OrderOpenPrice() ) {  
  OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,clrNONE);
  brmodify_list=brmodify_list+OrderTicket()+"|";
  }
  
  if ( febrprc1 < febrprc2 &&
  OrderOpenPrice() < fe2brprc && // 2 den küçük
  OrderOpenPrice() > febrprc1 && // 1 den büyük
  OrderClosePrice() >= fe3brprc && // 3 ün üstüne geçiyse
  fe6brprc > vbid && // bid 6 nin altındaysa
  OrderClosePrice() < fe6brprc && 
  OrderProfit() > 0 && OrderType() == OP_BUY && OrderStopLoss() != OrderOpenPrice() ) {
  //Alert("Evet",fe6brprc);
  OrderModify(OrderTicket(),OrderOpenPrice(),OrderOpenPrice(),OrderTakeProfit(),0,clrNONE);
  brmodify_list=brmodify_list+OrderTicket()+"|";
  }
  }  
    
    
    }
    
    
    }      
      
      
      
      prevChart=currChart;// let's save the current chart ID for the ChartNext()
      i++;// Do not forget to increase the counter      
      
      }   
      
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   



//Print("FeBrain");

//int com = 0;


  int totali = OrdersTotal();
  for(int ii=0;ii<=OrdersTotal()-1;ii++)
  {
    OrderSelect(ii, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    int Order_Ticket=OrderTicket();
    string Order_Sym = OrderSymbol();
    double Order_Profit = OrderProfit();
    double Order_TakeProfit = OrderTakeProfit();
    double Order_StopLoss = OrderStopLoss();
    double Order_OpenPrice = OrderOpenPrice();
    double Order_ClosePrice = OrderClosePrice();
string cmt="Fe5236-"+OrderSymbol();
int index=StringFind(OrderComment(), cmt, 0);

int gecen_sure=TimeCurrent()-OrderOpenTime();
double tp=OrderTakeProfit();
//if ( index != -1 ) Print(OrderTakeProfit());

//Print(gecen_sure);

         string ord = comments;
      int replacedz = StringReplace(ord,"Fe5236","Fe5");
      
      //Print("Ord:",ord,"/",OrderCommetbs(ord,Symbol()));
      //
      
      
      
      
////////////////////////////////////////////////////////////////////////////      
   string sym_line="";
   string sym="";
   
   //if ( sym_periyod == "" ) {  
   string sep="-";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(comments,u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   sym_line = results[0];
   sym = results[1];   
   }
   //}
       
   //Print(sym,"/",sym_line);  
///////////////////////////////////////////////////////////////////////////   


int indexFe5236=StringFind(OrderComment(), "Fe5236-", 0);

//,"/",OrderCommetbs(ord,OrderSymbol())

bool Order_Find = false;
int Order_Type = -1;
bool Order_Open = false;
int OrderNum = -1;
double OrderOpen;
double OrderSL;
string OrderSym;
double OrderTP;
double OrderProfits;
double OrderClosePrc;

if ( indexFe5236 != -1 ) {


if ( type == OP_BUY || type == OP_SELL ) {
//Print("Evet",comments);
Order_Open=true; // Order Live
}




         string ord = OrderComment();
      int replacedz = StringReplace(ord,"Fe5236","Fe5");
      
      //Print(indexFe5236,OrderComment(),"/",ord,OrderType());
     
      //Print(ii,"/",OrderComment(),"/",indexFe5236,"/",OrdersTotal(),"/",OrderTicket(),"/",ord);
      


  int totalii = OrdersTotal();
  
  //Alert(OrdersTotal());
  
  for(int iii=0;iii<=OrdersTotal()-1;iii++)
  {
    OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    
    /*if ( Symbol() == OrderSymbol() ) {
    
    //Print(OrderTicket(),"/",ObjectFind("Order"+OrderTicket()));
    
    string OrderLine="FeOrderSave"+OrderTicket();
    if ( ObjectFind("FeOrderSave"+OrderTicket()) == -1 ) {
    
    //int      right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
    
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }



bool tpl_files_per_find=false;
bool tpl_files_find=false;
string tpl_files=OrderTicket();
string tpl_files_time = "";

if(FileIsExist(tpl_files +"-"+Period()+"-.tpl",1)) {
    //tpl_files_find=true;
    tpl_files_per_find=true;
    } 
    

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)) {
    tpl_files_time="M1";
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M5";
    }         

    if(FileIsExist(tpl_files +"-30-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M30";
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H1";
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H4";
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"D1";
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"W1";
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"MN1";
    } 
        
    if ( tpl_files_time != "" ) tpl_files_find=true;
      
    
    //Alert(right_bound,"/",WindowFirstVisibleBar());
    
//datetime right=Time[right_bound]+Period()*60;
//shift=iBarShift(ChartSymbol(ChartID()),ChartPeriod(ChartID()),right);   
//shift = (shift+carpan)*-1;
    //datetime right=Time[right_bound]+Period()*60;
    ObjectDelete(OrderLine);
    //ObjectCreate(ChartID(),OrderLine,OBJ_TREND,0,Time[WindowFirstVisibleBar()],OrderOpenPrice(),Time[WindowFirstVisibleBar()]+5*PeriodSeconds(),OrderOpenPrice());
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_RAY_RIGHT,0);
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_WIDTH,2);
    //ObjectCreate(ChartID(),OrderLine,OBJ_HLINE,0,Time[0],OrderOpenPrice());
      datetime OrderTime=Time[WindowFirstVisibleBar()]+5*PeriodSeconds();
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
      OrderLine="FeOrderLoad"+OrderTicket();
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime+5*PeriodSeconds());        // Set time
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrAliceBlue);      
      if ( tpl_files_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGreen);
      if ( tpl_files_per_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      if ( tpl_files_find ) ObjectSetString(ChartID(),OrderLine,OBJPROP_TEXT,tpl_files_time);
      
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);

      OrderLine="FeOrderDelete"+OrderTicket();
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime+20*PeriodSeconds());        // Set time
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrBlack);
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
                           
         
         
      ChartRedraw(ChartID());  
          
    
    }
    
    }*/
    
    
    
    if ( ord == commentsi ) {
    Order_Find=true;
    Order_Type=OrderType();
    OrderNum=OrderTicket();
    OrderOpen=OrderOpenPrice();
    OrderSL=OrderStopLoss();
    OrderSym=OrderSymbol();
    OrderTP=OrderTakeProfit();
    OrderProfits=OrderProfit();
    OrderClosePrc=OrderClosePrice();
    //Order_Sym=OrderSymbol();
    //Print(ord,",",commentsi,"/",Order_Find);
    //Print(indexFe5236,OrderComment(),"/",ord);
    }
    
    
    }
    //&& Order_Sym == OrderSym
    // Fe5 Yoksa Fe5236 İptal Olucak
    if ( Order_Find == false && type > 1 ) {OrderDelete(Order_Ticket,clrNONE);
    //Order_Find=true;
    }
    // Fe5326 Açıldıysa F5 TP sini onunla eşitleyecek
    if ( Order_Find == true && type < 2 && Order_TakeProfit != OrderTP && Order_TakeProfit != 0  && Order_Sym == OrderSym ) {
    OrderModify(OrderNum,OrderOpen,OrderSL,Order_TakeProfit,0,clrNONE);
    OrderTP=Order_TakeProfit;
    }
    
    // Fe5326 SL Değiştiyse F5 SL sini onunla eşitleyecek
    if ( Order_Find == true && type < 2 && Order_StopLoss != OrderSL && Order_StopLoss != 0  && Order_Sym == OrderSym ) {
    OrderModify(OrderNum,OrderOpen,Order_StopLoss,OrderTP,0,clrNONE);
    }
    
    

  //////////////////////////////////
  // Cuma Günü
  //////////////////////////////////
  /*if ( DayOf != -1 ) {
  if(DayOfWeek()==DayOf || DayOfWeek()==0 || DayOfWeek()==6) {
  return; 
  }     
  }*/
  /*
 if ( sym == pair && 
 !MarketInfo(pair,MODE_TRADEALLOWED) 
 
 ) {
 Print("Market Kapali Pair:",pair,"Time",OrderTimeSym("BuyTrendFind",pair),"/",OrderTimeSym("SellTrendFind",pair),":",MarketInfo(pair,MODE_TRADEALLOWED));
 }
 
if ( sym == pair ){
    int trade_mode=(int)SymbolInfoInteger(pair,SYMBOL_TRADE_MODE);
   string str_trade_mode;
   switch(trade_mode)
     {
      case SYMBOL_TRADE_MODE_DISABLED: str_trade_mode="SYMBOL_TRADE_MODE_DISABLED (trade is disabled for the symbol)"; break;
      case SYMBOL_TRADE_MODE_LONGONLY: str_trade_mode="SYMBOL_TRADE_MODE_LONGONLY (only long positions are allowed)"; break;
      case SYMBOL_TRADE_MODE_SHORTONLY: str_trade_mode="SYMBOL_TRADE_MODE_SHORTONLY (only short positions are allowed)"; break;
      case SYMBOL_TRADE_MODE_CLOSEONLY: str_trade_mode="SYMBOL_TRADE_MODE_CLOSEONLY (only position close operations are allowed)"; break;
      case SYMBOL_TRADE_MODE_FULL: str_trade_mode="SYMBOL_TRADE_MODE_FULL (no trade restrictions)"; break;
     }
     
     Print("Trade Mode:",pair,str_trade_mode);
     }
 
 }
*/

    
    // İki İşlem Açıldıysa ve Fe5'de Kara geçtiyse SL seviyeleri F5236 seviyesine Breakeven yapılacak.
    if ( Order_Find == true && OrderProfits > 0 && Order_Profit > 0 && MarketInfo(OrderSym,MODE_TRADEALLOWED) != 0.0 ) {   
  
   // Mesafe Çok Yakınsa BreakEven Yapılması uygun değil  
  int BreakEvenMinPip=90;
  int BreakEvenPip=-1;

  if ( OrderOpen > Order_OpenPrice ) BreakEvenPip=(OrderOpen-Order_OpenPrice)/Point;
  if ( Order_OpenPrice > OrderOpen ) BreakEvenPip=(Order_OpenPrice-OrderOpen)/Point;
          
    //int trade_mode=(int)SymbolInfoInteger(OrderSym,SYMBOL_TRADE_MODE);
     //Print("trade_mode",trade_mode,"MarketInfo(pair,MODE_TRADEALLOWED)",MarketInfo(OrderSym,MODE_TRADEALLOWED),"/",OrderSym,"/",MarketInfo(Symbol(),MODE_TRADEALLOWED));
    // F236 Breakeven
    if ( BreakEvenPip >= BreakEvenMinPip ) {
    OrderModify(Order_Ticket,Order_OpenPrice,Order_OpenPrice,Order_TakeProfit,0,clrNONE);
    OrderModify(OrderNum,OrderOpen,Order_OpenPrice,OrderTP,0,clrNONE);    
    }
    
    }
    
    
          
      
/*      
      if ( OrderSymbol() == sym && (OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT) && gecen_sure > 5 && OrderCommetbs(ord,OrderSymbol())==0 && OrderCommetlive(ord,OrderSymbol())==0 ) {
      //int OrdTckt = FeBrainGetTicket(comments,OrderSymbol());      
      //OrderDelete(OrdTckt,clrNONE);
      Print(OrderTicket(),"/",ord,"/",sym,"/",OrderSymbol());
      }



*/
}
   
     

      
      
//////////////////////////////////////////////
/// FE5 TP olduysa ve ( Yoksa ) İptal Edildiyse F5236 İptal
/////////////////////////////////////////////
/*if ( OrdTckt == OrderTicket() && index != -1 && (OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT) && gecen_sure > 5 && OrderCommetbs(ord,OrderSymbol())==0 && OrderCommetlive(ord,OrderSymbol())==0 ) {
      Print("Silmeye Çalışıyorum",ord,"/",OrderTicket());
      OrderDelete(OrderTicket(),clrNONE);
      
      //Print(ord,"/",OrderCommetlive(ord,OrderSymbol()));
 
//if (OrderCommetbs(cmt2,Symbol())==1) 
//if ( OrderCommetlive(ord) == 0 ) 
}*/


//////////////////////////////////////////////////
// FE5236 Açıldıysa FE5 TP = FE4736
/////////////////////////////////////////////////
/*if ( index != -1 && OrderCommetlive(ord,OrderSymbol())==1 && OrderCommetlive(comments,OrderSymbol())==1 ) {
      //OrderDelete(OrderTicket(),clrNONE);
      //Print(ord,"/",OrderCommetlive(ord));
FeBrainChangeTP(ord,tp,OrderSymbol());
//if (OrderCommetbs(cmt2,Symbol())==1) 
//if ( OrderCommetlive(ord) == 0 ) 

}*/
/*
if ( index != -1 && (OrderType() == OP_BUY || OrderType() == OP_SELL) && OrderCommetlive(ord,OrderSymbol())==1 && OrderCommetlive(comments,OrderSymbol())==1) {
      //OrderDelete(OrderTicket(),clrNONE);
      //Print(ord,"/",OrderCommetlive(ord));
FeBrainChangeTP(ord,tp,OrderSymbol());
//if (OrderCommetbs(cmt2,Symbol())==1) 
//if ( OrderCommetlive(ord) == 0 ) 

}*/




/*
if ( index != -1 && (OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT) && gecen_sure > 5 && OrderCommetbs(ord,Symbol())==1 ) {

//Print(ord,"/",OrderCommetbs(ord,Symbol()),"/",gecen_sure);
      //OrderDelete(OrderTicket(),clrNONE);
      //Print(ord,"/",OrderCommetlive(ord));
FeBrainChangePendingTP(ord,tp,OrderSymbol());
//if (OrderCommetbs(cmt2,Symbol())==1) 
//if ( OrderCommetlive(ord) == 0 ) 

}*/






      

//Print(comments);


  
   /*if ( type == OP_BUYLIMIT || type == OP_BUYSTOP || type == OP_SELLLIMIT || type == OP_SELLSTOP ) {
   


if(index!=-1 && (OrderSymbol() == sym || sym == "*") ){com++;};
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){com++;};
 
 }
 
 
 //}
//return com;
*/
}









};




void FeAnaliz() {



  int totalii = OrdersTotal();
  
  //Alert(OrdersTotal());
  
  for(int iii=0;iii<=OrdersTotal()-1;iii++)
  {
    OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    
    if ( Symbol() == OrderSymbol() ) {
    
    //Print(OrderTicket(),"/",ObjectFind("Order"+OrderTicket()));
    
    string OrderLine="FeOrderSave"+OrderTicket();
    if ( ObjectFind("FeOrderSave"+OrderTicket()) == -1 ) {
    
    //int      right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
    
  datetime left;
  int      right_bound;
  if ( WindowFirstVisibleBar() > -1 ) {
  //left=Time[WindowFirstVisibleBar()];
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();}
  else{
  //left=TimeCurrent();
  right_bound=WindowFirstVisibleBar()-WindowBarsPerChart();
  }



bool tpl_files_per_find=false;
bool tpl_files_find=false;
string tpl_files=OrderTicket();
string tpl_files_time = "";

if(FileIsExist(tpl_files +"-"+Period()+"-.tpl",1)) {
    //tpl_files_find=true;
    tpl_files_per_find=true;
    } 
    

//Alert("Delete",tpl_files);
    
    if(FileIsExist(tpl_files +"-1-.tpl",1)) {
    tpl_files_time="M1";
    } 
        
    if(FileIsExist(tpl_files +"-5-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M5";
    }         
    
    if(FileIsExist(tpl_files +"-15-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M15";
    }         

    if(FileIsExist(tpl_files +"-30-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"M30";
    }     
        
    if(FileIsExist(tpl_files +"-60-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H1";
    }     
    
    if(FileIsExist(tpl_files +"-240-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"H4";
    } 
    
    if(FileIsExist(tpl_files +"-1440-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"D1";
    } 

    if(FileIsExist(tpl_files +"-10080-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"W1";
    } 

    if(FileIsExist(tpl_files +"-43200-.tpl",1)) {
    if ( tpl_files_time != "" ) tpl_files_time=tpl_files_time+" ";
    tpl_files_time=tpl_files_time+"MN1";
    } 
        
    if ( tpl_files_time != "" ) tpl_files_find=true;
      
    
    //Alert(right_bound,"/",WindowFirstVisibleBar());
    
//datetime right=Time[right_bound]+Period()*60;
//shift=iBarShift(ChartSymbol(ChartID()),ChartPeriod(ChartID()),right);   
//shift = (shift+carpan)*-1;
    //datetime right=Time[right_bound]+Period()*60;
    ObjectDelete(OrderLine);
    //ObjectCreate(ChartID(),OrderLine,OBJ_TREND,0,Time[WindowFirstVisibleBar()],OrderOpenPrice(),Time[WindowFirstVisibleBar()]+5*PeriodSeconds(),OrderOpenPrice());
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_RAY_RIGHT,0);
    //ObjectSetInteger(ChartID(),OrderLine,OBJPROP_WIDTH,2);
    //ObjectCreate(ChartID(),OrderLine,OBJ_HLINE,0,Time[0],OrderOpenPrice());
      datetime OrderTime=Time[WindowFirstVisibleBar()-5];//*PeriodSeconds();
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,OrderTime,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
      OrderLine="FeOrderLoad"+OrderTicket();
      OrderTime=Time[WindowFirstVisibleBar()-20];//*PeriodSeconds();
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime); //       // Set time+20*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrAliceBlue);      
      if ( tpl_files_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrDarkGreen);
      if ( tpl_files_per_find ) ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrLimeGreen);
      if ( tpl_files_find ) ObjectSetString(ChartID(),OrderLine,OBJPROP_TEXT,tpl_files_time);
      
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);

      OrderLine="FeOrderDelete"+OrderTicket();
      OrderTime=Time[WindowFirstVisibleBar()-40];//*PeriodSeconds();
      ObjectCreate(ChartID(),OrderLine,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_TIME,OrderTime);        // Set time+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),OrderLine,OBJPROP_PRICE,OrderOpenPrice());// Set price
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_FONTSIZE,8); 
      ObjectSetInteger(ChartID(),OrderLine,OBJPROP_COLOR,clrBlack);
         //ObjectSetInteger(0,name,OBJPROP_ANCHOR,ANCHOR_UPPER);
         
                           
         
         
      ChartRedraw(ChartID());  
          
    
    }
    
    }
    
    
    
  
    
    
    }

}


bool brohighline=false;
bool brolowline=false;
bool Fe3Order=false;
string Fe3OrderLine="";

void Fe3Strategy(string sparam) {

string febrline="";
double febrprc1=-1;
double febrprc2=-1;

double fe2brprc=-1;
double fe3brprc=-1;
double fe6brprc=-1;
double fe4brprc=-1;
double fe618brprc=-1;
datetime febrtime=-1;

int indext = StringFind(sparam,"Text", 0); 

if ( indext != -1 ) return;

//////////////////////////////////////////////////////////////////////////////////////////
string sparams=sparam;


int indexofbrohigh = StringFind(sparams," BroHigh", 0);
int indexofbrolow = StringFind(sparams," BroLow", 0);
int indexofbro5 = StringFind(sparams," Bro50", 0);
int indexofbro618 = StringFind(sparams," Bro61.8", 0);
int indexofbro666 = StringFind(sparams," Bro66.6", 0);
 
int replaced=StringReplace(sparams," BroHigh","");
    replaced+=StringReplace(sparams," BroLow","");

if ( (indexofbrohigh != -1 || indexofbrolow != -1 ) && indexofbro5 == -1 && indexofbro618 == -1 && indexofbro666 == -1 && FeBrainSystem) {

febrline=sparams;

ObjectDelete(febrline+" Bro50");
ObjectDelete(febrline+" Bro61.8");
ObjectDelete(febrline+" Bro66.6");
ObjectDelete(febrline+" Bro70.7");
ObjectDelete(febrline+" Bro76.4");
ObjectDelete(febrline+" Bro11.8");

//Print(febrline);

  febrline=sparams;
  febrprc1=ObjectGetDouble(currChart,febrline,OBJPROP_PRICE1);
  febrprc2=ObjectGetDouble(currChart,febrline,OBJPROP_PRICE2);

  double brohigh=ObjectGetDouble(ChartID(),febrline+" BroHigh",OBJPROP_PRICE);
  double brolow=ObjectGetDouble(ChartID(),febrline+" BroLow",OBJPROP_PRICE);
   

if ( febrprc1 < febrprc2 ) {

//Alert("Selam");
///double FeFibo666Price=brohigh-(brohigh-brolow)/1.50;
///double FeFibo666Price=brohigh-(brohigh-brolow)/1.666;
double FeFibo618Price=brohigh-(brohigh-brolow)/1.618;
double FeFibo50Price=brohigh-(((brohigh-brolow)/100)*50);
double FeFibo666Price=brohigh-(((brohigh-brolow)/100)*66.6);
/*double FeFibo118Price=brohigh-(brohigh-brolow)/1.118;
double FeFibo707Price=brohigh-(brohigh-brolow)/1.707;
double FeFibo764Price=brohigh-(brohigh-brolow)/1.764;*/
/*double FeFibo118Price=brohigh-(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brohigh-(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brohigh-(((brohigh-brolow)/100)*29.3);*/
double FeFibo118Price=brolow+(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brolow+(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brolow+(((brohigh-brolow)/100)*29.3);





FeFibo50Price=NormalizeDouble(FeFibo50Price,Digits);
FeFibo618Price=NormalizeDouble(FeFibo618Price,Digits);
FeFibo666Price=NormalizeDouble(FeFibo666Price,Digits);
FeFibo118Price=NormalizeDouble(FeFibo118Price,Digits);
FeFibo707Price=NormalizeDouble(FeFibo707Price,Digits);
FeFibo764Price=NormalizeDouble(FeFibo764Price,Digits);

ObjectDelete(febrline+" Bro50");
//ObjectCreate(ChartID(),febrline+" Bro50",OBJ_TREND,0,Time[brohighshift],FeFibo50Price,Time[brolowshift],FeFibo50Price);
ObjectCreate(ChartID(),febrline+" Bro50",OBJ_HLINE,0,Time[0],FeFibo50Price);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_COLOR,clrBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro61.8");
ObjectCreate(ChartID(),febrline+" Bro61.8",OBJ_HLINE,0,Time[0],FeFibo618Price);
//ObjectCreate(ChartID(),febrline+" Bro61.8",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_COLOR,clrLimeGreen);
//ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro66.6");
ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_HLINE,0,Time[0],FeFibo666Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro11.8");
ObjectCreate(ChartID(),febrline+" Bro11.8",OBJ_HLINE,0,Time[0],FeFibo118Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro70.7");
ObjectCreate(ChartID(),febrline+" Bro70.7",OBJ_HLINE,0,Time[0],FeFibo707Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_COLOR,clrLightBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro76.4");
ObjectCreate(ChartID(),febrline+" Bro76.4",OBJ_HLINE,0,Time[0],FeFibo764Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_COLOR,clrTurquoise);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);

}
     

if ( febrprc1 > febrprc2 ) {



///double FeFibo666Price=brohigh-(brohigh-brolow)/1.50;
///double FeFibo666Price=brohigh+(brohigh-brolow)/1.50;
//double FeFibo666Price=brolow+(brohigh-brolow)/1.666;
double FeFibo618Price=brolow+(brohigh-brolow)/1.618;
double FeFibo50Price=brolow+(((brohigh-brolow)/100)*50);
double FeFibo666Price=brolow+(((brohigh-brolow)/100)*66.6);

/*double FeFibo118Price=brolow+(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brolow+(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brolow+(((brohigh-brolow)/100)*29.3);*/
//double FeFibo118Price=brolow+(brohigh-brolow)/1.118;
//double FeFibo707Price=brolow+(brohigh-brolow)/1.707;
//double FeFibo764Price=brolow+(brohigh-brolow)/1.764;

double FeFibo118Price=brohigh-(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brohigh-(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brohigh-(((brohigh-brolow)/100)*29.3);




FeFibo50Price=NormalizeDouble(FeFibo50Price,Digits);
FeFibo618Price=NormalizeDouble(FeFibo618Price,Digits);
FeFibo666Price=NormalizeDouble(FeFibo666Price,Digits);
FeFibo118Price=NormalizeDouble(FeFibo118Price,Digits);
FeFibo707Price=NormalizeDouble(FeFibo707Price,Digits);
FeFibo764Price=NormalizeDouble(FeFibo764Price,Digits);

ObjectDelete(febrline+" Bro50");
//ObjectCreate(ChartID(),febrline+" BroHigh50",OBJ_TREND,0,Time[brohighshift],FeFibo50Price,Time[brolowshift],FeFibo50Price);
ObjectCreate(ChartID(),febrline+" Bro50",OBJ_HLINE,0,Time[0],FeFibo50Price);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_COLOR,clrBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro61.8");
ObjectCreate(ChartID(),febrline+" Bro61.8",OBJ_HLINE,0,Time[0],FeFibo618Price);
//ObjectCreate(ChartID(),febrline+" BroHigh61.8",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_COLOR,clrLimeGreen);
//ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro66.6");
ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_HLINE,0,Time[0],FeFibo666Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro11.8");
ObjectCreate(ChartID(),febrline+" Bro11.8",OBJ_HLINE,0,Time[0],FeFibo118Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro70.7");
ObjectCreate(ChartID(),febrline+" Bro70.7",OBJ_HLINE,0,Time[0],FeFibo707Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_COLOR,clrLightBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro76.4");
ObjectCreate(ChartID(),febrline+" Bro76.4",OBJ_HLINE,0,Time[0],FeFibo764Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_COLOR,clrTurquoise);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);


}     
     

//ObjectDelete(febrline+" BroHigh");
//ObjectDelete(febrline+" BroLow");

Fe3Order=true;
Fe3OrderLine=febrline;



return;
}




int indexoffesl200 = StringFind(sparams," FE SL 200", 0);

 
    replaced=StringReplace(sparams," FE 3.0","");
    replaced+=StringReplace(sparams," FE SL 200","");

if ( indexoffesl200 != -1 && FeBrainSystem) {

{
//Alert("Sparam İşlem Kapa",sparams);

  int totalii = OrdersTotal();
  for(int iii=0;iii<=OrdersTotal()-1;iii++)
  {
    OrderSelect(iii, SELECT_BY_POS);
           int typei = OrderType();
    string commentsi = OrderComment();
    
    int indexdel = StringFind(commentsi,sparams, 0); 
    int indexde3 = StringFind(commentsi,sparams+"Fe3-", 0); 
    int indexde2 = StringFind(commentsi,sparams+"Fe2-", 0); 
    int indexde25 = StringFind(commentsi,sparams+"Fe25-", 0); 
    int indexde1168 = StringFind(commentsi,sparams+"Fe1168-", 0); 
    int indexdef50 = StringFind(commentsi,sparams+"FeFibo50-", 0); 
    int indexdef618 = StringFind(commentsi,sparams+"FeFibo618-", 0); 
    int indexdef666 = StringFind(commentsi,sparams+"FeFibo666-", 0); 
    
    
    
    //indexdel != -1
    if ( indexde3 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }
    if ( indexde2 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }
    if ( indexde1168 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }    
    if ( indexde25 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }        
    if ( indexdef50 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }      
    if ( indexdef618 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }  
    if ( indexdef666 != -1 && OrderType() > 1 ) {
    OrderDelete(OrderTicket(),clrNONE);
    }      
        
    
    
    }
    return;
}



return;

}
//////////////////////////////////////////////////////////////////////////////////////////////////


//int indexoffe275 = StringFind(sparam," FE 2.75", 0); 

  
  //if ( ObjectGetInteger(ChartID(),sparams,OBJPROP_TYPE) != OBJ_TRIANGLE ) return;

  if ( indexofbro5 != -1 || indexofbro618 != -1 || indexofbro666 != -1 ) return;


  febrline=sparams;
  //int replacedz = StringReplace(febrline," FE 4 ARZ","");

  febrprc1=ObjectGetDouble(currChart,febrline,OBJPROP_PRICE1);
  febrprc2=ObjectGetDouble(currChart,febrline,OBJPROP_PRICE2);
  
  fe4brprc=ObjectGetDouble(currChart,sparam,OBJPROP_PRICE);
  
  ////////////////////////////////////////////////////////////////////////////////////
  // Başka bir line seçildiyse işlem açma yetkisini iptal ediyoruz.
  ////////////////////////////////////////////////////////////////////////////////////
  if ( Fe3OrderLine != "" ) {
  
  if ( Fe3OrderLine != sparams ) {
  
  Fe3Order=false;
  
  }
  
  }
  //////////////////////////////////////////////////////////////////////////////
  
  


    

  
if ( ChartGetInteger(currChart,CHART_AUTOSCROLL) ) {
  price_shf=0;
  Price_Close=Close[price_shf];
  Price_Open=Open[price_shf];
  Price_High=High[price_shf];
  Price_Low=Low[price_shf];
  Price_Time=Time[price_shf]; 
  } else {
  price_shf=WindowFirstVisibleBar()-WindowBarsPerChart();
  if ( price_shf > -1 ) {
  ObjectSetDouble(ChartID(),"PriceLine",OBJPROP_PRICE,Close[price_shf]);
  Price_Close=Close[price_shf];
  Price_Open=Open[price_shf];
  Price_High=High[price_shf];
  Price_Low=Low[price_shf];
  Price_Time=Time[price_shf];
  } else {
  price_shf=1;
  Price_Close=Close[price_shf];
  Price_Open=Open[price_shf];
  Price_High=High[price_shf];
  Price_Low=Low[price_shf];
  Price_Time=Time[price_shf];  
  }
  }    

//Comment(price_shf);  
  
  
  
  
//Alert(febrline,"/",febrprc1,"/",febrprc2,"/",price_shf);
//Alert("sparams",sparams);

//if ( febrprc1 < febrprc2 ) {

int bro=0;
int brolimit=200;
double brohigh=High[price_shf];
double brolow=Low[price_shf];
double brosure=5;
int brohighsure=0;
int brolowsure=0;
int brohighshift = 0;
int brolowshift = 0;


/////////////////////////////////////////////////////////////////////////
// İlk çizim için
/////////////////////////////////////////////////////////////////////////
//brohighline == false && brolowline == false && 
if ( ObjectFind(febrline+" BroHigh") == -1 && ObjectFind(febrline+" BroLow") == -1 ) {

//Alert(febrline,"/",febrprc1,"/",febrprc2,"/",price_shf);



ObjectDelete(ChartID(),febrline+" BroStart");
ObjectCreate(ChartID(),febrline+" BroStart",OBJ_VLINE,0,Time[price_shf],Ask);
ObjectDelete(ChartID(),febrline+" BroFinish");
ObjectCreate(ChartID(),febrline+" BroFinish",OBJ_VLINE,0,Time[price_shf+brolimit],Ask);

//Alert(price_shf,"/",price_shf+brolimit);

//for (int bro=0;bro<=brolimit;bro++){
//for (int bro=price_shf;price_shf+bro<=price_shf+brolimit;bro++){
for (int bro=price_shf;bro<=price_shf+brolimit;bro++){
//Print(bro);


if ( brohigh < High[bro] && brohighsure < brosure) {
brohigh=High[bro];
brohighsure=0;
brohighshift=bro;
} else {
brohighsure=brohighsure+1;
}

if ( brolow > Low[bro] && brolowsure < brosure ) {
brolow=Low[bro];
brolowsure=0;
brolowshift=bro;
} else {
brolowsure=brolowsure+1;
}


//Alert(brohighsure,"/",brosure,"/",brolowsure);


if ( brohighsure < brosure ) {
ObjectDelete(febrline+" BroHigh");
ObjectCreate(ChartID(),febrline+" BroHigh",OBJ_HLINE,0,Time[0],brohigh);
ObjectSetInteger(ChartID(),febrline+" BroHigh",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" BroHigh",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),febrline+" BroHigh",OBJPROP_RAY,0);
brohighline=true;
}

if ( brolowsure < brosure ) {
ObjectDelete(febrline+" BroLow");
ObjectCreate(ChartID(),febrline+" BroLow",OBJ_HLINE,0,Time[0],brolow);
ObjectSetInteger(ChartID(),febrline+" BroLow",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" BroLow",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),febrline+" BroLow",OBJPROP_RAY,0);
brolowline=true;
}

}
}

/////////////////////////////////////////////////////////////////////////
// Çizildikten sonra yapılan değişiklikleri okumak için
/////////////////////////////////////////////////////////////////////////
//if ( brohighline == true && brolowline == true ) {
if ( ObjectFind(febrline+" BroHigh") != -1 && ObjectFind(febrline+" BroLow") != -1 ) {
brohigh=ObjectGetDouble(ChartID(),febrline+" BroHigh",OBJPROP_PRICE);
brolow=ObjectGetDouble(ChartID(),febrline+" BroLow",OBJPROP_PRICE);
}



//Alert("Buy");

//}



//return;




/*
if ( indexoffe225 != -1 ) {
//Alert("Sparam İşlem Aç",sparams);
//return;
}
//return;*/

//replaced=+StringReplace(sparams," FE 2.75","");



//ObjectFind(sparams + " FE 3.0") != -1 && && indexoffe225 != -1

if ( FeBrainSystem  ) {


if ( TerminalInfoInteger(TERMINAL_TRADE_ALLOWED) == 0 ) return;

if (!IsTradeAllowed()) return;
   

FeLot=Lot;

//Alert("Selam");

string Fe3=sparams + " FE 3.0";
double Fe3Price=ObjectGetDouble(ChartID(),Fe3,OBJPROP_PRICE1);

string Fe618=sparams + " FE 61.8";
double Fe618Price=ObjectGetDouble(ChartID(),Fe618,OBJPROP_PRICE1);

string Fe25=sparams + " FE 2.5";
double Fe25Price=ObjectGetDouble(ChartID(),Fe25,OBJPROP_PRICE1);

string Fe2=sparams + " FE 2.0";
double Fe2Price=ObjectGetDouble(ChartID(),Fe2,OBJPROP_PRICE1);

string Fe1168=sparams + " FE 1.168";
double Fe1168Price=ObjectGetDouble(ChartID(),Fe1168,OBJPROP_PRICE1);

//Alert(Fe1618,"/",Fe1618Price);
//return;

string Fe5=sparams + " FE 5 ARZ";
double Fe5Price=ObjectGetDouble(ChartID(),Fe5,OBJPROP_PRICE);

string Fe5236=sparams + " FE 5.236 ARZ";
double Fe5236Price=ObjectGetDouble(ChartID(),Fe5236,OBJPROP_PRICE);

string Fe55=sparams + " FE 5.5 ARZ";
double Fe55Price=ObjectGetDouble(ChartID(),Fe55,OBJPROP_PRICE);

string Fe4=sparams + " FE 4";
double Fe4Price=ObjectGetDouble(ChartID(),Fe4,OBJPROP_PRICE1);

string Fe45=sparams + " FE 4.5";
double Fe45Price=ObjectGetDouble(ChartID(),Fe45,OBJPROP_PRICE1);

string Fe4736=sparams + " FE 4.736";
double Fe4736Price=ObjectGetDouble(ChartID(),Fe4736,OBJPROP_PRICE1);

string Fe6=sparams + " FE 6";
double Fe6Price=ObjectGetDouble(ChartID(),Fe6,OBJPROP_PRICE1);

string Fe7=sparams + " FE 7";
double Fe7Price=ObjectGetDouble(ChartID(),Fe7,OBJPROP_PRICE1);

string Fe8=sparams + " FE 8";
double Fe8Price=ObjectGetDouble(ChartID(),Fe8,OBJPROP_PRICE1);


int Spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
bool FeFark=false;

double Fe5Fark;
//Fe5FarkOran = 10;
double Fe5FarkYuzdePoint=0;
int Fe5FarkYuzdePip=0;

if ( Fe5FarkOran > 0 ) {
//if ( Fe5Price > Fe5236Price ) Fe5Fark = Fe5Price-Fe5236Price;
//if ( Fe5236Price > Fe5Price ) Fe5Fark = Fe5236Price-Fe5Price;

if ( Fe45Price > Fe5Price ) Fe5Fark = Fe45Price-Fe5Price;
if ( Fe5Price > Fe45Price ) Fe5Fark = Fe5Price-Fe45Price;




//Alert(Fe5Fark,"/",Fe5FarkOran);

double Fe5FarkYuzde=Fe5Fark/100;
Fe5FarkYuzdePoint = Fe5FarkYuzde*Fe5FarkOran;
Fe5FarkYuzdePip = Fe5FarkYuzdePoint/Point;
//Fe5Fark=true;
}

double FeSL=Fe6Price;
FeSL=Fe618Price;


if ( febrprc1 < febrprc2 ) {

//Alert("Selam");
///double FeFibo666Price=brohigh-(brohigh-brolow)/1.50;
double FeFibo666Price=brohigh-(brohigh-brolow)/1.666;
double FeFibo618Price=brohigh-(brohigh-brolow)/1.618;
double FeFibo50Price=brohigh-(((brohigh-brolow)/100)*50);
/*double FeFibo118Price=brohigh-(brohigh-brolow)/1.118;
double FeFibo707Price=brohigh-(brohigh-brolow)/1.707;
double FeFibo764Price=brohigh-(brohigh-brolow)/1.764;*/
/*double FeFibo118Price=brohigh-(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brohigh-(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brohigh-(((brohigh-brolow)/100)*29.3);*/

double FeFibo118Price=brolow+(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brolow+(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brolow+(((brohigh-brolow)/100)*29.3);



if ( ObjectFind(febrline+" Bro50") == -1 ) {


FeFibo50Price=NormalizeDouble(FeFibo50Price,Digits);
FeFibo618Price=NormalizeDouble(FeFibo618Price,Digits);
FeFibo666Price=NormalizeDouble(FeFibo666Price,Digits);
FeFibo118Price=NormalizeDouble(FeFibo118Price,Digits);
FeFibo707Price=NormalizeDouble(FeFibo707Price,Digits);
FeFibo764Price=NormalizeDouble(FeFibo764Price,Digits);

ObjectDelete(febrline+" Bro50");
//ObjectCreate(ChartID(),febrline+" Bro50",OBJ_TREND,0,Time[brohighshift],FeFibo50Price,Time[brolowshift],FeFibo50Price);
ObjectCreate(ChartID(),febrline+" Bro50",OBJ_HLINE,0,Time[0],FeFibo50Price);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_COLOR,clrBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro61.8");
ObjectCreate(ChartID(),febrline+" Bro61.8",OBJ_HLINE,0,Time[0],FeFibo618Price);
//ObjectCreate(ChartID(),febrline+" Bro61.8",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_COLOR,clrLimeGreen);
//ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro66.6");
ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_HLINE,0,Time[0],FeFibo666Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro11.8");
ObjectCreate(ChartID(),febrline+" Bro11.8",OBJ_HLINE,0,Time[0],FeFibo118Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro70.7");
ObjectCreate(ChartID(),febrline+" Bro70.7",OBJ_HLINE,0,Time[0],FeFibo707Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_COLOR,clrLightBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro76.4");
ObjectCreate(ChartID(),febrline+" Bro76.4",OBJ_HLINE,0,Time[0],FeFibo764Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_COLOR,clrTurquoise);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);
} else {

FeFibo50Price=ObjectGetDouble(ChartID(),febrline+" Bro50",OBJPROP_PRICE);
FeFibo618Price=ObjectGetDouble(ChartID(),febrline+" Bro61.8",OBJPROP_PRICE);
FeFibo666Price=ObjectGetDouble(ChartID(),febrline+" Bro66.6",OBJPROP_PRICE);
FeFibo118Price=ObjectGetDouble(ChartID(),febrline+" Bro11.8",OBJPROP_PRICE);
FeFibo707Price=ObjectGetDouble(ChartID(),febrline+" Bro70.7",OBJPROP_PRICE);
FeFibo764Price=ObjectGetDouble(ChartID(),febrline+" Bro76.4",OBJPROP_PRICE);

FeFibo50Price=NormalizeDouble(FeFibo50Price,Digits);
FeFibo618Price=NormalizeDouble(FeFibo618Price,Digits);
FeFibo666Price=NormalizeDouble(FeFibo666Price,Digits);
FeFibo118Price=NormalizeDouble(FeFibo118Price,Digits);
FeFibo707Price=NormalizeDouble(FeFibo707Price,Digits);
FeFibo764Price=NormalizeDouble(FeFibo764Price,Digits);



}


////////////////////////////////////////////////////////////
// Sperad Küçültme Ecn hesaplarda işe yaramıyor
////////////////////////////////////////////////////////////
if ( FeFark ) {
Fe5Price=Fe5Price+Spread*Point;
Fe5236Price=Fe5236Price+Spread*Point;
FeSL=FeSL-Spread*Point;
}

////////////////////////////////////////////////////////////
// Hedef Küçülme %10
////////////////////////////////////////////////////////////
if ( Fe5FarkOran > 0 ) {
/*Fe5Price=Fe5Price+Fe5FarkYuzdePip*Point;
Fe5236Price=Fe5236Price+Fe5FarkYuzdePip*Point;
Fe4736Price=Fe4736Price-Fe5FarkYuzdePip*Point;
Fe45Price=Fe45Price-Fe5FarkYuzdePip*Point;*/

Fe4Price=Fe4Price-Fe5FarkYuzdePip*Point;
Fe3Price=Fe3Price-Fe5FarkYuzdePip*Point;
Fe2Price=Fe2Price+Fe5FarkYuzdePip*Point;
Fe25Price=Fe25Price+Fe5FarkYuzdePip*Point;
Fe1168Price=Fe1168Price+Fe5FarkYuzdePip*Point;
FeSL=FeSL-Fe5FarkYuzdePip*Point;

FeFibo618Price=FeFibo618Price+Fe5FarkYuzdePip*Point;
FeFibo50Price=FeFibo50Price+Fe5FarkYuzdePip*Point;
FeFibo666Price=FeFibo666Price+Fe5FarkYuzdePip*Point;

}



//Alert("Buy");


if ( Fe3Order ) {

string cmt1=sparams + "Fe3-"+Symbol();
if (OrderCommetbs(cmt1,Symbol())==0 && OrderCommetlive(cmt1,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYSTOP,FeLot,Fe3Price,0,FeSL,Fe4Price,cmt1,0,0,clrNONE);

/*
string cmt2=sparams + "Fe2-"+Symbol();
if (OrderCommetbs(cmt2,Symbol())==0 && OrderCommetlive(cmt2,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,Fe2Price,0,FeSL,Fe4Price,cmt2,0,0,clrNONE);

string cmt3=sparams + "Fe1168-"+Symbol();
if (OrderCommetbs(cmt3,Symbol())==0 && OrderCommetlive(cmt3,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,Fe1168Price,0,FeSL,Fe4Price,cmt3,0,0,clrNONE);


string cmt4=sparams + "Fe25-"+Symbol();
if (OrderCommetbs(cmt4,Symbol())==0 && OrderCommetlive(cmt4,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,Fe25Price,0,FeSL,Fe4Price,cmt4,0,0,clrNONE);
*/
string cmt5=sparams + "FeFibo50-"+Symbol();
if (OrderCommetbs(cmt5,Symbol())==0 && OrderCommetlive(cmt5,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,FeFibo50Price,0,FeSL,Fe4Price,cmt5,0,0,clrNONE);

string cmt6=sparams + "FeFibo618-"+Symbol();
if (OrderCommetbs(cmt6,Symbol())==0 && OrderCommetlive(cmt6,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,FeFibo618Price,0,FeSL,Fe4Price,cmt6,0,0,clrNONE);

//string cmt7=sparams + "FeFibo666-"+Symbol();
//if (OrderCommetbs(cmt7,Symbol())==0 && OrderCommetlive(cmt7,Symbol())==0) int ticket=OrderSend(Symbol(),OP_BUYLIMIT,FeLot,FeFibo666Price,0,FeSL,Fe4Price,cmt7,0,0,clrNONE);

} /*else {

Fe3Order=true;
}*/




}
if ( febrprc1 > febrprc2 ) {

//double FeFibo666Price=brolow+(brohigh-brolow)/1.50;
double FeFibo666Price=brolow+(brohigh-brolow)/1.666;
double FeFibo618Price=brolow+(brohigh-brolow)/1.618;
double FeFibo50Price=brolow+(((brohigh-brolow)/100)*50);
/*double FeFibo118Price=brolow+(brohigh-brolow)/1.118;
double FeFibo707Price=brolow+(brohigh-brolow)/1.707;
double FeFibo764Price=brolow+(brohigh-brolow)/1.764;*/
/*double FeFibo118Price=brolow+(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brolow+(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brolow+(((brohigh-brolow)/100)*29.3);*/
double FeFibo118Price=brohigh-(((brohigh-brolow)/100)*88.2);
double FeFibo764Price=brohigh-(((brohigh-brolow)/100)*23.6);
double FeFibo707Price=brohigh-(((brohigh-brolow)/100)*29.3);


if ( ObjectFind(febrline+" Bro50") == -1 ) {

FeFibo50Price=NormalizeDouble(FeFibo50Price,Digits);
FeFibo618Price=NormalizeDouble(FeFibo618Price,Digits);
FeFibo666Price=NormalizeDouble(FeFibo666Price,Digits);
FeFibo118Price=NormalizeDouble(FeFibo118Price,Digits);
FeFibo707Price=NormalizeDouble(FeFibo707Price,Digits);
FeFibo764Price=NormalizeDouble(FeFibo764Price,Digits);

ObjectDelete(febrline+" Bro50");
//ObjectCreate(ChartID(),febrline+" BroHigh50",OBJ_TREND,0,Time[brohighshift],FeFibo50Price,Time[brolowshift],FeFibo50Price);
ObjectCreate(ChartID(),febrline+" Bro50",OBJ_HLINE,0,Time[0],FeFibo50Price);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_COLOR,clrBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro50",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro61.8");
ObjectCreate(ChartID(),febrline+" Bro61.8",OBJ_HLINE,0,Time[0],FeFibo618Price);
//ObjectCreate(ChartID(),febrline+" BroHigh61.8",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_COLOR,clrLimeGreen);
//ObjectSetInteger(ChartID(),febrline+" Bro61.8",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro66.6");
ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_HLINE,0,Time[0],FeFibo666Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro11.8");
ObjectCreate(ChartID(),febrline+" Bro11.8",OBJ_HLINE,0,Time[0],FeFibo118Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro11.8",OBJPROP_COLOR,clrCrimson);
//ObjectSetInteger(ChartID(),febrline+" Bro66.6",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro70.7");
ObjectCreate(ChartID(),febrline+" Bro70.7",OBJ_HLINE,0,Time[0],FeFibo707Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_COLOR,clrLightBlue);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);
ObjectDelete(febrline+" Bro76.4");
ObjectCreate(ChartID(),febrline+" Bro76.4",OBJ_HLINE,0,Time[0],FeFibo764Price);
//ObjectCreate(ChartID(),febrline+" Bro66.6",OBJ_TREND,0,Time[brohighshift],FeFibo618Price,Time[brolowshift],FeFibo618Price);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),febrline+" Bro76.4",OBJPROP_COLOR,clrTurquoise);
//ObjectSetInteger(ChartID(),febrline+" Bro70.7",OBJPROP_RAY,0);

} else {

FeFibo50Price=ObjectGetDouble(ChartID(),febrline+" Bro50",OBJPROP_PRICE);
FeFibo618Price=ObjectGetDouble(ChartID(),febrline+" Bro61.8",OBJPROP_PRICE);
FeFibo666Price=ObjectGetDouble(ChartID(),febrline+" Bro66.6",OBJPROP_PRICE);
FeFibo118Price=ObjectGetDouble(ChartID(),febrline+" Bro11.8",OBJPROP_PRICE);
FeFibo707Price=ObjectGetDouble(ChartID(),febrline+" Bro70.7",OBJPROP_PRICE);
FeFibo764Price=ObjectGetDouble(ChartID(),febrline+" Bro76.4",OBJPROP_PRICE);

FeFibo50Price=NormalizeDouble(FeFibo50Price,Digits);
FeFibo618Price=NormalizeDouble(FeFibo618Price,Digits);
FeFibo666Price=NormalizeDouble(FeFibo666Price,Digits);
FeFibo118Price=NormalizeDouble(FeFibo118Price,Digits);
FeFibo707Price=NormalizeDouble(FeFibo707Price,Digits);
FeFibo764Price=NormalizeDouble(FeFibo764Price,Digits);

}


////////////////////////////////////////////////////////////
// Sperad Küçültme Ecn hesaplarda işe yaramıyor
////////////////////////////////////////////////////////////
if ( FeFark ) {
Fe5Price=Fe5Price-Spread*Point;
Fe5Price=Fe5236Price-Spread*Point;
FeSL=FeSL+Spread*Point;
}

////////////////////////////////////////////////////////////
// Hedef Küçülme %10
////////////////////////////////////////////////////////////
if ( Fe5FarkOran > 0 ) {
/*
Fe5Price=Fe5Price-Fe5FarkYuzdePip*Point; // Tp
Fe5236Price=Fe5236Price-Fe5FarkYuzdePip*Point; // Tp
Fe4736Price=Fe4736Price+Fe5FarkYuzdePip*Point; // İşleme Giriş
Fe45Price=Fe45Price+Fe5FarkYuzdePip*Point; // İşleme Giriş*/

Fe4Price=Fe4Price+Fe5FarkYuzdePip*Point;
Fe3Price=Fe3Price+Fe5FarkYuzdePip*Point;
Fe2Price=Fe2Price-Fe5FarkYuzdePip*Point;
Fe25Price=Fe25Price-Fe5FarkYuzdePip*Point;
Fe1168Price=Fe1168Price-Fe5FarkYuzdePip*Point;
FeSL=FeSL+Fe5FarkYuzdePip*Point;

FeFibo618Price=FeFibo618Price+Fe5FarkYuzdePip*Point;
FeFibo50Price=FeFibo50Price+Fe5FarkYuzdePip*Point;
FeFibo666Price=FeFibo666Price+Fe5FarkYuzdePip*Point;

}
////////////////////////////////////////////////////////


//Alert("Sell");}

if ( Fe3Order ) {

string cmt1=sparams + "Fe3-"+Symbol();
if (OrderCommetbs(cmt1,Symbol())==0 && OrderCommetlive(cmt1,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLSTOP,FeLot,Fe3Price,0,FeSL,Fe4Price,cmt1,0,0,clrNONE);
/*
string cmt2=sparams + "Fe2-"+Symbol();
if (OrderCommetbs(cmt2,Symbol())==0 && OrderCommetlive(cmt2,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,Fe2Price,0,FeSL,Fe4Price,cmt2,0,0,clrNONE);

string cmt3=sparams + "Fe1168-"+Symbol();
if (OrderCommetbs(cmt3,Symbol())==0 && OrderCommetlive(cmt3,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,Fe1168Price,0,FeSL,Fe4Price,cmt3,0,0,clrNONE);

string cmt4=sparams + "Fe25-"+Symbol();
if (OrderCommetbs(cmt4,Symbol())==0 && OrderCommetlive(cmt4,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,Fe25Price,0,FeSL,Fe4Price,cmt4,0,0,clrNONE);
*/
string cmt5=sparams + "FeFibo50-"+Symbol();
if (OrderCommetbs(cmt5,Symbol())==0 && OrderCommetlive(cmt5,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,FeFibo50Price,0,FeSL,Fe4Price,cmt5,0,0,clrNONE);

string cmt6=sparams + "FeFibo618-"+Symbol();
if (OrderCommetbs(cmt6,Symbol())==0 && OrderCommetlive(cmt6,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,FeFibo618Price,0,FeSL,Fe4Price,cmt6,0,0,clrNONE);

//string cmt7=sparams + "FeFibo666-"+Symbol();
//if (OrderCommetbs(cmt7,Symbol())==0 && OrderCommetlive(cmt7,Symbol())==0) int ticket=OrderSend(Symbol(),OP_SELLLIMIT,FeLot,FeFibo666Price,0,FeSL,Fe4Price,cmt7,0,0,clrNONE);

} /*else {

Fe3Order=true;
}*/



}




}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


  }
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void FiboChannelx(int baslangic) {

baslangic=6;

double NumberDigit=0.001;
string Rakams = "000";


  if ( MarketInfo(Symbol(),MODE_PROFITCALCMODE) == 1 || Symbol() == "XAUUSD"
  
  // || Symbol() == ".DE30Cash"
    ) {
  
  

  
   int first_bar=ChartGetInteger(0,CHART_FIRST_VISIBLE_BAR,0);

   int center_bar = first_bar/2;  

double   top=WindowPriceMax();
  double   bottom=WindowPriceMin();
  //bottom = 1.08;
  //top = 1.28;
  //int rakam = 60;
  //baslangic = sparam;//4;
  
  
  NumberDigit=0.00001;
  

  if ( baslangic == 2 ) {
  NumberDigit=0.1;
  }
  if ( baslangic == 3 ) {
  NumberDigit=0.01;
  }  
  if ( baslangic == 4 ) {
  NumberDigit=0.001;  
  }  
  if ( baslangic == 5 ) {
  NumberDigit=0.0001;
  }  
  if ( baslangic == 6 ) {
  NumberDigit=0.00001;
  }  
  NumberDigit=1;
  
  if ( baslangic == 11 ) {
  baslangic=1;
  }
  
  
  int Rakam = StringToInteger(Rakams);
    
  int Rakams_Len = StringLen(Rakams);
  
      for (int t=bottom;t<=top;t+=NumberDigit) {
      
      string sayilar=IntegerToString(t);
      
      string t=DoubleToString(t,Digits);
      
      
      
      string yeni_fiyat = StringSubstr(sayilar,baslangic,2);
      if ( Rakam < 10 && StringLen(Rakams) == 1 ) {
      yeni_fiyat = StringSubstr(sayilar,baslangic,1);
      }
      if ( StringLen(Rakams) > 2 ) {
      yeni_fiyat = StringSubstr(sayilar,baslangic,Rakams_Len); // 0 = 11 1 = 2
      }      
      
      //Print(IntegerToString(t),"/",yeni_fiyat,"/",StringLen(Rakams));
      
      int indexof=StringFind(sayilar, Rakams, 0);
      int indexofy=StringFind(yeni_fiyat, Rakams, 0);
      
    if ( indexofy != -1 ) {
    
    color LineColor=clrBlack;
    
    if ( Rakam >= 0 && Rakam <10 ) LineColor=clrBlack;
    if ( Rakam >= 10 && Rakam <20 ) LineColor=clrBlue;
    if ( Rakam >= 20 && Rakam <30 ) LineColor=clrRed;
    if ( Rakam >= 30 && Rakam <40 ) LineColor=clrGreen;
    if ( Rakam >= 40 && Rakam <50 ) LineColor=clrTurquoise;
    if ( Rakam >= 50 && Rakam <60 ) LineColor=clrGold;
    if ( Rakam >= 60 && Rakam <70 ) LineColor=clrDarkGray;
    if ( Rakam >= 70 && Rakam <80 ) LineColor=clrMaroon;
    if ( Rakam >= 80 && Rakam <90 ) LineColor=clrDarkBlue;
    if ( Rakam >= 90 && Rakam <100 ) LineColor=clrMagenta;
    
    //ObjectSetInteger(ChartID(),last_rakam_box,OBJPROP_BGCOLOR,LineColor);
    
    
    ObjectCreate(ChartID(),t+"-"+Rakams,OBJ_HLINE,0,Time[0],t);
    ObjectSetInteger(ChartID(),t+"-"+Rakams,OBJPROP_COLOR,LineColor);  
    ObjectSetInteger(ChartID(),t+"-"+Rakams,OBJPROP_BACK,true);  
    ObjectSetInteger(ChartID(),t+"-"+Rakams,OBJPROP_WIDTH,2); 

               ObjectCreate(ChartID(),t+"-Box"+Rakams,OBJ_ARROW,0,Time[center_bar],t+20*Point);
               ObjectSet(t+"-Box"+Rakams,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
               ObjectSet(t+"-Box"+Rakams,OBJPROP_COLOR,LineColor);   
               ObjectSetInteger(ChartID(),t+"-Box"+Rakams,OBJPROP_BACK,true);         
    
    }
    }
  
  
  }
  
  //if ( MarketInfo(sym,MODE_PROFITCALCMODE) == 0 && !ForexQuestion ) OrderOpenQuestion = false;
  //if ( MarketInfo(sym,MODE_PROFITCALCMODE) == 1 && !CFDQuestion ) OrderOpenQuestion = false;
  
  if ( MarketInfo(Symbol(),MODE_PROFITCALCMODE) == 0 && Symbol() != "XAUUSD"
  // && Symbol() != ".DE30Cash"
   ) {
   
   
   int first_bar=ChartGetInteger(0,CHART_FIRST_VISIBLE_BAR,0);

   int center_bar = first_bar/2;
  
/*
if ( baslangic != sparam && last_rakam != Rakam) {
ObjectsDeleteAll(ChartID(),-1,OBJ_HLINE);
}*/

   double   top=WindowPriceMax();
  double   bottom=WindowPriceMin();
  //bottom = 1.08;
  //top = 1.28;
  //int rakam = 60;
  //baslangic = sparam;//4;
  
  
  NumberDigit=0.0001;
  

  if ( baslangic == 2 ) {
  NumberDigit=0.1;
  }
  if ( baslangic == 3 ) {
  NumberDigit=0.01;
  }  
  if ( baslangic == 4 ) {
  NumberDigit=0.001;  
  }  
  if ( baslangic == 5 ) {
  NumberDigit=0.0001;
  }  
  if ( baslangic == 6 ) {
  NumberDigit=0.00001;
  }  
  NumberDigit=0.00001;
  
  if ( baslangic == 11 ) {
  baslangic=1;
  }
    
    
    
    int Rakam = StringToInteger(Rakams);
    
    int Rakams_Len = StringLen(Rakams);
  
      for (double t=bottom;t<=top;t+=NumberDigit) {
      
      string t=DoubleToString(t,Digits);
      
      string sayilar=DoubleToString(t,Digits);
      
      string yeni_fiyat = StringSubstr(sayilar,baslangic,2);
      if ( Rakam < 10 && StringLen(Rakams) == 1 ) {
      yeni_fiyat = StringSubstr(sayilar,baslangic,1);
      }
      if ( StringLen(Rakams) > 2 ) {
      yeni_fiyat = StringSubstr(sayilar,baslangic,Rakams_Len); // 0 = 11 1 = 2
      }        
      
      //Print(DoubleToString(t,Digits),"/",yeni_fiyat);
      
      //Print("Rakams",Rakams);
      
      int indexof=StringFind(sayilar, Rakams, 0);
      int indexofy=StringFind(yeni_fiyat, Rakams, 0);
      
    if ( indexofy != -1 ) {
    
    color LineColor=clrBlack;
    
    if ( Rakam >= 0 && Rakam <10 ) LineColor=clrBlack;
    if ( Rakam >= 10 && Rakam <20 ) LineColor=clrBlue;
    if ( Rakam >= 20 && Rakam <30 ) LineColor=clrRed;
    if ( Rakam >= 30 && Rakam <40 ) LineColor=clrGreen;
    if ( Rakam >= 40 && Rakam <50 ) LineColor=clrTurquoise;
    if ( Rakam >= 50 && Rakam <60 ) LineColor=clrGold;
    if ( Rakam >= 60 && Rakam <70 ) LineColor=clrDarkGray;
    if ( Rakam >= 70 && Rakam <80 ) LineColor=clrMaroon;
    if ( Rakam >= 80 && Rakam <90 ) LineColor=clrDarkBlue;
    if ( Rakam >= 90 && Rakam <100 ) LineColor=clrMagenta;
    
    //ObjectSetInteger(ChartID(),last_rakam_box,OBJPROP_BGCOLOR,LineColor);
    
    ObjectCreate(ChartID(),t+"-"+Rakams,OBJ_HLINE,0,Time[0],t);
    ObjectSetInteger(ChartID(),t+"-"+Rakams,OBJPROP_COLOR,LineColor);  
    ObjectSetInteger(ChartID(),t+"-"+Rakams,OBJPROP_BACK,true);  
    ObjectSetInteger(ChartID(),t+"-"+Rakams,OBJPROP_WIDTH,2); 
        
               ObjectCreate(ChartID(),t+"-Box"+Rakams,OBJ_ARROW,0,Time[center_bar],t+10*Point);
               ObjectSet(t+"-Box"+Rakams,OBJPROP_ARROWCODE,SYMBOL_LEFTPRICE);
               ObjectSet(t+"-Box"+Rakams,OBJPROP_COLOR,LineColor);   
               ObjectSetInteger(ChartID(),t+"-Box"+Rakams,OBJPROP_BACK,true);
               
    
    }
          
      
      
/*
  double fiyat = NormalizeDouble(t,Digits);
  string sayilar = NormalizeDouble(t,Digits);
  sayilar = DoubleToString(t,Digits);
      
    
    
    
    
    Print(StringSubstr(DoubleToString(t,Digits),baslangic,2),"/",yeni_fiyat,"/",rakam); 
    
    
    if ( yeni_fiyat == rakam ) {
    
    ObjectCreate(ChartID(),t+"-00",OBJ_HLINE,0,Time[0],t);
    ObjectSetInteger(ChartID(),t+"-00",OBJPROP_COLOR,clrDarkGray);  
    ObjectSetInteger(ChartID(),t+"-00",OBJPROP_BACK,true);  
        
    
    }*/
    
    
    /*
    baslangic=baslangic-1;
    
    
    string sayilar=StringSubstr(DoubleToString(t,Digits),baslangic,2); 
    
    Print(t,"/",NumberDigit,"/",sayilar);      
    
    
    if ( sayilar == IntegerToString(rakam) ) {

    ObjectCreate(ChartID(),t+"-00",OBJ_HLINE,0,Time[0],fiyat);
    ObjectSetInteger(ChartID(),t+"-00",OBJPROP_COLOR,clrDarkGray);  
    ObjectSetInteger(ChartID(),t+"-00",OBJPROP_BACK,true);    
    Print(baslangic); 
    }*/

      
    
    
    }
    }

}





void FiboChannel(int baslangic) {

int secim=baslangic;


  for(int xt=0;xt<=5000;xt++){
  ObjectDelete(ChartID(),"PriceActionLine"+xt);
  }
  ObjectDelete(ChartID(),"PRICE-LINE");
  ChartRedraw();
  
  
  if ( PaLine == false ) return;

////////////////////////////////////////////////////////////////////////////      
   string prc_first="";
   string prc_second="";
   
   //if ( sym_periyod == "" ) {  
   string sep=".";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   
   //string ButtonSinyalTip = "";
   
   int k=StringSplit(DoubleToString(Ask,Digits),u_sep,results);
   //Print("k",k);
   
   if(k>1) {
   prc_first = results[0];
   prc_second = results[1];   
   }
   //}
   int prc_len=StringLen(prc_second);
   int price_len=StringLen(Ask);
   
       
   //Print(sym,"/",sym_line);  
///////////////////////////////////////////////////////////////////////////   






  double   top=WindowPriceMax();
  double   bottom=WindowPriceMin();
  double   center=bottom+((top-bottom)/2);
  top=top+((top-bottom)/2);
  bottom=bottom-((top-bottom)/2);
  baslangic=6;
  string Rakams = "000";
  double NumberDigit=0.0001;
  string yeni_fiyat="";

  

  if ( baslangic == 2 ) {
  NumberDigit=0.1;
  }
  if ( baslangic == 3 ) {
  NumberDigit=0.01;
  }  
  if ( baslangic == 4 ) {
  NumberDigit=0.001;  
  }  
  if ( baslangic == 5 ) {
  NumberDigit=0.0001;
  }  
  if ( baslangic == 6 ) {
  NumberDigit=0.00001;
  }  
  //NumberDigit=1;
  
  if ( baslangic == 11 ) {
  baslangic=1;
  }  
  
  int pa=0;
  
  double prc_line=ObjectGetDouble(ChartID(),"PRICE-LINE",OBJPROP_PRICE);
  
  if (// ObjectFind("Triangle 39270") != -1 && 
  prc_line != center ) {
  
  //Alert(prc_second,"/",prc_len);
  
  //Alert("Selam2:",DoubleToString(NumberDigit),Point);
  ObjectDelete(ChartID(),"PRICE-LINE");
  ObjectCreate(ChartID(),"PRICE-LINE",OBJ_HLINE,0,TimeCurrent(),center);
  ObjectSetInteger(ChartID(),"PRICE-LINE",OBJPROP_COLOR,clrNONE);
  
  
  int indexofgold=StringFind(Symbol(), "GOLD", 0);
  int indexofxau=StringFind(Symbol(), "XAUUSD", 0);

  
  

  if ( MarketInfo(Symbol(),MODE_PROFITCALCMODE) == 1 || Symbol() == "XAUUSD" || indexofgold != -1 
  
  // || Symbol() == ".DE30Cash"
    ) { 
    
    
    
      NumberDigit=1;
      
      /*string bottoms=DoubleToString(bottom,Digits);
      string tops=DoubleToString(top,Digits);

    int replaced=StringReplace(bottoms,".","");
    int replaceds=StringReplace(tops,".","");
    
    bottom=StringToInteger(bottoms);
    top=StringToInteger(tops);
    
    int bottomss=bottoms;
    int topss=tops;*/
    
    //Alert("Bott:",bottomss,"/",tops,"/",price_len);
    //return;
      
    
      //for (int t=bottomss;t<=topss;t+=NumberDigit) {
      for (int t=int(bottom);t<=int(top);t+=NumberDigit) {
      
      string sayilar=IntegerToString(t);
      
      //string t=DoubleToString(t,Digits);

      
      string yeni_fiyat ;//= StringSubstr(sayilar,baslangic,2);
      
      if ( prc_len == 2  ) yeni_fiyat = StringSubstr(sayilar,StringLen(sayilar)-2,4);
      
      if ( prc_len == 2 && price_len == 5 ) yeni_fiyat = StringSubstr(sayilar,StringLen(sayilar)-2,4);
      
      //if ( price_len == 7  ) yeni_fiyat = StringSubstr(sayilar,StringLen(sayilar)-4,2);
 
      
      int yeni_sontek = StringSubstr(sayilar,StringLen(sayilar)-1,1);
      
      
      //Print(sayilar,"/",StringSubstr(sayilar,StringLen(sayilar)-1,1));
      
      
      
      //if ( price_len == 7  ) yeni_fiyat = StringSubstr(sayilar,StringLen(sayilar)-4,2);
      

if ( prc_len == 2 && price_len == 5 ) {

      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrBisque);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);      

      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t+0.50);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrGoldenrod);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,2);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);

      if ( secim != 0 ) {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t+0.25);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrBisque);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,3);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t+0.75);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrBisque);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,3);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);      
      }
                  
      
      }      


      
      
     /* if ( yeni_sontek == "0" ) {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrBisque);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      }*/
      
      //if ( yeni_sontek == "0" || (yeni_sontek == "5" && indexofgold != -1 )) {
      if ( yeni_sontek == "0" || (yeni_sontek == "5" && yeni_fiyat != "75"  && yeni_fiyat != "25") ) {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      if ( yeni_sontek == "0" ) ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrBisque);
      if ( yeni_sontek == "5" && (indexofgold != -1 || indexofxau != -1) ) ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrTurquoise);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);      
      if ( yeni_sontek == "0" ) ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,3);
      if ( yeni_sontek == "5" && (indexofgold != -1 || indexofxau != -1)) ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,1);      
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      }      
          
      
      //Print(t,"/",StringLen(sayilar),"/",yeni_fiyat,"/",prc_len);
      
      if ( prc_len == 2 || prc_len == 2 ) {
      if ( yeni_fiyat == "00" || yeni_fiyat == "50" ) {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrGoldenrod);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      }
      
      if ( yeni_fiyat == "75"  || yeni_fiyat == "25") {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrGold);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,2);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,true);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      }
      
      if (  yeni_fiyat == "37"  || yeni_fiyat == "12" || yeni_fiyat == "62" || yeni_fiyat == "87") {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t+0.5);
      //if ( Symbol() == "XUAUSD" ) ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t+0.5);
      //if ( Symbol() != "XUAUSD" ) ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);      
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrGold);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,2);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,true);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);      
      }  
      
      
      
      }   
      
      
      }

    
    
    }

  
      if ( MarketInfo(Symbol(),MODE_PROFITCALCMODE) == 0 && Symbol() != "XAUUSD" ) {
  
  
      for (double t=bottom;t<=top;t+=NumberDigit) {
      
      string t=DoubleToString(t,Digits);
      
      string sayilar=DoubleToString(t,Digits);
      
      //string yeni_fiyat = StringSubstr(sayilar,baslangic,2);
      if ( prc_len >= 3 && price_len == 7 ) yeni_fiyat = StringSubstr(sayilar,4,3);
      if ( prc_len >= 3 && price_len == 6 ) yeni_fiyat = StringSubstr(sayilar,3,3);
      if ( prc_len == 2 ) yeni_fiyat = StringSubstr(sayilar,StringLen(sayilar)-2,2);
      //if ( prc_len == 5 ) yeni_fiyat = StringSubstr(sayilar,4,3);
      
      //Print(StringLen(sayilar)-2,"/",yeni_fiyat);
      
      if ( prc_len == 2 || prc_len == 2 ) {
      if ( yeni_fiyat == "00" || yeni_fiyat == "50" ) {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrGoldenrod);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      }
      }
      
            
      

      if ( prc_len == 5 || prc_len == 3 ) {
      if ( yeni_fiyat == "000" || yeni_fiyat == "500" ) {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrBisque);//clrGoldenrod
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      }
      
      //if ( yeni_fiyat == "000" || yeni_fiyat == "500" || yeni_fiyat == "750"  || yeni_fiyat == "250") {
      if ( yeni_fiyat == "750"  || yeni_fiyat == "250") {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrGold);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,2);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,true);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);
      }

      if ( secim != 0 ) {
      if (  yeni_fiyat == "375"  || yeni_fiyat == "125" || yeni_fiyat == "625" || yeni_fiyat == "875") {
      pa=pa+1;
      ObjectDelete(ChartID(),"PriceActionLine"+pa);
      ObjectCreate(ChartID(),"PriceActionLine"+pa,OBJ_HLINE,0,Time[0],t);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_COLOR,clrGold);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_STYLE,2);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_WIDTH,1);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_BACK,true);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"PriceActionLine"+pa,OBJPROP_SELECTABLE,false);      
      }
      }
      
      
      }
            
      
      
      
      //Print(sayilar,"/",yeni_fiyat);
      
      
      }
  
  }

    //int Rakam = StringToInteger(Rakams);
    
    //int Rakams_Len = StringLen(Rakams);
    
    //Alert(Rakam);
      
  
/*
19000
18750
18500
18375
18250
18125
18000*/
  
  
  
  //Alert(ftop,"/",fbottom,"/",fcenter);
  
  }



}



// Finito