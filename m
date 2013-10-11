From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Oct 2013 06:34:33 +0000
Subject: [PATCH 01/10] ARM: shmobile: bockw: fixup MMC pin conflict on DTS
Message-Id: <87k3hk1fk9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index c6b834f..4d997f8 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -51,10 +51,6 @@
 		vdd33a-supply = <&fixedregulator3v3>;
 	};
 
-	mmc_pins: mmc {
-		renesas,groups = "mmc_data8", "mmc_ctrl";
-		renesas,function = "mmc";
-	};
 };
 
 &mmcif {
@@ -79,4 +75,9 @@
 		renesas,groups = "scif0_data_a", "scif0_ctrl";
 		renesas,function = "scif0";
 	};
+
+	mmc_pins: mmc {
+		renesas,groups = "mmc_data8", "mmc_ctrl";
+		renesas,function = "mmc";
+	};
 };
-- 
1.7.9.5

