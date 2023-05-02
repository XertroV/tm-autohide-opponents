#if DEV

Meta::PluginCoroutine@ tests = startnew(RunTests);

void RunTests() {

}





bool LooksLikePointer(uint64 ptr) {
    if (ptr < 0x000001000fffffff || ptr > 0x00000fffffffffff)
        return false;

    return true;
}





#endif
