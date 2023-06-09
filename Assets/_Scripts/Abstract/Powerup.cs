using System.Threading.Tasks;
using UnityEngine;

public abstract class Powerup : FallingObject {

    public async void IApply() {
        Death();
        await Apply();
    }

    public abstract Task Apply();

    private void OnTriggerEnter2D(Collider2D collision) {
        if (collision.CompareTag("Player")) {
            if (player.changeShape) return;
            IApply();
        }
    }
}