From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 04:26:49 +0000
Subject: [PATCH 1/4 v2] ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
Message-Id: <871tmooj0g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7790 SDHI ch0/ch1 has SD_DMACR which is located in 0x324.
This patch updates register size

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - lacated -> located

 arch/arm/boot/dts/r8a7790.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4b38fc9..0010600 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -493,7 +493,7 @@
 
 	sdhi0: sd@ee100000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee100000 0 0x200>;
+		reg = <0 0xee100000 0 0x328>;
 		interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
 		status = "disabled";
@@ -501,7 +501,7 @@
 
 	sdhi1: sd@ee120000 {
 		compatible = "renesas,sdhi-r8a7790";
-		reg = <0 0xee120000 0 0x200>;
+		reg = <0 0xee120000 0 0x328>;
 		interrupts = <0 166 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp3_clks R8A7790_CLK_SDHI1>;
 		status = "disabled";
-- 
1.7.9.5

