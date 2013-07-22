From: Simon Horman <horms@verge.net.au>
Date: Mon, 22 Jul 2013 01:13:56 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: fix PFC DT node
Message-Id: <20130722011356.GG12445@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307191703040.26183@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307191703040.26183@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 19, 2013 at 05:09:13PM +0200, Guennadi Liakhovetski wrote:
> The pfc DT node should use 2 cells for address and size, fix it.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> ---
> 
> This is against Simon's renesas.git devel branch. Feel free to merge with 
> the offending patch, if possible.
> 
>  arch/arm/boot/dts/r8a73a4.dtsi |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index 2f1bec8..3c9c7f2 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -257,7 +257,7 @@
>  
>  	pfc: pfc@e6050000 {
>  		compatible = "renesas,pfc-r8a73a4";
> -		reg = <0xe6050000 0x9000>;
> +		reg = <0 0xe6050000 0 0x9000>;
>  		gpio-controller;
>  		#gpio-cells = <2>;
>  	};

Thanks, I now have the following queued-up.

Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

ARM: shmobile: r8a73a4: Add pin control device to device tree

Add a pfc node to the r8a73a4 device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[g.liakhovetski+renesas@gmail.com use 2 nodes for address and size]
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4ff2019..b886afd 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -85,4 +85,11 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 69 4>;
 	};
+
+	pfc: pfc@e6050000 {
+		compatible = "renesas,pfc-r8a73a4";
+		reg = <0 0xe6050000 0 0x9000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
-- 
1.8.2.1

