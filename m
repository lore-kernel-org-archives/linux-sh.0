From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 29 May 2014 16:00:08 +0000
Subject: Re: [PATCH 3/7] ARM: shmobile: Disable DVS support for r8a7790
Message-Id: <53875988.6090300@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5386E66D.3020502@bp.renesas.com>
In-Reply-To: <5386E66D.3020502@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 05/29/2014 11:49 AM, Gaku Inami wrote:

> Since range of VDD is narrow, there is no effect of power consumption
> by DVS. So, DVS is disabled in R-CAR Gen2 series.

> Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> ---
>   arch/arm/boot/dts/r8a7790-lager.dts |    4 ----
>   1 file changed, 4 deletions(-)

> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index ab73ed0..9becef7 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -317,7 +317,3 @@
>   	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
>   	status = "okay";
>   };
> -
> -&cpu0 {
> -	cpu0-supply = <&vdd_dvfs>;
> -};

   Why enable it in the first place (patch #1)?

WBR, Sergei

