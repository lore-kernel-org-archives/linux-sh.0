From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 05 Mar 2008 20:59:48 +0000
Subject: [HP J6xx] - Touchscreen still not working with tslib
Message-Id: <20080305220015.a30f01fa.Kristoffer.Ericson@Gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings,

(including arm-linux, just because tslib is multiplatform)

Im still having no luck with ts_calibrate. It atleast starts now, but doesnt react to any input. Ive also added some printk's and
they feed back good data when touchscreen is pressed. So the problem is somehow in how the data is presented to tslib.

J6xx and J7xx is suffering from same issues, Im including j6xx code here simply because Ive made some minimal progress with it.
Basicly j6xx ts_calibrate starts while j7xx bugs out with ts_read argument error (which j6xx did before).

Best wishes
Kristoffer Ericson

/*
 * Platform driver for the HP Jornada 620/660/680/690 Touchscreen.
 *
 * Copyright 2008 Kristoffer Ericson <kristoffer.ericson@gmail.com>
 *  Copyright ...-2007 Andriy Skulysh <askulysh@image.kiev.ua>
 */
#include <linux/input.h>
#include <linux/module.h>
#include <linux/init.h>
#include <linux/interrupt.h>
#include <linux/platform_device.h>
#include <linux/sched.h>

#include <asm/io.h>
#include <asm/delay.h>
#include <asm/adc.h>
#include <asm/hp6xx.h>

#define MODNAME "hp680_ts_input"

#define ICR1	0xa4000010	/* Interrupt Control Register 1 */
#define IRR0	0xa4000004	/* Interrupt Request Register */
#define	PHDR	0xa400012e	/* PORT H  DATA REGISTER */
#define SCPDR	0xa4000136	/* PORT SC DATA REGISTER */

struct input_dev *dev;
static void do_softint(struct delayed_work *work);
static DECLARE_DELAYED_WORK(work, do_softint);

static void do_softint(struct delayed_work *work)
{
	u8 x,y, scpdr;
	int touched = 0;

	if (ctrl_inb(PHDR) & PHDR_TS_PEN_DOWN) {
		scpdr = ctrl_inb(SCPDR);
		scpdr |= SCPDR_TS_SCAN_ENABLE;
		scpdr &= ~SCPDR_TS_SCAN_Y;
		ctrl_outb(scpdr, SCPDR);
		udelay(30);

		y = adc_single(ADC_CHANNEL_TS_Y);

		scpdr = ctrl_inb(SCPDR);
		scpdr |= SCPDR_TS_SCAN_Y;
		scpdr &= ~SCPDR_TS_SCAN_X;
		ctrl_outb(scpdr, SCPDR);
		udelay(30);

		x = adc_single(ADC_CHANNEL_TS_X);

		scpdr = ctrl_inb(SCPDR);
		scpdr |= SCPDR_TS_SCAN_X;
		scpdr &= ~SCPDR_TS_SCAN_ENABLE;
		ctrl_outb(scpdr, SCPDR);
		udelay(100);
		touched = ctrl_inb(PHDR) & PHDR_TS_PEN_DOWN;
	}

	if (touched) {
		input_report_abs(dev, ABS_X, x);
		input_report_abs(dev, ABS_Y, y);
		input_report_abs(dev, ABS_PRESSURE, 1);
		input_report_key(dev, BTN_TOUCH, 1);
		printk(KERN_INFO "ts: PRESS x=%d, y=%d\n", x, y);
	} else {
		input_report_key(dev, ABS_PRESSURE, 0);
	}
	input_sync(dev);
	enable_irq(HP680_TS_IRQ);
}

static irqreturn_t hp680_ts_interrupt(int irq, void *pdev)
{
    disable_irq_nosync(irq);
    schedule_delayed_work(&work, HZ / 20);
    return IRQ_HANDLED;
}

static int __init jornada680_ts_probe(struct platform_device *pdev)
{
	int error;

	dev = input_allocate_device();

	if (!dev) {
		printk(KERN_INFO "ts: failed to allocate device\n");
		error = -ENODEV;
		return error;
	}

	dev->name = "HP Jornada 6xx Touchscreen";
	dev->phys = "jornadats/input0";
	dev->id.bustype = BUS_HOST;
	dev->dev.parent = &pdev->dev;
	dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
	dev->absbit[0] = BIT_MASK(ABS_X) | BIT_MASK(ABS_Y) | BIT_MASK(ABS_PRESSURE);
	dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);

	input_set_abs_params(dev, ABS_X, 40, 950, 0, 0);
	input_set_abs_params(dev, ABS_Y, 80, 910, 0, 0);

	printk(KERN_INFO "ts: registering device\n");
	error = input_register_device(dev);
	if (error)
	    goto fail2;

	error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
			IRQF_DISABLED, "HP6xx Touchscreen Driver", NULL);

	if (error) {
	    printk(KERN_INFO "ts: Unable to aquire irq %d\n", HP680_TS_IRQ);
	    error = -ENODEV;
	    goto fail3;
	}

	return 0;

fail3:
	input_unregister_device(dev);
fail2:
    	input_free_device(dev);
	return error;
}

static int __devexit jornada680_ts_remove(struct platform_device *pdev)
{
	cancel_delayed_work(&work);
	flush_scheduled_work();
	free_irq(HP680_TS_IRQ, pdev);
	input_unregister_device(dev);
	return 0;
}

static struct platform_driver jornada680_ts_driver = {
	.probe	= jornada680_ts_probe,
	.remove	= jornada680_ts_remove,
	.driver = {
		.name = "jornada_ts",
	},
};

static int __devinit hp680_ts_init(void)
{
	return platform_driver_register(&jornada680_ts_driver);
}

static void __exit hp680_ts_exit(void)
{
	platform_driver_unregister(&jornada680_ts_driver);
}
module_init(hp680_ts_init);
module_exit(hp680_ts_exit);

MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
MODULE_DESCRIPTION("HP Jornada 620/660/680/690 touchscreen platform driver");
MODULE_LICENSE("GPL");


-- 
Kristoffer Ericson <Kristoffer.Ericson@Gmail.com>
