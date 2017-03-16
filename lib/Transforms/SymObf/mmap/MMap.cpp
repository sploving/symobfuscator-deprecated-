#include "MMap.h"
#include "MathUtils.h"

using namespace std;

int64_t zMax = 128;
int64_t hMax = 128;
int64_t gMax = 65535;
int64_t pMax = 2147483647;

struct secparam sp;

int64_t MMapInitParam(int64_t z, int64_t n, int64_t setnum){
  sp.Z = z;
  sp.N = n;
  sp.setnum = setnum;
  /*
  sp.z = (int64_t *) malloc (sizeof(int64_t) * sp.Z); 
  sp.h = (int64_t *) malloc (sizeof(int64_t) * sp.N); 
  sp.g = (int64_t *) malloc (sizeof(int64_t) * sp.N); 
  sp.ginv = (int64_t *) malloc (sizeof(int64_t) * sp.N); 
  sp.p = (int64_t *) malloc (sizeof(int64_t) * sp.N); 
  sp.setid = (vector<int64_t> *) malloc (sizeof(vector<int64_t>) * sp.setnum); 

  srand((unsigned)time(NULL));
  for(int64_t i =0; i< sp.Z; i++){
    sp.z[i] = rand() % zMax; 
  }

  for(int64_t i =0; i< sp.N; i++){
    sp.g[i] = GetPrime(gMax); 
    sp.p[i] = GetPrime(pMax); 
    sp.ginv[i] = InvMod(sp.g[i], sp.p[i]); 
    sp.h[i] = rand() % hMax; 
    sp.q = sp.q * sp.p[i]; 
  }
  //TODO:To implement more secure set mechanism
  for(int64_t i =0; i< sp.setnum; i++){
    sp.setid[i].push_back(sp.z[i]);
  }
  */
}


int64_t MMapIsZero(double u){
  double pzt = 0;
  for(int64_t i=0; i<sp.N; i++){
	int mid = 1;
	int64_t tail = 1;
    for(int64_t j=0; j<sp.Z; j++){
	  mid = (mid * sp.ginv[i] * sp.z[j]) % sp.p[i];
	}
    for(int64_t k=0; k<sp.N; k++){
	  if (k!=i){
	    tail = tail * sp.p[k] % sp.q;
	  }
	}
    pzt = pzt + sp.h[i] * mid * tail; 
  }
  pzt = (int64_t) fmod((pzt * u), sp.q);
  if(abs(pzt) < sp.q * pow(2,-2-sp.N-sp.alphalen))
	return 1;
  return 0;
}

double MMapEnc(int64_t m, int64_t mid, int64_t setid){
  int64_t set = 1;
  for(int i=0; i<sp.setid[setid].size(); i++){
	int64_t zid = sp.setid[setid][i];
    set = set * sp.z[zid];
  }
  double rest = fmod((sp.h[mid] * sp.g[mid] + m) /  set, sp.p[mid]);
  return rest;
}

double MMapAdd(double u1, double u2, int64_t mid){
  double rest = fmod(u1+u2, sp.p[mid]);
  return rest;
}

double MMapMult(double u1, double u2, int64_t mid){
  double rest = fmod(u1*u2, sp.p[mid]);
  return rest;
}
