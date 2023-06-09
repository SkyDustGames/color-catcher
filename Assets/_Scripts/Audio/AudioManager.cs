using UnityEngine;

public class AudioManager : MonoBehaviour {

    [System.Serializable]
    public class Sound {
        public string name;
        [HideInInspector] public AudioSource source;
        [Range(0, 1)] public float volume;
        public bool loop;
        public AudioClip clip;
    }

    private static AudioManager instance;
    public Sound[] sounds;

    private void Awake() {
        transform.SetParent(null, false);
        if (instance != null) {
            Destroy(gameObject);
            return;
        }

        instance = this;
        DontDestroyOnLoad(instance);

        foreach (Sound sound in sounds) {
            sound.source = gameObject.AddComponent<AudioSource>();
            sound.source.loop = sound.loop;
            sound.source.volume = sound.volume;
            sound.source.clip = sound.clip;
        }
    }

    public static void Play(string name) {
        foreach (Sound sound in instance.sounds) {
            if (sound.name == name) {
                sound.source.Play();
                break;
            }
        }
    }

    public static void Stop(string name) {
        foreach (Sound sound in instance.sounds) {
            if (sound.name == name) {
                sound.source.Stop();
                break;
            }
        }
    }

    public static Sound GetSound(string name) {
        foreach (Sound sound in instance.sounds) {
            if (sound.name == name) {
                return sound;
            }
        }
        
        return null;
    }
}