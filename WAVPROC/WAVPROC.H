#ifndef _WAVPROC
#define _WAVPROC
//////////////////////////folosite de BPCF si TEST////////////////////////////

#define BETA    0.8     // coeficient exponentiala
#define PRAG    0.7     // prag de recunoastere (la test)

#define NTD     4       // numar de neuroni/grup de comprimare
#define NH1     12      // numar de neuroni/first hidden layer
#define NH2     8       // numar de neuroni/second hidden layer
#define NO      5      // numar de neuroni/output layer (clase) (si B2A)
#define NTR     200     // numar vectori de antrenare
#define NTE     100     // numar vectori de test

#define NRFER   20      // numar total de ferestre achizitionate (si B2A si WAVPROC)
#define NRFRECV 12      // numar de frecvente/fereastra-spectru (si B2A si WAVPROC)

#define Ncuante_SIG 1024// numarul de valori sigmoid tabelate
#define cuanta_SIG  0.01354// pasul de calcul sigmoid

//////////////////////////folosite de WAVPROC/////////////////////////////////

#define WIDTH   128     // numar de esantioane/fereastra-timp (latime fer)
#define DEPL    64      // numarul de esantioane cu care plimb fereastra

//header fisier .WAV (RIFF)
typedef struct
{       char rId[4];                  // "RIFF"
        unsigned long rLen;           // lungime fisier-(len(rId)+len(rLen))
        char wId[4];                  // "WAVE"         \________  ________/
        char fId[4];                  // "fmt "                  \/
        unsigned long fLen;           // lungime format (10)     (8)
        unsigned int wFormatTag;      // 8b samples uncompressed
        unsigned int nChannels;       // 1=mono : 2=stereo
        unsigned long nSamplesPerSec; // 0x00002b11
        unsigned long nAvgBytesPerSec;// nChannels*nSamplesPerSec*(nBitsPer_Sample/8)
        unsigned int nBlockAlign;     // nChannels*(nBitsPerSample/8)
        unsigned int FormatSpecific;
        char dId[4];                  // "data"
        unsigned long dLen;           // lungime date
}RIFFheader;   // (folosit si in WARP_EXT)

//header fisier binar de iesire
typedef struct
{       unsigned int Nvect;           // nr vectori
        char sp1;                     // spatiu (' '=0x20)
        unsigned int Ni;              // nr intrari in retea (NRFER*NRFRECV)
        char sp2;                     // spatiu (' '=0x20)
        char crlf[2];                 // CRLF (0x0d 0x0a)
}BINheader;

//////////////////////////folosite peste tot, mai putin BPCF si TEST//////////
#define paramERR  1     //\
#define fileERR   2     // \ coduri mesaje de eroare
#define ftypeERR  3     // /
#define memERR    4     ///

#endif  //_WAVPROC