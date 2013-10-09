From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 09 Oct 2013 06:50:28 +0000
Subject: [PATCH 12/13] ARM: shmobile: r8a7779: add irqpin default status on DTSI
Message-Id: <84b47dfc1b1638c40257382d2216d1668cfca3d0.1381298964.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381298964.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381298964.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7779 INTC needs IRL pin mode settings to determine
behavior of IRQ0 - IRQ3. But it depends on platform.
This patch adds status = "disabled" on r8a7779.dtsi as default

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 65dc652..c2fb49b 100644
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
1.8.4

