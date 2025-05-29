#include <iostream>
#include <stdlib.h>
#include <omp.h>
#include "f1.h"
#include "f2.h"
#include "f3.h"
#include "f4.h"
int main() {
const int n = 1024*1024*1024;
float *t0 = (float*)aligned_alloc(64, n*sizeof(float));
float *t1 = (float*)aligned_alloc(64, n*sizeof(float));
float *t2 = (float*)aligned_alloc(64, n*sizeof(float));
for(int i=0; i<n; ++i) {
t0[i] = i * 1.0;
t1[i] = i*3.0;
t2[i] = 0.0;
}
double time;
time = omp_get_wtime();
//f1    
for(int i=0; i<n; ++i)
scalar_add(t0[i],t1[i],t2[i]);

//f2
for(int i=0; i<n; i+=4){
    __m128 a= _mm_load_ps(&t0[i]);
    __m128 a= _mm_load_ps(&t1[i]);
    __m128 c;
    sse_add(a,b,c);
    _mm_store_ps(&t2[i], c);}
 
//f3
for(int i=0; i<n; i+=8){
    __m256 a= _mm256_load_ps(&t0[i]);
    __m256 a= _mm256_load_ps(&t1[i]);
    __m256 c;
    avx_add(a,b,c);
    _m256_store_ps(&t2[i], c);}

//f4
for(int i=0; i<n; i+=8){
    __m512d a= _mm512_load_pd((double*)&t0[i]);
    __m512d a= _mm512_load_pd((double*)&t1[i]);
    __m512d c;
    avx512_add(a,b,c);
    _mm512_store_pd((double*)&t2[i], c);}
    
    
    
time = omp_get_wtime() - time;
std::cout<<time<<" czas wykonania obl."<<std::endl;
free(t0);
free(t1);
free(t2);
return 0;
}
