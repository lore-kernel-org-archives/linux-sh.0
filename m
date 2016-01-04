From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 04 Jan 2016 22:27:46 +0000
Subject: [PATCH v2 11/13] ARM: shmobile: gose: enable sound DMA support via SRC in device tree
Message-Id: <1451946468-20499-12-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1451946468-20499-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable DMA transfer to/from SRC in r8a7793/gose device tree.

     DMA      DMApp
[MEM] -> [SRC] -> [SSIU] -> [SSI]

     DMA      DMApp
[MEM] <- [SRC] <- [SSIU] <- [SSI]

Current sound driver is supporting
SSI/SRC random connection.
So, this patch is tring
SSI0 -> SRC2
SSI1 <- SRC3

Based on similar work for the r8a7791/koeslch by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 4a7048d676c8..ad20ddc5203d 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -315,8 +315,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0>;
-			capture  = <&ssi1>;
+			playback = <&ssi0 &src2>;
+			capture  = <&ssi1 &src3>;
 		};
 	};
 };
-- 
2.1.4

