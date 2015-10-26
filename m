From: Simon Horman <horms@verge.net.au>
Date: Mon, 26 Oct 2015 05:50:36 +0000
Subject: Re: [PATCH/RFC 1/6] boot-mode-reg: Add core
Message-Id: <20151026055035.GF2411@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Oct 23, 2015 at 05:11:56PM +0300, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Thursday 15 October 2015 15:59:32 Simon Horman wrote:
> > The motivation for this new module is to add a small frame work to allow
> > kernel subsystems to obtain boot mode information from a centralised
> > source using a new, and hopefully soon well-known, API.
> > 
> > The new API consists of two function calls and nothing more:
> > 
> > boot_mode_reg_set: Should be called by platform-specific drivers
> >                    to register the boot mode register value which
> > 		   they obtain from hardware or otherwise.
> > 
> > boot_mode_reg_get: Should be called by consumers; subsystems that
> >                    wish to know he boot mode register.
> > 
> > The boot mode register is a 32bit unsigned entity,
> > the meaning of its values are implementation dependent.
> 
> I believe this is where the bulk of the discussion will take place.
> 
> The boot mode get API is pretty straightforward. We might want to pass a
> boot mode structure pointer instead of an u32 *, but I believe that's a
> detail at this stage. I'll leave bikeshedding to others for now.
> 
> I had envisioned the set operation a bit differently, but that doesn't
> mean your proposal is bad. Just for the record, I was thinking of adding
> a macro similar to CLK_OF_DECLARE() to declare possible boot mode
> providers. The get operation would then walk through the list the first
> time it's called and try to get the boot mode from the provider(s)
> compatible with the running DT. The value would then be cached internally
> and returned on subsequent calls.
> 
> That approach would solve (or work around, depending on how you see it)
> the initcall ordering issue. initcall ordering is another point that I
> see as potentially leading to lengthy discussions, we need to think it
> through propery and define exactly when the boot mode is available to
> drivers or other kernel code.

Thanks.

I apologise if you had mentioned this to me before, if so I must
have misunderstood it because I did not consider using a CLK_OF_DECLARE()
variant before now.

I have now taken a look at it and it does seem to quite nicely
side-step the initcall / earlyboot ordering problem. I took a stab
at implementing the idea and it seemed to come out quite cleanly
(and worked first go!).

What did is in the incremental patch on top of the entire series below.
It also includes a few other minor cleanups - correcting error handing
and EXPORT_SYMBOL_GPL names.

Could you see if it is to your liking? Of course I will
break up the patch and squash the appropriate portions into the
patches of this series before any formal posting of it.


diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 403ee0ede379..8aba1c4c2a62 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -121,10 +121,7 @@ void __init rcar_gen2_timer_init(void)
 {
 	int err;
 
-	err = rcar_gen2_init_boot_mode();
-	if (err)
-		pr_err("Could not initialise boot mode register driver\n");
-
+	boot_mode_reg_of_init();
 	rcar_gen2_timer_init_for_arch_timer();
 	rcar_gen2_clocks_init();
 	clocksource_of_init();
diff --git a/drivers/misc/boot-mode-reg/core.c b/drivers/misc/boot-mode-reg/core.c
index 9d7d72f52132..f50d84b8c65d 100644
--- a/drivers/misc/boot-mode-reg/core.c
+++ b/drivers/misc/boot-mode-reg/core.c
@@ -44,9 +44,9 @@ int boot_mode_reg_get(u32 *mode)
 	err = 0;
 err:
 	mutex_unlock(&boot_mode_mutex);
-	return 0;
+	return err;
 }
-EXPORT_SYMBOL_GPL(boot_mode_get);
+EXPORT_SYMBOL_GPL(boot_mode_reg_get);
 
 /**
  * boot_mode_reg_set() - record boot mode register value
@@ -54,25 +54,47 @@ EXPORT_SYMBOL_GPL(boot_mode_get);
  *
  * Records the boot mode register value which may subsequently
  * be retrieved using boot_mode_reg_get().
- *
- * return: 0 on success
  */
-int boot_mode_reg_set(u32 mode)
+void boot_mode_reg_set(u32 mode)
 {
-	int err = -EBUSY;
-
 	mutex_lock(&boot_mode_mutex);
-	if (boot_mode_is_set && boot_mode != mode)
+	if (boot_mode_is_set && boot_mode != mode) {
+		pr_err("boot mode register value already registered");
 		goto err;
+	}
 	boot_mode = mode;
 	boot_mode_is_set = true;
-	err = 0;
-err:
 	mutex_unlock(&boot_mode_mutex);
-	return 0;
+err:
+	return;
 }
-EXPORT_SYMBOL_GPL(boot_mode_set);
+EXPORT_SYMBOL_GPL(boot_mode_reg_set);
+
+
+#include <linux/init.h>
+#include <linux/of.h>
+
+extern struct of_device_id __boot_mode_reg_of_table[];
 
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Simon Horman <horms@verge.net.au>");
-MODULE_DESCRIPTION("Core Boot Mode Register Driver");
+static const struct of_device_id __boot_mode_reg_of_table_sentinel
+	__used __section(__boot_mode_reg_of_table_end);
+
+void __init boot_mode_reg_of_init(void)
+{
+	struct device_node *np;
+	const struct of_device_id *match;
+
+	for_each_matching_node_and_match(np, __boot_mode_reg_of_table, &match) {
+		of_init_fn_1 init_func;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		init_func = match->data;
+		init_func(np);
+
+		return;
+	}
+
+	pr_warn("%s: no matching boot mode reg providor found\n", __func__);
+}
diff --git a/drivers/misc/boot-mode-reg/rcar-gen2.c b/drivers/misc/boot-mode-reg/rcar-gen2.c
index 0f1a06fcf094..3970c9ffc38e 100644
--- a/drivers/misc/boot-mode-reg/rcar-gen2.c
+++ b/drivers/misc/boot-mode-reg/rcar-gen2.c
@@ -21,40 +21,35 @@
 
 #define MODEMR 0xe6160060
 
-static int __init rcar_gen2_read_mode_pins(void)
+static void __init rcar_gen2_read_mode_pins(void)
 {
 	void __iomem *modemr;
-	int err = -ENOMEM;
 	static u32 mode;
 
 	modemr = ioremap_nocache(MODEMR, 4);
 	if (!modemr) {
 		pr_err("failed to map boot mode register");
-		goto err;
+		return;
 	}
 	mode = ioread32(modemr);
 	iounmap(modemr);
 
-	err = boot_mode_reg_set(mode);
-err:
-	if (err)
-		pr_err("failed to initialise boot mode");
-	return err;
+	boot_mode_reg_set(mode);
 }
 
-int __init rcar_gen2_init_boot_mode(void)
+static void __init rcar_gen2_init(struct device_node *np)
 {
-	if (of_machine_is_compatible("renesas,r8a7790") ||
-	    of_machine_is_compatible("renesas,r8a7791") ||
-	    of_machine_is_compatible("renesas,r8a7792") ||
-	    of_machine_is_compatible("renesas,r8a7793") ||
-	    of_machine_is_compatible("renesas,r8a7794"))
-		return rcar_gen2_read_mode_pins();
-
-	return 0;
+	rcar_gen2_read_mode_pins();
 }
-EXPORT_SYMBOL_GPL(boot_mode_set);
-early_initcall(rcar_gen2_init_boot_mode);
+
+#define RCAR_GEN2_BOOT_MODE_REG_OF_DECLARE(name) \
+	BOOT_MODE_REG_OF_DECLARE(name, "renesas," #name, rcar_gen2_init);
+
+RCAR_GEN2_BOOT_MODE_REG_OF_DECLARE(r8a7790);
+RCAR_GEN2_BOOT_MODE_REG_OF_DECLARE(r8a7791);
+RCAR_GEN2_BOOT_MODE_REG_OF_DECLARE(r8a7792);
+RCAR_GEN2_BOOT_MODE_REG_OF_DECLARE(r8a7793);
+RCAR_GEN2_BOOT_MODE_REG_OF_DECLARE(r8a7794);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Simon Horman <horms@verge.net.au>");
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1781e54ea6d3..875afce4827d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -180,6 +180,8 @@
 #define CPU_METHOD_OF_TABLES()	OF_TABLE(CONFIG_SMP, cpu_method)
 #define CPUIDLE_METHOD_OF_TABLES() OF_TABLE(CONFIG_CPU_IDLE, cpuidle_method)
 #define EARLYCON_OF_TABLES()	OF_TABLE(CONFIG_SERIAL_EARLYCON, earlycon)
+#define BOOT_MODE_REG_OF_TABLES() OF_TABLE(CONFIG_BOOT_MODE_REG_CORE,   \
+						 boot_mode_reg)
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
@@ -515,7 +517,8 @@
 	KERNEL_DTB()							\
 	IRQCHIP_OF_MATCH_TABLE()					\
 	EARLYCON_TABLE()						\
-	EARLYCON_OF_TABLES()
+	EARLYCON_OF_TABLES()						\
+	BOOT_MODE_REG_OF_TABLES()
 
 #define INIT_TEXT							\
 	*(.init.text)							\
diff --git a/include/misc/boot-mode-reg.h b/include/misc/boot-mode-reg.h
index f8fea0ea5a3e..dacfa94373e4 100644
--- a/include/misc/boot-mode-reg.h
+++ b/include/misc/boot-mode-reg.h
@@ -19,9 +19,14 @@
 #include <linux/types.h>
 
 int boot_mode_reg_get(u32 *mode);
-int boot_mode_reg_set(u32 mode);
+void boot_mode_reg_set(u32 mode);
 
-/* Allow explicit initialisation before initcalls */
-int rcar_gen2_init_boot_mode(void);
+
+void boot_mode_reg_of_init(void);
+
+#define BOOT_MODE_REG_OF_DECLARE(name, compat, fn)                      \
+       static const struct of_device_id __boot_mode_reg_of_table_##name \
+               __used __section(__boot_mode_reg_of_table)               \
+                = { .compatible = compat, .data = fn };
 
 #endif
