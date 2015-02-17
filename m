From: Simon Horman <horms@verge.net.au>
Date: Tue, 17 Feb 2015 23:28:53 +0000
Subject: Re: [PATCH v3 10/15] ARM: shmobile: r8a7778: add sound to DT
Message-Id: <20150217232851.GA3768@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-11-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-11-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 16, 2015 at 05:58:54PM +0100, Ulrich Hecht wrote:
> Adds an entry for an R-Car Gen. 1 sound controller.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/r8a7778.dtsi | 55 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
> index c802e72..50e26d7 100644
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -220,6 +220,61 @@
>  		status = "disabled";
>  	};
>  
> +	rcar_sound: sound@ffd90000 {
> +		#sound-dai-cells = <1>;
> +		compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1", "renesas,rcar_sound";
> +		reg =	<0xffd90000 0x1000>,	/* SRU */
> +			<0xffd91000 0x1240>,	/* SSI */
> +			<0xfffe0000 0x24>;	/* ADG */

[snip]

Please submit a patch to add renesas,rcar_sound-r8a7778 to
Documentation/devicetree/bindings/sound/renesas,rsnd.txt
