From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:26:35 +0000
Subject: [PATCH 22/24] ARM: shmobile: marzen: Remove early_printk from command line
Message-Id: <33b9966db3024b3b739cf8031a28ad9ee5919f36.1403487423.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As early printk support is not enabled in the kernel in the
shmobile defconfig it does not make much sense to provide for
it in the default command line.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 363f693..3212908 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -19,7 +19,7 @@
 	compatible = "renesas,marzen", "renesas,r8a7779";
 
 	chosen {
-		bootargs = "console=ttySC2,115200 earlyprintk=sh-sci.2,115200 ignore_loglevel root=/dev/nfs ip=on";
+		bootargs = "console=ttySC2,115200 ignore_loglevel root=/dev/nfs ip=on";
 	};
 
 	memory {
-- 
2.0.0.rc2

