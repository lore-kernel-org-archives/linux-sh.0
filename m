From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Feb 2015 01:49:17 +0000
Subject: Re: [PATCH v4 5/9] ASoC: rsnd: Document r8a7778-specific bindings
Message-Id: <20150227014916.GD31738@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424968934-30577-6-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424968934-30577-6-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[Cc Mark Brown]

On Thu, Feb 26, 2015 at 05:42:10PM +0100, Ulrich Hecht wrote:
> Adds "renesas,rcar_sound-r8a7778".
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 1 +
>  1 file changed, 1 insertion(+)

Thanks, this looks good to me. I believe it should be handled by
Mark Brown so please repost it to him and the appropriate ML.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Alternatively, I am happy to take this if Mark provides an Ack.

> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index 2dd690b..67c9861 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -5,6 +5,7 @@ Required properties:
>  				  "renesas,rcar_sound-gen1" if generation1, and
>  				  "renesas,rcar_sound-gen2" if generation2
>  				  Examples with soctypes are:
> +				    - "renesas,rcar_sound-r8a7778" (R-Car M1)
>  				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
>  				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
>  - reg				: Should contain the register physical address.
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
