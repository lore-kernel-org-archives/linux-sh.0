From: ahaslam@baylibre.com
Date: Mon, 04 May 2015 11:04:08 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: skip set_wake for gic irq.
Message-Id: <1430737448-29223-1-git-send-email-ahaslam@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Axel Haslam <ahaslam+renesas@baylibre.com>

when doing a suspend to ram with r8a7790 a warning starts appearing
since: commit ab82fa7da4dc ("gpio: rcar: Prevent module clock disable
when wake-up is enabled")

the call trace that ends up in the waring is:
	gpio_rcar_irq_set_wake()
		irq_set_irq_wake(p->irq_parent, on);
			gic_set_wake()

but since gic_arch_extn.irq_set_wake is not set, this returns
an error and  desc->wake_depth is set to 0, which generates warnings
on trying to disable the wake upon resume.

To avoid this warning set the IRQCHIP_SKIP_SET_WAKE flag for the gic
irq's. With this flag set_irq_wake_real will avoid returning
errors and the calls will be balanced.

usb usb1: root hub lost power or was reset
WARNING: CPU: 1 PID: 931 at kernel/irq/manage.c:572 irq_set_irq_wake+0x9c
Unbalanced IRQ 22 wake disable
CPU: 1 PID: 931 Comm: sh Not tainted 4.1.0-rc1-dirty #91
Hardware name: Generic R8A7790 (Flattened Device Tree)
Backtrace:
[<c0012f50>] (dump_backtrace) from [<c00130f8>] (show_stack+0x18/0x1c)
 r7:c05abf59 r6:ee161ac0 r5:00000009 r4:00000000
[<c00130e0>] (show_stack) from [<c049c714>] (dump_stack+0x78/0x94)
[<c049c69c>] (dump_stack) from [<c0027248>] (warn_slowpath_common+0x88/0xb4)
 r5:00000009 r4:ed8dfc98
[<c00271c0>] (warn_slowpath_common) from [<c00272e0>] (warn_slowpath_fmt+0x38/0x40)
 r9:00000000 r8:00000000 r7:00000010 r6:00000016 r5:ee095640 r4:00000000
[<c00272ac>] (warn_slowpath_fmt) from [<c005fbe8>] (irq_set_irq_wake+0x9c/0xf8)
 r3:00000016 r2:c05ac08a
[<c005fb4c>] (irq_set_irq_wake) from [<c01d34f0>] (gpio_rcar_irq_set_wake+0x1c/0x44)
 r7:00000010 r6:000000a6 r5:00000000 r4:ee276a30
[<c01d34d4>] (gpio_rcar_irq_set_wake) from [<c005ebe8>] (set_irq_wake_real+0x38/0x4c)
 r5:ee1177c0 r4:00000000
[<c005ebb0>] (set_irq_wake_real) from [<c005fc04>] (irq_set_irq_wake+0xb8/0xf8)
 r5:ee1177c0 r4:00000001
[<c005fb4c>] (irq_set_irq_wake) from [<c030a674>] (gpio_keys_resume+0x60/0xb8)
 r7:00000010 r6:00000000 r5:edba2c10 r4:edba2c10
[<c030a614>] (gpio_keys_resume) from [<c0261288>] (platform_pm_resume+0x48/0x54)
 r7:00000010 r6:ee28cc44 r5:ee28cc10 r4:c0261240
[<c0261240>] (platform_pm_resume) from [<c02699e0>] (dpm_run_callback.isra.10+0x24/0x50)
[<c02699bc>] (dpm_run_callback.isra.10) from [<c026a1c4>] (device_resume+0x10c/0x134)
 r5:ee28cc10 r4:00000001
[<c026a0b8>] (device_resume) from [<c026a2c0>] (dpm_resume+0xd4/0x200)
 r9:00000000 r8:00000010 r7:ee28cc10 r6:c0667cd8 r5:c06a1a44 r4:ee28cc78
[<c026a1ec>] (dpm_resume) from [<c026a400>] (dpm_resume_end+0x14/0x20)
 r10:00000000 r9:c067f6ec r8:c05a83f3 r7:00000000 r6:00000003 r5:c067f6ec
 r4:00000010
[<c026a3ec>] (dpm_resume_end) from [<c005ac14>] (suspend_devices_and_enter+0x230/0x3f4)
 r5:c067f6ec r4:00000000
[<c005a9e4>] (suspend_devices_and_enter) from [<c005ae84>] (pm_suspend+0xac/0x1c0)
 r9:c067f6f4 r8:c05a83f3 r7:edb6fa00 r6:00000003 r5:c06a1a48 r4:00000000
[<c005add8>] (pm_suspend) from [<c0059d74>] (state_store+0xb0/0xc4)
 r7:edb6fa00 r6:00000004 r5:00000003 r4:00000003
[<c0059cc4>] (state_store) from [<c01aa868>] (kobj_attr_store+0x1c/0x28)
 r9:000beb08 r8:ed8dff80 r7:ee10ee4c r6:ee10ee40 r5:edb6fa00 r4:00000004
[<c01aa84c>] (kobj_attr_store) from [<c011e970>] (sysfs_kf_write+0x40/0x4c)
[<c011e930>] (sysfs_kf_write) from [<c011dc24>] (kernfs_fop_write+0x120/0x180)
[<c011db04>] (kernfs_fop_write) from [<c00c8f80>] (__vfs_write+0x34/0xdc)
 r9:ed8de000 r8:c000fd44 r7:00000004 r6:ed8dff80 r5:c011db04 r4:edba9700
[<c00c8f4c>] (__vfs_write) from [<c00c91a4>] (vfs_write+0xb4/0x13c)
 r7:ed8dff80 r6:000beb08 r5:edba9700 r4:00000004
[<c00c90f0>] (vfs_write) from [<c00c930c>] (SyS_write+0x50/0x90)
 r9:ed8de000 r8:c000fd44 r7:00000004 r6:000beb08 r5:edba9700 r4:edba9700
[<c00c92bc>] (SyS_write) from [<c000fba0>] (ret_fast_syscall+0x0/0x34)
 r7:00000004 r6:000beb08 r5:00000001 r4:000bba10
---[ end trace 1c19f00acedc2bc7 ]---

Signed-off-by: Axel Haslam <ahaslam+renesas@baylibre.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 3a18af4..84fa279 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -15,6 +15,9 @@
  */
 
 #include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqchip/arm-gic.h>
 
 #include <asm/mach/arch.h>
 
@@ -27,6 +30,12 @@ static const char * const r8a7790_boards_compat_dt[] __initconst = {
 	NULL,
 };
 
+void __init r8a7790_init_irq(void)
+{
+	gic_arch_extn.flags = IRQCHIP_SKIP_SET_WAKE;
+	irqchip_init();
+}
+
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= shmobile_init_delay,
@@ -34,4 +43,5 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.init_late	= shmobile_init_late,
 	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7790_boards_compat_dt,
+	.init_irq	= r8a7790_init_irq,
 MACHINE_END
-- 
1.9.1

