using System.Threading.Tasks;

public class SpeedPowerup : Powerup {

    public override async Task Apply() {
        player.SpeedUp();
        await Task.Delay(10000);
        player.SpeedUp(-50);
    }
}