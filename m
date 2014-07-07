From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 06:50:09 +0000
Subject: [PATCH 2/2] ARM: shmobile: kzm9g-reference: Remove early_printk from command line
Message-Id: <1404715809-31331-3-git-send-email-horms+renesas@verge.net.au>
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
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index a99171c..838f93e4 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -35,7 +35,7 @@
 	};
 
 	chosen {
-		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel earlyprintk=sh-sci.4,115200 rw";
+		bootargs = "console=tty0 console=ttySC4,115200 root=/dev/nfs ip=dhcp ignore_loglevel rw";
 	};
 
 	memory {
-- 
2.0.0.rc2

