/* Dame el <ITEM> :

LA sgte funcion retorna el resref al azar de una lista de items  clasificados , hasta el momento
solo estan los estandar resrefs de bioware , para agregar mas solo basta poner el resref en la lista
Referencias acerca de los resrefs : http://www.nwnlexicon.com/ keyword = resource.potions
*/

string dame_low_pocion(){

string resref_pocion;
int ndice = d10(1);

switch (ndice){

 case 1:
        resref_pocion= "nw_it_mpotion001";
            break;
 case 2:
        resref_pocion= "nw_it_mpotion020";
         break;
 case 3:
        resref_pocion=  "nw_it_mpotion002";
         break;
 case 4:
        resref_pocion=  "nw_it_mpotion008";
         break;
 case 5:
        resref_pocion=  "nw_it_mpotion011";
         break;
 case 6:
        resref_pocion=  "nw_it_mpotion023";
         break;
 case 8:
      resref_pocion= "x2_it_mpotion001";
       break;
 case 9:
      resref_pocion=  "nw_it_mpotion006";
       break;
 case 10:
      resref_pocion=  "nw_it_mpotion019";
       break;
}
return resref_pocion ;
}


string dame_gema(){

string resref_gema;
int ndice = d10(1);

switch (ndice){

 case 1:
        resref_gema= "nw_it_gem013";
            break;
 case 2:
        resref_gema= "nw_it_gem003";
         break;
 case 3:
        resref_gema=  "nw_it_gem005";
         break;
 case 4:
        resref_gema=  "nw_it_gem015";
         break;
 case 5:
        resref_gema=  "nw_it_gem008";
         break;
 case 6:
        resref_gema=  "nw_it_gem010";
         break;
 case 8:
      resref_gema= "nw_it_gem009";
       break;
 case 9:
      resref_gema=  "nw_it_gem014";
       break;
 case 10:
      resref_gema=  "nw_it_gem014";
       break;
}
return resref_gema ;
}

string give_fucking_cheap_jewelry(){

string resref_jewelry;
int ndice = d10(1);

switch (ndice){

 case 1:
        resref_jewelry= "nw_it_mneck024";
            break;
 case 2:
        resref_jewelry= "nw_it_mneck023";
         break;
 case 3:
        resref_jewelry=  "nw_hen_lin1rw";
         break;
 case 4:
        resref_jewelry=  "nw_it_mneck006";
         break;
 case 5:
        resref_jewelry=  "nw_it_mneck021";
         break;
 case 6:
        resref_jewelry=  "nw_it_mneck021";
         break;
 case 8:
      resref_jewelry= "nw_it_mneck021";
       break;
 case 9:
      resref_jewelry=  "nw_it_mneck022";
       break;
 case 10:
      resref_jewelry=  "nw_it_mneck022";
       break;
}
return resref_jewelry ;
}










