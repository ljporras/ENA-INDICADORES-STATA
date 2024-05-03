/*
CODIGO: CÓDIGO DE IDENTIFICACIÓN
1 Pequeños y medianos productores/as agropecuarios/as
2 Grandes productores/as agropecuarios/as

OMICAP900: OMISION DEL CAPITULO 900

FACTOR: FACTOR DE EXPANSION

REGION: REGION NATURAL

NOMBREDD: Nombre de Departamento

CONGLOMERADO: Conglomerado #

DOMINIO: DOMINIO GEOGRAFICO
********************************************************************************

PORCENTAJE DE PRODUCTORES/AS AGROPECUARIOS/AS QUE ACCEDEN A 
SERVICIOS FINANCIEROS FORMALES EN LOS ÚLTIMOS 12 MESES

Numerador:
Número de productores agropecuarios que acceden a servicios financieros formales,
es decir, que en el Capítulo 900, Pregunta 902 tienen circulado el código 1 y 
en la Pregunta 903 tengan circulado alguno de los códigos del 1 al 5;
en la Pregunta 905 tienen circulado el código 1
y en la Pregunta 906 tengan circulado alguno de los códigos del 1 al 4;
y/o en la Pregunta 907 tienen circulado el código 1 
y en la Pregunta 908 tienen circulado cualquiera de los códigos del 1 al 6.

Denominador:
Número de productores agropecuarios que obtuvieron crédito,
han sido beneficiarios de algún seguro agropecuario o 
han tenido alguna cuenta de ahorro,
en el Capítulo 100, Pregunta 102, tienen circulado solo el código 1, el código 2 o los códigos 1 y 2; 
y en la Pregunta 902 tienen circulado el código 1,
en la Pregunta 905 tienen circulado en el código 1 o 
en la Pregunta 907 tienen circulado el código 1.

CODIGO: CÓDIGO DE IDENTIFICACIÓN
1 Pequeños y medianos productores/as agropecuarios/as
2 Grandes productores/as agropecuarios/as

P102_1 EN LOS ÚLTIMOS 12 MESES, DE…..A…….., LA EMPRESA/UD, REALIZÓ ACTIVIDAD: ¿Agrícola?
P102_2 EN LOS ÚLTIMOS 12 MESES, DE…..A…….., LA EMPRESA/UD, REALIZÓ ACTIVIDAD: ¿Pecuaria?

P902 ¿OBTUVO EL CRÉDITO QUE SOLICITÓ? 1 Sí 2 No

P903_1 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? AGROBANCO
P903_2 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Caja Municipal
P903_3 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Caja Rural
P903_4 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Banca Privada
P903_5 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Financiera/EDPYME
P903_6 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Organismo No Gubernamental (ONG)
P903_7 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Cooperativa
P903_8 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Establecimiento comercial
P903_9 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Prestamista/Habilitador
P903_10 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Programas del Estado
P903_11 ¿QUIÉN LE PROPORCIONÓ EL CRÉDITO QUE OBTUVO? Otro

P905: EN LOS ÚLTIMOS 12 MESES, DE…A…, ¿LA EMPRESA/UD. 
HA SIDO BENEFICIARIO DE ALGÚN SEGURO AGROPECUARIO? 1 Sí 2 No

P906: ¿QUIÉN LE PROPORCIONÓ EL SEGURO AGROPECUARIO?
1 Ministerio de Agricultura y Riego
2 Empresa aseguradora
3 Banca privada
4 AGROBANCO
5 Otro

P907: EN LOS ÚLTIMOS 12 MESES, DE….A….., ¿HA TENIDO ALGUNA CUENTA DE AHORRO? 1 Sí 2 No

P908_1 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? AGROBANCO
P908_2 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? Banco de la Nación
P908_3 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? Caja Municipal
P908_4 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? Caja Rural
P908_5 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? Banca Privada
P908_6 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? Financiera/EDPYME
P908_7 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? Cooperativa
P908_8 ¿EN QUE INSTITUCIÓN TUVO LA CUENTA DE AHORRO? Otro

Nota:Se consideran productores/as agropecuarios/as que acceden a servicios 
financieros formales, a aquellos que en los últimos 12 meses, accedieron a crédito,
seguro agropecuario otuvieron una cuenta de ahorros en al menos una entidad financiera,
como Agrobanco, Banco de la Nación, Caja Municipal o Rural, Banca Privada o Financiera/EDPYME.
a/ Tiene únicamente valor referencial por presentar un coeficiente de variación mayor al 15%.
*/

clear all
cd   "D:\ENA"

use 17_Cap900.dta, clear
*28,370 obs. (realizaron act en los ult. 12 meses)
*26,942 peq.
* 1,428 gra.

gen     DPTO=NOMBREDD
replace DPTO="LIMA" if NOMBREDD=="CALLAO"


sum  P903_1 P903_2 P903_3 P903_4 P903_5
egen P903= rowtotal(P903_1 P903_2 P903_3 P903_4 P903_5)

sum  P908_1 P908_2 P908_3 P908_4 P908_5 P908_6
egen P908=rowtotal(P908_1 P908_2 P908_3 P908_4 P908_5 P908_6)


gen     ssff=0 if (P102_1==1 | P102_2==1) & (P902==1 | P905==1 | P907==1) & CODIGO==1 & OMICAP900~="99" 
replace ssff=1 if (P102_1==1 | P102_2==1) & (P903>0 |  P906<5 | P908>0) & CODIGO==1 & OMICAP900~="99" 
la de nosi 0 "No" 1 "Si"
label values ssff nosi
label var ssff "Productores que acceden a servicios financieros formales"


svyset [pweight=FACTOR],  psu(CONGLOMERADO) strata(DOMINIO)
svy: tab   REGION ssff, per row cv ci obs format(%12.1fc)  
svy: tab   DPTO   ssff, per row           format(%12.1fc) 
svy: tab   DPTO   ssff, per row obs       format(%12.1fc) 
svy: tab   DPTO   ssff, per row ci        format(%12.1fc) 
svy: tab   DPTO   ssff, per row cv        format(%12.1fc) 

