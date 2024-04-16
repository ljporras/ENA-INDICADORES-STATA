clear all
cd   "D:\ENA"
use 15_Cap700.dta, clear

/*
CODIGO: CÓDIGO DE IDENTIFICACIÓN
1 Pequeños y medianos productores/as agropecuarios/as
2 Grandes productores/as agropecuarios/as

OMICAP700: OMISION DEL CAPITULO 700

FACTOR: FACTOR DE EXPANSION

REGION: REGION NATURAL

NOMBREDD: Nombre de Departamento

CONGLOMERADO: Conglomerado #

DOMINIO: DOMINIO GEOGRAFICO
********************************************************************************

NPACRC: # de productores agropecuarios que utilizan servicios de info. agropecuaria.
NTPA: # total de productores agropecuarios.

Numerador: Número de productores agropecuarios que utilizan servicios de información
agropecuaria, es decir, en el Capítulo 700, Sección 700C, Pregunta 707, tienen
circulado el código 1, en por lo menos uno de los Ítems del 1 al 8; y 
en la Pregunta 708 tienen anotado alguno de los código del 1 al 6.

Denominador: Número de productores agropecuarios, es decir, que en el Capítulo 100,
Pregunta 102, tienen registrado solo el código 1, el código 2 o los códigos 1 y 2.


P102_1 EN LOS ÚLTIMOS 12 MESES, DE…..A…….., LA EMPRESA/UD, REALIZÓ ACTIVIDAD: ¿Agrícola?
P102_2 EN LOS ÚLTIMOS 12 MESES, DE…..A…….., LA EMPRESA/UD, REALIZÓ ACTIVIDAD: ¿Pecuaria?

P707_1 EN LOS ULT. 12 MESES ¿LA EMPRESA/UD. UTILIZÓ INFO AGROPECUARIA COMO: Precio de venta (chacra, mayorista, minorista)? 1 Sí 2 No
P708_1_1 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Ministerio de Agricultura y Riego
P708_1_2 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Gobierno Regional
P708_1_3 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Gobierno Local
P708_1_4 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Organismo No Gubernamental (ONG)
P708_1_5 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Empresa Privada
P708_1_6 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Asociación de productores/as

P707_2 EN LOS ULT. 12 MESES ¿LA EMPRESA/UD. UTILIZÓ INFO AGROPECUARIA COMO: Cantidad producida? 1 Sí 2 No
P708_2_1 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Ministerio de Agricultura y Riego
P708_2_2 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Gobierno Regional
P708_2_3 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Gobierno Local
P708_2_4 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Organismo No Gubernamental (ONG)
P708_2_5 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Empresa Privada
P708_2_6 ¿QUIÉN LE BRINDÓ LA INFORMACIÓN? Asociación de productores/as

SE REPITE HASTA EL P707_8 & P708_8_6

*/

sum P707_1 P707_2 P707_3 P707_4 P707_5 P707_6 P707_7 P707_8
recode P707_1 P707_2 P707_3 P707_4 P707_5 P707_6 P707_7 P707_8 (2=0)

egen P707= rowtotal(P707_1 P707_2 P707_3 P707_4 P707_5 P707_6 P707_7 P707_8)
tab P707

egen P708=rowtotal(P708_1_1 P708_1_2 P708_1_3 P708_1_4 P708_1_5 P708_1_6 P708_2_1 P708_2_2 P708_2_3 P708_2_4 P708_2_5 P708_2_6 P708_3_1 P708_3_2 P708_3_3 P708_3_4 P708_3_5 P708_3_6 P708_4_1 P708_4_2 P708_4_3 P708_4_4 P708_4_5 P708_4_6 P708_5_1 P708_5_2 P708_5_3 P708_5_4 P708_5_5 P708_5_6 P708_6_1 P708_6_2 P708_6_3 P708_6_4 P708_6_5 P708_6_6 P708_7_1 P708_7_2 P708_7_3 P708_7_4 P708_7_5 P708_7_6 P708_8_1 P708_8_2 P708_8_3 P708_8_4 P708_8_5 P708_8_6)  
tab P708

gen     ppacrc=0 if (P102_1==1 | P102_2==1) & CODIGO==1 & OMICAP700~="99" 
replace ppacrc=1 if (P707>0 & P708>0) & CODIGO==1 & OMICAP700~="99" 
label var  ppacrc "Pro. agropecuarios usaron sist. inf. agro."
la de nosi 0 "No" 1 "Si"
label values ppacrc nosi

tab REGION   ppacrc    [iw= FACTOR] , row nofreq
tab NOMBREDD ppacrc    [iw= FACTOR] , row nofreq


gen DPTO=NOMBREDD
replace DPTO="LIMA" if NOMBREDD=="CALLAO"
svyset [pweight=FACTOR],  psu(CONGLOMERADO) strata(DOMINIO)

svy: tab   REGION ppacrc, per row cv ci obs format(%12.1fc)  
svy: tab   DPTO   ppacrc, per row           format(%12.1fc) 
svy: tab   DPTO   ppacrc, per row obs       format(%12.1fc) 
svy: tab   DPTO   ppacrc, per row ci        format(%12.1fc) 
