From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Oct 2014 08:03:47 +0000
Subject: [PATCH 11/12] ARM: shmobile: koelsch: Sound DMA support via SRC on DTS
Message-Id: <87lhnw1x9b.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMA transfer to/from SRC

     DMA      DMApp
[MEM] -> [SRC] -> [SSIU] -> [SSI]

     DMA      DMApp
[MEM] <- [SRC] <- [SSIU] <- [SSI]

Current sound driver is supporting
SSI/SRC random connection.
So, this patch is tring
SSI0 -> SRC2
SSI1 <- SRC3

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 4432f40..4270ad0 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -568,8 +568,8 @@
 
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
1.7.9.5

