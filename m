From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Feb 2015 01:49:23 +0000
Subject: Re: [PATCH v4 7/9] ARM: shmobile: bockw: add sound to DT
Message-Id: <20150227014923.GF31738@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424968934-30577-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424968934-30577-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 26, 2015 at 05:42:12PM +0100, Ulrich Hecht wrote:
> Adds sound card using the ak4643 codec.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks, I have queued this up.

> ---
>  arch/arm/boot/dts/r8a7778-bockw.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> index abf3f06..9b9a5eb 100644
> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> @@ -57,6 +57,23 @@
>  		vddvario-supply = <&fixedregulator3v3>;
>  		vdd33a-supply = <&fixedregulator3v3>;
>  	};
> +
> +	sound {
> +		compatible = "simple-audio-card";
> +
> +		simple-audio-card,format = "left_j";
> +		simple-audio-card,bitclock-master = <&sndcodec>;
> +		simple-audio-card,frame-master = <&sndcodec>;
> +
> +		sndcpu: simple-audio-card,cpu {
> +			sound-dai = <&rcar_sound>;
> +		};
> +
> +		sndcodec: simple-audio-card,codec {
> +			sound-dai = <&ak4643>;
> +			system-clock-frequency = <11289600>;
> +		};
> +	};
>  };
>  
>  &bsc {
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
