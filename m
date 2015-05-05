From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Tue, 05 May 2015 21:17:56 +0000
Subject: Re: [PATCH] ARM: shmobile: koelsch: Fix adv7511 IRQ sensing
Message-Id: <1430860676.4222.9.camel@xylophone.i.decadent.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1430315743-8521-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1430315743-8521-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 2015-04-29 at 16:55 +0300, Laurent Pinchart wrote:
> The adv7511 IRQ is low level triggered, not falling edge triggered. The
> wrong sense configuration results in no interrupt being triggered at
> all, breaking hotplug detection. Fix it.

The Lager DT has the same bug; will you send a fix for that or should I?

Ben.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> index 74c3212f1f11..824ddab9c3ad 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -545,7 +545,7 @@
>  		compatible = "adi,adv7511w";
>  		reg = <0x39>;
>  		interrupt-parent = <&gpio3>;
> -		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
> +		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
>  
>  		adi,input-depth = <8>;
>  		adi,input-colorspace = "rgb";


