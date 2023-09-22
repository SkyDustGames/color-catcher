using System.Threading.Tasks;

public class ShapePowerup : Powerup {

    public override Task Apply() {
        player.ChangeShape();
        return Task.Delay(0);
    }
}