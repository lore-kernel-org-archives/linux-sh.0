From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Jun 2015 00:34:58 +0000
Subject: Re: [PATCH] ASoC: rsnd: Document r8a7778-specific binding
Message-Id: <20150602003457.GB4781@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1433155455-28827-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1433155455-28827-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Jun 01, 2015 at 12:44:15PM +0200, Geert Uytterhoeven wrote:
> Add the missing r8a7778-specific compatible value, which is already in
> use since v4.1-rc1.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Apologies for not noticing this myself.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index 62ece4c59da759a4..b6b3a786855f275b 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -5,6 +5,7 @@ Required properties:
>  				  "renesas,rcar_sound-gen1" if generation1, and
>  				  "renesas,rcar_sound-gen2" if generation2
>  				  Examples with soctypes are:
> +				    - "renesas,rcar_sound-r8a7778" (R-Car M1A)
>  				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
>  				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
>  - reg				: Should contain the register physical address.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
