# POSIX sh: appended to MOZ_GMP_PATH once, safe under dash and bash.
case ":${MOZ_GMP_PATH}:" in
    *":/var/lib/widevine/gmp-widevinecdm/system-installed:"*) ;;
    *)
        MOZ_GMP_PATH="${MOZ_GMP_PATH}${MOZ_GMP_PATH:+:}/var/lib/widevine/gmp-widevinecdm/system-installed"
        export MOZ_GMP_PATH
        ;;
esac
