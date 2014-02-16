From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 16 Feb 2014 20:55:37 +0000
Subject: [PATCH RFC] MAINTAINERS: Mark SuperH orphan
Message-Id: <1392584137-24486-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <paul.mundt@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Bolle <pebolle@tiscali.nl>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Paul Mundt's email address bounces regularly, and he hasn't taken any
SuperH patches for about one year.

Suggested-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 MAINTAINERS |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2cf5cfb4d29..2d294561ebdc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8372,12 +8372,10 @@ S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
 SUPERH
-M:	Paul Mundt <lethal@linux-sh.org>
 L:	linux-sh@vger.kernel.org
 W:	http://www.linux-sh.org
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
-T:	git git://github.com/pmundt/linux-sh.git sh-latest
-S:	Supported
+S:	Orphan
 F:	Documentation/sh/
 F:	arch/sh/
 F:	drivers/sh/
-- 
1.7.9.5

