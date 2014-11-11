From: Simon Horman <horms@verge.net.au>
Date: Tue, 11 Nov 2014 00:24:59 +0000
Subject: Re: [PATCH 1/5] ASoC: sh: fsi: Document SoC-specific bindings
Message-Id: <20141111002458.GE29665@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415646044-4168-1-git-send-email-geert+renesas@glider.be>
 <1415646044-4168-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415646044-4168-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Nov 10, 2014 at 08:00:40PM +0100, Geert Uytterhoeven wrote:
> The documentation only mentioned the generic fallback compatible
> property.
> Add the missing SoC-specific compatible properties, some of which are
> already in use.
> 
> Also fix a small typo, while we're at it.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/sound/renesas,fsi.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/renesas,fsi.txt b/Documentation/devicetree/bindings/sound/renesas,fsi.txt
> index c5be003f413e3aa3..0d0ab51105b01ece 100644
> --- a/Documentation/devicetree/bindings/sound/renesas,fsi.txt
> +++ b/Documentation/devicetree/bindings/sound/renesas,fsi.txt
> @@ -1,11 +1,16 @@
>  Renesas FSI
>  
>  Required properties:
> -- compatible			: "renesas,sh_fsi2" or "renesas,sh_fsi"
> +- compatible			: "renesas,fsi2-<soctype>",
> +				  "renesas,sh_fsi2" or "renesas,sh_fsi" as
> +				  fallback.
> +				  Examples with soctypes are:
> +				    - "renesas,fsi2-r8a7740" (R-Mobile A1)
> +				    - "renesas,fsi2-sh73a0" (SH-Mobile AG5)
>  - reg				: Should contain the register physical address and length
>  - interrupts			: Should contain FSI interrupt
>  
> -- fsia,spdif-connection		: FSI is connected by S/PDFI
> +- fsia,spdif-connection		: FSI is connected by S/PDIF
>  - fsia,stream-mode-support	: FSI supports 16bit stream mode.
>  - fsia,use-internal-clock	: FSI uses internal clock when master mode.
>  
> -- 
> 1.9.1
> 
