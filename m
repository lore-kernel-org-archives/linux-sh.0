From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 22 Jul 2013 16:21:43 +0000
Subject: [PATCH v2 1/3] ARM: shmobile: sh73a0: fix spurious irqpin interrupts in the DT case
Message-Id: <1374510105-21896-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All 3 irqpin controllers require their interrupts to be masked on the
parent. This can be verified by booting a kzm9g board and looking at its
interrupt counts.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 39183dd..005f3d4 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -97,6 +97,7 @@
 			      0 22 0x4
 			      0 23 0x4
 			      0 24 0x4>;
+		control-parent;
 	};
 
 	irqpin3: irqpin@e690000c {
@@ -117,6 +118,7 @@
 			      0 30 0x4
 			      0 31 0x4
 			      0 32 0x4>;
+		control-parent;
 	};
 
 	dmac: dma-multiplexer@0 {
-- 
1.7.2.5

