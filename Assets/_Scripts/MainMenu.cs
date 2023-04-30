using TMPro;
using UnityEngine;
using DG.Tweening;
using System.Collections;

public class MainMenu : MonoBehaviour {

    [SerializeField] TextMeshProUGUI highscore;
    [SerializeField] CanvasGroup group;

    private void Awake() {
        highscore.text = string.Format("Highscore: {0}", PlayerPrefs.GetInt("Highscore"));
    }

    public void Play() {
        StartCoroutine(IPlay());
    }

    private IEnumerator IPlay() {
        group.DOFade(0f, 1f);
        Camera.main.transform.DOMove(new Vector3(10f, 0f, -10), 1f);
        yield return new WaitForSeconds(1);
        Scenes.instance.LoadScene(1);
    }

    public void Quit() {
        Application.Quit();
    }
}