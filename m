From: Simon Horman <horms@verge.net.au>
Date: Thu, 07 May 2015 04:22:48 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g dts: Configure the HOME key as wake-up source
Message-Id: <20150507042243.GE28846@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430760969-23368-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430760969-23368-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 04, 2015 at 07:36:09PM +0200, Geert Uytterhoeven wrote:
> Note that from now on any of the pfc8575 gpio keys will wake up the
> system, as the pfc8575 cannot mask individual interrupts.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
>  arch/arm/boot/dts/sh73a0-kzm9g.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
> index 022ba505f57339a9..24b4cd24dceb2f9e 100644
> --- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
> +++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
> @@ -147,6 +147,7 @@
>  			gpios = <&pcf8575 14 GPIO_ACTIVE_LOW>;
>  			linux,code = <KEY_HOME>;
>  			label = "SW1";
> +			gpio-key,wakeup;
>  		};
>  	};
>  
> -- 
> 1.9.1
> 
