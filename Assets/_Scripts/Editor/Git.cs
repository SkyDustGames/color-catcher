using UnityEditor;
using UnityEngine;
using System.Diagnostics;

public class Git : EditorWindow {

    private string commitMessage = "Commit Message...";
    private string branch = "Branch...";
    private string remote = "Remote...";

    [MenuItem("Window/Git")]
    public static void Start() {
        GetWindow<Git>();
    }

    private void StartProcess(string name, string parameters) {
        Process process = new Process();
        ProcessStartInfo startInfo = new ProcessStartInfo();
        startInfo.WindowStyle = ProcessWindowStyle.Hidden;
        startInfo.FileName = "cmd.exe";
        startInfo.Arguments = "/C " + name + " " + parameters;
        process.StartInfo = startInfo;
        process.Start();
    }

    private void OnGUI() {
        commitMessage = EditorGUILayout.TextField(commitMessage);
        branch = EditorGUILayout.TextField(branch);

        if (GUILayout.Button("Add All"))
            StartProcess("git", "add --all");
        if (GUILayout.Button("Commit"))
            StartProcess("git", "commit -m \"" + commitMessage + "\"");
        if (GUILayout.Button("Push"))
            StartProcess("git", "push -u " + remote + " " + branch);
    }
}