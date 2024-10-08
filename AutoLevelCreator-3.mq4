//+------------------------------------------------------------------+
//|                                             AutoLevelCreator.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string last_level_select_object="";
int magic=0;

extern int LinesAboveBelow= 10;
color LineColorMain= Black;
color LineColorSub= DarkGray;

double dPt;


double open_order=false;
double first_question=false;

int OrderTotal=0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

void CloseAllPenOrdersLevel(string cmt)
{
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderType() >= 2 && OrderSymbol() == Symbol() && OrderMagicNumber() == magic && StringFind(OrderComment(),cmt,0) != -1 )
         {
            OrderDelete(OrderTicket(),clrNONE);
         }
      }
    }
}





int OnInit()
  {
//---
  /*int i=OrdersHistoryTotal()-1;
   if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true)
   {  
   
   Print(OrderTicket());
   }*/
   /*
      string grid_cmts="703091367BUY";
      int grid_buy_total=OrderCommets(grid_cmts);
      Alert(grid_buy_total);
    */  
         

   
   OrderTotal=OrdersTotal();
   
   ObjectsDeleteAlls(ChartID(),"Sweet",-1,-1);

   dPt = Point;
   if(Digits==3||Digits==5){
      dPt=dPt*10;
   } 
   
   if ( StringFind(Symbol(),"XAUUSD",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"SP500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"USDZAR",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDMXN",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDJPY",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"NAS100",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"GER30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"EURMXN",0) != -1 ) dPt=dPt*100;
   
   
   if ( StringFind(AccountCompany(),"Robo",0) != -1 ) {
   
   
   if ( StringFind(Symbol(),"DE40",0) != -1 ) dPt=dPt*10;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*0.1;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=1;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=Point*100;
   if ( StringFind(Symbol(),"USTECH",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"BTC",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"BNB",0) != -1 ) dPt=dPt*10;
   }
   
   
   Ict();
   Ict250();   
   
   //CloseAllPenOrdersLevel(703089906);
   
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

if ( OrderTotal!=OrdersTotal()){
OrderTotal=OrdersTotal();

   int i=OrdersHistoryTotal()-1;
   if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true)
   {  
   Print(OrderTicket());
   CloseAllPenOrdersLevel(OrderTicket());
   }

}



   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

if ( sparam == 45 ) {

if ( OrderTotal!=OrdersTotal()){
OrderTotal=OrdersTotal();

   int i=OrdersHistoryTotal()-1;
   if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==true)
   {  
   Print(OrderTicket());
   CloseAllPenOrdersLevel(OrderTicket());
   }

}



}

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE ) {

last_level_select_object=sparam;

          int obj_typ = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_level_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_level_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_level_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_level_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_level_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_level_select_object,OBJPROP_BACK);  
          
          
          Comment(obj_prc1,"/",obj_prc2);
          
          double level_high_price;
          double level_low_price;
          
          if ( obj_prc1 > obj_prc2 ) {
          level_high_price=obj_prc1;
          level_low_price=obj_prc2;          
          }
          
          
          if ( obj_prc2 > obj_prc1 ) {
          level_high_price=obj_prc2;
          level_low_price=obj_prc1;          
          }
                    
        Comment(level_high_price,"/",level_low_price);
        
       CheckFirstOrder(level_high_price,level_low_price); 



                    
          
          
}


   
  }
//+------------------------------------------------------------------+

bool level_sell_order=false;
bool level_buy_order=false;
double level_lot_order;
long level_ticket_order;

void CheckFirstOrder(double level_high_price,double level_low_price) {


   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            //OrderDelete(OrderTicket(),clrNONE);
            
            if ( OrderOpenPrice() >= level_low_price && OrderClosePrice() <= level_high_price && OrderType() <=1 ) {
            
            
            ObjectDelete(ChartID(),"HLINE"+OrderTicket());
            ObjectCreate(ChartID(),"HLINE"+OrderTicket(),OBJ_HLINE,0,Time[0],OrderOpenPrice());
            first_question=false;
            
            
            if ( OrderType() == OP_BUY ) {

level_sell_order=false;
level_buy_order=true; 
level_lot_order=OrderLots();  
level_ticket_order=OrderTicket(); 
level_last_lot=level_lot_order;
int level_mode=50;


int cevap=MessageBox(Symbol()+" Do I open level 50? ","Order Open Grid 50",4); //  / Spread:"+Spread_Yuzde+"%"
if ( cevap == 6 ) {
level_mode=50;
} else {
level_mode=25;
}

       IctBuy(level_mode);
       
            
            }
            
            
            if ( OrderType() == OP_SELL ) {

level_sell_order=true;
level_buy_order=false;
level_lot_order=OrderLots();
level_ticket_order=OrderTicket();   
level_last_lot=level_lot_order;  
int level_mode=50;

int cevap=MessageBox(Symbol()+" Do I open level 50? ","Order Open Grid",4); //  / Spread:"+Spread_Yuzde+"%"
if ( cevap == 6 ) {
level_mode=50;
} else {
level_mode=25;
}

    IctSell(level_mode);
            
            }
            
            
            }
            
         }
      }
    }
    
    

}



double level_last_lot=0;

void IctSell(int level_mode) {


//Alert(level_last_lot);


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%level_mode;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*level_mode); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
            
      
      if ( int(TimeHour(TimeCurrent())) < 23 && ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {
      int cevap=0;
      if ( first_question == false ) {cevap=MessageBox(Symbol()+" Do I open the order? ","Order Open Grid",4); //  / Spread:"+Spread_Yuzde+"%"
      first_question=true;
      }
      if ( cevap == 6 ) {      
      open_order=true;
      }  
      if ( open_order == true ) {
      double grid_price=NormalizeDouble(ds1,Digits);
      string grid_cmt="";
      double grid_lot=level_lot_order;
      /*
      if ( level_last_lot != 0 ) {level_last_lot=level_last_lot*2;
      grid_lot=level_last_lot;
      Print("level_last_lot",level_last_lot);
      }*/
      if ( Bid < ds1 && ds1-Bid >= 250*Point && level_sell_order == true ) {
      
  
      
      grid_cmt=level_ticket_order+"SELL"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) {
      
      if ( level_last_lot != 0 ) {level_last_lot=level_last_lot*2;
      grid_lot=level_last_lot;
      Print("level_last_lot",level_last_lot);
      }          
      
      string grid_cmts=level_ticket_order+"SELL";
      int grid_sell_total=OrderCommets(grid_cmts);
      grid_sell_total=grid_sell_total+1;
            
if ( grid_sell_total < 4 ) grid_lot=0.01;
if ( grid_sell_total >=3 && grid_sell_total <=6) grid_lot=0.02;
if ( grid_sell_total >= 7 && grid_sell_total <=9) grid_lot=0.03;
if ( grid_sell_total >= 10 ) grid_lot=0.04;

      
      
      OrderSend(Symbol(),OP_SELLLIMIT,grid_lot,ds1,0,0,0,grid_cmt,magic,0,clrNONE);
      
      }
      }

      if ( Ask > ds1 && Ask-ds1 >= 250*Point && level_buy_order == true ) {
      

      
      grid_cmt=level_ticket_order+"BUY"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) {
      
      if ( level_last_lot != 0 ) {level_last_lot=level_last_lot*2;
      grid_lot=level_last_lot;
      Print("level_last_lot",level_last_lot);
      }      
      

     
      
      OrderSend(Symbol(),OP_BUYLIMIT,grid_lot,ds1,0,0,0,grid_cmt,magic,0,clrNONE);
}      
      
      } 
      }
      }
      
      
         
      SetLevel(DoubleToStr(ds1,Digits), ds1,  linecolor, style, Time[10]);
   }
   
   
}



void IctBuy(int level_mode) {


//Alert(LinesAboveBelow);


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%level_mode;

   //for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
   for (i= LinesAboveBelow; i>LinesAboveBelow-20; i--) {

   
   //Print(i);
   
   
      ssp= ssp1+(i*level_mode); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
            
      //Print(ds1);
            
      
      if ( int(TimeHour(TimeCurrent())) < 23 && ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {
      int cevap=0;
      if ( first_question == false ) {cevap=MessageBox(Symbol()+" Do I open the order? ","Order Open Grid",4); //  / Spread:"+Spread_Yuzde+"%"
      first_question=true;
      }
      if ( cevap == 6 ) {      
      open_order=true;
      }  
      if ( open_order == true ) {
      double grid_price=NormalizeDouble(ds1,Digits);
      string grid_cmt="";
      double grid_lot=level_lot_order;
      /*
      if ( level_last_lot != 0 ) {level_last_lot=level_last_lot*2;
      grid_lot=level_last_lot;
      Print("level_last_lot",level_last_lot);
      }*/
      if ( Bid < ds1 && ds1-Bid >= 250*Point && level_sell_order == true ) {
      
  
      
      grid_cmt=level_ticket_order+"SELL"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) {
      
      if ( level_last_lot != 0 ) {level_last_lot=level_last_lot*2;
      grid_lot=level_last_lot;
      Print("level_last_lot",level_last_lot);
      }          
      
      OrderSend(Symbol(),OP_SELLLIMIT,grid_lot,ds1,0,0,0,grid_cmt,magic,0,clrNONE);
      
      }
      }

      if ( Ask > ds1 && Ask-ds1 >= 250*Point && level_buy_order == true ) {
      

      
      grid_cmt=level_ticket_order+"BUY"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) {
      
      if ( level_last_lot != 0 ) {level_last_lot=level_last_lot*2;
      grid_lot=level_last_lot;
      Print("level_last_lot",level_last_lot);
      }      
      

      string grid_cmts=level_ticket_order+"BUY";
      int grid_buy_total=OrderCommets(grid_cmts);
      grid_buy_total=grid_buy_total+1;
            
if ( grid_buy_total < 4 ) grid_lot=0.01;
if ( grid_buy_total >=3 && grid_buy_total <=6) grid_lot=0.02;
if ( grid_buy_total >= 7 && grid_buy_total <=9) grid_lot=0.03;
if ( grid_buy_total >= 10 ) grid_lot=0.04;

      
      
      OrderSend(Symbol(),OP_BUYLIMIT,grid_lot,ds1,0,0,0,grid_cmt,magic,0,clrNONE);
}      
      
      } 
      }
      }
      
      
         
      SetLevel(DoubleToStr(ds1,Digits), ds1,  linecolor, style, Time[10]);
   }
   
   
}





void Ict() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%50;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*50); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
            
      /*
      if ( int(TimeHour(TimeCurrent())) < 23 && ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {
      int cevap=0;
      if ( first_question == false ) {cevap=MessageBox(Symbol()+" Do I open the order? ","Order Open Grid",4); //  / Spread:"+Spread_Yuzde+"%"
      first_question=true;
      }
      if ( cevap == 6 ) {      
      open_order=true;
      }  
      if ( open_order == true ) {
      double grid_price=NormalizeDouble(ds1,Digits);
      string grid_cmt="";
      double grid_lot=0.01;
      if ( Bid < ds1 && ds1-Bid >= 250*Point ) {
      grid_cmt="SELL"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) OrderSend(Symbol(),OP_SELLLIMIT,grid_lot,ds1,0,0,0,grid_cmt,0,0,clrNONE);
      }

      if ( Ask > ds1 && Ask-ds1 >= 250*Point ) {
      grid_cmt="BUY"+DoubleToString(grid_price,Digits);
      if( OrderCommets(grid_cmt)==0) OrderSend(Symbol(),OP_BUYLIMIT,grid_lot,ds1,0,0,0,grid_cmt,0,0,clrNONE);
      } 
      }
      }*/
      
      
         
      SetLevel(DoubleToStr(ds1,Digits), ds1,  linecolor, style, Time[10]);
   }
   
   
}




void Ict250() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%25;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*25); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
      SetLevel(DoubleToStr(ds1,Digits), ds1,  clrLightSkyBlue, STYLE_DASHDOTDOT, Time[10]);
   }
   
   
}



void SetLevel(string text, double level, color col1, int linestyle, datetime startofday)
{
   int digits= Digits;
   string linename= "[SweetSpot] " + text + " Line",
          pricelabel; 

   // create or move the horizontal line   
   if (ObjectFind(ChartID(),linename) != 0) {
      ObjectCreate(ChartID(),linename, OBJ_HLINE, 0, 0, level);
      ObjectSetInteger(ChartID(),linename, OBJPROP_STYLE, linestyle);
      ObjectSetInteger(ChartID(),linename, OBJPROP_COLOR, col1);
      ObjectSetInteger(ChartID(),linename, OBJPROP_WIDTH, 0);
   }
   else {
      ObjectMove(ChartID(),linename, 0, Time[0], level);
   }
}



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


}

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
int OrderCommets(string cmt){
int com = 0;


//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){

if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;
//Sonuna Rakam Ekledik Hangi Tutar Kazanıyor diye onun için instr veya indexof yapıp comment içinde arama yapıyoruz.
int index=StringFind(OrderComment(), cmt, 0);

//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if(index!=-1 && OrderSymbol() == Symbol()){com++;}; // Hatali Calisiyor
//if(OrderComment()==cmt){com++;};
if(OrderComment()=="" && cmt=="" && OrderSymbol() == Symbol()){com++;};
//}
}



return com;
};



















// Welcome to Rich Mode