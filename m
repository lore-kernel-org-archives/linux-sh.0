From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 May 2016 07:50:55 +0000
Subject: [PATCH v2 2/2] MAINTAINERS: Drop drivers/sh/ for Renesas ARM
Message-Id: <1463730655-16199-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1463730655-16199-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1463730655-16199-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

None of the code under drivers/sh/ is used anymore on Renesas ARM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Extracted from series "[PATCH 0/4] Enable PM and PM_GENERIC_DOMAINS
    for SoCs with PM Domains",
  - Rebased.
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 03d537d375503907..c45737b306c97e9a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1605,7 +1605,6 @@ F:	arch/arm/boot/dts/sh*
 F:	arch/arm/configs/shmobile_defconfig
 F:	arch/arm/include/debug/renesas-scif.S
 F:	arch/arm/mach-shmobile/
-F:	drivers/sh/
 F:	drivers/soc/renesas/
 F:	include/linux/soc/renesas/
 
-- 
1.9.1

