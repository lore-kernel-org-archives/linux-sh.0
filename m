From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Aug 2015 12:58:24 +0000
Subject: Re: [PATCH/RFC 10/10] Local: Hack: arm64: dts: r8a7795: add ravb phy max-speed 100 for Salvator-X bo
Message-Id: <55DF0970.9000305@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-11-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 8/27/2015 12:24 PM, Simon Horman wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> This is a work-around for limitations in the driver implementation.
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> [horms: updated filename to salvator-x; updated changelog]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 109261ea60bd..2e2329451791 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -134,6 +134,7 @@
>   		reg = <0>;
>   		interrupt-parent = <&gpio2>;
>   		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;

    Actually, the GPIO interrupt was also used to overcome the driver's 
limitation. The AVB_PHY_IRQ is directly reflected in the AVB registers, I just 
didn't want to use a thread in order to call phy_mac_interrupt().

> +		max-speed = <100>;
>   	};
>
>   };

MBR, Sergei

