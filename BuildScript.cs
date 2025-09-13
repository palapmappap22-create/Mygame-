#if UNITY_EDITOR
using UnityEditor;
public class BuildScript {
    public static void BuildAndroid() {
        string[] scenes = { "Assets/Scenes/MainMenu.unity" };
        string path = "build/Snake.Balest.apk";
        BuildPlayerOptions opts = new BuildPlayerOptions();
        opts.scenes = scenes;
        opts.locationPathName = path;
        opts.target = BuildTarget.Android;
        opts.options = BuildOptions.None;
        BuildPipeline.BuildPlayer(opts);
    }
}
#endif
