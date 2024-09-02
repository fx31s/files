//+------------------------------------------------------------------+
//|                                                   WebRequest.mqh |
//|                                           Lorentzos Roussos 2020 |
//|                              https://www.mql5.com/en/users/lorio |
//+------------------------------------------------------------------+
#property copyright "Lorentzos Roussos 2020"
#property link      "https://www.mql5.com/en/users/lorio"
#property strict

/*
usage example : 
global 
web_request WR;

oninit test:
  WR.SetupWithBasicHeaders(wr_type_get,"https://mql4.requestcatcher.com/",2000);
  WR.SetReferer("https://www.mql5.com");
  WR.SetUserAgent("MT4/V2356 GR");
  //parameters 
  WR.Parameters+"Name"="Lorentzos";
  WR.Parameters+"LastName"="Roussos";
  WR.Parameters+"CodingSkills"="0";
  WR.Cookies+"CookieLast"=TimeToString(TimeLocal(),TIME_DATE|TIME_MINUTES|TIME_SECONDS);
  simple_result result=WR.Send();
  Print("Errors : "+result.error);
  if(result.status==200)
    {
    Alert("response headers : \n"+result.response_headers+"\nresponse body : \n"+result.response_body);
    }
*/
//HEADERS 
class wr_header_parameter_item
{
public:
string Title,Value;
wr_header_parameter_item(void){Title=NULL;Value=NULL;}
~wr_header_parameter_item(void){delete GetPointer(this);}
void operator=(string new_value){Value=new_value;}
/* non needed overkill */
//void operator=(wr_header_parameter_item &new_item){Print("Previous :"+Title+" New :"+new_item.Title);this=new_item;}
};
class wr_headers_parameters_list
{
public:
wr_header_parameter_item Items[];
wr_headers_parameters_list(void){Reset();}
~wr_headers_parameters_list(void){Reset();delete GetPointer(this);}
void Reset(){ArrayFree(Items);}
//Add Item 
void AddItem(string title,string value){
int newsize=ArraySize(Items)+1;
ArrayResize(Items,newsize,0);
Items[newsize-1].Title=title;
Items[newsize-1].Value=value;
}
//Remove Item 
void RemoveItem(int ix){
for(int r=ix;r<=ArraySize(Items)-2;r++){
Items[r]=Items[r+1];
}
int newsize=ArraySize(Items)-1;
if(newsize>0){ArrayResize(Items,newsize,0);}
if(newsize<=0){ArrayFree(Items);}
}
//Remove Item Ends here
//Remove Item - operator 
void operator-(string title)
                {
                //find the field name 
                string name_b=title;
                StringToUpper(name_b);
                for(int f=0;f<ArraySize(Items);f++){
                string name_a=Items[f].Title;
                StringToUpper(name_a);
                if(name_a==name_b){RemoveItem(f);break;}
                }                
                }
//add item + operator
wr_header_parameter_item* operator+(string title)
                {
                //find the field name 
                string name_b=title;
                StringToUpper(name_b);
                for(int f=0;f<ArraySize(Items);f++){
                string name_a=Items[f].Title;
                StringToUpper(name_a);
                if(name_a==name_b){return(GetPointer(Items[f]));}
                }
                //if it does not exist create it 
                AddItem(title,"");
                return(GetPointer(Items[ArraySize(Items)-1]));             
                }
//change or add item [] operator (same as +)
wr_header_parameter_item* operator[](string title)
                {
                //find the field name 
                string name_b=title;
                StringToUpper(name_b);
                for(int f=0;f<ArraySize(Items);f++){
                string name_a=Items[f].Title;
                StringToUpper(name_a);
                if(name_a==name_b){return(GetPointer(Items[f]));}
                }
                //if it does not exist create it 
                AddItem(title,"");
                return(GetPointer(Items[ArraySize(Items)-1]));
                }
void Display(){
string txt="[Request Headers]\n";
for(int d=0;d<ArraySize(Items);d++){
txt+="["+IntegerToString(d)+"] "+Items[d].Title+": "+Items[d].Value;
Print("["+IntegerToString(d)+"] "+Items[d].Title+": "+Items[d].Value);
if(d<ArraySize(Items)-1){txt+="\n";}
}
Alert(txt);
}                
};
enum wr_type
{
wr_type_get=0,//GET
wr_type_post=1//POST
};
struct simple_result
{
int status;
string response_headers,response_body,error;
simple_result(void){status=-1;response_headers=NULL;response_body=NULL;error="";}
};
struct web_request
{
wr_headers_parameters_list RequestHeaders;
wr_headers_parameters_list Parameters;
wr_headers_parameters_list Cookies;
string Url;
uint Timeout;
wr_type Type;
web_request(void){Reset(true,true,true);}
~web_request(void){delete GetPointer(RequestHeaders);delete GetPointer(Parameters);}
//Fill Basic Request Headers 
void FillBasicHeaders(){
Reset(true,false,false);
RequestHeaders["Accept"]="*/*";
RequestHeaders["Accept-charset"]="utf-8";
RequestHeaders["Accept-language"]="en, gr, ru";
RequestHeaders["Cache-Control"]="no-cache";
RequestHeaders["Connection"]="keep-alive";
RequestHeaders["Content-Type"]="application/x-www-form-urlencoded";
RequestHeaders["Pragma"]="no-cache";
RequestHeaders["Proxy-Connection"]="keep-alive";
}
//Fill Basic Request Headers Ends here
//Setup with basic headers
void SetupWithBasicHeaders(wr_type type,
                           string url,
                           uint timeout){
FillBasicHeaders();
Url=url;Type=type;Timeout=timeout;                           
}                           
//Setup with basic headers ends here 
//Set Referer 
void SetReferer(string new_referer){RequestHeaders-"Referer";RequestHeaders["Referer"]=new_referer;}
//Set User Agent
void SetUserAgent(string ua){RequestHeaders-"User-Agent";RequestHeaders["User-Agent"]=ua;}
//Reset
void Reset(bool remove_request_headers,
           bool remove_parameters,
           bool remove_cookies){
if(remove_request_headers){ArrayFree(RequestHeaders.Items);}
if(remove_parameters){ArrayFree(Parameters.Items);}
if(remove_cookies){ArrayFree(Cookies.Items);}
Url=NULL;
Timeout=5000;//ms
Type=wr_type_get;
}
//Reset ends here
//Send Request 
simple_result Send()
{
simple_result result;
if(StringFind(Url,"http",0)==-1){result.error+="No Url Specified\n";}
if(Timeout<=50){result.error+="Unrealistic Timeout\n";}
if(ArraySize(RequestHeaders.Items)==0){result.error+="No Request Headers\n";}
if(ArraySize(Parameters.Items)==0&&Type==wr_type_post){result.error+="No parameters passed for POST\n";}
//request valid 
if(result.error=="")
{
string sent_hdrs="";
for(int h=0;h<ArraySize(RequestHeaders.Items);h++){
sent_hdrs+=RequestHeaders.Items[h].Title+": "+RequestHeaders.Items[h].Value;
if(h<ArraySize(RequestHeaders.Items)-1){sent_hdrs+="\r\n";}
}
//cookies 
string cookie_list="";
if(ArraySize(Cookies.Items)>0){cookie_list="Cookie: ";}
for(int c=0;c<ArraySize(Cookies.Items);c++){
cookie_list+=Cookies.Items[c].Title+"="+Cookies.Items[c].Value;
if(c<ArraySize(Cookies.Items)-1){cookie_list+="; ";}
}
if(cookie_list!=""){sent_hdrs+="\r\n"+cookie_list;}
//cookies end here 
char results[];
string target_url=Url;
string specs="";
//fill specs if they exist 
bool noparams=false;
if(ArraySize(Parameters.Items)==0){noparams=true;}
if(!noparams){
for(int fp=0;fp<ArraySize(Parameters.Items);fp++){
specs+=UrlEncode(Parameters.Items[fp].Title+"="+Parameters.Items[fp].Value);
if(fp<ArraySize(Parameters.Items)-1){specs+="&";}
}}
//fill specs ends here
if(Type==wr_type_get&&!noparams){target_url=target_url+"?"+specs;}
char data[];
int data_size=0;
int slen=StringLen(specs);
string req_string="GET";
if(Type==wr_type_post){
data_size=StringToCharArray(specs,data,0,slen,CP_UTF8);
req_string="POST";
}
ResetLastError();
result.status=WebRequest(req_string,target_url,sent_hdrs,Timeout,data,results,result.response_headers);
if(result.status==-1){result.error+="Error in WebRequest. Error code  ="+IntegerToString(GetLastError())+"\n"+" Add the address '"+Url+"' in the list of allowed URLs on tab 'Expert Advisors'";}
if(result.status==200){
int t=ArraySize(results)-1;
for(int xx=0;xx<=t;xx++){
result.response_body+=CharToStr(results[xx]);
}}  
}
//request valid ends here
return(result);
}
//Send Request Ends Here 
};

//URL ENCODE 
string UrlEncode(string in)
{
string returnio=in;
//replace %
int rep=StringReplace(returnio,"%","%25");
//space
rep=StringReplace(returnio," ","%20");
//!
rep=StringReplace(returnio,"!","%21");
//@
rep=StringReplace(returnio,"@","%40");
//#
rep=StringReplace(returnio,"#","%23");
//$
rep=StringReplace(returnio,"$","%24");
//^
rep=StringReplace(returnio,"^","%CB%86");
//&
rep=StringReplace(returnio,"&","%26");
//*
rep=StringReplace(returnio,"*","%2A");
//(
rep=StringReplace(returnio,"(","%28");
//)
rep=StringReplace(returnio,")","%29");
//-
rep=StringReplace(returnio,"-","%2D");
//+
rep=StringReplace(returnio,"+","%2B");
//:
rep=StringReplace(returnio,":","%3A");
//;
rep=StringReplace(returnio,";","%3B");
//"
rep=StringReplace(returnio,"\"","%22");
//'
rep=StringReplace(returnio,"'","%27");
//?
rep=StringReplace(returnio,"?","%3F");
//<
rep=StringReplace(returnio,"<","%3C");
//>
rep=StringReplace(returnio,">","%3E");
//.
rep=StringReplace(returnio,".","%2E");
//,
rep=StringReplace(returnio,",","%2C");
///
rep=StringReplace(returnio,"/","%2F");
//\
rep=StringReplace(returnio,"\\","%5C");
//[
rep=StringReplace(returnio,"[","%5B");
//]
rep=StringReplace(returnio,"]","%5D");
//(
rep=StringReplace(returnio,"(","%28");
//)
rep=StringReplace(returnio,")","%29");
return(returnio);
}
//URL ENCODE ENDS HERE 
string TextGapsTreat(string text)
{
string result=text;
for(int c=0;c<=31;c++)
{
string tr=CharToString((uchar)c);
int rep=StringReplace(result,tr," ");
}
string tr=CharToString(255);
int rep=StringReplace(result,tr," ");
tr=CharToString(127);
rep=StringReplace(result,tr," ");
int tc=StringLen(result);
//max gaps
int max_gap=0,gap_now=0;
for(int c=0;c<tc;c++)
{
ushort code=StringGetCharacter(result,c);
if(code==32) gap_now++;
if(code!=32) gap_now=0;
if(gap_now>max_gap) max_gap=gap_now;
}
for(int mg=max_gap;mg>=1;mg--)
{
string gaps="";
for(int fg=1;fg<=mg;fg++) gaps+=" ";
rep=StringReplace(result,gaps," ");
}
return(result);
}


