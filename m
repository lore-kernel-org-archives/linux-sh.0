From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Oct 2014 05:53:44 +0000
Subject: [PATCH/RFC] ARM: shmobile: koelsch: Fix SPI mode of SPI-Flash into mode3
Message-Id: <1414648424-29688-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>

In order to change into mode3, CPOL and CPHA bit of SPCMD register
of MSIOF is changed. Mode3 can avoid intermediate voltage.

Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree

 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 523ae4d..ced0738 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -387,6 +387,8 @@
 		spi-tx-bus-width = <4>;
 		spi-rx-bus-width = <4>;
 		m25p,fast-read;
+		spi-cpol;
+		spi-cpha;
 
 		partition@0 {
 			label = "loader";
-- 
2.1.1

