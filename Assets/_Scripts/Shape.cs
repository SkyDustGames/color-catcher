using UnityEngine;
using DG.Tweening;
using System.Threading.Tasks;

public class Shape : FallingObject {

    public static Color[] colors = new Color[] { Color.red, Color.white, Color.cyan, Color.green, Color.magenta, Color.gray };

    [HideInInspector]
    public Color Color {
        get {
            return spriteRenderer.color;
        }

        set {
            spriteRenderer.color = value;
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