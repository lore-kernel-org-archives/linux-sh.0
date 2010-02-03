From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Wed, 03 Feb 2010 13:05:08 +0000
Subject: [PATCH] sh: added PWM driver for SH7723 using the TPU
Message-Id: <95F51F4B902CAC40AF459205F6322F0171E8D499FD@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

this PWM driver using the TPU can be used with drivers/video/backlight/pwm_bl.c to dim the backlight

Signed-off-by: Markus Pietrek <markus.pietrek@emtrion.de>
---
 arch/sh/Kconfig           |    3 +
 arch/sh/drivers/Kconfig   |    7 +
 arch/sh/drivers/Makefile  |    1 +
 arch/sh/drivers/pwm_tpu.c |  332 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 343 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/drivers/pwm_tpu.c

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index bae5383..54ecbae 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -182,6 +182,9 @@ config DMA_COHERENT
 config DMA_NONCOHERENT
        def_bool !DMA_COHERENT

+config HAVE_PWM
+       bool
+
 source "init/Kconfig"

 source "kernel/Kconfig.freezer"
diff --git a/arch/sh/drivers/Kconfig b/arch/sh/drivers/Kconfig
index 420c6b2..83c8794 100644
--- a/arch/sh/drivers/Kconfig
+++ b/arch/sh/drivers/Kconfig
@@ -16,4 +16,11 @@ config PUSH_SWITCH
          This enables support for the push switch framework, a simple
          framework that allows for sysfs driven switch status reporting.

+config SH_PWM_TPU
+       bool "PWM with Timer Pulse Unit (TPU) Driver"
+       depends on CPU_SUBTYPE_SH7723
+       select HAVE_PWM
+        help
+          Provides a PWM driver using the Timer Pulse Unit of the SH7723
+
 endmenu
diff --git a/arch/sh/drivers/Makefile b/arch/sh/drivers/Makefile
index e13f06b..3dcaf83 100644
--- a/arch/sh/drivers/Makefile
+++ b/arch/sh/drivers/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_PCI)               += pci/
 obj-$(CONFIG_SUPERHYWAY)       += superhyway/
 obj-$(CONFIG_PUSH_SWITCH)      += push-switch.o
 obj-$(CONFIG_HEARTBEAT)                += heartbeat.o
+obj-$(CONFIG_SH_PWM_TPU)        += tpu.o
diff --git a/arch/sh/drivers/pwm_tpu.c b/arch/sh/drivers/pwm_tpu.c
new file mode 100644
index 0000000..d79733c
--- /dev/null
+++ b/arch/sh/drivers/pwm_tpu.c
@@ -0,0 +1,332 @@
+/*
+ * pwm_tpu.c
+ *
+ * Copyright (c) 2010 by emtrion GmbH
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; either version 2 of
+ * the License, or (at your option) any later version.
+ *
+ * Author:     Markus Pietrek
+ * Description: Provides PWM functionality with the TPU.
+ *             TPU outputs 1 in disabled state and 0 in active state.
+ *
+ **/
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/pwm.h>
+
+#ifdef CONFIG_CPU_SUBTYPE_SH7723
+# include <cpu/sh7723.h>
+#endif
+
+/* TPU register definitions */
+#define TSTR           0x00
+
+/* TPU channel specific registers */
+#define TPUC_BASE      0x10
+#define TPUC_OFFSET    0x40
+
+#define TCR            0x00
+#define TMDR           0x04
+#define TIOR           0x08
+#define TIER           0x0C
+#define TSR            0x10
+#define TCNT           0x14
+#define TGRA           0x18
+#define TGRB           0x1C
+#define TGRC           0x20
+#define TGRD           0x24
+
+/* TPU register bits */
+#define TCR_CCLR_TGRB_CLEARS   0x40
+#define TCR_CKEG_RISING                0x00
+#define TCR_TPSC_64            0x03
+
+#define TIOR_OUTPUT_ALWAYS_0                   0x00
+#define TIOR_OUTPUT_ALWAYS_1                   0x04
+#define TIOR_INIT_0_OUTPUT_1_ON_MATCH_TGRA     0x02
+#define TIOR_INIT_1_OUTPUT_0_ON_MATCH_TGRA     0x05
+
+#define TMDR_PWM       0x02
+
+#define CHANNELS 4
+
+struct pwm_device {
+       const char *label;
+       int pwm_id;
+       int active;             /* for counting whether the clock on the TPU needs to be enabled */
+};
+
+static struct pwm_tpu_priv {
+       struct device *dev;
+       void __iomem *base;
+       struct clk *clk;
+       struct clk *bclk;
+       struct mutex mutex;
+
+       struct pwm_device devices[CHANNELS];
+       int clk_enabled;
+} *priv;
+
+static const int gpios[CHANNELS] = {
+#ifdef CONFIG_CPU_SUBTYPE_SH7723
+       GPIO_PTG0,
+       GPIO_PTG1,
+       GPIO_PTG2,
+       GPIO_PTG3,
+#else
+# error no GPIO configuration for cpu
+#endif
+};
+
+static inline void tpuc_write(const struct pwm_tpu_priv *priv, int ch, u16 val, int reg)
+{
+       iowrite16(val, priv->base + TPUC_BASE + (ch*TPUC_OFFSET) + reg);
+}
+
+static inline u16 tpuc_read(const struct pwm_tpu_priv *priv, int ch, int reg)
+{
+       return ioread16(priv->base + TPUC_BASE + (ch*TPUC_OFFSET) + reg);
+}
+
+/* exported pwm functions */
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+       struct pwm_device *pwm = NULL;
+       int error;
+
+       mutex_lock(&priv->mutex);
+
+       if (!label) {
+               dev_err(priv->dev, "need a name for pwm %i\n", pwm_id);
+               pwm = ERR_PTR(-EINVAL);
+               goto out;
+       }
+
+       if (pwm_id >= ARRAY_SIZE(priv->devices) || priv->devices[pwm_id].label) {
+               dev_err(priv->dev, "TPU %i already in use %s\n", pwm_id, priv->devices[pwm_id].label);
+               pwm = ERR_PTR(-EBUSY);
+               goto out;
+       }
+       pwm = &priv->devices[pwm_id];
+
+       error = gpio_request(gpios[pwm_id], label);
+       if (error) {
+               dev_err(priv->dev, "GPIO %i already reserved.\n", gpios[pwm_id] );
+               pwm = ERR_PTR(error);
+               goto out;
+       }
+       pwm->label  = label;
+       pwm->pwm_id = pwm_id;
+
+       dev_info(priv->dev, "TPU %i registered for %s\n", pwm_id, label);
+
+out:
+       mutex_unlock(&priv->mutex);
+       return pwm;
+}
+EXPORT_SYMBOL(pwm_request);
+
+void pwm_free(struct pwm_device *pwm)
+{
+       mutex_lock(&priv->mutex);
+       gpio_free(gpios[pwm->pwm_id]);
+       pwm->label = NULL;
+       mutex_unlock(&priv->mutex);
+}
+EXPORT_SYMBOL(pwm_free);
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+       int period_hz;
+       int tgra;
+       int tgrb;
+
+       BUG_ON((period_ns <= 0) || (duty_ns > period_ns));
+
+       mutex_lock(&priv->mutex);
+
+       /* enable clock for TPU when it was off before  */
+       if (!priv->clk_enabled) {
+               clk_enable(priv->clk);
+               priv->clk_enabled = 1;
+       }
+       pwm->active = 1;
+
+       /* calculate TGRA and TGRB settings based on the duty/period durations */
+       period_hz = 1000000000 / period_ns;
+       tgrb = ((clk_get_rate(priv->bclk)/64) / period_hz);
+
+       if (duty_ns >= period_ns)
+               tgra = 0;       /* 100% duty */
+       else if (duty_ns <= 0)
+               tgra = tgrb + 1; /* off */
+       else
+               tgra = tgrb - (tgrb * (duty_ns/1000))/(period_ns/1000);
+
+       /* configure TPU */
+       tpuc_write(priv, pwm->pwm_id,
+                  TCR_CCLR_TGRB_CLEARS |
+                  TCR_CKEG_RISING      |
+                  TCR_TPSC_64,
+                  TCR);
+       tpuc_write(priv, pwm->pwm_id,
+                  TIOR_INIT_1_OUTPUT_0_ON_MATCH_TGRA,
+                  TIOR);
+       tpuc_write(priv, pwm->pwm_id, tgra, TGRA);
+       tpuc_write(priv, pwm->pwm_id, tgrb, TGRB);
+       tpuc_write(priv, pwm->pwm_id, TMDR_PWM, TMDR);
+
+       mutex_unlock(&priv->mutex);
+
+       return 0;
+}
+EXPORT_SYMBOL(pwm_config);
+
+int pwm_enable(struct pwm_device *pwm)
+{
+       /* pwm_config is called before enable, so we don't need to enable priv->clk here */
+       mutex_lock(&priv->mutex);
+       iowrite16(ioread16(priv->base+TSTR) | (1<<pwm->pwm_id), priv->base+TSTR);
+       mutex_unlock(&priv->mutex);
+
+       return 0;
+}
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwm)
+{
+       int devices_active = 0;
+       int i;
+
+       mutex_lock(&priv->mutex);
+
+       /* set output to off state */
+       tpuc_write(priv, pwm->pwm_id,
+                  TIOR_OUTPUT_ALWAYS_1,
+                  TIOR);
+       iowrite16(ioread16(priv->base+TSTR) & ~(1<<pwm->pwm_id), priv->base+TSTR);
+
+       /* disable power when TPU is no longer in use */
+       pwm->active = 0;
+       for (i=0; i < ARRAY_SIZE(priv->devices); i++) {
+               if (priv->devices[i].active) {
+                       devices_active = 1;
+                       break;
+               }
+       }
+
+       if (!devices_active) {
+               clk_disable(priv->clk);
+               priv->clk_enabled = 0;
+       }
+
+       mutex_unlock(&priv->mutex);
+}
+EXPORT_SYMBOL(pwm_disable);
+
+/* driver registering functions */
+
+static int __devinit pwm_tpu_probe(struct platform_device *pdev)
+{
+       struct resource *res;
+       int error;
+
+       priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+       if (!priv) {
+               dev_err(&pdev->dev, "cannot get memory\n");
+               error = -ENOMEM;
+               goto error;
+       }
+       priv->dev = &pdev->dev;
+       platform_set_drvdata(pdev, priv);
+
+       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+       if (!res) {
+               dev_err(&pdev->dev, "cannot get platform resources\n");
+               error = -EINVAL;
+               goto error_map;
+       }
+
+       priv->base = ioremap(res->start, (res->end-res->start)+1);
+       if (!priv->base) {
+               dev_err(&pdev->dev, "cannot get io memory\n");
+               error = -ENOMEM;
+               goto error_map;
+       }
+
+       priv->clk = clk_get(&pdev->dev, "tpu0");
+       if (IS_ERR(priv->clk)) {
+               dev_err(&pdev->dev, "cannot get clock");
+               goto error_clock;
+       }
+
+       priv->bclk = clk_get(&pdev->dev, "bus_clk");
+       if (IS_ERR(priv->bclk)) {
+               dev_err(&pdev->dev, "cannot get bus clock");
+               goto error_bclock;
+       }
+
+       mutex_init(&priv->mutex);
+
+       dev_info(&pdev->dev, "initialized\n");
+       return 0;
+
+error_bclock:
+       clk_put(priv->bclk);
+
+error_clock:
+       iounmap(priv->base);
+
+error_map:
+       kfree(priv);
+
+error:
+       return error;
+}
+
+static int __devexit pwm_tpu_remove(struct platform_device *pdev)
+{
+       clk_put(priv->bclk);
+       clk_put(priv->clk);
+       iounmap(priv->base);
+       kfree(priv);
+
+       platform_set_drvdata(pdev, NULL);
+
+       return 0;
+}
+
+static struct platform_driver pwm_tpu_driver = {
+       .probe          = pwm_tpu_probe,
+       .remove         = pwm_tpu_remove,
+       .driver         = {
+               .name   = "pwm_tpu",
+               .owner  = THIS_MODULE,
+       },
+};
+
+static int __init pwm_tpu_init(void)
+{
+       return platform_driver_register(&pwm_tpu_driver);
+}
+
+static void __exit pwm_tpu_exit(void)
+{
+       platform_driver_unregister(&pwm_tpu_driver);
+}
+
+MODULE_AUTHOR("Markus Pietrek");
+MODULE_DESCRIPTION("PWM/Timer Pulse Unit TPU control");
+MODULE_LICENSE("GPL");
+
+arch_initcall(pwm_tpu_init);
+module_exit(pwm_tpu_exit);
--
1.5.4.3

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch?ftsf?hrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or otherwise confidential information.
- If you have received this e-mail in error, you are hereby notified that any review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
