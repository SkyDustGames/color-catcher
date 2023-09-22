using UnityEngine;
using TMPro;

public class Score : MonoBehaviour {

    [SerializeField] TextMeshProUGUI tScore;

    int score;
    int highscore;

    static Score instance;

    private void Awake() {
        instance = this;
        highscore = PlayerPrefs.GetInt("Highscore", 0);
    }

    public static void AddScore(int amount = 1) {
        instance.score += amount;
        if (instance.highscore < instance.score) {
            instance.highscore = instance.score;
            PlayerPrefs.SetInt("Highscore", instance.highscore);
        }

        instance.tScore.text = string.Format("Score: {0}", instance.score);
    }
}