import flixel.system.FlxAssets.FlxShader;

class MotionBlurShaders extends FlxFixedShader {
    public function new(motion_blur:Null<Bool> = null, passes:Int = 10) {
        super();
        this.enabled.value = [true];
        this.blurEnabled.value = [motion_blur];
        this.y.value = [0.75];
        this.passes.value = [passes];
    }
}