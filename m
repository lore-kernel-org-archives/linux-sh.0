From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Apr 2015 02:07:32 +0000
Subject: Re: [PATCH] ASoC: rsnd: Use generic names for device nodes
Message-Id: <20150428020731.GB26051@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430138949-14563-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430138949-14563-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Apr 27, 2015 at 02:49:09PM +0200, Geert Uytterhoeven wrote:
> rcar_sound -> sound
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index f316ce1f214a03e3..62ece4c59da759a4 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -47,7 +47,7 @@ DAI subnode properties:
>  
>  Example:
>  
> -rcar_sound: rcar_sound@ec500000 {
> +rcar_sound: sound@ec500000 {
>  	#sound-dai-cells = <1>;
>  	compatible = "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2";
>  	reg =	<0 0xec500000 0 0x1000>, /* SCU */
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
