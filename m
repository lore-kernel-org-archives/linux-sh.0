From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 13 Dec 2013 02:31:14 +0000
Subject: [PATCH 40/69] ARM: shmobile: marzen: remove SDHI0 WP pin setting from DTS
Message-Id: <72e7db878b8469261d01a3dfcece8ab99ffc9cb6.1386901186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

WP pin is not implemented on Marzen

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 3 +--
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
1.8.4

