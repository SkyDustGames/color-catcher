using UnityEngine;

public class Spawner : MonoBehaviour {

    public static float difficulty = 1;

    [SerializeField] float time;
    [SerializeField] GameObject[] objects;
    [SerializeField] GameObject[] powerups;
    float timer;

    private void Update() {
        timer += Time.deltaTime;

        if (timer >= time) {
            timer = 0;
            transform.position = new Vector3(Random.Range(-7, 7), transform.position.y);

            if (Random.value < .25) {
                Instantiate(powerups[Random.Range(0, powerups.Length)], transform.position, transform.rotation);
                return;
            }

            time -= difficulty / 10f;
            if (time < 0.5f) time = 0.5f;

            GameObject @object = Instantiate(objects[Random.Range(0, objects.Length)], transform.position, transform.rotation);
            @object.GetComponent<Shape>().Color = Shape.colors[Random.Range(0, Shape.colors.Length)];
        }
    }
}