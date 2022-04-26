package gamejolt;

class GameJoltInfo
{
    /**
    * Inline variable to change the font for the GameJolt API elements.
    * @param font You can change the font by doing **Paths.font([Name of your font file])** or by listing your file path.
    * If *null*, will default to the normal font.
    */
    public static var font:String = null; /* Example: Paths.font("vcr.ttf"); */
    /**
    * Inline variable to change the font for the notifications made by Firubii.
    * 
    * Don't make it a NULL variable. Worst mistake of my life.
    */
    public static var fontPath:String = "assets/fonts/vcr.ttf";
    /**
    * Image to show for notifications. Leave NULL for no image, it's all good :)
    * 
    * Example: Paths.getLibraryPath("images/stepmania-icon.png")
    */
    public static var imagePath:String = null; 

    /* Other things that shouldn't be messed with are below this line! */

    /**
    * GameJolt + FNF version.
    */
    public static var version:String = "1.1";
    /**
     * Random quotes I got from other people. Nothing more, nothing less. Just for funny.
     */
    public static var textArray:Array<String> = [
        "I should probably push my commits...",
        "Where is my apple cider?",
        "Mario be like wahoo!",
        "[Funny IP address joke]",
        "I love Camellia mod",
        "I forgot to remove the IP grabber...",
        "Play Post Mortem Mixup",
        "*Spontaniously combusts*",
        "Holofunk is awesome",
        "What you know about rollin down in the deep",
        "This isn't an NFT. Crazy right?",
        "no not the null reference :(",
        "Thank you BrightFyre for your help :)",
        "Thank you Firubii for the notification code :)"
    ];
}