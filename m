From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Dec 2009 14:26:05 +0000
Subject: [PATCH] sh: LCDC start_transfer() for the KFR2R09 board
Message-Id: <20091207142605.6728.6076.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds a ->start_transfer() callback to the
KFR2R09 lcd handling code. The callback is used to
notify the lcd controller that a new frame of data
is about to be transferred. The callback is only used
in combination with deferred io, but the code has
been tested both with and without deferred io enabled.

Without this patch the display data on the KFR2R09
lcd panel becomes corrupted over time.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Depends on the LCDC start_transfer() patch.

 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c     |    6 ++++++
 arch/sh/boards/mach-kfr2r09/setup.c         |    1 +
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h |    6 ++++++
 3 files changed, 13 insertions(+)

--- 0001/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c
+++ work/arch/sh/boards/mach-kfr2r09/lcd_wqvga.c	2009-12-07 18:32:49.000000000 +0900
@@ -273,6 +273,12 @@ int kfr2r09_lcd_setup(void *board_data, 
 	return 0;
 }
 
+void kfr2r09_lcd_start(void *board_data, void *sohandle,
+		       struct sh_mobile_lcdc_sys_bus_ops *so)
+{
+	write_memory_start(sohandle, so);
+}
+
 #define CTRL_CKSW       0x10
 #define CTRL_C10        0x20
 #define CTRL_CPSW       0x80
--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2009-12-07 18:32:49.000000000 +0900
@@ -149,6 +149,7 @@ static struct sh_mobile_lcdc_info kfr2r0
 		},
 		.board_cfg = {
 			.setup_sys = kfr2r09_lcd_setup,
+			.start_transfer = kfr2r09_lcd_start,
 			.display_on = kfr2r09_lcd_on,
 			.display_off = kfr2r09_lcd_off,
 		},
--- 0001/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h
+++ work/arch/sh/include/mach-kfr2r09/mach/kfr2r09.h	2009-12-07 18:32:49.000000000 +0900
@@ -8,6 +8,8 @@ void kfr2r09_lcd_on(void *board_data);
 void kfr2r09_lcd_off(void *board_data);
 int kfr2r09_lcd_setup(void *board_data, void *sys_ops_handle,
 		      struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
+void kfr2r09_lcd_start(void *board_data, void *sys_ops_handle,
+		       struct sh_mobile_lcdc_sys_bus_ops *sys_ops);
 #else
 static inline void kfr2r09_lcd_on(void *board_data) {}
 static inline void kfr2r09_lcd_off(void *board_data) {}
@@ -16,6 +18,10 @@ static inline int kfr2r09_lcd_setup(void
 {
 	return -ENODEV;
 }
+static inline void kfr2r09_lcd_start(void *board_data, void *sys_ops_handle,
+				     struct sh_mobile_lcdc_sys_bus_ops *sys_ops)
+{
+}
 #endif
 
 #endif /* __ASM_SH_KFR2R09_H */
