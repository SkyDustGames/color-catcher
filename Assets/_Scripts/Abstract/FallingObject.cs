using UnityEngine;
using DG.Tweening;
using System.Threading.Tasks;

public abstract class FallingObject : MonoBehaviour {

    [SerializeField] protected GameObject explosion;
    [SerializeField] protected string sound = "Collect";
    protected float speed;
    protected float rotationSpeed;
    protected SpriteRenderer spriteRenderer;

    protected Player player;

    private void Awake() {
        speed = Random.Range(4, 5);
        rotationSpeed = Random.Range(-20, 20);
        player = FindObjectOfType<Player>();
        spriteRenderer = GetComponent<SpriteRenderer>();
    }

    private void Update() {
        transform.Rotate(new Vector3(0, 0, rotationSpeed * Time.deltaTime));
        transform.position -= new Vector3(0, speed * Time.deltaTime);

        if (transform.position.y <= -6) {
            Destroy(gameObject);
        }
    }

    protected async void Death() {
        Camera.main.transform.DOShakePosition(.5f); 
        AudioManager.Play(sound);

        speed = 0;
        Destroy(GetComponent<Collider2D>());

        GameObject sr = Instantiate(explosion, transform.position, transform.rotation);

        Destroy(gameObject);
        await Task.Delay(1000);

        Destroy(sr);
    }
}