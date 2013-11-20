From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Nov 2013 03:17:41 +0000
Subject: [PATCH 1/3] ARM: shmobile: marzen: remove SDHI0 WP pin setting from DTS
Message-Id: <8738mrahim.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

WP pin is not implemented on Marzen

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 13fa8be..918085c 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -94,8 +94,7 @@
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd",
-				 "sdhi0_wp";
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
 		renesas,function = "sdhi0";
 	};
 };
-- 
1.7.9.5

