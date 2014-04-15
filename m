From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:45:24 +0000
Subject: [PATCH 5/5] [DEBUG] r8a7791: show MSTP clock status in /proc/cpuinfo
Message-Id: <1397565924-23541-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Not-Yet-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/kernel/setup.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 50e198c1e9c8..6a0373bc6046 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1017,6 +1017,8 @@ static const char *hwcap2_str[] = {
 	NULL
 };
 
+extern void r8a7791_show_mstp_clocks(struct seq_file *m);
+
 static int c_show(struct seq_file *m, void *v)
 {
 	int i, j;
@@ -1072,6 +1074,13 @@ static int c_show(struct seq_file *m, void *v)
 	seq_printf(m, "Serial\t\t: %08x%08x\n",
 		   system_serial_high, system_serial_low);
 
+#ifdef CONFIG_ARCH_R8A7791
+#ifdef CONFIG_ARCH_MULTIPLATFORM
+	if (of_machine_is_compatible("renesas,r8a7791"))
+#endif
+		r8a7791_show_mstp_clocks(m);
+#endif /* CONFIG_ARCH_R8A7791 */
+
 	return 0;
 }
 
-- 
1.7.9.5

