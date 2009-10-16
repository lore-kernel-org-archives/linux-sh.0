From: Valentin Sitdikov <valentin.sitdikov@siemens.com>
Date: Fri, 16 Oct 2009 10:45:47 +0000
Subject: [PATCH] sh4: fix watchdog timer for sh7780/sh7785
Message-Id: <1255689947-25421-1-git-send-email-valentin.sitdikov@siemens.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Valentin Sitdikov <valentin.sitdikov@siemens.com>
---
 arch/sh/include/asm/watchdog.h         |   59 +++++++++++++++++++++++++++++++-
 arch/sh/include/cpu-sh4/cpu/watchdog.h |   13 +++++++
 2 files changed, 71 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/watchdog.h b/arch/sh/include/asm/watchdog.h
index 2fe7cee..19dfff5 100644
--- a/arch/sh/include/asm/watchdog.h
+++ b/arch/sh/include/asm/watchdog.h
@@ -2,6 +2,8 @@
  * include/asm-sh/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
+ * Copyright (C) 2009 Siemens AG
+ * Copyright (C) 2009 Valentin Sitdikov
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of the GNU General Public License as published by the
@@ -61,6 +63,61 @@
 #define WTCSR_CKS_2048	0x06
 #define WTCSR_CKS_4096	0x07
 
+#if defined(CONFIG_CPU_SUBTYPE_SH7785) || defined(CONFIG_CPU_SUBTYPE_SH7780)
+/**
+ * 	sh_wdt_read_cnt - Read from Counter
+ * 	Reads back the WTCNT value.
+ */
+static inline __u32 sh_wdt_read_cnt(void)
+{
+	return ctrl_inl(WTCNT_R);
+}
+
+/**
+ *	sh_wdt_write_cnt - Write to Counter
+ *	@val: Value to write
+ *
+ *	Writes the given value @val to the lower byte of the timer counter.
+ *	The upper byte is set manually on each write.
+ */
+static inline void sh_wdt_write_cnt(__u32 val)
+{
+	ctrl_outl((WTCNT_HIGH << 24) | (__u32)val, WTCNT);
+}
+
+/**
+ *	sh_wdt_write_bst - Write to Counter
+ *	@val: Value to write
+ *
+ *	Writes the given value @val to the lower byte of the timer counter.
+ *	The upper byte is set manually on each write.
+ */
+static inline void sh_wdt_write_bst(__u32 val)
+{
+	ctrl_outl((WTBST_HIGH << 24) | (__u32)val, WTBST);
+}
+/**
+ * 	sh_wdt_read_csr - Read from Control/Status Register
+ *
+ *	Reads back the WTCSR value.
+ */
+static inline __u32 sh_wdt_read_csr(void)
+{
+	return ctrl_inl(WTCSR_R);
+}
+
+/**
+ * 	sh_wdt_write_csr - Write to Control/Status Register
+ * 	@val: Value to write
+ *
+ * 	Writes the given value @val to the lower byte of the control/status
+ * 	register. The upper byte is set manually on each write.
+ */
+static inline void sh_wdt_write_csr(__u32 val)
+{
+	ctrl_outl((WTCSR_HIGH << 24) | (__u32)val, WTCSR);
+}
+#else
 /**
  * 	sh_wdt_read_cnt - Read from Counter
  * 	Reads back the WTCNT value.
@@ -103,6 +160,6 @@ static inline void sh_wdt_write_csr(__u8 val)
 {
 	ctrl_outw((WTCSR_HIGH << 8) | (__u16)val, WTCSR);
 }
-
+#endif /* CONFIG_CPU_SUBTYPE_SH7785 || CONFIG_CPU_SUBTYPE_SH7780 */
 #endif /* __KERNEL__ */
 #endif /* __ASM_SH_WATCHDOG_H */
diff --git a/arch/sh/include/cpu-sh4/cpu/watchdog.h b/arch/sh/include/cpu-sh4/cpu/watchdog.h
index 259f6a0..7672301 100644
--- a/arch/sh/include/cpu-sh4/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh4/cpu/watchdog.h
@@ -2,6 +2,8 @@
  * include/asm-sh/cpu-sh4/watchdog.h
  *
  * Copyright (C) 2002, 2003 Paul Mundt
+ * Copyright (C) 2009 Siemens AG
+ * Copyright (C) 2009 Sitdikov Valentin
  *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
@@ -10,9 +12,20 @@
 #ifndef __ASM_CPU_SH4_WATCHDOG_H
 #define __ASM_CPU_SH4_WATCHDOG_H
 
+#if defined(CONFIG_CPU_SUBTYPE_SH7785) || defined(CONFIG_CPU_SUBTYPE_SH7780)
+/* Prefix definition */
+#define WTBST_HIGH	0x55
+/* Register definitions */
+#define WTCNT_R		0xffcc0010 /*WDTCNT*/
+#define WTCSR		0xffcc0004 /*WDTCSR*/
+#define WTCNT		0xffcc0000 /*WDTST*/
+#define WTST		WTCNT
+#define WTBST		0xffcc0008 /*WDTBST*/
+#else
 /* Register definitions */
 #define WTCNT		0xffc00008
 #define WTCSR		0xffc0000c
+#endif
 
 /* Bit definitions */
 #define WTCSR_TME	0x80
-- 
1.6.3.3

