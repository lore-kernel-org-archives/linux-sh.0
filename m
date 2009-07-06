From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 06 Jul 2009 10:32:42 +0000
Subject: [PATCH 2/3] sh: Define HAVE_FUNCTION_TRACE_MCOUNT_TEST
Message-Id: <96b9e0d9c8f2a7f5f444a792f07731b544334c82.1246875978.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Enable HAVE_FUNCTION_TRACE_MCOUNT_TEST and test the value of
function_trace_stop from our assembly code as opposed to using the
generic C function. This should optimise our mcount/ftrace code path.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/Kconfig      |    1 +
 arch/sh/lib/mcount.S |   17 ++++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index e7390dd..235c388 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -28,6 +28,7 @@ config SUPERH32
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_DYNAMIC_FTRACE
+	select HAVE_FUNCTION_TRACE_MCOUNT_TEST
 	select HAVE_ARCH_KGDB
 	select ARCH_HIBERNATION_POSSIBLE if MMU
 
diff --git a/arch/sh/lib/mcount.S b/arch/sh/lib/mcount.S
index 110fbfe..cb87ef5 100644
--- a/arch/sh/lib/mcount.S
+++ b/arch/sh/lib/mcount.S
@@ -2,7 +2,7 @@
  * arch/sh/lib/mcount.S
  *
  *  Copyright (C) 2008  Paul Mundt
- *  Copyright (C) 2008  Matt Fleming
+ *  Copyright (C) 2008, 2009  Matt Fleming
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -35,6 +35,12 @@
 	.type	mcount,@function
 _mcount:
 mcount:
+#ifndef CONFIG_DYNAMIC_FTRACE
+	mov.l	.Lfunction_trace_stop, r0
+	mov.l	@r0, r0
+	tst	r0, r0
+	bf	ftrace_stub
+#endif
 	MCOUNT_ENTER()
 
 #ifdef CONFIG_DYNAMIC_FTRACE
@@ -62,6 +68,11 @@ skip_trace:
 #ifdef CONFIG_DYNAMIC_FTRACE
 	.globl ftrace_caller
 ftrace_caller:
+	mov.l	.Lfunction_trace_stop, r0
+	mov.l	@r0, r0
+	tst	r0, r0
+	bf	ftrace_stub
+	
 	MCOUNT_ENTER()
 
 	.globl ftrace_call
@@ -88,3 +99,7 @@ ftrace_call:
 ftrace_stub:
 	rts
 	 nop
+
+	.align 2
+.Lfunction_trace_stop:
+	.long	function_trace_stop
-- 
1.6.3.2.316.gda4e

