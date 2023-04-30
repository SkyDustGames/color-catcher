using DG.Tweening;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Scenes : MonoBehaviour {

    [SerializeField] GameObject panel;

    public static Scenes instance;

    private void Awake() {
        transform.SetParent(null, false);

        if (instance != null) {
            Destroy(gameObject);
            return;
        }

        instance = this;
        DontDestroyOnLoad(instance);

        panel.transform.localScale = new Vector3(2, 2, 2);
        SceneManager.sceneLoaded += (n1, n2) => {
            panel.transform.DOScale(0, 1f).SetUpdate(true);
        };
    }

    public async void LoadScene(int index) {
        panel.transform.DOScale(2, 1f).SetUpdate(true);
        await System.Threading.Tasks.Task.Delay(1000);
        Time.timeScale = 1;
        SceneManager.LoadScene(index);
    }

    public void LoadScene(string name) {
        LoadScene(SceneManager.GetSceneByName(name).buildIndex);
    }

    public void ReloadScene() {
        LoadScene(Active.buildIndex);
    }

    public Scene Active {
        get {
            return SceneManager.GetActiveScene();
        }
    }
}