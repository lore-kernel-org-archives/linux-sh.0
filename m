From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Jun 2014 00:56:02 +0000
Subject: Re: [PATCH v3 5/8] ARM: shmobile: r8a7791: Add default PCIe bus clock
Message-Id: <20140616005602.GC11582@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1384872347-11724-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384872347-11724-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 13, 2014 at 10:37:19AM +0100, Phil Edworthy wrote:
> This patch adds a default PCIe bus clock node.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> v3:
>  - By default, disable the PCIe bus clock
> 
> v2:
>  - Use a default PCIe bus clock in the device's dtsi
> 
>  arch/arm/boot/dts/r8a7791.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 1e644eb..7c4f7c7 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -532,6 +532,15 @@
>  			clock-output-names = "extal";
>  		};
>  
> +		/* External PCIe clock - can be overridden by the board */
> +		pcie_bus_clk: pcie_bus_clk {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <100000000>;
> +			clock-output-names = "pcie_bus";
> +			status = "disabled";
> +		};
> +
>  		/* Special CPG clocks */
>  		cpg_clocks: cpg_clocks@e6150000 {
>  			compatible = "renesas,r8a7791-cpg-clocks",
> -- 
> 2.0.0
> 


Hi Phil,

I encountered a minor conflict when applying this patch.
The version that I have queued-up is below, please check that it is correct.

From: Phil Edworthy <phil.edworthy@renesas.com>

[PATCH] ARM: shmobile: r8a7791: Add default PCIe bus clock

This patch adds a default PCIe bus clock node.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
[horms+renesas@verge.net.au: resolved conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index a15bf7a..7f7eda7 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -555,6 +555,15 @@
 			clock-output-names = "audio_clk_c";
 		};
 
+		/* External PCIe clock - can be overridden by the board */
+		pcie_bus_clk: pcie_bus_clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <100000000>;
+			clock-output-names = "pcie_bus";
+			status = "disabled";
+		};
+
 		/* Special CPG clocks */
 		cpg_clocks: cpg_clocks@e6150000 {
 			compatible = "renesas,r8a7791-cpg-clocks",
-- 
2.0.0.rc2

