From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Nov 2014 00:54:40 +0000
Subject: [PATCH 14/29] ARM: shmobile: koelsch: Sound DMA support on DTS
Message-Id: <54153c26d206b9168a37704ca8b17f986f047d70.1416476366.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMA transfer to/from SSI

     DMA
[MEM] -> [SSI]

     DMA
[MEM] <- [SSI]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index c92d0d7..68628cf 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -576,10 +576,10 @@
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
2.1.1

