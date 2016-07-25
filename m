From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Jul 2016 02:29:39 +0000
Subject: [PATCH 2/2] MAINTAINERS: Drop drivers/sh/ for Renesas ARM
Message-Id: <3fd0498b842f2932558797ec297dc30f6eb5cec0.1469413328.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1469413328.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1469413328.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Geert Uytterhoeven <geert+renesas@glider.be>

None of the code under drivers/sh/ is used anymore on Renesas ARM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7304d2e37a98..e6bf58769b49 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1664,7 +1664,6 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
-F:	drivers/sh/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
2.7.0.rc3.207.g0ac5344

