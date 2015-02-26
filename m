From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Feb 2015 06:21:08 +0000
Subject: [PATCH 11/32] ARM: shmobile: kzm9g-reference dts: Declare the full 512 MiB of RAM
Message-Id: <3ce1bc08efdd1c1dfba123e802604c0e853ae5db.1424849129.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Traditionally, the first 16 MiB of RAM was reserved for the RT
processor.  However, this is incompatible with CONFIG_AUTO_ZRELADDR=y,
which requires that the start address of physical memory is a multiple
of 128 MiB.

As CONFIG_AUTO_ZRELADDR=y is enabled for multi-platform kernels, declare
RAM to start at 0x40000000.

While at it, reclaim the last 8 MiB of RAM, too, so the full 512 MiB is
available. Note that kzm9g_defconfig still has
CONFIG_MEMORY_START=0x41000000 and CONFIG_MEMORY_SIZE=0x1f000000, so
before the advent of DT we scribbled over the last 8 MiB, too.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 0156fc8..bf365f7 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -45,7 +45,7 @@
 
 	memory {
 		device_type = "memory";
-		reg = <0x41000000 0x1e800000>;
+		reg = <0x40000000 0x20000000>;
 	};
 
 	reg_1p8v: regulator@0 {
-- 
2.1.4

