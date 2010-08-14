From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 14 Aug 2010 12:23:39 +0000
Subject: [PATCH] sh: fix recursive dependency in Kconfig
Message-Id: <20100814122339.GA26739@merkur.ravnborg.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When executing:

   make ARCH=sh defconfig

kconfig segfaulted.
kconfig should obviously not segfault.

But this indicated a problem in the sh files which was
tracked down to a recursive dependency.

We select HAVE_HW_BREAKPOINT and in the following line
we use the same symbol in an expression.
Drop the conditional as it is of no use.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Michal Marek <mmarek@suse.cz>
---

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 33990fa..06645b6 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -45,7 +45,7 @@ config SUPERH32
 	select HAVE_ARCH_KGDB
 	select HAVE_HW_BREAKPOINT
 	select HAVE_MIXED_BREAKPOINTS_REGS
-	select PERF_EVENTS if HAVE_HW_BREAKPOINT
+	select PERF_EVENTS
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 
 config SUPERH64
