From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 17 Jul 2018 11:24:27 +0000
Subject: [RESEND PATCH 4/4] sh: remove board_time_init() callback
Message-Id: <0ad306a7d410d3695c7869bf081efaa71e956ae4.1531826106.git.baolin.wang@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
In-Reply-To: <bb0912b9725f192179cc94ef8c3f6702fc078e11.1531826106.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, corbet@lwn.net
Cc: baolin.wang@linaro.org, arnd@arndb.de, broonie@kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The only remaining user of board_time_init() is the of-generic
machine, and that just calls the global timer_init() function.
Calling that one has no effect on non-DT platforms, so we can
simply call it unconditionally in place of board_time_init().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 Documentation/sh/new-machine.txt |    8 --------
 arch/sh/boards/of-generic.c      |    8 --------
 arch/sh/include/asm/rtc.h        |    1 -
 arch/sh/kernel/time.c            |    5 +----
 4 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/Documentation/sh/new-machine.txt b/Documentation/sh/new-machine.txt
index f035416..e0961a66 100644
--- a/Documentation/sh/new-machine.txt
+++ b/Documentation/sh/new-machine.txt
@@ -116,7 +116,6 @@ might look something like:
  * arch/sh/boards/vapor/setup.c - Setup code for imaginary board
  */
 #include <linux/init.h>
-#include <asm/rtc.h> /* for board_time_init() */
 
 const char *get_system_type(void)
 {
@@ -132,13 +131,6 @@ int __init platform_setup(void)
 	 * this board.
 	 */
 
-  	/* 
-	 * Presume all FooTech boards have the same broken timer,
-	 * and also presume that we've defined foo_timer_init to
-	 * do something useful.
-	 */
-  	board_time_init = foo_timer_init;
-
 	/* Start-up imaginary PCI ... */
 
 	/* And whatever else ... */
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 46b2481..ee74ff1 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -116,18 +116,10 @@ static void __init sh_of_mem_reserve(void)
 	early_init_fdt_scan_reserved_mem();
 }
 
-static void __init sh_of_time_init(void)
-{
-	pr_info("SH generic board support: scanning for clocksource devices\n");
-	timer_probe();
-}
-
 static void __init sh_of_setup(char **cmdline_p)
 {
 	struct device_node *root;
 
-	board_time_init = sh_of_time_init;
-
 	sh_mv.mv_name = "Unknown SH model";
 	root = of_find_node_by_path("/");
 	if (root) {
diff --git a/arch/sh/include/asm/rtc.h b/arch/sh/include/asm/rtc.h
index fe55fbb..69dbae2 100644
--- a/arch/sh/include/asm/rtc.h
+++ b/arch/sh/include/asm/rtc.h
@@ -3,7 +3,6 @@
 #define _ASM_RTC_H
 
 void time_init(void);
-extern void (*board_time_init)(void);
 
 #define RTC_CAP_4_DIGIT_YEAR	(1 << 0)
 
diff --git a/arch/sh/kernel/time.c b/arch/sh/kernel/time.c
index eb0a912..a29eb98 100644
--- a/arch/sh/kernel/time.c
+++ b/arch/sh/kernel/time.c
@@ -22,8 +22,6 @@
 #include <asm/clock.h>
 #include <asm/rtc.h>
 
-void (*board_time_init)(void);
-
 static void __init sh_late_time_init(void)
 {
 	/*
@@ -41,8 +39,7 @@ static void __init sh_late_time_init(void)
 
 void __init time_init(void)
 {
-	if (board_time_init)
-		board_time_init();
+	timer_init();
 
 	clk_init();
 
-- 
1.7.9.5

