From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 28 Jan 2014 18:53:33 +0000
Subject: [PATCH RFC 2/2] ARM: shmobile: lager: Increase the size of ARM corehent DMA pool
Message-Id: <1390935213-12896-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This increases the size of ARM coherent DMA pool to 4MB to
avoid issues with DMA bounce for PCI DMA transfers.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 1081c5e..b2cac57 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -17,7 +17,7 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	chosen {
-		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp coherent_pool=4M";
 	};
 
 	memory@40000000 {
-- 
1.8.3.1

