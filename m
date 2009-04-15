From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 10:50:30 +0000
Subject: [PATCH 04/05] sh: Early Platform Data for SuperH Mobile
Message-Id: <20090415105030.29940.38797.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Use plat_early_device_setup() to register Early Platform Data
for SuperH Mobile processors.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   10 ++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   10 ++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   10 ++++++++++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   10 ++++++++++
 4 files changed, 40 insertions(+)

--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2009-04-15 17:10:53.000000000 +0900
@@ -234,6 +234,16 @@ static int __init sh7343_devices_setup(v
 }
 __initcall(sh7343_devices_setup);
 
+static struct platform_device *sh7343_early_devices[] __initdata = {
+	&cmt_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7343_early_devices,
+				   ARRAY_SIZE(sh7343_early_devices));
+}
+
 enum {
 	UNUSED = 0,
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2009-04-15 17:13:37.000000000 +0900
@@ -226,6 +226,16 @@ static int __init sh7366_devices_setup(v
 }
 __initcall(sh7366_devices_setup);
 
+static struct platform_device *sh7366_early_devices[] __initdata = {
+	&cmt_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7366_early_devices,
+				   ARRAY_SIZE(sh7366_early_devices));
+}
+
 enum {
 	UNUSED=0,
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-04-15 17:11:25.000000000 +0900
@@ -270,6 +270,16 @@ static int __init sh7722_devices_setup(v
 }
 __initcall(sh7722_devices_setup);
 
+static struct platform_device *sh7722_early_devices[] __initdata = {
+	&cmt_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7722_early_devices,
+				   ARRAY_SIZE(sh7722_early_devices));
+}
+
 enum {
 	UNUSED=0,
 
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-04-15 17:14:04.000000000 +0900
@@ -281,6 +281,16 @@ static int __init sh7723_devices_setup(v
 }
 __initcall(sh7723_devices_setup);
 
+static struct platform_device *sh7723_early_devices[] __initdata = {
+	&cmt_device,
+};
+
+void __init plat_early_device_setup(void)
+{
+	early_platform_add_devices(sh7723_early_devices,
+				   ARRAY_SIZE(sh7723_early_devices));
+}
+
 enum {
 	UNUSED=0,
 
