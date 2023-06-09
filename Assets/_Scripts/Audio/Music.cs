using UnityEngine;

public class Music : MonoBehaviour {

    public string stop;
    public string start;

    private void Start() {
        Destroy(this, 5);

        AudioManager.Sound playing = AudioManager.GetSound(start);
        AudioManager.Sound stopping = AudioManager.GetSound(stop);

        if (playing == stopping) return;

        stopping.source.Stop();
        playing.source.Play();
    }
}