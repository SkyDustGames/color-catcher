using UnityEngine;
using DG.Tweening;
using System.Collections;

public class Player : MonoBehaviour {

    [SerializeField] float speed;
    [SerializeField] int lives;
    [SerializeField] GameObject explosion;
    [SerializeField] GameObject[] tLives;
    [SerializeField] Sprite[] sprites;
    int startLives;
    Rigidbody2D rb;
    SpriteRenderer spriteRenderer;
    float movement;

    [HideInInspector] public bool changeShape;

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
        rb = GetComponent<Rigidbody2D>();
        spriteRenderer = GetComponent<SpriteRenderer>();
        startLives = lives;

        Color = Shape.colors[Random.Range(0, Shape.colors.Length)];
        spriteRenderer.sprite = sprites[Random.Range(0, sprites.Length)];
    }

    private void Update() {
        if (changeShape) return;
        movement = Input.GetAxis("Horizontal");

        if (Input.GetKeyDown(KeyCode.E)) ChangeShape();
    }

    private IEnumerator IChangeShape() {
        Color color = Color;

        changeShape = true;
        movement = 0;

        GetComponent<SpriteRenderer>().DOColor(Color.white, .5f);
        transform.DOScale(1.1f, 1f);

        yield return new WaitForSeconds(1);

        transform.DOScale(1, .1f);
        SpriteRenderer sr = Instantiate(explosion, transform.position, transform.rotation).GetComponent<SpriteRenderer>();
        sr.color = Color;

        yield return new WaitForSeconds(.1f);
        Damage(-(startLives - lives));
        AudioManager.Play("Switch Shape");

        yield return new WaitForSeconds(.4f);
        spriteRenderer.sprite = sprites[Random.Range(0, sprites.Length)];
        Color = color;
        changeShape = false;

        yield return new WaitForSeconds(.5f);

        Destroy(sr.gameObject);
    }

    public void ChangeShape() => StartCoroutine(IChangeShape());

    private void FixedUpdate() {
        rb.velocity = new Vector2(movement * speed * Time.fixedDeltaTime, 0);
    }

    public void Damage(int amount = 1) {
        lives -= amount;
        if (amount <= 0) {
            for (int i = 0; i < lives; i++) {
                tLives[i].SetActive(true);
            }
        } else {
            tLives[lives].SetActive(false);
        }

        if (lives <= 0) {
            Instantiate(explosion, transform.position, transform.rotation).GetComponent<SpriteRenderer>().color = Color;
            Destroy(gameObject);

            Sequence s = DOTween.Sequence();
            s.Append(DOVirtual.Float(1f, 0, .3f, v => Time.timeScale = v));
            Camera.main.DOColor(Color.white, .3f);
            Death(s);
        }
    }

    public async void Death(Sequence s) {
        await System.Threading.Tasks.Task.Delay(5000);
        s.Kill(true);
        Scenes.instance.LoadScene(0);
    }

    public void SpeedUp(float amount = 50) {
        speed += amount;
    }
}