using UnityEngine;
using DG.Tweening;

public class PauseMenu : MonoBehaviour {

    public static bool gamePaused;
    [SerializeField] CanvasGroup group;

    private void Update() {
        if (Input.GetKeyDown(KeyCode.Escape)) TogglePause();
    }

    public void TogglePause() {
        gamePaused = !gamePaused;
        Time.timeScale = gamePaused ? 0 : 1;

        group.DOFade(gamePaused ? 1 : 0, .5f).SetUpdate(true);
        group.blocksRaycasts = gamePaused;
        group.interactable = gamePaused;

        AudioManager.Play("Select");
    }

    public void Quit() {
        Scenes.instance.LoadScene(0);
        AudioManager.Play("Select");
    }
}