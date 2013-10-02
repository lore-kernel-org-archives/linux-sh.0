From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Oct 2013 08:39:13 +0000
Subject: [PATCH 2/4 v2] ARM: shmobile: r8a7779: add irqpin default status on DTSI
Message-Id: <878uycyslu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7779 INTC needs IRL pin mode settings to determine
behavior of IRQ0 - IRQ3. But it depends on platform.
This patch adds status = "disabled" on r8a7779.dtsi as default

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - patch was splited, only dtsi

 arch/arm/boot/dts/r8a7779.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 912b3a0..19faeac 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -135,6 +135,7 @@
 	irqpin0: irqpin@fe780010 {
 		compatible = "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
+		status = "disabled";
 		interrupt-controller;
 		reg = <0xfe78001c 4>,
 			<0xfe780010 4>,
-- 
1.7.9.5

