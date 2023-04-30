using UnityEngine;
using DG.Tweening;
using System.Threading.Tasks;

public class Shape : MonoBehaviour {

    public static Color[] colors = new Color[] { Color.red, Color.white, Color.cyan, Color.green, Color.magenta, Color.gray };

    [SerializeField] GameObject explosion;
    SpriteRenderer spriteRenderer;
    Player player;
    float rotationSpeed;
    float speed;

    [HideInInspector]
    public Color Color {
        get {
            return spriteRenderer.color;
        }

        set {
            spriteRenderer.color = value;
        }
    }

    private void Awake() {
        rotationSpeed = Random.Range(-20, 20);
        speed = Random.Range(4, 5);
        spriteRenderer = GetComponent<SpriteRenderer>();
        player = FindObjectOfType<Player>();
    }

    private void Update() {
        transform.Rotate(new Vector3(0, 0, rotationSpeed * Time.deltaTime));
        transform.position -= new Vector3(0, speed * Time.deltaTime);

        if (transform.position.y <= -6) {
            Destroy(gameObject);
        }
    }

    private async void Death(Color color) {
        speed = 0;
        Destroy(GetComponent<Collider2D>());

        SpriteRenderer sr = Instantiate(explosion, transform.position, transform.rotation).GetComponent<SpriteRenderer>();
        sr.color = Color;

        player.Color = color;
        Destroy(gameObject);
        await Task.Delay(1000);

        Destroy(sr.gameObject);
    }

    private void OnTriggerEnter2D(Collider2D collision) {
        if (collision.CompareTag("Player")) {
            if (player.changeShape) return;

            Camera.main.transform.DOShakePosition(.5f);

            bool equals = Color.Equals(player.Color);
            Death(equals ? colors[Random.Range(0, colors.Length)] : Color);

            if (!equals) {
                player.Damage();
            } else {
                Score.AddScore();
            }
        }
    }
}