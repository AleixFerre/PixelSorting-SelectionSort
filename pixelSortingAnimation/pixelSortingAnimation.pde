/*
-------------------------- PIXEL SORT ANIMATION --------------------------
by Aleix Ferré and Javi || The Coding Train Channel

(ca:)

Aquest programa en Java ens permet ordenar els pixels d'una imatge entrada
pel valor que nosaltres vulguem. Això crea un efecte a la imatge bastant bonic
i artístic. Sembla humà però és una màquina.

*-> Notes:  Aquest programa és bastant ineficient degut a la ordenació de SELECCIÓ
            DIRECTA [Selection Sort]. Això es podria arreglar amb un QuickSort
            (encara no implementat). Pot ser que això afecti al resultat final ja 
            que cada algorisme ordena les llistes de forma diferent.

*-> Eficiència: O(n^2); [Selection Sort]

*-> Recomanacions:  No passar MAI d'imatges de més de 200-400x200-400 px
                    Això podria provocar que el programa tardi massa en veure
                    els resultats.
                    Ex: Una imatge en 4K [3840x2160px] (en una CPU actual) tardaria
                    81 anys en ordenar-se!
                    
-----------------------------------------------------------------------------------
(en:)

This Processing program allows us to sort the pixels of an image for the value
that we want. This creates a pretty nice and artistic effect on the image.
It looks human but it is a machine.

* -> Notes:  This program is quite inefficient due to the SELECTION order
             DIRECT [Selection Sort]. This could be fixed with a QuickSort
             (not yet implemented). This may affect the final result already
             that each algorithm orders the lists differently.

* -> Efficiency: O(n^2); [Selection Sort]

* -> Recommendations:  Never spend more images of 200-400x200-400 px
                       This could cause the program to take too long to see
                       the results
                       Ex: An image in 4K [3840x2160px] (in a current CPU) would take
                       81 years to finish!

*/

PImage img; // Original
PImage sorted; // Artificial, modificada per nosaltres
int index = 0; // Index del pixel actual de 'img'

void setup(){
  size(400,200);
  img = loadImage("rainbow.jpg"); // INTRODUEIX LA IMATGE QUE VULGUIS DE LA CARPETA /data/
  image(img, 0, 0, 200, 200);
  
  sorted = createImage(img.width, img.height, RGB);
  sorted = img.get(); // Copiem tots els pixels d'una imatge a una nova creada per nosaltres
  sorted.loadPixels(); // Carreguem els pixels per treballar amb ells
}

void draw(){
  for(int i = 0; i<100; i++){ // Actualitzem 100 pixels per frame
    //Selection Sort 
    float record = -1;
    int selectedPixel = index;
    for (int j = index; j < sorted.pixels.length; j++){
      color pix = sorted.pixels[j];
      float b = saturation(pix); // saturation || hue || brightness
      if (b > record) {
        selectedPixel = j;
        record = b;
      }
    }
    
    // Intercambiem selectedPixel (el pixel que té el valor més alt) amb i (el pixel actual)
    color temp = sorted.pixels[index];
    sorted.pixels[index] = sorted.pixels[selectedPixel];
    sorted.pixels[selectedPixel] = temp;
    
    if (index < sorted.pixels.length-1){ // Si encara hi ha pixels a analitzar
      index++; // Actualitza l'index per anar al seguent pixel
    }
    else {
      saveFrame("composed.png"); // Guardem una foto de la pantalla
      index = 0;
      sorted = img.get(); // Ho tornem a començar
    }
    println("FPS:", floor(frameRate));
  }
  sorted.updatePixels(); // Actualitzem els pixels de la nostra imatge al canvi que hem fet
  image(sorted, 200, 0); // Ho mostrem per pantalla
}
