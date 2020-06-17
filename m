From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 14:36:33 +0000
Subject: [PATCH v2 3/9] Revert "sh: remove needless printk()"
Message-Id: <20200617143639.18315-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617143639.18315-1-geert+renesas@glider.be>
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This reverts commit 8b92f34877225c8eb85e3ab7f1177fc248ba26d0.

"data" became the log level in commit 539e786cc37ee5cb ("sh: add loglvl
to show_trace()"), so we do need to keep the printk() before the
continuation in print_trace_address().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/sh/kernel/dumpstack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index ad548fc976350c50..cc8063a01284bf64 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -118,6 +118,7 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
+	printk("%s", (char *)data);
 	printk_address(addr, reliable);
 }
 
-- 
2.17.1
