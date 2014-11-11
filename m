From: Simon Horman <horms@verge.net.au>
Date: Tue, 11 Nov 2014 00:25:18 +0000
Subject: Re: [PATCH 3/5] ASoC: rsnd: Document SoC-specific bindings
Message-Id: <20141111002517.GF29665@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415646044-4168-1-git-send-email-geert+renesas@glider.be>
 <1415646044-4168-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415646044-4168-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Nov 10, 2014 at 08:00:42PM +0100, Geert Uytterhoeven wrote:
> The documentation only mentioned the generic fallback compatible
> property.
> Add the missing SoC-specific compatible properties, which are already in
> use.
> 
> Also drop a bogus 0x unit-address prefix while we're at it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> index aa697abf337e7aa6..2dd690bc19cc6436 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
> @@ -1,8 +1,12 @@
>  Renesas R-Car sound
>  
>  Required properties:
> -- compatible			: "renesas,rcar_sound-gen1" if generation1
> +- compatible			: "renesas,rcar_sound-<soctype>", fallbacks
> +				  "renesas,rcar_sound-gen1" if generation1, and
>  				  "renesas,rcar_sound-gen2" if generation2
> +				  Examples with soctypes are:
> +				    - "renesas,rcar_sound-r8a7790" (R-Car H2)
> +				    - "renesas,rcar_sound-r8a7791" (R-Car M2-W)
>  - reg				: Should contain the register physical address.
>  				  required register is
>  				   SRU/ADG/SSI      if generation1
> @@ -35,9 +39,9 @@ DAI subnode properties:
>  
>  Example:
>  
> -rcar_sound: rcar_sound@0xffd90000 {
> +rcar_sound: rcar_sound@ec500000 {
>  	#sound-dai-cells = <1>;
> -	compatible = "renesas,rcar_sound-gen2";
> +	compatible = "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2";
>  	reg =	<0 0xec500000 0 0x1000>, /* SCU */
>  		<0 0xec5a0000 0 0x100>,  /* ADG */
>  		<0 0xec540000 0 0x1000>, /* SSIU */
> -- 
> 1.9.1
> 
