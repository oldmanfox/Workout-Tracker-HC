#if defined(__has_feature) && __has_feature(objc_generics)
#  define SC_GENERIC(Ts...) <Ts>
#else
#  define SC_GENERIC(Ts...)
#endif
