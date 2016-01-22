From: Rich Felker <dalias@libc.org>
Date: Fri, 22 Jan 2016 05:26:15 +0000
Subject: [PATCH] MAINTAINERS: return arch/sh to maintained state, with new maintainers
Message-Id: <20160122052614.GA21960@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>, Peter Zijlstra <peterz@infradead.org>, Simon Horman <horms+renesas@verge.net.au>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

From: Rich Felker <dalias@libc.org>

Add Yoshinori Sato and Rich Felker as maintainers for arch/sh
(SUPERH).

Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Acked-by: D. Jeff Dionne <jeff@uClinux.org>
Acked-by: Rob Landley <rob@landley.net>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Andrew, since we don't have our own repo up for Linus to pull from
yet, could you commit this? Geert (who's the closest there is to an
acting maintainer for sh right now) and I thought that would make the
most sense. If possible I'd really like to get this in the merge
window to make it official that sh isn't abandoned.


diff --git a/MAINTAINERS b/MAINTAINERS
index 9bff63c..55e48b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10274,9 +10274,11 @@ S:	Maintained
 F:	drivers/net/ethernet/dlink/sundance.c
 
 SUPERH
+M:	Yoshinori Sato <ysato@users.sourceforge.jp>
+M:	Rich Felker <dalias@libc.org>
 L:	linux-sh@vger.kernel.org
 Q:	http://patchwork.kernel.org/project/linux-sh/list/
-S:	Orphan
+S:	Maintained
 F:	Documentation/sh/
 F:	arch/sh/
 F:	drivers/sh/
