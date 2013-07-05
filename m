From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 05 Jul 2013 15:26:43 +0000
Subject: [PATCH v2 1/4] ARM: shmobile: r8a73a4: move cpufreq-cpu0 device registration into a function
Message-Id: <1373038006-19973-2-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a73a4 currently uses the cpufreq-cpu0 driver for its CPUFreq
implementation. However, this can change in the future when CA7 cores are
also activated. To free r8a73a4 boards from CPUFreq implementation details
move cpufreq-cpu0 device registration into an SoC-specific function.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v2: new patch in this version

 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    4 ++++
 arch/arm/mach-shmobile/setup-r8a73a4.c        |    7 ++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index 12a4ee9..aa94dcc 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -21,4 +21,8 @@ void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
 void r8a73a4_init_delay(void);
 
+#ifdef CONFIG_USE_OF
+void r8a73a4_add_cpufreq_device_dt(void);
+#endif
+
 #endif /* __ASM_R8A73A4_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index bdd1f5a..75a4977 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -330,9 +330,14 @@ void __init r8a73a4_init_delay(void)
 }
 
 #ifdef CONFIG_USE_OF
-void __init r8a73a4_add_standard_devices_dt(void)
+void __init r8a73a4_add_cpufreq_device_dt(void)
 {
 	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
+}
+
+void __init r8a73a4_add_standard_devices_dt(void)
+{
+	r8a73a4_add_cpufreq_device_dt();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.2.5

