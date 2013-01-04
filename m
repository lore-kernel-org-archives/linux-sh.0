From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Jan 2013 16:10:05 +0000
Subject: Re: [PATCH 3/9] ARM: shmobile: r8a7740: Add pin control device in device tree
Message-Id: <Pine.LNX.4.64.1301041709160.28515@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1357260060-32164-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1357260060-32164-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent

Thanks for patches!

On Fri, 4 Jan 2013, Laurent Pinchart wrote:

> Add a pfc node in the r8a7740 device tree.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/boot/dts/r8a7740.dtsi |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 798fa35..9586d66 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -18,4 +18,10 @@
>  			compatible = "arm,cortex-a9";
>  		};
>  	};
> +
> +	gpio: pfc@e6050000 {
> +		compatible = "renesas,pfc-r8a7740";
> +		reg = <0xe6050000 0x8000>,
> +		      <0xe605800c 0x20>;

isn't

+		#gpio-cells = <2>;

missing here?

> +	};
>  };
> -- 
> 1.7.8.6

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
