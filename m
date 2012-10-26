From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 26 Oct 2012 13:38:48 +0000
Subject: [PATCH v3 2/5] pwm: Add Renesas Mobile TPU PWM driver
Message-Id: <1351258731-14111-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

The Timer Pulse Unit (TPU is a 4-channels 16-bit timer used to generate
waveforms. This driver exposes PWM functions through the PWM API for
other drivers to use.

The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
 drivers/pwm/Kconfig                    |    7 +
 drivers/pwm/Makefile                   |    1 +
 drivers/pwm/pwm-rmob.c                 |  482 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/pwm-rmob.h |   20 ++
 4 files changed, 510 insertions(+), 0 deletions(-)
 create mode 100644 drivers/pwm/pwm-rmob.c
 create mode 100644 include/linux/platform_data/pwm-rmob.h

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index ed81720..54cec32 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -103,6 +103,13 @@ config PWM_PXA
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-pxa.
 
+config PWM_RMOB
+	tristate "R-Mobile TPU PWM support"
+	depends on ARCH_SHMOBILE
+	help
+	  This driver exposes the Timer Pulse Unit (TPU) PWM controller found
+	  in R-Mobile and SH-Mobile chips through the PWM API.
+
 config PWM_SAMSUNG
 	tristate "Samsung pwm support"
 	depends on PLAT_SAMSUNG
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index acfe482..7b9211b 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_PUV3)		+= pwm-puv3.o
 obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
+obj-$(CONFIG_PWM_RMOB)		+= pwm-rmob.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
diff --git a/drivers/pwm/pwm-rmob.c b/drivers/pwm/pwm-rmob.c
new file mode 100644
index 0000000..43f2065
--- /dev/null
+++ b/drivers/pwm/pwm-rmob.c
@@ -0,0 +1,482 @@
+/*
+ * R-Mobile TPU PWM driver
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_data/pwm-rmob.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+
+#define TPU_TSTR		0x00	/* Timer start register (shared) */
+
+#define TPU_TCRn		0x00	/* Timer control register */
+#define TPU_TCR_CCLR_NONE	(0 << 5)
+#define TPU_TCR_CCLR_TGRA	(1 << 5)
+#define TPU_TCR_CCLR_TGRB	(2 << 5)
+#define TPU_TCR_CCLR_TGRC	(5 << 5)
+#define TPU_TCR_CCLR_TGRD	(6 << 5)
+#define TPU_TCR_CKEG_RISING	(0 << 3)
+#define TPU_TCR_CKEG_FALLING	(1 << 3)
+#define TPU_TCR_CKEG_BOTH	(2 << 3)
+#define TPU_TMDRn		0x04	/* Timer mode register */
+#define TPU_TMDR_BFWT		(1 << 6)
+#define TPU_TMDR_BFB		(1 << 5)
+#define TPU_TMDR_BFA		(1 << 4)
+#define TPU_TMDR_MD_NORMAL	(0 << 0)
+#define TPU_TMDR_MD_PWM		(2 << 0)
+#define TPU_TIORn		0x08	/* Timer I/O control register */
+#define TPU_TIOR_IOA_0		(0 << 0)
+#define TPU_TIOR_IOA_0_CLR	(1 << 0)
+#define TPU_TIOR_IOA_0_SET	(2 << 0)
+#define TPU_TIOR_IOA_0_TOGGLE	(3 << 0)
+#define TPU_TIOR_IOA_1		(4 << 0)
+#define TPU_TIOR_IOA_1_CLR	(5 << 0)
+#define TPU_TIOR_IOA_1_SET	(6 << 0)
+#define TPU_TIOR_IOA_1_TOGGLE	(7 << 0)
+#define TPU_TIERn		0x0c	/* Timer interrupt enable register */
+#define TPU_TSRn		0x10	/* Timer status register */
+#define TPU_TCNTn		0x14	/* Timer counter */
+#define TPU_TGRAn		0x18	/* Timer general register A */
+#define TPU_TGRBn		0x1c	/* Timer general register B */
+#define TPU_TGRCn		0x20	/* Timer general register C */
+#define TPU_TGRDn		0x24	/* Timer general register D */
+
+#define TPU_CHANNEL_OFFSET	0x10
+#define TPU_CHANNEL_SIZE	0x40
+
+enum tpu_pin_state {
+	TPU_PIN_UNUSED,			/* Pin is not used */
+	TPU_PIN_GPIO,			/* Pin is used as a GPIO */
+	TPU_PIN_GPIO_FN,		/* Pin is driven by the TPU */
+};
+
+struct tpu_device;
+
+struct tpu_pwm_device {
+	enum tpu_pin_state pin_state;
+	bool timer_on;			/* Whether the timer is running */
+
+	struct rmob_tpu_pwm_channel_data *pdata;
+	struct tpu_device *tpu;
+	unsigned int channel;		/* Channel number in the TPU */
+
+	unsigned int prescaler;
+	u16 period;
+	u16 duty;
+};
+
+struct tpu_device {
+	struct platform_device *pdev;
+	struct pwm_chip chip;
+	spinlock_t lock;
+
+	void __iomem *base;
+	struct clk *clk;
+
+	struct tpu_pwm_device pwms[RMOB_TPU_CHANNEL_MAX];
+};
+
+#define to_tpu_device(c)	container_of(c, struct tpu_device, chip)
+
+static void tpu_pwm_write(struct tpu_pwm_device *pwm, int reg_nr, u16 value)
+{
+	void __iomem *base = pwm->tpu->base + TPU_CHANNEL_OFFSET
+			   + pwm->channel * TPU_CHANNEL_SIZE;
+
+	iowrite16(value, base + reg_nr);
+}
+
+static void tpu_pwm_start_stop(struct tpu_pwm_device *pwm, int start)
+{
+	unsigned long flags;
+	u16 value;
+
+	spin_lock_irqsave(&pwm->tpu->lock, flags);
+	value = ioread16(pwm->tpu->base + TPU_TSTR);
+
+	if (start)
+		value |= 1 << pwm->channel;
+	else
+		value &= ~(1 << pwm->channel);
+
+	iowrite16(value, pwm->tpu->base + TPU_TSTR);
+	spin_unlock_irqrestore(&pwm->tpu->lock, flags);
+}
+
+static int tpu_pwm_timer_start(struct tpu_pwm_device *pwm)
+{
+	int ret;
+
+	if (!pwm->timer_on) {
+		/* Wake up device and enable clock. */
+		pm_runtime_get_sync(&pwm->tpu->pdev->dev);
+		ret = clk_prepare_enable(pwm->tpu->clk);
+		if (ret) {
+			dev_err(&pwm->tpu->pdev->dev, "cannot enable clock\n");
+			return ret;
+		}
+		pwm->timer_on = true;
+	}
+
+	/* Make sure the channel is stopped, as we need to reconfigure it
+	 * completely.
+	 */
+	tpu_pwm_start_stop(pwm, false);
+
+	/*
+	 * - Clear TCNT on TGRB match
+	 * - Count on rising edge
+	 * - Set prescaler
+	 * - Output 0 until TGRA, output 1 until TGRB (active low polarity)
+	 * - Output 1 until TGRA, output 0 until TGRB (active high polarity
+	 * - PWM mode
+	 */
+	tpu_pwm_write(pwm, TPU_TCRn, TPU_TCR_CCLR_TGRB | TPU_TCR_CKEG_RISING |
+		      pwm->prescaler);
+	tpu_pwm_write(pwm, TPU_TMDRn, TPU_TMDR_MD_PWM);
+	tpu_pwm_write(pwm, TPU_TIORn, pwm->pdata->polarity ?
+		      TPU_TIOR_IOA_1_CLR : TPU_TIOR_IOA_0_SET);
+	tpu_pwm_write(pwm, TPU_TGRAn, pwm->duty);
+	tpu_pwm_write(pwm, TPU_TGRBn, pwm->period);
+
+	dev_dbg(&pwm->tpu->pdev->dev, "%u: TGRA 0x%04x TGRB 0x%04x\n",
+		pwm->channel, pwm->duty, pwm->period);
+
+	/* Start the channel. */
+	tpu_pwm_start_stop(pwm, true);
+
+	return 0;
+}
+
+static void tpu_pwm_timer_stop(struct tpu_pwm_device *pwm)
+{
+	if (!pwm->timer_on)
+		return;
+
+	/* Disable channel. */
+	tpu_pwm_start_stop(pwm, false);
+
+	/* Stop clock and mark device as idle. */
+	clk_disable_unprepare(pwm->tpu->clk);
+	pm_runtime_put(&pwm->tpu->pdev->dev);
+
+	pwm->timer_on = false;
+}
+
+static void tpu_pwm_set_pin(struct tpu_pwm_device *pwm,
+			    enum tpu_pin_state new_state,
+			    bool active)
+{
+	static const char * const states[] = { "unused", "GPIO", "TPU" };
+	struct rmob_tpu_pwm_channel_data *pdata = pwm->pdata;
+	unsigned int gpio_value = active = pdata->polarity;
+
+	dev_dbg(&pwm->tpu->pdev->dev, "%u: configuring pin as %s %u\n",
+		pwm->channel, states[new_state], gpio_value);
+
+	if (pwm->pin_state = new_state) {
+		if (pwm->pin_state = TPU_PIN_GPIO)
+			gpio_set_value(pdata->pin_gpio, gpio_value);
+		return;
+	}
+
+	if (pwm->pin_state = TPU_PIN_GPIO)
+		gpio_free(pdata->pin_gpio);
+	else if (pwm->pin_state = TPU_PIN_GPIO_FN)
+		gpio_free(pdata->pin_gpio_fn);
+
+	if (new_state = TPU_PIN_GPIO) {
+		unsigned long flags = gpio_value
+				    ? GPIOF_OUT_INIT_HIGH : GPIOF_OUT_INIT_LOW;
+		gpio_request_one(pdata->pin_gpio, flags, pdata->name);
+	} else if (new_state = TPU_PIN_GPIO_FN) {
+		gpio_request(pdata->pin_gpio_fn, pdata->name);
+	}
+
+	pwm->pin_state = new_state;
+}
+
+/* -----------------------------------------------------------------------------
+ * PWM API
+ */
+
+static int tpu_pwm_request(struct pwm_chip *chip, struct pwm_device *_pwm)
+{
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *pwm = &tpu->pwms[_pwm->hwpwm];
+
+	return pwm->pdata = NULL ? -EPROBE_DEFER : 0;
+}
+
+static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
+			  int duty_ns, int period_ns)
+{
+	static const unsigned int prescalers[] = { 1, 4, 16, 64 };
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *pwm = &tpu->pwms[_pwm->hwpwm];
+	unsigned int prescaler;
+	bool duty_only;
+	u32 clk_rate;
+	u32 period;
+	u32 duty;
+	int ret = 0;
+
+	if (period_ns <= 0 || duty_ns < 0 || duty_ns > period_ns)
+		return -EINVAL;
+
+	/* Pick a prescaler to avoid overflowing the counter.
+	 * TODO: Pick the highest acceptable prescaler.
+	 */
+	clk_prepare_enable(tpu->clk);
+	clk_rate = clk_get_rate(tpu->clk);
+
+	for (prescaler = 0; prescaler < ARRAY_SIZE(prescalers); ++prescaler) {
+		period = clk_rate / prescalers[prescaler]
+		       / (NSEC_PER_SEC / period_ns);
+		if (period <= 0xffff)
+			break;
+	}
+
+	if (prescaler = ARRAY_SIZE(prescalers) || period = 0) {
+		dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
+		ret = -ENOTSUPP;
+		goto done;
+	}
+
+	if (duty_ns) {
+		duty = clk_rate / prescalers[prescaler]
+		     / (NSEC_PER_SEC / duty_ns);
+		if (duty > period) {
+			ret = -EINVAL;
+			goto done;
+		}
+	} else {
+		duty = 0;
+	}
+
+	dev_dbg(&tpu->pdev->dev,
+		"rate %u, prescaler %u, period %u, duty %u\n",
+		clk_rate, prescalers[prescaler], period, duty);
+
+	duty_only = pwm->prescaler = prescaler && pwm->period = period;
+
+	pwm->prescaler = prescaler;
+	pwm->period = period;
+	pwm->duty = duty;
+
+	/* If the channel is disabled we're done. */
+	if (!test_bit(PWMF_ENABLED, &_pwm->flags))
+		goto done;
+
+	if (duty = 0 || duty = period) {
+		/* To avoid running the timer when not strictly required, handle
+		 * 0% and 100% duty cycles as GPIOs.
+		 */
+		tpu_pwm_set_pin(pwm, TPU_PIN_GPIO, duty);
+		tpu_pwm_timer_stop(pwm);
+	} else if (duty_only && pwm->timer_on) {
+		/* If only the duty cycle changed and the timer is already
+		 * running, there's no need to reconfigure it completely, Just
+		 * modify the duty cycle.
+		 */
+		tpu_pwm_write(pwm, TPU_TGRAn, pwm->duty);
+		dev_dbg(&tpu->pdev->dev, "%u: TGRA 0x%04x\n", pwm->channel,
+			pwm->duty);
+	} else {
+		/* Otherwise perform a full reconfiguration. As this will
+		 * require disabling the PWM channel, switch it to GPIO mode
+		 * first in inactive state. This avoid glitches with active low
+		 * signals that would otherwise suddenly become active.
+		 */
+		tpu_pwm_set_pin(pwm, TPU_PIN_GPIO, false);
+		ret = tpu_pwm_timer_start(pwm);
+		if (ret < 0)
+			goto done;
+		tpu_pwm_set_pin(pwm, TPU_PIN_GPIO_FN, false);
+	}
+
+done:
+	clk_disable_unprepare(pwm->tpu->clk);
+	return ret;
+}
+
+static int tpu_pwm_enable(struct pwm_chip *chip, struct pwm_device *_pwm)
+{
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *pwm = &tpu->pwms[_pwm->hwpwm];
+	int ret;
+
+	/* PWM was disabled, enable it. To avoid running the timer when not
+	 * strictly required, handle 0% and 100% duty cycles as GPIOs.
+	 */
+	if (pwm->duty = 0 || pwm->duty = pwm->period) {
+		tpu_pwm_set_pin(pwm, TPU_PIN_GPIO, pwm->duty);
+		return 0;
+	}
+
+	ret = tpu_pwm_timer_start(pwm);
+	if (ret < 0)
+		return ret;
+
+	tpu_pwm_set_pin(pwm, TPU_PIN_GPIO_FN, false);
+	return 0;
+}
+
+static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *_pwm)
+{
+	struct tpu_device *tpu = to_tpu_device(chip);
+	struct tpu_pwm_device *pwm = &tpu->pwms[_pwm->hwpwm];
+
+	/* Reconfigure the pin as GPIO and stop the timer. */
+	tpu_pwm_set_pin(pwm, TPU_PIN_GPIO, false);
+	tpu_pwm_timer_stop(pwm);
+}
+
+static const struct pwm_ops tpu_pwm_ops = {
+	.request = tpu_pwm_request,
+	.config = tpu_pwm_config,
+	.enable = tpu_pwm_enable,
+	.disable = tpu_pwm_disable,
+	.owner = THIS_MODULE,
+};
+
+/* -----------------------------------------------------------------------------
+ * Probe and remove
+ */
+
+static int __devinit tpu_probe(struct platform_device *pdev)
+{
+	struct rmob_tpu_pwm_platform_data *pdata = pdev->dev.platform_data;
+	struct tpu_device *tpu;
+	struct resource *res;
+	unsigned int i;
+	int ret;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data\n");
+		return -ENXIO;
+	}
+
+	tpu = devm_kzalloc(&pdev->dev, sizeof(*tpu), GFP_KERNEL);
+	if (tpu = NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	/* Map memory, get clock. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		return -ENXIO;
+	}
+
+	tpu->base = devm_ioremap_nocache(&pdev->dev, res->start,
+					 resource_size(res));
+	if (tpu->base = NULL) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		return -ENXIO;
+	}
+
+	tpu->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpu->clk)) {
+		dev_err(&pdev->dev, "cannot get clock\n");
+		return PTR_ERR(tpu->clk);
+	}
+
+	/* Initialize and register the device. */
+	platform_set_drvdata(pdev, tpu);
+
+	spin_lock_init(&tpu->lock);
+	tpu->pdev = pdev;
+
+	for (i = 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
+		struct tpu_pwm_device *pwm = &tpu->pwms[i];
+
+		if (!pdata->channels[i].pin_gpio &&
+		    !pdata->channels[i].pin_gpio_fn)
+			continue;
+
+		pwm->tpu = tpu;
+		pwm->channel = i;
+		pwm->pdata = &pdata->channels[i];
+
+		pwm->prescaler = 0;
+		pwm->period = 0;
+		pwm->duty = 0;
+
+		pwm->timer_on = false;
+		pwm->pin_state = TPU_PIN_UNUSED;
+	}
+
+	tpu->chip.dev = &pdev->dev;
+	tpu->chip.ops = &tpu_pwm_ops;
+	tpu->chip.base = -1;
+	tpu->chip.npwm = RMOB_TPU_CHANNEL_MAX;
+
+	ret = pwmchip_add(&tpu->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register PWM chip\n");
+		return ret;
+	}
+
+	dev_info(&pdev->dev, "TPU PWM %u registered\n", tpu->pdev->id);
+
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+}
+
+static int __devexit tpu_remove(struct platform_device *pdev)
+{
+	struct tpu_device *tpu = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
+		struct tpu_pwm_device *pwm = &tpu->pwms[i];
+
+		if (!pwm->tpu)
+			continue;
+
+		tpu_pwm_set_pin(pwm, TPU_PIN_UNUSED, false);
+		tpu_pwm_timer_stop(pwm);
+	}
+
+	pm_runtime_disable(&pdev->dev);
+
+	return 0;
+}
+
+static struct platform_driver tpu_driver = {
+	.probe		= tpu_probe,
+	.remove		= __devexit_p(tpu_remove),
+	.driver		= {
+		.name	= "rmob_tpu_pwm",
+	}
+};
+
+module_platform_driver(tpu_driver);
+
+MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
+MODULE_DESCRIPTION("R-Mobile TPU PWM Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/pwm-rmob.h b/include/linux/platform_data/pwm-rmob.h
new file mode 100644
index 0000000..6bb9ec3
--- /dev/null
+++ b/include/linux/platform_data/pwm-rmob.h
@@ -0,0 +1,20 @@
+#ifndef __PWM_RMOB_TPU_H__
+#define __PWM_RMOB_TPU_H__
+
+#define RMOB_TPU_CHANNEL_MAX		4
+
+#define RMOB_TPU_PWM_ID(device, channel) \
+	((device) * RMOB_TPU_CHANNEL_MAX + (channel))
+
+struct rmob_tpu_pwm_channel_data {
+	const char *name;
+	unsigned int polarity;
+	unsigned int pin_gpio;
+	unsigned int pin_gpio_fn;
+};
+
+struct rmob_tpu_pwm_platform_data {
+	struct rmob_tpu_pwm_channel_data channels[RMOB_TPU_CHANNEL_MAX];
+};
+
+#endif /* __PWM_RMOB_TPU_H__ */
-- 
1.7.8.6

