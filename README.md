Proiectul propus se concentrează asupra operațiilor de înmulțire a numerelor reprezentate conform standardului IEEE 754 pentru virgulă mobilă. 
Pentru rezolvarea problemelor asociate reprezentării în virgulă fixă, s-a propus utilizarea reprezentării în virgulă mobilă cu scalare automată.
Această abordare implică includerea factorului de scală în cuvântul de calculator, iar poziția virgulei binare se ajustează automat pentru fiecare număr. 
O reprezentare în virgulă mobilă constă într-o mantisă (M) și un exponent (E), stocate într-un cuvânt cu trei câmpuri: semnul, mantisa și exponentul.
Una dintre provocările în reprezentarea în virgulă mobilă este gestionarea depășirilor superioare și inferioare. 
Depășirea superioară apare atunci când exponentul depășește valoarea maximă, în timp ce depășirea inferioară apare când exponentul are o valoare sub pragul minim.
Soluția propusă pentru aceste probleme constă în implementarea corectă a reprezentării numerelor conform standardului IEEE 754 pe 32 de biți, algoritmului corespunzător 
înmulțirii numerelor în virgulă mobilă și aplicarea unei operații de rotunjire pentru obținerea unor rezultate precise. Scopul proiectului este de a asigura o implementare 
corectă și eficientă a acestor operații în conformitate cu standardele stabilite.
