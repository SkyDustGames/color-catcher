using UnityEngine;

public class MainMenu : MonoBehaviour {

    public void Play() {
        Scenes.instance.LoadScene(1);
    }

    public void Quit() {
        Application.Quit();
    }
}