From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 23 Feb 2014 22:29:17 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: koelsch: make i2c2-pfc node unique
Message-Id: <4277750.qKdxXIPxVH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393159224-14377-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1393159224-14377-4-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

Thank you for the patch.

On Sunday 23 February 2014 13:40:24 Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
> 
> This node should have a unique name so it can be distinguished when
> other i2c busses are added later.
> 
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> b/arch/arm/boot/dts/r8a7791-koelsch.dts index bf6ba0c..e6ca0e0 100644
> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> @@ -126,7 +126,7 @@
>  	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
>  	pinctrl-names = "default";
> 
> -	i2c2_pins: i2c {
> +	i2c2_pins: i2c2 {
>  		renesas,groups = "i2c2";
>  		renesas,function = "i2c2";
>  	};

-- 
Regards,

Laurent Pinchart

