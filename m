From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 16 Mar 2010 02:02:08 +0000
Subject: [PATCH] sh: Add watch-dog register address for SH7722/SH7723/SH7724
Message-Id: <uvdcxyqfz.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
In fact, ${LINUX}/arch/sh/kernel/reboot.c :: watchdog_trigger_immediate
call sh_wdt_write_csr(0xC2);
But SH7722/SH7723/SH7724 doesn't have 0x40 (= WTCSR_WT) bit.
It will be just ignored, but should I add any MASK ?

 arch/sh/include/cpu-sh4/cpu/watchdog.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/watchdog.h b/arch/sh/include/cpu-sh4/cpu/watchdog.h
index 7672301..7f62b93 100644
--- a/arch/sh/include/cpu-sh4/cpu/watchdog.h
+++ b/arch/sh/include/cpu-sh4/cpu/watchdog.h
@@ -21,6 +21,12 @@
 #define WTCNT		0xffcc0000 /*WDTST*/
 #define WTST		WTCNT
 #define WTBST		0xffcc0008 /*WDTBST*/
+/* Register definitions */
+#elif	defined(CONFIG_CPU_SUBTYPE_SH7722) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7723) || \
+	defined(CONFIG_CPU_SUBTYPE_SH7724)
+#define WTCNT		0xa4520000
+#define WTCSR		0xa4520004
 #else
 /* Register definitions */
 #define WTCNT		0xffc00008
-- 
1.6.3.3

