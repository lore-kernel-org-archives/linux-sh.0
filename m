From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 20 Nov 2012 12:45:20 +0000
Subject: Re: [RFC 09/15] ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva
Message-Id: <2217502.K9pLuGzWaC@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
 <1353302007-31045-10-git-send-email-horms@verge.net.au>
In-Reply-To: <1353302007-31045-10-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Thank you for the patch.

On Monday 19 November 2012 14:13:21 Simon Horman wrote:
> From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> 
> Cc: Magnus Damm <damm@opensource.se>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

I came up today with pretty much the same patch :-)

> ---
>  arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts index a7505a9..a8e7bd9
> 100644
> --- a/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva.dts
> @@ -9,7 +9,7 @@
>   */
> 
>  /dts-v1/;
> -/include/ "skeleton.dtsi"
> +/include/ "r8a7740.dtsi"
> 
>  / {
>  	model = "armadillo 800 eva";

Shouldn't the compatible property be modified to the following values ?

	compatible = "renesas,armadillo800eva", "renesas,r8a7740";

-- 
Regards,

Laurent Pinchart

