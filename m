From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 22 Jul 2009 15:14:29 +0000
Subject: [PATCH] sh: convert processor device setup functions to arch_initcall()
Message-Id: <20090722151429.18479.98082.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Convert the processor platform device setup
functions from __initcall() and sometimes
device_initcall() to arch_initcall().

This makes sure that the platform devices are
registered a bit earlier so the devices are
available when drivers register using initcall
levels earlier than device_initcall().

A good example is platform devices needed by
i2c-sh_mobile.c which registers a bit earlier
using subsys_initcall().

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh2/setup-sh7619.c  |    2 +-
 arch/sh/kernel/cpu/sh2a/setup-mxg.c    |    2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7201.c |    2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7203.c |    2 +-
 arch/sh/kernel/cpu/sh2a/setup-sh7206.c |    2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7705.c  |    2 +-
 arch/sh/kernel/cpu/sh3/setup-sh770x.c  |    2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7710.c  |    2 +-
 arch/sh/kernel/cpu/sh3/setup-sh7720.c  |    2 +-
 arch/sh/kernel/cpu/sh4/setup-sh4-202.c |    2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7750.c  |    2 +-
 arch/sh/kernel/cpu/sh4/setup-sh7760.c  |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7770.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |    2 +-
 arch/sh/kernel/cpu/sh4a/setup-shx3.c   |    2 +-
 arch/sh/kernel/cpu/sh5/setup-sh5.c     |    2 +-
 24 files changed, 24 insertions(+), 24 deletions(-)

--- 0001/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ work/arch/sh/kernel/cpu/sh2/setup-sh7619.c	2009-07-22 22:01:56.000000000 +0900
@@ -187,7 +187,7 @@ static int __init sh7619_devices_setup(v
 	return platform_add_devices(sh7619_devices,
 				    ARRAY_SIZE(sh7619_devices));
 }
-__initcall(sh7619_devices_setup);
+arch_initcall(sh7619_devices_setup);
 
 void __init plat_irq_setup(void)
 {
--- 0001/arch/sh/kernel/cpu/sh2a/setup-mxg.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-mxg.c	2009-07-22 22:02:12.000000000 +0900
@@ -238,7 +238,7 @@ static int __init mxg_devices_setup(void
 	return platform_add_devices(mxg_devices,
 				    ARRAY_SIZE(mxg_devices));
 }
-__initcall(mxg_devices_setup);
+arch_initcall(mxg_devices_setup);
 
 void __init plat_irq_setup(void)
 {
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7201.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7201.c	2009-07-22 22:02:20.000000000 +0900
@@ -357,7 +357,7 @@ static int __init sh7201_devices_setup(v
 	return platform_add_devices(sh7201_devices,
 				    ARRAY_SIZE(sh7201_devices));
 }
-__initcall(sh7201_devices_setup);
+arch_initcall(sh7201_devices_setup);
 
 void __init plat_irq_setup(void)
 {
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7203.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7203.c	2009-07-22 22:02:28.000000000 +0900
@@ -367,7 +367,7 @@ static int __init sh7203_devices_setup(v
 	return platform_add_devices(sh7203_devices,
 				    ARRAY_SIZE(sh7203_devices));
 }
-__initcall(sh7203_devices_setup);
+arch_initcall(sh7203_devices_setup);
 
 void __init plat_irq_setup(void)
 {
--- 0001/arch/sh/kernel/cpu/sh2a/setup-sh7206.c
+++ work/arch/sh/kernel/cpu/sh2a/setup-sh7206.c	2009-07-22 22:02:36.000000000 +0900
@@ -338,7 +338,7 @@ static int __init sh7206_devices_setup(v
 	return platform_add_devices(sh7206_devices,
 				    ARRAY_SIZE(sh7206_devices));
 }
-__initcall(sh7206_devices_setup);
+arch_initcall(sh7206_devices_setup);
 
 void __init plat_irq_setup(void)
 {
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7705.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7705.c	2009-07-22 22:01:22.000000000 +0900
@@ -222,7 +222,7 @@ static int __init sh7705_devices_setup(v
 	return platform_add_devices(sh7705_devices,
 				    ARRAY_SIZE(sh7705_devices));
 }
-__initcall(sh7705_devices_setup);
+arch_initcall(sh7705_devices_setup);
 
 static struct platform_device *sh7705_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh770x.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh770x.c	2009-07-22 22:01:29.000000000 +0900
@@ -250,7 +250,7 @@ static int __init sh770x_devices_setup(v
 	return platform_add_devices(sh770x_devices,
 		ARRAY_SIZE(sh770x_devices));
 }
-__initcall(sh770x_devices_setup);
+arch_initcall(sh770x_devices_setup);
 
 static struct platform_device *sh770x_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7710.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7710.c	2009-07-22 22:01:35.000000000 +0900
@@ -226,7 +226,7 @@ static int __init sh7710_devices_setup(v
 	return platform_add_devices(sh7710_devices,
 				    ARRAY_SIZE(sh7710_devices));
 }
-__initcall(sh7710_devices_setup);
+arch_initcall(sh7710_devices_setup);
 
 static struct platform_device *sh7710_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh3/setup-sh7720.c
+++ work/arch/sh/kernel/cpu/sh3/setup-sh7720.c	2009-07-22 22:01:41.000000000 +0900
@@ -388,7 +388,7 @@ static int __init sh7720_devices_setup(v
 	return platform_add_devices(sh7720_devices,
 				    ARRAY_SIZE(sh7720_devices));
 }
-__initcall(sh7720_devices_setup);
+arch_initcall(sh7720_devices_setup);
 
 static struct platform_device *sh7720_early_devices[] __initdata = {
 	&cmt0_device,
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh4-202.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh4-202.c	2009-07-22 22:00:48.000000000 +0900
@@ -138,7 +138,7 @@ static int __init sh4202_devices_setup(v
 	return platform_add_devices(sh4202_devices,
 				    ARRAY_SIZE(sh4202_devices));
 }
-__initcall(sh4202_devices_setup);
+arch_initcall(sh4202_devices_setup);
 
 static struct platform_device *sh4202_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7750.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7750.c	2009-07-22 22:00:55.000000000 +0900
@@ -239,7 +239,7 @@ static int __init sh7750_devices_setup(v
 	return platform_add_devices(sh7750_devices,
 				    ARRAY_SIZE(sh7750_devices));
 }
-__initcall(sh7750_devices_setup);
+arch_initcall(sh7750_devices_setup);
 
 static struct platform_device *sh7750_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh4/setup-sh7760.c
+++ work/arch/sh/kernel/cpu/sh4/setup-sh7760.c	2009-07-22 22:01:01.000000000 +0900
@@ -265,7 +265,7 @@ static int __init sh7760_devices_setup(v
 	return platform_add_devices(sh7760_devices,
 				    ARRAY_SIZE(sh7760_devices));
 }
-__initcall(sh7760_devices_setup);
+arch_initcall(sh7760_devices_setup);
 
 static struct platform_device *sh7760_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2009-07-22 21:58:23.000000000 +0900
@@ -325,7 +325,7 @@ static int __init sh7343_devices_setup(v
 	return platform_add_devices(sh7343_devices,
 				    ARRAY_SIZE(sh7343_devices));
 }
-__initcall(sh7343_devices_setup);
+arch_initcall(sh7343_devices_setup);
 
 static struct platform_device *sh7343_early_devices[] __initdata = {
 	&cmt_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2009-07-22 21:58:38.000000000 +0900
@@ -318,7 +318,7 @@ static int __init sh7366_devices_setup(v
 	return platform_add_devices(sh7366_devices,
 				    ARRAY_SIZE(sh7366_devices));
 }
-__initcall(sh7366_devices_setup);
+arch_initcall(sh7366_devices_setup);
 
 static struct platform_device *sh7366_early_devices[] __initdata = {
 	&cmt_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2009-07-22 21:58:51.000000000 +0900
@@ -359,7 +359,7 @@ static int __init sh7722_devices_setup(v
 	return platform_add_devices(sh7722_devices,
 				    ARRAY_SIZE(sh7722_devices));
 }
-__initcall(sh7722_devices_setup);
+arch_initcall(sh7722_devices_setup);
 
 static struct platform_device *sh7722_early_devices[] __initdata = {
 	&cmt_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2009-07-22 21:59:00.000000000 +0900
@@ -473,7 +473,7 @@ static int __init sh7723_devices_setup(v
 	return platform_add_devices(sh7723_devices,
 				    ARRAY_SIZE(sh7723_devices));
 }
-__initcall(sh7723_devices_setup);
+arch_initcall(sh7723_devices_setup);
 
 static struct platform_device *sh7723_early_devices[] __initdata = {
 	&cmt_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2009-07-22 21:58:02.000000000 +0900
@@ -508,7 +508,7 @@ static int __init sh7724_devices_setup(v
 	return platform_add_devices(sh7724_devices,
 				    ARRAY_SIZE(sh7724_devices));
 }
-device_initcall(sh7724_devices_setup);
+arch_initcall(sh7724_devices_setup);
 
 static struct platform_device *sh7724_early_devices[] __initdata = {
 	&cmt_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7763.c	2009-07-22 21:59:19.000000000 +0900
@@ -314,7 +314,7 @@ static int __init sh7763_devices_setup(v
 	return platform_add_devices(sh7763_devices,
 				    ARRAY_SIZE(sh7763_devices));
 }
-__initcall(sh7763_devices_setup);
+arch_initcall(sh7763_devices_setup);
 
 static struct platform_device *sh7763_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7770.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7770.c	2009-07-22 21:59:27.000000000 +0900
@@ -368,7 +368,7 @@ static int __init sh7770_devices_setup(v
 	return platform_add_devices(sh7770_devices,
 				    ARRAY_SIZE(sh7770_devices));
 }
-__initcall(sh7770_devices_setup);
+arch_initcall(sh7770_devices_setup);
 
 static struct platform_device *sh7770_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7780.c	2009-07-22 21:59:35.000000000 +0900
@@ -256,7 +256,7 @@ static int __init sh7780_devices_setup(v
 	return platform_add_devices(sh7780_devices,
 				    ARRAY_SIZE(sh7780_devices));
 }
-__initcall(sh7780_devices_setup);
+arch_initcall(sh7780_devices_setup);
 
 static struct platform_device *sh7780_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7785.c	2009-07-22 21:59:41.000000000 +0900
@@ -263,7 +263,7 @@ static int __init sh7785_devices_setup(v
 	return platform_add_devices(sh7785_devices,
 				    ARRAY_SIZE(sh7785_devices));
 }
-__initcall(sh7785_devices_setup);
+arch_initcall(sh7785_devices_setup);
 
 static struct platform_device *sh7785_early_devices[] __initdata = {
 	&tmu0_device,
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7786.c	2009-07-22 21:59:50.000000000 +0900
@@ -547,7 +547,7 @@ static int __init sh7786_devices_setup(v
 	return platform_add_devices(sh7786_devices,
 				    ARRAY_SIZE(sh7786_devices));
 }
-device_initcall(sh7786_devices_setup);
+arch_initcall(sh7786_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
--- 0001/arch/sh/kernel/cpu/sh4a/setup-shx3.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-shx3.c	2009-07-22 22:00:31.000000000 +0900
@@ -256,7 +256,7 @@ static int __init shx3_devices_setup(voi
 	return platform_add_devices(shx3_devices,
 				    ARRAY_SIZE(shx3_devices));
 }
-__initcall(shx3_devices_setup);
+arch_initcall(shx3_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
--- 0001/arch/sh/kernel/cpu/sh5/setup-sh5.c
+++ work/arch/sh/kernel/cpu/sh5/setup-sh5.c	2009-07-22 22:02:48.000000000 +0900
@@ -186,7 +186,7 @@ static int __init sh5_devices_setup(void
 	return platform_add_devices(sh5_devices,
 				    ARRAY_SIZE(sh5_devices));
 }
-__initcall(sh5_devices_setup);
+arch_initcall(sh5_devices_setup);
 
 void __init plat_early_device_setup(void)
 {
