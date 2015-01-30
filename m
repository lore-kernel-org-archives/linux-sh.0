From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Jan 2015 02:33:19 +0000
Subject: [PATCH 2/3 v2][RFC] ARM: shmobile: r8a7790: add SSIU/DTCP/MLM/SCU reg for Audio DMAC peri peri
Message-Id: <87h9v9f13n.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

New Audio DMAC peri peri driver requests SSIU/DTCP/MLM/SCU
register address.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - new patch

 arch/arm/boot/dts/r8a7790.dtsi |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ca22009..9f05f19 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -373,7 +373,11 @@
 		compatible = "renesas,rcar-audmapp";
 		#dma-cells = <1>;
 
-		reg = <0 0xec740000 0 0x200>;
+		reg = <0 0xec740000 0 0x200>,
+			<0 0xec400000 0 0x10000>, /* SSIU */
+			<0 0xec420000 0 0x4800>,  /* DTCP */
+			<0 0xec320000 0 0x2000>,  /* MLM */
+			<0 0xec300000 0 0x8800>;  /* SCU */
 	};
 
 	i2c0: i2c@e6508000 {
-- 
1.7.9.5

