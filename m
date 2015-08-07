From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 07 Aug 2015 02:45:33 +0000
Subject: [PATCH] ARM: shmobile: marzen: Board specific serial port order
Message-Id: <20150807024533.25666.34925.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Convert Marzen to use board-specific serial0 and serial1 instead
of the older shared SoC-specific SCIF index.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Cooked up against renesas-devel-20150807-v4.2-rc5

 arch/arm/boot/dts/r8a7779-marzen.dts |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7779-marzen.dts
+++ work/arch/arm/boot/dts/r8a7779-marzen.dts	2015-08-07 11:04:37.432366518 +0900
@@ -19,12 +19,12 @@
 	compatible = "renesas,marzen", "renesas,r8a7779";
 
 	aliases {
-		serial2 = &scif2;
-		serial4 = &scif4;
+		serial0 = &scif2;
+		serial1 = &scif4;
 	};
 
 	chosen {
-		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";
+		bootargs = "ignore_loglevel root=/dev/nfs ip=on";
 		stdout-path = &scif2;
 	};
 
