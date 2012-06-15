From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 15 Jun 2012 15:17:03 +0000
Subject: [PATCH 2/6] misc: Add Renesas Mobile TPU PWM driver
Message-Id: <1339773427-29508-3-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The Timer Pulse Unit (TPU is a 4-channels 16-bit timer used to generate
waveforms. This driver exposes PWM functions through the PWM API for
other drivers to use.

The code is loosely based on the leds-renesas-tpu driver by Magnus Damm
and the TPU PWM driver shipped in the Armadillo EVA 800 kernel sources.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/misc/Kconfig                       |    9 +
 drivers/misc/Makefile                      |    1 +
 drivers/misc/rmob-tpu-pwm.c                |  526 ++++++++++++++++++++++++++++
 include/linux/platform_data/rmob-tpu-pwm.h |   17 +
 4 files changed, 553 insertions(+), 0 deletions(-)
 create mode 100644 drivers/misc/rmob-tpu-pwm.c
 create mode 100644 include/linux/platform_data/rmob-tpu-pwm.h

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 1a0254a..841f1ed 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -518,6 +518,15 @@ config WL127X_RFKILL
 	 Creates an rfkill entry in sysfs for power control of Bluetooth
 	 TI wl127x chips.
 	 
+config RMOB_TPU_PWM
+	tristate "R-Mobile TPU PWM driver"
+	depends on ARCH_SHMOBILE
+	select HAVE_PWM
+	help
+	  This driver supports the Timer Pulse Unit (TPU) PWM controller found
+	  in R-Mobile and SH-Mobile chips. It exposes PWM functions through the
+	  PWM API.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 89540d1..a4a4e09 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
 obj-$(CONFIG_MAX8997_MUIC)	+= max8997-muic.o
 obj-$(CONFIG_WL127X_RFKILL)	+= wl127x-rfkill.o
 obj-$(CONFIG_SENSORS_AK8975)	+= akm8975.o
+obj-$(CONFIG_RMOB_TPU_PWM)	+= rmob-tpu-pwm.o
diff --git a/drivers/misc/rmob-tpu-pwm.c b/drivers/misc/rmob-tpu-pwm.c
new file mode 100644
index 0000000..1a666b8
--- /dev/null
+++ b/drivers/misc/rmob-tpu-pwm.c
@@ -0,0 +1,526 @@
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
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
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
+#include <linux/platform_data/rmob-tpu-pwm.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
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
+struct pwm_device {
+	struct list_head list;
+	enum tpu_pin_state pin_state;
+	bool pwm_enabled;		/* Whether the PWM output is enabled */
+	bool timer_on;			/* Whether the timer is running */
+	bool in_use;
+
+	struct rmob_tpu_pwm_channel_data *pdata;
+	struct tpu_device *tpu;
+	unsigned int id;		/* Global PWM ID */
+	unsigned int channel;		/* Channel number in the TPU */
+
+	unsigned int prescaler;
+	u16 period;
+	u16 duty;
+};
+
+struct tpu_device {
+	struct platform_device *pdev;
+	spinlock_t lock;
+
+	void __iomem *base;
+	struct clk *clk;
+
+	struct pwm_device pwms[RMOB_TPU_CHANNEL_MAX];
+};
+
+static void tpu_pwm_write(struct pwm_device *pwm, int reg_nr, u16 value)
+{
+	void __iomem *base = pwm->tpu->base + TPU_CHANNEL_OFFSET
+			   + pwm->channel * TPU_CHANNEL_SIZE;
+
+	iowrite16(value, base + reg_nr);
+}
+
+static void tpu_pwm_start_stop(struct pwm_device *pwm, int start)
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
+static int tpu_pwm_timer_start(struct pwm_device *pwm)
+{
+	int ret;
+
+	if (!pwm->timer_on) {
+		/* Wake up device and enable clock. */
+		pm_runtime_get_sync(&pwm->tpu->pdev->dev);
+		ret = clk_enable(pwm->tpu->clk);
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
+static void tpu_pwm_timer_stop(struct pwm_device *pwm)
+{
+	if (!pwm->timer_on)
+		return;
+
+	/* Disable channel. */
+	tpu_pwm_start_stop(pwm, false);
+
+	/* Stop clock and mark device as idle. */
+	clk_disable(pwm->tpu->clk);
+	pm_runtime_put(&pwm->tpu->pdev->dev);
+
+	pwm->timer_on = false;
+}
+
+static void tpu_pwm_set_pin(struct pwm_device *pwm,
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
+static int tpu_pwm_update(struct pwm_device *pwm, unsigned int prescaler,
+			  unsigned int period, unsigned int duty)
+{
+	bool duty_only = pwm->prescaler = prescaler && pwm->period = period;
+	int ret;
+
+	pwm->prescaler = prescaler;
+	pwm->period = period;
+	pwm->duty = duty;
+
+	if (!pwm->pwm_enabled)
+		return 0;
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
+		dev_dbg(&pwm->tpu->pdev->dev, "%u: TGRA 0x%04x\n", pwm->channel,
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
+			return ret;
+		tpu_pwm_set_pin(pwm, TPU_PIN_GPIO_FN, false);
+	}
+
+	return 0;
+}
+
+/* -----------------------------------------------------------------------------
+ * PWM API
+ */
+
+static DEFINE_MUTEX(pwm_lock);
+static LIST_HEAD(pwm_list);
+
+int pwm_enable(struct pwm_device *pwm)
+{
+	int ret;
+
+	if (pwm->pwm_enabled)
+		return 0;
+
+	pwm->pwm_enabled = true;
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
+EXPORT_SYMBOL(pwm_enable);
+
+void pwm_disable(struct pwm_device *pwm)
+{
+	if (!pwm->pwm_enabled)
+		return;
+
+	pwm->pwm_enabled = false;
+
+	/* PWM was enabled, disable it. Reconfigure the pin as GPIO and stop the
+	 * timer.
+	 */
+	tpu_pwm_set_pin(pwm, TPU_PIN_GPIO, false);
+	tpu_pwm_timer_stop(pwm);
+}
+EXPORT_SYMBOL(pwm_disable);
+
+int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
+{
+	static const unsigned int prescalers[] = { 1, 4, 16, 64 };
+	unsigned int prescaler;
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
+	clk_enable(pwm->tpu->clk);
+	clk_rate = clk_get_rate(pwm->tpu->clk);
+
+	for (prescaler = 0; prescaler < ARRAY_SIZE(prescalers); ++prescaler) {
+		period = clk_rate / prescalers[prescaler]
+		       / (NSEC_PER_SEC / period_ns);
+		if (period <= 0xffff)
+			break;
+	}
+
+	if (prescaler = ARRAY_SIZE(prescalers) || period = 0) {
+		dev_err(&pwm->tpu->pdev->dev, "clock rate mismatch\n");
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
+	dev_dbg(&pwm->tpu->pdev->dev,
+		"rate %u, prescaler %u, period %u, duty %u\n",
+		clk_rate, prescalers[prescaler], period, duty);
+
+	ret = tpu_pwm_update(pwm, prescaler, period, duty);
+
+done:
+	clk_disable(pwm->tpu->clk);
+	return ret;
+}
+EXPORT_SYMBOL(pwm_config);
+
+struct pwm_device *pwm_request(int pwm_id, const char *label)
+{
+	struct pwm_device *pwm;
+
+	mutex_lock(&pwm_lock);
+	list_for_each_entry(pwm, &pwm_list, list) {
+		if (pwm->id != pwm_id)
+			continue;
+
+		if (pwm->in_use) {
+			mutex_unlock(&pwm_lock);
+			return ERR_PTR(-EBUSY);
+		}
+
+		pwm->in_use = true;
+		mutex_unlock(&pwm_lock);
+		return pwm;
+	}
+	mutex_unlock(&pwm_lock);
+	return ERR_PTR(-ENODEV);
+}
+EXPORT_SYMBOL(pwm_request);
+
+void pwm_free(struct pwm_device *pwm)
+{
+	pwm_disable(pwm);
+
+	mutex_lock(&pwm_lock);
+	pwm->in_use = false;
+	mutex_unlock(&pwm_lock);
+}
+EXPORT_SYMBOL(pwm_free);
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
+	int ret = -ENXIO;
+
+	if (!pdata) {
+		dev_err(&pdev->dev, "missing platform data\n");
+		return -ENXIO;
+	}
+
+	tpu = kzalloc(sizeof(*tpu), GFP_KERNEL);
+	if (tpu = NULL) {
+		dev_err(&pdev->dev, "failed to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	/* Map memory, get clock. */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		goto err_free;
+	}
+
+	tpu->base = ioremap_nocache(res->start, resource_size(res));
+	if (tpu->base = NULL) {
+		dev_err(&pdev->dev, "failed to remap I/O memory\n");
+		goto err_free;
+	}
+
+	tpu->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(tpu->clk)) {
+		dev_err(&pdev->dev, "cannot get clock\n");
+		ret = PTR_ERR(tpu->clk);
+		goto err_unmap;
+	}
+
+	/* Initialize the device. */
+	platform_set_drvdata(pdev, tpu);
+
+	spin_lock_init(&tpu->lock);
+	tpu->pdev = pdev;
+
+	for (i = 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
+		struct pwm_device *pwm = &tpu->pwms[i];
+
+		if (!pdata->channels[i].pin_gpio &&
+		    !pdata->channels[i].pin_gpio_fn)
+			continue;
+
+		pwm->tpu = tpu;
+		pwm->id = tpu->pdev->id * RMOB_TPU_CHANNEL_MAX + i;
+		pwm->channel = i;
+		pwm->pdata = &pdata->channels[i];
+
+		pwm->prescaler = 0;
+		pwm->period = 0;
+		pwm->duty = 0;
+
+		pwm->pwm_enabled = false;
+		pwm->timer_on = false;
+		pwm->pin_state = TPU_PIN_UNUSED;
+
+		mutex_lock(&pwm_lock);
+		list_add_tail(&pwm->list, &pwm_list);
+		mutex_unlock(&pwm_lock);
+
+		dev_info(&pdev->dev, "TPU PWM %u (%u/%u) registered\n",
+			 pwm->id, tpu->pdev->id, i);
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	return 0;
+
+err_unmap:
+	iounmap(tpu->base);
+err_free:
+	kfree(tpu);
+	return ret;
+}
+
+static int __devexit tpu_remove(struct platform_device *pdev)
+{
+	struct tpu_device *tpu = platform_get_drvdata(pdev);
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tpu->pwms); ++i) {
+		struct pwm_device *pwm = &tpu->pwms[i];
+
+		if (!pwm->tpu)
+			continue;
+
+		tpu_pwm_set_pin(pwm, TPU_PIN_UNUSED, false);
+		tpu_pwm_timer_stop(pwm);
+	}
+
+	pm_runtime_disable(&pdev->dev);
+	clk_put(tpu->clk);
+
+	iounmap(tpu->base);
+	kfree(tpu);
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
diff --git a/include/linux/platform_data/rmob-tpu-pwm.h b/include/linux/platform_data/rmob-tpu-pwm.h
new file mode 100644
index 0000000..48454e9
--- /dev/null
+++ b/include/linux/platform_data/rmob-tpu-pwm.h
@@ -0,0 +1,17 @@
+#ifndef __RMOB_TPU_PWM_H__
+#define __RMOB_TPU_PWM_H__
+
+#define RMOB_TPU_CHANNEL_MAX		4
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
+#endif /* __RMOB_TPU_PWM_H__ */
-- 
1.7.3.4

