From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Oct 2015 02:30:02 +0000
Subject: Re: [PATCH 08/20 v2] arm64: renesas: r8a7795: add I2C support
Message-Id: <20151005023000.GG25427@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 17, 2015 at 04:25:22AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1 -> v2
> 
>  - use power-domains
>  - add Geert's Reviewed-by
> 
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 96 ++++++++++++++++++++++++++++++-
>  include/dt-bindings/clock/r8a7795-clock.h |  7 +++
>  2 files changed, 102 insertions(+), 1 deletion(-)

Hi,

I have taken the liberty of updating this patch with the following
incremental change from Geert. The result can be found in the
topic/r8a7795-i2c-v3.rebase branch of my renesas tree.

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8ce92db14c8bd101..16abf8956c68cb00 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -533,7 +533,9 @@
 					clock-output-names  						"gpio7", "gpio6", "gpio5",
 						"gpio4", "gpio3", "gpio2",
-						"gpio1", "gpio0";
+						"gpio1", "gpio0", "i2c6",
+						"i2c5", "i2c4", "i2c3", "i2c2",
+						"i2c1", "i2c0";
 				};
 
 				mstp10_clks: mstp10_clks@e6150998 {
-- 
1.9.1

