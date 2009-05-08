From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 08 May 2009 14:51:51 +0000
Subject: [PATCH] Add UBC trap vector for SH2A
Message-Id: <1241794311.16311.33.camel@quercus-bis>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From bc37bbf2a11cfc3ffa02b181695d769adec7584c Mon Sep 17 00:00:00 2001
From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 8 May 2009 15:03:30 +0100
Subject: [PATCH] Add UBC trap vector for SH2A


Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
---
 arch/sh/kernel/traps_32.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/traps_32.c b/arch/sh/kernel/traps_32.c
index 30ca9c5..2721bdf 100644
--- a/arch/sh/kernel/traps_32.c
+++ b/arch/sh/kernel/traps_32.c
@@ -34,6 +34,7 @@
 # define TRAP_ILLEGAL_SLOT_INST	6
 # define TRAP_ADDRESS_ERROR	9
 # ifdef CONFIG_CPU_SH2A
+#  define TRAP_UBC              12
 #  define TRAP_FPU_ERROR	13
 #  define TRAP_DIVZERO_ERROR	17
 #  define TRAP_DIVOVF_ERROR	18
@@ -849,6 +850,10 @@ void __init trap_init(void)
 #endif
 #endif
 
+#ifdef TRAP_UBC
+	set_exception_table_vec(TRAP_UBC, break_point_trap);
+#endif
+
 	/* Setup VBR for boot cpu */
 	per_cpu_trap_init();
 }
-- 
1.5.6.3



