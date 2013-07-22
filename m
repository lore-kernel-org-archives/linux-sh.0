From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 22 Jul 2013 07:36:15 +0000
Subject: [PATCH 03/11] ARM: shmobile: Update KZM9D dts command line
Message-Id: <8f675493f4706a9f92a822121fe38892a08e0161.1374478037.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1374478037.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1374478037.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Update the KZM9D DTS command line to remove following cruft:
 - console=tty0 - no graphic support upstream anyway
 - earlyprintk= - not supported by the 8250-em driver anyway
 - mem= - this is provided via DT anyway

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index b9b3241..dda13bc 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -21,6 +21,6 @@
 	};
 
 	chosen {
-		bootargs = "console=tty0 console=ttyS1,115200n81 earlyprintk=serial8250-em.1,115200n81 mem8M@0x40000000 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96";
+		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp nfsroot=,rsize@96,wsize@96";
 	};
 };
-- 
1.8.2.1

