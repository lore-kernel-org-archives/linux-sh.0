From: Rich Felker <dalias@libc.org>
Date: Fri, 08 Jan 2016 04:39:59 +0000
Subject: [PATCH 1/2] MAINTAINERS: return arch/sh to maintained state, with new maintainers
Message-Id: <20160108043959.GA7856@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <20160108043907.GA7005@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "D. Jeff Dionne" <jeff@uClinux.org>, Rob Landley <rob@landley.net>

From: Rich Felker <dalias@libc.org>

Add Yoshinori Sato and Rich Felker as maintainers for arch/sh
(SUPERH).

Signed-off-by: Rich Felker <dalias@libc.org>
Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Acked-by: D. Jeff Dionne <jeff@uClinux.org>
Acked-by: Rob Landley <rob@landley.net>

---

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
