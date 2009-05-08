From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 08 May 2009 14:48:15 +0000
Subject: [PATCH] Add in support for ptrace GDB defines
Message-Id: <1241794095.16311.28.camel@quercus-bis>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From 74f64c22d2d3b0082cf96ed81fe2ccd02a352441 Mon Sep 17 00:00:00 2001
From: Kieran Bingham <kieranbingham@gmail.com>
Date: Mon, 2 Mar 2009 17:05:09 +0000
Subject: [PATCH] Add in support for ptrace GDB defines


Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
Signed-off-by: Peter Griffin <kieranbingham@gmail.com>
---
 arch/sh/include/asm/ptrace.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index 68e20ff..1dc12cb 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -102,6 +102,11 @@ struct pt_dspregs {
 #define	PTRACE_GETDSPREGS	55	/* DSP registers */
 #define	PTRACE_SETDSPREGS	56
 
+#define PT_TEXT_END_ADDR 	240
+#define PT_TEXT_ADDR 		244	/* &(struct user)->start_code */
+#define PT_DATA_ADDR 		248	/* &(struct user)->start_data */
+#define PT_TEXT_LEN		252
+
 #ifdef __KERNEL__
 #include <asm/addrspace.h>
 
-- 
1.5.6.3



