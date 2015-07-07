From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jul 2015 14:23:10 +0000
Subject: Re: [PATCH/RFC 06/11] ARM: shmobile: r8a7790: Link CPG to RST using "renesas,modemr"
Message-Id: <3792169.nKlDE6xfl4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1436278217-20522-1-git-send-email-geert+renesas@glider.be>
 <1436278217-20522-7-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436278217-20522-7-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Geert,

Thank you for the patches.

On Tuesday 07 July 2015 16:10:12 Geert Uytterhoeven wrote:
> Add a link from the Clock Pulse Generator node to the Reset Controller
> node, so the CPG can read the Mode Monitoring Register (MODEMR) to
> obtain the MD pin values.x
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 08067ae177643b8f..4ee5523fc3e13e12 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -1115,6 +1115,7 @@
>  					     "lb", "qspi", "sdh", "sd0", "sd1",
>  					     "z", "rcan", "adsp";
>  			#power-domain-cells = <0>;
> +			renesas,modemr = <&rst 0x60>;

I have mixed feelings about this as I don't think it really describes the 
hardware.

Wouldn't it make sense to instead add a standard kernel API to retrieve the 
boot mode value ? It seems to be a pretty common feature of SoCs across all 
vendors.

>  		};
> 
>  		/* Variable factor clocks */

-- 
Regards,

Laurent Pinchart

