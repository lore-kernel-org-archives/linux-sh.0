From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:02 +0000
Subject: [PATCH 28/69] ARM: shmobile: marzen: tidyup DT node naming
Message-Id: <6220c5197eb0820d9fd75595efa73c56a2162689.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

According to ePAPR spec,
this patch tidies up DT node name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index f7578d5..ce3fe9e 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -82,17 +82,17 @@
 		};
 	};
 
-	scif2_pins: scif2 {
+	scif2_pins: serial2 {
 		renesas,groups = "scif2_data_c";
 		renesas,function = "scif2";
 	};
 
-	scif4_pins: scif4 {
+	scif4_pins: serial4 {
 		renesas,groups = "scif4_data";
 		renesas,function = "scif4";
 	};
 
-	sdhi0_pins: sdhi0 {
+	sdhi0_pins: sd0 {
 		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
 				 "sdhi0_wp";
 		renesas,function = "sdhi0";
-- 
1.8.4

