From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 15 Jan 2016 02:38:03 +0000
Subject: [PATCH v3 10/14] ARM: shmobile: gose: enable sound DMA support in device tree
Message-Id: <1452825487-15931-11-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452825487-15931-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1452825487-15931-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable DMA transfer to/from SSI in r8a7793/gose device tree.

     DMA
[MEM] -> [SSI]

     DMA
[MEM] <- [SSI]

Based on similar work for the r8a7791/koelsch by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index a90af303e21a..0ab0abb9f889 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -322,10 +322,10 @@
 };
 
 &ssi0 {
-	pio-transfer;
+	no-busif;
 };
 
 &ssi1 {
-	pio-transfer;
+	no-busif;
 	shared-pin;
 };
-- 
2.1.4

