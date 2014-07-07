From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 06:50:08 +0000
Subject: [PATCH 1/2] ARM: shmobile: armadillo800eva-reference: Remove early_printk from command line
Message-Id: <1404715809-31331-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404715809-31331-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404715809-31331-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

As early printk is not supported when devices are initialised
using DT, so remove it from the command line.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index f6ef73f..ba2e180 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -20,7 +20,7 @@
 	compatible = "renesas,armadillo800eva-reference", "renesas,r8a7740";
 
 	chosen {
-		bootargs = "console=tty0 console=ttySC1,115200 earlyprintk=sh-sci.1,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
+		bootargs = "console=tty0 console=ttySC1,115200 ignore_loglevel root=/dev/nfs ip=dhcp rw";
 	};
 
 	memory {
-- 
2.0.0.rc2

