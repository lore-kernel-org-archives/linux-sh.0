From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Fri, 07 Jan 2011 02:58:16 +0000
Subject: [PATCH 5/5] sh: Use device_initcall() instead of __initcall()
Message-Id: <1294369335-4064-5-git-send-email-iwamatsu@nigauri.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 arch/sh/boards/board-edosk7705.c    |    2 +-
 arch/sh/boards/board-edosk7760.c    |    2 +-
 arch/sh/boards/board-sh7785lcr.c    |    2 +-
 arch/sh/boards/mach-cayman/setup.c  |    2 +-
 arch/sh/boards/mach-landisk/setup.c |    2 +-
 arch/sh/boards/mach-r2d/setup.c     |    2 +-
 arch/sh/boards/mach-sdk7786/setup.c |    2 +-
 arch/sh/boards/mach-se/7206/setup.c |    2 +-
 arch/sh/boards/mach-se/7751/setup.c |    2 +-
 arch/sh/boards/mach-sh03/setup.c    |    2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/sh/boards/board-edosk7705.c b/arch/sh/boards/board-edosk7705.c
index 4cb3bb7..541d8a2 100644
--- a/arch/sh/boards/board-edosk7705.c
+++ b/arch/sh/boards/board-edosk7705.c
@@ -66,7 +66,7 @@ static int __init init_edosk7705_devices(void)
 	return platform_add_devices(edosk7705_devices,
 				    ARRAY_SIZE(edosk7705_devices));
 }
-__initcall(init_edosk7705_devices);
+device_initcall(init_edosk7705_devices);
 
 /*
  * The Machine Vector
diff --git a/arch/sh/boards/board-edosk7760.c b/arch/sh/boards/board-edosk7760.c
index 35dc099..f47ac82 100644
--- a/arch/sh/boards/board-edosk7760.c
+++ b/arch/sh/boards/board-edosk7760.c
@@ -182,7 +182,7 @@ static int __init init_edosk7760_devices(void)
 	return platform_add_devices(edosk7760_devices,
 				    ARRAY_SIZE(edosk7760_devices));
 }
-__initcall(init_edosk7760_devices);
+device_initcall(init_edosk7760_devices);
 
 /*
  * The Machine Vector
diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index fe7e686..ee65ff0 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -284,7 +284,7 @@ static int __init sh7785lcr_devices_setup(void)
 	return platform_add_devices(sh7785lcr_devices,
 				    ARRAY_SIZE(sh7785lcr_devices));
 }
-__initcall(sh7785lcr_devices_setup);
+device_initcall(sh7785lcr_devices_setup);
 
 /* Initialize IRQ setting */
 void __init init_sh7785lcr_IRQ(void)
diff --git a/arch/sh/boards/mach-cayman/setup.c b/arch/sh/boards/mach-cayman/setup.c
index 7e8216a..e89e8e1 100644
--- a/arch/sh/boards/mach-cayman/setup.c
+++ b/arch/sh/boards/mach-cayman/setup.c
@@ -165,7 +165,7 @@ static int __init smsc_superio_setup(void)
 
 	return 0;
 }
-__initcall(smsc_superio_setup);
+device_initcall(smsc_superio_setup);
 
 static void __iomem *cayman_ioport_map(unsigned long port, unsigned int len)
 {
diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index c693121..94186cf 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -81,7 +81,7 @@ static int __init landisk_devices_setup(void)
 				    ARRAY_SIZE(landisk_devices));
 }
 
-__initcall(landisk_devices_setup);
+device_initcall(landisk_devices_setup);
 
 static void __init landisk_setup(char **cmdline_p)
 {
diff --git a/arch/sh/boards/mach-r2d/setup.c b/arch/sh/boards/mach-r2d/setup.c
index b84df6a..4b98a52 100644
--- a/arch/sh/boards/mach-r2d/setup.c
+++ b/arch/sh/boards/mach-r2d/setup.c
@@ -258,7 +258,7 @@ static int __init rts7751r2d_devices_setup(void)
 	return platform_add_devices(rts7751r2d_devices,
 				    ARRAY_SIZE(rts7751r2d_devices));
 }
-__initcall(rts7751r2d_devices_setup);
+device_initcall(rts7751r2d_devices_setup);
 
 static void rts7751r2d_power_off(void)
 {
diff --git a/arch/sh/boards/mach-sdk7786/setup.c b/arch/sh/boards/mach-sdk7786/setup.c
index 75e4ddb..c2e110b 100644
--- a/arch/sh/boards/mach-sdk7786/setup.c
+++ b/arch/sh/boards/mach-sdk7786/setup.c
@@ -135,7 +135,7 @@ static int __init sdk7786_devices_setup(void)
 
 	return sdk7786_i2c_setup();
 }
-__initcall(sdk7786_devices_setup);
+device_initcall(sdk7786_devices_setup);
 
 static int sdk7786_mode_pins(void)
 {
diff --git a/arch/sh/boards/mach-se/7206/setup.c b/arch/sh/boards/mach-se/7206/setup.c
index 33039e0..8ab8330 100644
--- a/arch/sh/boards/mach-se/7206/setup.c
+++ b/arch/sh/boards/mach-se/7206/setup.c
@@ -77,7 +77,7 @@ static int __init se7206_devices_setup(void)
 {
 	return platform_add_devices(se7206_devices, ARRAY_SIZE(se7206_devices));
 }
-__initcall(se7206_devices_setup);
+device_initcall(se7206_devices_setup);
 
 static int se7206_mode_pins(void)
 {
diff --git a/arch/sh/boards/mach-se/7751/setup.c b/arch/sh/boards/mach-se/7751/setup.c
index 9fbc51b..4ed60c5 100644
--- a/arch/sh/boards/mach-se/7751/setup.c
+++ b/arch/sh/boards/mach-se/7751/setup.c
@@ -48,7 +48,7 @@ static int __init se7751_devices_setup(void)
 {
 	return platform_add_devices(se7751_devices, ARRAY_SIZE(se7751_devices));
 }
-__initcall(se7751_devices_setup);
+device_initcall(se7751_devices_setup);
 
 /*
  * The Machine Vector
diff --git a/arch/sh/boards/mach-sh03/setup.c b/arch/sh/boards/mach-sh03/setup.c
index af4a0c0..d4f79b2 100644
--- a/arch/sh/boards/mach-sh03/setup.c
+++ b/arch/sh/boards/mach-sh03/setup.c
@@ -96,7 +96,7 @@ static int __init sh03_devices_setup(void)
 
 	return platform_add_devices(sh03_devices, ARRAY_SIZE(sh03_devices));
 }
-__initcall(sh03_devices_setup);
+device_initcall(sh03_devices_setup);
 
 static struct sh_machine_vector mv_sh03 __initmv = {
 	.mv_name		= "Interface (CTP/PCI-SH03)",
-- 
1.7.2.3

