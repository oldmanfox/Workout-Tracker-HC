#if defined(__has_feature) && __has_feature(objc_generics)
#  define SC_GENERIC(Ts...) <Ts>
#else
#  define SC_GENERIC(Ts...)
#endif

#ifdef SCHART_HIDE_DEPRECATIONS
#   undef SCHART_DEPRECATED
#   undef SCHART_MSG_DEPRECATED
#   define SCHART_DEPRECATED
#   define SCHART_MSG_DEPRECATED(...)
#endif

#ifndef SCHART_MSG_DEPRECATED
#    define SCHART_MSG_DEPRECATED DEPRECATED_MSG_ATTRIBUTE
#endif

#ifndef SCHART_DEPRECATED
#    define SCHART_DEPRECATED DEPRECATED_ATTRIBUTE
#endif
