From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Dec 2015 02:52:51 +0000
Subject: [PATCH/RFC 14/19] ARM: shmobile: gose: enable sound DMA support via BUSIF in device tree
Message-Id: <1449802376-11301-15-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable DMA transfer to/from SSIU in gose/r8a7791 device tree.

     DMA
[MEM] -> [SSIU] -> [SSI]

     DMA
[MEM] <- [SSIU] <- [SSI]

Based on similar work for the r8a7791/koelsch by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index b43a06104125..763cc272127e 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -222,11 +222,6 @@
 	};
 };
 
-&ssi0 {
-	no-busif;
-};
-
 &ssi1 {
-	no-busif;
 	shared-pin;
 };
-- 
2.1.4

