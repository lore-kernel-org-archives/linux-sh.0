From: Simon Horman <horms@verge.net.au>
Date: Wed, 31 Jul 2013 01:46:07 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7740: Add TPU node to the device tree
Message-Id: <20130731014607.GL17209@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1354709587-25288-2-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1354709587-25288-2-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 26, 2013 at 12:51:00AM +0200, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7740.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index e18a195..639822d 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -147,4 +147,11 @@
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  	};
> +
> +	tpu: pwm@e6600000 {
> +		compatible = "renesas,tpu-r8a7740", "renesas,tpu";
> +		reg = <0xe6600000 0x100>;
> +		status = "disabled";
> +		#pwm-cells = <3>;
> +	};
>  };

Thanks, I will queue this up for v3.12 in the tpu-pwm branch.
