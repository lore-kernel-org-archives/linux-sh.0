From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 07 Feb 2008 13:24:01 +0000
Subject: Re: Requestirq() = freeze for touchscreendriver
Message-Id: <20080207142401.0b11830b.Kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Multipart=_Thu__7_Feb_2008_14_24_01_+0100_XXMOZbyGJ6Y=vyrH"
List-Id: <linux-sh.vger.kernel.org>
References: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__7_Feb_2008_14_24_01_+0100_XXMOZbyGJ6Y=vyrH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Greetings,

These patches are against vanilla 2.6.24, but should apply cleanly to linux-2.6 also. hp6xx_ts_input.patch creates platform_driver for the touchscreen, not much is kept from the old.
 
The booting comes to "waiting to aquire IRQ" and then freezes. So it happens in one of these lines :

	printk(KERN_INFO "ts: waiting to request IRQ\n");
	error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
			IRQF_DISABLED, "HP6XX Touchscreen Driver", pdev);
		
	if (error) {
	    printk(KERN_INFO "hp680_touchscreen.c: Unable to aquire irq %d\n", HP680_TS_IRQ);
	    goto fail2;
	}
	error = input_register_device(jornada_ts->dev);
	if (error)
	    goto fail1;
	printk(KERN_INFO "ts: passed probing successfully\n");
	return 0;


diff --git a/arch/sh/boards/hp6xx/setup.c b/arch/sh/boards/hp6xx/setup.c
index 2f414ac..7b5b273 100644
--- a/arch/sh/boards/hp6xx/setup.c
+++ b/arch/sh/boards/hp6xx/setup.c
@@ -12,7 +12,7 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <asm/hd64461.h>
+#include <asm/hd6446x.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/hp6xx.h>
@@ -21,7 +21,7 @@
 #define	SCPCR	0xa4000116
 #define	SCPDR	0xa4000136
 
-/* CF Slot */
+/* CF slot configured as storage */
 static struct resource cf_ide_resources[] = {
 	[0] = {
 		.start = 0x15000000 + 0x1f0,
@@ -51,9 +51,21 @@ static struct platform_device jornadakbd_device = {
 	.id		= -1,
 };
 
+static struct platform_device hp6xxled_device = {
+	.name		= "hp6xx-led",
+	.id		= -1,
+};
+
+static struct platform_device jornadats_device = {
+	.name		= "jornada_ts",
+	.id		= -1,
+};
+
 static struct platform_device *hp6xx_devices[] __initdata = {
 	&cf_ide_device,
 	&jornadakbd_device,
+	&jornadats_device,
+	&hp6xxled_device,
 };
 
 static void __init hp6xx_init_irq(void)
@@ -72,24 +84,26 @@ static void __init hp6xx_setup(char **cmdline_p)
 	u8 v8;
 	u16 v;
 
-	v = inw(HD64461_STBCR);
-	v |=	HD64461_STBCR_SURTST | HD64461_STBCR_SIRST	|
-		HD64461_STBCR_STM1ST | HD64461_STBCR_STM0ST	|
-		HD64461_STBCR_SAFEST | HD64461_STBCR_SPC0ST	|
-		HD64461_STBCR_SMIAST | HD64461_STBCR_SAFECKE_OST|
-		HD64461_STBCR_SAFECKE_IST;
+	v = inw(HD6446x_STBCR);
+	v |=	HD6446x_STBCR_URT    | HD6446x_STBCR_IRDA	|
+		HD6446x_STBCR_TMU1   | HD6446x_STBCR_TMU0	|
+		HD6446x_STBCR_AFE    | HD6446x_STBCR_PCC0	|
+		HD6446x_STBCR_PP     | HD6446x_STBCR_SAFECKE_OST|
+		HD6446x_STBCR_ADC;
 #ifndef CONFIG_HD64461_ENABLER
-	v |= HD64461_STBCR_SPC1ST;
+	v |= HD6446x_STBCR_PCC1;
 #endif
-	outw(v, HD64461_STBCR);
-	v = inw(HD64461_GPADR);
+	outw(v, HD6446x_STBCR);
+	v = inw(HD6446x_GPADR);
 	v |= HD64461_GPADR_SPEAKER | HD64461_GPADR_PCMCIA0;
-	outw(v, HD64461_GPADR);
+	outw(v, HD6446x_GPADR);
 
-	outw(HD64461_PCCGCR_VCC0 | HD64461_PCCSCR_VCC1, HD64461_PCC0GCR);
+	/* set voltage control pin to high level (PCC0SEL)*/
+	outw(HD6446x_PCCGCR_VCC0 | HD6446x_PCCSCR_VCC1, HD6446x_PCC0GCR);
 
 #ifndef CONFIG_HD64461_ENABLER
-	outw(HD64461_PCCGCR_VCC0 | HD64461_PCCSCR_VCC1, HD64461_PCC1GCR);
+	/* set voltage control pin to high level (PCC1SEL)*/
+	outw(HD6446x_PCCGCR_VCC0 | HD6446x_PCCSCR_VCC1, HD6446x_PCC1GCR);
 #endif
 
 	sh_dac_output(0, DAC_SPEAKER_VOLUME);
@@ -107,15 +121,31 @@ static void __init hp6xx_setup(char **cmdline_p)
 	v &= ~SCPCR_TS_MASK;
 	v |= SCPCR_TS_ENABLE;
 	ctrl_outw(v, SCPCR);
+
 }
 device_initcall(hp6xx_devices_setup);
 
+static void __iomem *port_map(unsigned long port, unsigned int size)
+{
+    /* this is for all drivers actually accepting io_offset */
+    if (0xf300<=port && port<=0xf31f)
+	port = port - 0xf000;
+
+    /* non-port? then just return it */
+    if (PXSEG(port))
+	return (void __iomem *)(port);
+
+    /* add base value and return it */
+    return (void __iomem *)(0xba000000 + port);
+}
+
 static struct sh_machine_vector mv_hp6xx __initmv = {
-	.mv_name = "hp6xx",
+	.mv_name = "HP Jornada 6xx",
 	.mv_setup = hp6xx_setup,
 	/* IRQ's : CPU(64) + CCHIP(16) + FREE_TO_USE(6) */
-	.mv_nr_irqs = HD64461_IRQBASE + HD64461_IRQ_NUM + 6,
-	.mv_irq_demux = hd64461_irq_demux,
+	.mv_nr_irqs = HD6446x_IRQBASE + HD6446x_IRQ_NUM + 6,
+	.mv_irq_demux = hd6446x_irq_demux,
 	/* Enable IRQ0 -> IRQ3 in IRQ_MODE */
 	.mv_init_irq = hp6xx_init_irq,
+	.mv_ioport_map = port_map,
 };

diff --git a/drivers/input/touchscreen/hp680_ts_input.c b/drivers/input/touchscreen/hp680_ts_input.c
index c38d4e0..b658746 100644
--- a/drivers/input/touchscreen/hp680_ts_input.c
+++ b/drivers/input/touchscreen/hp680_ts_input.c
@@ -1,7 +1,12 @@
+
+
+
+
 #include <linux/input.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <asm/adc.h>
@@ -17,113 +22,152 @@
 #define	PHDR	0xa400012e
 #define SCPDR	0xa4000136
 
-static void do_softint(struct work_struct *work);
-
-static struct input_dev *hp680_ts_dev;
-static DECLARE_DELAYED_WORK(work, do_softint);
+struct jornada_ts {
+	struct input_dev *dev;
+	int x, y;
+};
 
-static void do_softint(struct work_struct *work)
-{
-	int absx = 0, absy = 0;
-	u8 scpdr;
+static irqreturn_t hp680_ts_interrupt(int irq, void *dev_id)
+{ 
+	struct platform_device *pdev = dev_id;
+	struct jornada_ts *jornada_ts = platform_get_drvdata(pdev);
 	int touched = 0;
+	u8 scpdr;
 
-	if (ctrl_inb(PHDR) & PHDR_TS_PEN_DOWN) {
-		scpdr = ctrl_inb(SCPDR);
+	disable_irq(irq);
+	if (inb(PHDR) & PHDR_TS_PEN_DOWN) {
+		scpdr = inb(SCPDR);
 		scpdr |= SCPDR_TS_SCAN_ENABLE;
 		scpdr &= ~SCPDR_TS_SCAN_Y;
-		ctrl_outb(scpdr, SCPDR);
+		outb(scpdr, SCPDR);
 		udelay(30);
 
-		absy = adc_single(ADC_CHANNEL_TS_Y);
+		jornada_ts->y = adc_single(ADC_CHANNEL_TS_Y);
 
-		scpdr = ctrl_inb(SCPDR);
+		scpdr = inb(SCPDR);
 		scpdr |= SCPDR_TS_SCAN_Y;
 		scpdr &= ~SCPDR_TS_SCAN_X;
-		ctrl_outb(scpdr, SCPDR);
+		outb(scpdr, SCPDR);
 		udelay(30);
 
-		absx = adc_single(ADC_CHANNEL_TS_X);
+		jornada_ts->x = adc_single(ADC_CHANNEL_TS_X);
 
-		scpdr = ctrl_inb(SCPDR);
+		scpdr = inb(SCPDR);
 		scpdr |= SCPDR_TS_SCAN_X;
 		scpdr &= ~SCPDR_TS_SCAN_ENABLE;
-		ctrl_outb(scpdr, SCPDR);
+		outb(scpdr, SCPDR);
 		udelay(100);
-		touched = ctrl_inb(PHDR) & PHDR_TS_PEN_DOWN;
+		touched = inb(PHDR) & PHDR_TS_PEN_DOWN;
 	}
 
 	if (touched) {
-		input_report_key(hp680_ts_dev, BTN_TOUCH, 1);
-		input_report_abs(hp680_ts_dev, ABS_X, absx);
-		input_report_abs(hp680_ts_dev, ABS_Y, absy);
+		input_report_key(jornada_ts->dev, BTN_TOUCH, 1);
+		input_report_abs(jornada_ts->dev, ABS_X, jornada_ts->x);
+		input_report_abs(jornada_ts->dev, ABS_Y, jornada_ts->y);
 	} else {
-		input_report_key(hp680_ts_dev, BTN_TOUCH, 0);
+		input_report_key(jornada_ts->dev, BTN_TOUCH, 0);
 	}
 
-	input_sync(hp680_ts_dev);
-	enable_irq(HP680_TS_IRQ);
-}
-
-static irqreturn_t hp680_ts_interrupt(int irq, void *dev)
-{
-	disable_irq_nosync(irq);
-	schedule_delayed_work(&work, HZ / 20);
+	input_sync(jornada_ts->dev);
 
+	enable_irq(irq);
 	return IRQ_HANDLED;
 }
 
-static int __init hp680_ts_init(void)
+static int __init jornada680_ts_probe(struct platform_device *pdev)
 {
-	int err;
+	struct jornada_ts *jornada_ts;
+	struct input_dev *input_dev;
+	int error;
+
+	jornada_ts = kzalloc(sizeof(struct jornada_ts), GFP_KERNEL);
+	if (!jornada_ts) {
+	    printk(KERN_INFO "ts :failed to aquire memory\n");
+	    return -ENOMEM;
+	}
 
-	hp680_ts_dev = input_allocate_device();
-	if (!hp680_ts_dev)
-		return -ENOMEM;
+	input_dev = input_allocate_device();
+	
+	if (!input_dev) {
+		printk(KERN_INFO "failed to aquire device\n");
+		error = ENODEV;
+		goto fail3;
+	}
 
-	hp680_ts_dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
-	hp680_ts_dev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
+	platform_set_drvdata(pdev, jornada_ts);
+	printk(KERN_INFO "ts: driver + memory allocated\n");
+		
+	jornada_ts->dev = input_dev;
+
+	input_dev->name = "HP Jornada 6XX Touchscreen";
+	input_dev->phys = "jornadats/input0";
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->dev.parent = &pdev->dev;
+	input_dev->evbit[0] = BIT_MASK(EV_ABS) | BIT_MASK(EV_KEY);
+	set_bit(BTN_TOUCH, input_dev->keybit);
+	
+	input_set_abs_params(input_dev, ABS_X, 40, 950, 0, 0);
+	input_set_abs_params(input_dev, ABS_Y, 80, 910, 0, 0);
+
+	printk(KERN_INFO "ts: waiting to request IRQ\n");
+	error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
+			IRQF_DISABLED, "HP6XX Touchscreen Driver", pdev);
+		
+	if (error) {
+	    printk(KERN_INFO "hp680_touchscreen.c: Unable to aquire irq %d\n", HP680_TS_IRQ);
+	    goto fail2;
+	}
 
-	input_set_abs_params(hp680_ts_dev, ABS_X,
-		HP680_TS_ABS_X_MIN, HP680_TS_ABS_X_MAX, 0, 0);
-	input_set_abs_params(hp680_ts_dev, ABS_Y,
-		HP680_TS_ABS_Y_MIN, HP680_TS_ABS_Y_MAX, 0, 0);
+	error = input_register_device(jornada_ts->dev);
+	if (error)
+	    goto fail1;
 
-	hp680_ts_dev->name = "HP Jornada touchscreen";
-	hp680_ts_dev->phys = "hp680_ts/input0";
+	printk(KERN_INFO "ts: passed probing successfully\n");
+	return 0;
 
-	if (request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
-			IRQF_DISABLED, MODNAME, 0) < 0) {
-		printk(KERN_ERR "hp680_touchscreen.c: Can't allocate irq %d\n",
-		       HP680_TS_IRQ);
-		err = -EBUSY;
-		goto fail1;
-	}
+fail1:
+	free_irq(HP680_TS_IRQ, pdev);
+fail2:
+	platform_set_drvdata(pdev, NULL);
+    	input_free_device(input_dev);
+fail3:
+	kfree(jornada_ts);
+	return error;
+}
 
-	err = input_register_device(hp680_ts_dev);
-	if (err)
-		goto fail2;
+static int __devexit jornada680_ts_remove(struct platform_device *pdev)
+{
+	struct jornada_ts *jornada_ts = platform_get_drvdata(pdev);
 
+	free_irq(HP680_TS_IRQ, pdev);	
+	platform_set_drvdata(pdev, NULL);
+	input_unregister_device(jornada_ts->dev);
+	kfree(jornada_ts);
+	
 	return 0;
+}
+
+static struct platform_driver jornada680_ts_driver = {
+	.probe	= jornada680_ts_probe,
+	.remove	= jornada680_ts_remove,
+	.driver = {
+		    "jornada_ts",
+	}
+};
 
- fail2:	free_irq(HP680_TS_IRQ, NULL);
-	cancel_delayed_work(&work);
-	flush_scheduled_work();
- fail1:	input_free_device(hp680_ts_dev);
-	return err;
+static int __devinit hp680_ts_init(void)
+{
+	return platform_driver_register(&jornada680_ts_driver);
 }
 
 static void __exit hp680_ts_exit(void)
 {
-	free_irq(HP680_TS_IRQ, NULL);
-	cancel_delayed_work(&work);
-	flush_scheduled_work();
-	input_unregister_device(hp680_ts_dev);
+	platform_driver_unregister(&jornada680_ts_driver);
 }
-
 module_init(hp680_ts_init);
 module_exit(hp680_ts_exit);
 
-MODULE_AUTHOR("Andriy Skulysh, askulysh@image.kiev.ua");
-MODULE_DESCRIPTION("HP Jornada 680 touchscreen driver");
+MODULE_AUTHOR("Kristoffer Ericson <Kristoffer.Ericson@gmail.com>");
+/* Based on original device driver by Andriy Skulysh, askulysh@image.kiev.ua */
+MODULE_DESCRIPTION("HP Jornada 620/660/680/690 touchscreen platform driver");
 MODULE_LICENSE("GPL");





On Thu, 7 Feb 2008 11:38:14 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Thu, Feb 07, 2008 at 02:06:00AM +0100, Kristoffer Ericson wrote:
> > Been bugtracking touchscreen driver, seems like it gets stuck on IRQ request. irq = 35 in this case. Im still
> > bad at recalculating but vect 0x660 = 35?
> > 
> The math for calculating this can be found in the headers. Write a test
> app to convert for you if you aren't sure.
> 
> > static void __init hp6xx_init_irq(void)
> > {
> > 	/* Gets touchscreen and powerbutton IRQ working */
> > 	plat_irq_setup_pins(IRQ_MODE_IRQ);
> > }
> > 
> > static int __init hp6xx_devices_setup(void)
> > {
> > 	return platform_add_devices(hp6xx_devices, ARRAY_SIZE(hp6xx_devices));
> > }
> > 
> > I got two other likely candidates :
> > 1) the new base io_map I added (strange that nothing else fails though)
> > 2) plat_irq_setup MUST be finished before hp6xx_devices_setup starts, otherwise
> >    I suspect the IRQ3 would never reach IRQ_MODE.
> > 
> Unfortunately you've not posted enough context to figure out the
> initialization sequence. Please post your patch (and as a patch, not an
> inlined file) if you want feedback.

--Multipart=_Thu__7_Feb_2008_14_24_01_+0100_XXMOZbyGJ6Y=vyrH
Content-Type: application/octet-stream;
 name="hp6xx_setup.patch"
Content-Disposition: attachment;
 filename="hp6xx_setup.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvc2gvYm9hcmRzL2hwNnh4L3NldHVwLmMgYi9hcmNoL3NoL2JvYXJk
cy9ocDZ4eC9zZXR1cC5jCmluZGV4IDJmNDE0YWMuLjdiNWIyNzMgMTAwNjQ0Ci0tLSBhL2FyY2gv
c2gvYm9hcmRzL2hwNnh4L3NldHVwLmMKKysrIGIvYXJjaC9zaC9ib2FyZHMvaHA2eHgvc2V0dXAu
YwpAQCAtMTIsNyArMTIsNyBAQAogI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+CiAjaW5jbHVkZSA8
bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgotI2luY2x1
ZGUgPGFzbS9oZDY0NDYxLmg+CisjaW5jbHVkZSA8YXNtL2hkNjQ0NnguaD4KICNpbmNsdWRlIDxh
c20vaW8uaD4KICNpbmNsdWRlIDxhc20vaXJxLmg+CiAjaW5jbHVkZSA8YXNtL2hwNnh4Lmg+CkBA
IC0yMSw3ICsyMSw3IEBACiAjZGVmaW5lCVNDUENSCTB4YTQwMDAxMTYKICNkZWZpbmUJU0NQRFIJ
MHhhNDAwMDEzNgogCi0vKiBDRiBTbG90ICovCisvKiBDRiBzbG90IGNvbmZpZ3VyZWQgYXMgc3Rv
cmFnZSAqLwogc3RhdGljIHN0cnVjdCByZXNvdXJjZSBjZl9pZGVfcmVzb3VyY2VzW10gPSB7CiAJ
WzBdID0gewogCQkuc3RhcnQgPSAweDE1MDAwMDAwICsgMHgxZjAsCkBAIC01MSw5ICs1MSwyMSBA
QCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBqb3JuYWRha2JkX2RldmljZSA9IHsKIAku
aWQJCT0gLTEsCiB9OwogCitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBocDZ4eGxlZF9k
ZXZpY2UgPSB7CisJLm5hbWUJCT0gImhwNnh4LWxlZCIsCisJLmlkCQk9IC0xLAorfTsKKworc3Rh
dGljIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ugam9ybmFkYXRzX2RldmljZSA9IHsKKwkubmFtZQkJ
PSAiam9ybmFkYV90cyIsCisJLmlkCQk9IC0xLAorfTsKKwogc3RhdGljIHN0cnVjdCBwbGF0Zm9y
bV9kZXZpY2UgKmhwNnh4X2RldmljZXNbXSBfX2luaXRkYXRhID0gewogCSZjZl9pZGVfZGV2aWNl
LAogCSZqb3JuYWRha2JkX2RldmljZSwKKwkmam9ybmFkYXRzX2RldmljZSwKKwkmaHA2eHhsZWRf
ZGV2aWNlLAogfTsKIAogc3RhdGljIHZvaWQgX19pbml0IGhwNnh4X2luaXRfaXJxKHZvaWQpCkBA
IC03MiwyNCArODQsMjYgQEAgc3RhdGljIHZvaWQgX19pbml0IGhwNnh4X3NldHVwKGNoYXIgKipj
bWRsaW5lX3ApCiAJdTggdjg7CiAJdTE2IHY7CiAKLQl2ID0gaW53KEhENjQ0NjFfU1RCQ1IpOwot
CXYgfD0JSEQ2NDQ2MV9TVEJDUl9TVVJUU1QgfCBIRDY0NDYxX1NUQkNSX1NJUlNUCXwKLQkJSEQ2
NDQ2MV9TVEJDUl9TVE0xU1QgfCBIRDY0NDYxX1NUQkNSX1NUTTBTVAl8Ci0JCUhENjQ0NjFfU1RC
Q1JfU0FGRVNUIHwgSEQ2NDQ2MV9TVEJDUl9TUEMwU1QJfAotCQlIRDY0NDYxX1NUQkNSX1NNSUFT
VCB8IEhENjQ0NjFfU1RCQ1JfU0FGRUNLRV9PU1R8Ci0JCUhENjQ0NjFfU1RCQ1JfU0FGRUNLRV9J
U1Q7CisJdiA9IGludyhIRDY0NDZ4X1NUQkNSKTsKKwl2IHw9CUhENjQ0NnhfU1RCQ1JfVVJUICAg
IHwgSEQ2NDQ2eF9TVEJDUl9JUkRBCXwKKwkJSEQ2NDQ2eF9TVEJDUl9UTVUxICAgfCBIRDY0NDZ4
X1NUQkNSX1RNVTAJfAorCQlIRDY0NDZ4X1NUQkNSX0FGRSAgICB8IEhENjQ0NnhfU1RCQ1JfUEND
MAl8CisJCUhENjQ0NnhfU1RCQ1JfUFAgICAgIHwgSEQ2NDQ2eF9TVEJDUl9TQUZFQ0tFX09TVHwK
KwkJSEQ2NDQ2eF9TVEJDUl9BREM7CiAjaWZuZGVmIENPTkZJR19IRDY0NDYxX0VOQUJMRVIKLQl2
IHw9IEhENjQ0NjFfU1RCQ1JfU1BDMVNUOworCXYgfD0gSEQ2NDQ2eF9TVEJDUl9QQ0MxOwogI2Vu
ZGlmCi0Jb3V0dyh2LCBIRDY0NDYxX1NUQkNSKTsKLQl2ID0gaW53KEhENjQ0NjFfR1BBRFIpOwor
CW91dHcodiwgSEQ2NDQ2eF9TVEJDUik7CisJdiA9IGludyhIRDY0NDZ4X0dQQURSKTsKIAl2IHw9
IEhENjQ0NjFfR1BBRFJfU1BFQUtFUiB8IEhENjQ0NjFfR1BBRFJfUENNQ0lBMDsKLQlvdXR3KHYs
IEhENjQ0NjFfR1BBRFIpOworCW91dHcodiwgSEQ2NDQ2eF9HUEFEUik7CiAKLQlvdXR3KEhENjQ0
NjFfUENDR0NSX1ZDQzAgfCBIRDY0NDYxX1BDQ1NDUl9WQ0MxLCBIRDY0NDYxX1BDQzBHQ1IpOwor
CS8qIHNldCB2b2x0YWdlIGNvbnRyb2wgcGluIHRvIGhpZ2ggbGV2ZWwgKFBDQzBTRUwpKi8KKwlv
dXR3KEhENjQ0NnhfUENDR0NSX1ZDQzAgfCBIRDY0NDZ4X1BDQ1NDUl9WQ0MxLCBIRDY0NDZ4X1BD
QzBHQ1IpOwogCiAjaWZuZGVmIENPTkZJR19IRDY0NDYxX0VOQUJMRVIKLQlvdXR3KEhENjQ0NjFf
UENDR0NSX1ZDQzAgfCBIRDY0NDYxX1BDQ1NDUl9WQ0MxLCBIRDY0NDYxX1BDQzFHQ1IpOworCS8q
IHNldCB2b2x0YWdlIGNvbnRyb2wgcGluIHRvIGhpZ2ggbGV2ZWwgKFBDQzFTRUwpKi8KKwlvdXR3
KEhENjQ0NnhfUENDR0NSX1ZDQzAgfCBIRDY0NDZ4X1BDQ1NDUl9WQ0MxLCBIRDY0NDZ4X1BDQzFH
Q1IpOwogI2VuZGlmCiAKIAlzaF9kYWNfb3V0cHV0KDAsIERBQ19TUEVBS0VSX1ZPTFVNRSk7CkBA
IC0xMDcsMTUgKzEyMSwzMSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgaHA2eHhfc2V0dXAoY2hhciAq
KmNtZGxpbmVfcCkKIAl2ICY9IH5TQ1BDUl9UU19NQVNLOwogCXYgfD0gU0NQQ1JfVFNfRU5BQkxF
OwogCWN0cmxfb3V0dyh2LCBTQ1BDUik7CisKIH0KIGRldmljZV9pbml0Y2FsbChocDZ4eF9kZXZp
Y2VzX3NldHVwKTsKIAorc3RhdGljIHZvaWQgX19pb21lbSAqcG9ydF9tYXAodW5zaWduZWQgbG9u
ZyBwb3J0LCB1bnNpZ25lZCBpbnQgc2l6ZSkKK3sKKyAgICAvKiB0aGlzIGlzIGZvciBhbGwgZHJp
dmVycyBhY3R1YWxseSBhY2NlcHRpbmcgaW9fb2Zmc2V0ICovCisgICAgaWYgKDB4ZjMwMDw9cG9y
dCAmJiBwb3J0PD0weGYzMWYpCisJcG9ydCA9IHBvcnQgLSAweGYwMDA7CisKKyAgICAvKiBub24t
cG9ydD8gdGhlbiBqdXN0IHJldHVybiBpdCAqLworICAgIGlmIChQWFNFRyhwb3J0KSkKKwlyZXR1
cm4gKHZvaWQgX19pb21lbSAqKShwb3J0KTsKKworICAgIC8qIGFkZCBiYXNlIHZhbHVlIGFuZCBy
ZXR1cm4gaXQgKi8KKyAgICByZXR1cm4gKHZvaWQgX19pb21lbSAqKSgweGJhMDAwMDAwICsgcG9y
dCk7Cit9CisKIHN0YXRpYyBzdHJ1Y3Qgc2hfbWFjaGluZV92ZWN0b3IgbXZfaHA2eHggX19pbml0
bXYgPSB7Ci0JLm12X25hbWUgPSAiaHA2eHgiLAorCS5tdl9uYW1lID0gIkhQIEpvcm5hZGEgNnh4
IiwKIAkubXZfc2V0dXAgPSBocDZ4eF9zZXR1cCwKIAkvKiBJUlEncyA6IENQVSg2NCkgKyBDQ0hJ
UCgxNikgKyBGUkVFX1RPX1VTRSg2KSAqLwotCS5tdl9ucl9pcnFzID0gSEQ2NDQ2MV9JUlFCQVNF
ICsgSEQ2NDQ2MV9JUlFfTlVNICsgNiwKLQkubXZfaXJxX2RlbXV4ID0gaGQ2NDQ2MV9pcnFfZGVt
dXgsCisJLm12X25yX2lycXMgPSBIRDY0NDZ4X0lSUUJBU0UgKyBIRDY0NDZ4X0lSUV9OVU0gKyA2
LAorCS5tdl9pcnFfZGVtdXggPSBoZDY0NDZ4X2lycV9kZW11eCwKIAkvKiBFbmFibGUgSVJRMCAt
PiBJUlEzIGluIElSUV9NT0RFICovCiAJLm12X2luaXRfaXJxID0gaHA2eHhfaW5pdF9pcnEsCisJ
Lm12X2lvcG9ydF9tYXAgPSBwb3J0X21hcCwKIH07Cg==

--Multipart=_Thu__7_Feb_2008_14_24_01_+0100_XXMOZbyGJ6Y=vyrH
Content-Type: application/octet-stream;
 name="hp6xx_ts_input.patch"
Content-Disposition: attachment;
 filename="hp6xx_ts_input.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vaHA2ODBfdHNfaW5wdXQuYyBi
L2RyaXZlcnMvaW5wdXQvdG91Y2hzY3JlZW4vaHA2ODBfdHNfaW5wdXQuYwppbmRleCBjMzhkNGUw
Li5iNjU4NzQ2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2lucHV0L3RvdWNoc2NyZWVuL2hwNjgwX3Rz
X2lucHV0LmMKKysrIGIvZHJpdmVycy9pbnB1dC90b3VjaHNjcmVlbi9ocDY4MF90c19pbnB1dC5j
CkBAIC0xLDcgKzEsMTIgQEAKKworCisKKwogI2luY2x1ZGUgPGxpbnV4L2lucHV0Lmg+CiAjaW5j
bHVkZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUg
PGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgog
I2luY2x1ZGUgPGFzbS9pby5oPgogI2luY2x1ZGUgPGFzbS9kZWxheS5oPgogI2luY2x1ZGUgPGFz
bS9hZGMuaD4KQEAgLTE3LDExMyArMjIsMTUyIEBACiAjZGVmaW5lCVBIRFIJMHhhNDAwMDEyZQog
I2RlZmluZSBTQ1BEUgkweGE0MDAwMTM2CiAKLXN0YXRpYyB2b2lkIGRvX3NvZnRpbnQoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKTsKLQotc3RhdGljIHN0cnVjdCBpbnB1dF9kZXYgKmhwNjgwX3Rz
X2RldjsKLXN0YXRpYyBERUNMQVJFX0RFTEFZRURfV09SSyh3b3JrLCBkb19zb2Z0aW50KTsKK3N0
cnVjdCBqb3JuYWRhX3RzIHsKKwlzdHJ1Y3QgaW5wdXRfZGV2ICpkZXY7CisJaW50IHgsIHk7Cit9
OwogCi1zdGF0aWMgdm9pZCBkb19zb2Z0aW50KHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKLXsK
LQlpbnQgYWJzeCA9IDAsIGFic3kgPSAwOwotCXU4IHNjcGRyOworc3RhdGljIGlycXJldHVybl90
IGhwNjgwX3RzX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpkZXZfaWQpCit7IAorCXN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYgPSBkZXZfaWQ7CisJc3RydWN0IGpvcm5hZGFfdHMgKmpvcm5h
ZGFfdHMgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShwZGV2KTsKIAlpbnQgdG91Y2hlZCA9IDA7CisJ
dTggc2NwZHI7CiAKLQlpZiAoY3RybF9pbmIoUEhEUikgJiBQSERSX1RTX1BFTl9ET1dOKSB7Ci0J
CXNjcGRyID0gY3RybF9pbmIoU0NQRFIpOworCWRpc2FibGVfaXJxKGlycSk7CisJaWYgKGluYihQ
SERSKSAmIFBIRFJfVFNfUEVOX0RPV04pIHsKKwkJc2NwZHIgPSBpbmIoU0NQRFIpOwogCQlzY3Bk
ciB8PSBTQ1BEUl9UU19TQ0FOX0VOQUJMRTsKIAkJc2NwZHIgJj0gflNDUERSX1RTX1NDQU5fWTsK
LQkJY3RybF9vdXRiKHNjcGRyLCBTQ1BEUik7CisJCW91dGIoc2NwZHIsIFNDUERSKTsKIAkJdWRl
bGF5KDMwKTsKIAotCQlhYnN5ID0gYWRjX3NpbmdsZShBRENfQ0hBTk5FTF9UU19ZKTsKKwkJam9y
bmFkYV90cy0+eSA9IGFkY19zaW5nbGUoQURDX0NIQU5ORUxfVFNfWSk7CiAKLQkJc2NwZHIgPSBj
dHJsX2luYihTQ1BEUik7CisJCXNjcGRyID0gaW5iKFNDUERSKTsKIAkJc2NwZHIgfD0gU0NQRFJf
VFNfU0NBTl9ZOwogCQlzY3BkciAmPSB+U0NQRFJfVFNfU0NBTl9YOwotCQljdHJsX291dGIoc2Nw
ZHIsIFNDUERSKTsKKwkJb3V0YihzY3BkciwgU0NQRFIpOwogCQl1ZGVsYXkoMzApOwogCi0JCWFi
c3ggPSBhZGNfc2luZ2xlKEFEQ19DSEFOTkVMX1RTX1gpOworCQlqb3JuYWRhX3RzLT54ID0gYWRj
X3NpbmdsZShBRENfQ0hBTk5FTF9UU19YKTsKIAotCQlzY3BkciA9IGN0cmxfaW5iKFNDUERSKTsK
KwkJc2NwZHIgPSBpbmIoU0NQRFIpOwogCQlzY3BkciB8PSBTQ1BEUl9UU19TQ0FOX1g7CiAJCXNj
cGRyICY9IH5TQ1BEUl9UU19TQ0FOX0VOQUJMRTsKLQkJY3RybF9vdXRiKHNjcGRyLCBTQ1BEUik7
CisJCW91dGIoc2NwZHIsIFNDUERSKTsKIAkJdWRlbGF5KDEwMCk7Ci0JCXRvdWNoZWQgPSBjdHJs
X2luYihQSERSKSAmIFBIRFJfVFNfUEVOX0RPV047CisJCXRvdWNoZWQgPSBpbmIoUEhEUikgJiBQ
SERSX1RTX1BFTl9ET1dOOwogCX0KIAogCWlmICh0b3VjaGVkKSB7Ci0JCWlucHV0X3JlcG9ydF9r
ZXkoaHA2ODBfdHNfZGV2LCBCVE5fVE9VQ0gsIDEpOwotCQlpbnB1dF9yZXBvcnRfYWJzKGhwNjgw
X3RzX2RldiwgQUJTX1gsIGFic3gpOwotCQlpbnB1dF9yZXBvcnRfYWJzKGhwNjgwX3RzX2Rldiwg
QUJTX1ksIGFic3kpOworCQlpbnB1dF9yZXBvcnRfa2V5KGpvcm5hZGFfdHMtPmRldiwgQlROX1RP
VUNILCAxKTsKKwkJaW5wdXRfcmVwb3J0X2Ficyhqb3JuYWRhX3RzLT5kZXYsIEFCU19YLCBqb3Ju
YWRhX3RzLT54KTsKKwkJaW5wdXRfcmVwb3J0X2Ficyhqb3JuYWRhX3RzLT5kZXYsIEFCU19ZLCBq
b3JuYWRhX3RzLT55KTsKIAl9IGVsc2UgewotCQlpbnB1dF9yZXBvcnRfa2V5KGhwNjgwX3RzX2Rl
diwgQlROX1RPVUNILCAwKTsKKwkJaW5wdXRfcmVwb3J0X2tleShqb3JuYWRhX3RzLT5kZXYsIEJU
Tl9UT1VDSCwgMCk7CiAJfQogCi0JaW5wdXRfc3luYyhocDY4MF90c19kZXYpOwotCWVuYWJsZV9p
cnEoSFA2ODBfVFNfSVJRKTsKLX0KLQotc3RhdGljIGlycXJldHVybl90IGhwNjgwX3RzX2ludGVy
cnVwdChpbnQgaXJxLCB2b2lkICpkZXYpCi17Ci0JZGlzYWJsZV9pcnFfbm9zeW5jKGlycSk7Ci0J
c2NoZWR1bGVfZGVsYXllZF93b3JrKCZ3b3JrLCBIWiAvIDIwKTsKKwlpbnB1dF9zeW5jKGpvcm5h
ZGFfdHMtPmRldik7CiAKKwllbmFibGVfaXJxKGlycSk7CiAJcmV0dXJuIElSUV9IQU5ETEVEOwog
fQogCi1zdGF0aWMgaW50IF9faW5pdCBocDY4MF90c19pbml0KHZvaWQpCitzdGF0aWMgaW50IF9f
aW5pdCBqb3JuYWRhNjgwX3RzX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiB7
Ci0JaW50IGVycjsKKwlzdHJ1Y3Qgam9ybmFkYV90cyAqam9ybmFkYV90czsKKwlzdHJ1Y3QgaW5w
dXRfZGV2ICppbnB1dF9kZXY7CisJaW50IGVycm9yOworCisJam9ybmFkYV90cyA9IGt6YWxsb2Mo
c2l6ZW9mKHN0cnVjdCBqb3JuYWRhX3RzKSwgR0ZQX0tFUk5FTCk7CisJaWYgKCFqb3JuYWRhX3Rz
KSB7CisJICAgIHByaW50ayhLRVJOX0lORk8gInRzIDpmYWlsZWQgdG8gYXF1aXJlIG1lbW9yeVxu
Iik7CisJICAgIHJldHVybiAtRU5PTUVNOworCX0KIAotCWhwNjgwX3RzX2RldiA9IGlucHV0X2Fs
bG9jYXRlX2RldmljZSgpOwotCWlmICghaHA2ODBfdHNfZGV2KQotCQlyZXR1cm4gLUVOT01FTTsK
KwlpbnB1dF9kZXYgPSBpbnB1dF9hbGxvY2F0ZV9kZXZpY2UoKTsKKwkKKwlpZiAoIWlucHV0X2Rl
dikgeworCQlwcmludGsoS0VSTl9JTkZPICJmYWlsZWQgdG8gYXF1aXJlIGRldmljZVxuIik7CisJ
CWVycm9yID0gRU5PREVWOworCQlnb3RvIGZhaWwzOworCX0KIAotCWhwNjgwX3RzX2Rldi0+ZXZi
aXRbMF0gPSBCSVRfTUFTSyhFVl9BQlMpIHwgQklUX01BU0soRVZfS0VZKTsKLQlocDY4MF90c19k
ZXYtPmtleWJpdFtCSVRfV09SRChCVE5fVE9VQ0gpXSA9IEJJVF9NQVNLKEJUTl9UT1VDSCk7CisJ
cGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgam9ybmFkYV90cyk7CisJcHJpbnRrKEtFUk5fSU5G
TyAidHM6IGRyaXZlciArIG1lbW9yeSBhbGxvY2F0ZWRcbiIpOworCQkKKwlqb3JuYWRhX3RzLT5k
ZXYgPSBpbnB1dF9kZXY7CisKKwlpbnB1dF9kZXYtPm5hbWUgPSAiSFAgSm9ybmFkYSA2WFggVG91
Y2hzY3JlZW4iOworCWlucHV0X2Rldi0+cGh5cyA9ICJqb3JuYWRhdHMvaW5wdXQwIjsKKwlpbnB1
dF9kZXYtPmlkLmJ1c3R5cGUgPSBCVVNfSE9TVDsKKwlpbnB1dF9kZXYtPmRldi5wYXJlbnQgPSAm
cGRldi0+ZGV2OworCWlucHV0X2Rldi0+ZXZiaXRbMF0gPSBCSVRfTUFTSyhFVl9BQlMpIHwgQklU
X01BU0soRVZfS0VZKTsKKwlzZXRfYml0KEJUTl9UT1VDSCwgaW5wdXRfZGV2LT5rZXliaXQpOwor
CQorCWlucHV0X3NldF9hYnNfcGFyYW1zKGlucHV0X2RldiwgQUJTX1gsIDQwLCA5NTAsIDAsIDAp
OworCWlucHV0X3NldF9hYnNfcGFyYW1zKGlucHV0X2RldiwgQUJTX1ksIDgwLCA5MTAsIDAsIDAp
OworCisJcHJpbnRrKEtFUk5fSU5GTyAidHM6IHdhaXRpbmcgdG8gcmVxdWVzdCBJUlFcbiIpOwor
CWVycm9yID0gcmVxdWVzdF9pcnEoSFA2ODBfVFNfSVJRLCBocDY4MF90c19pbnRlcnJ1cHQsCisJ
CQlJUlFGX0RJU0FCTEVELCAiSFA2WFggVG91Y2hzY3JlZW4gRHJpdmVyIiwgcGRldik7CisJCQor
CWlmIChlcnJvcikgeworCSAgICBwcmludGsoS0VSTl9JTkZPICJocDY4MF90b3VjaHNjcmVlbi5j
OiBVbmFibGUgdG8gYXF1aXJlIGlycSAlZFxuIiwgSFA2ODBfVFNfSVJRKTsKKwkgICAgZ290byBm
YWlsMjsKKwl9CiAKLQlpbnB1dF9zZXRfYWJzX3BhcmFtcyhocDY4MF90c19kZXYsIEFCU19YLAot
CQlIUDY4MF9UU19BQlNfWF9NSU4sIEhQNjgwX1RTX0FCU19YX01BWCwgMCwgMCk7Ci0JaW5wdXRf
c2V0X2Fic19wYXJhbXMoaHA2ODBfdHNfZGV2LCBBQlNfWSwKLQkJSFA2ODBfVFNfQUJTX1lfTUlO
LCBIUDY4MF9UU19BQlNfWV9NQVgsIDAsIDApOworCWVycm9yID0gaW5wdXRfcmVnaXN0ZXJfZGV2
aWNlKGpvcm5hZGFfdHMtPmRldik7CisJaWYgKGVycm9yKQorCSAgICBnb3RvIGZhaWwxOwogCi0J
aHA2ODBfdHNfZGV2LT5uYW1lID0gIkhQIEpvcm5hZGEgdG91Y2hzY3JlZW4iOwotCWhwNjgwX3Rz
X2Rldi0+cGh5cyA9ICJocDY4MF90cy9pbnB1dDAiOworCXByaW50ayhLRVJOX0lORk8gInRzOiBw
YXNzZWQgcHJvYmluZyBzdWNjZXNzZnVsbHlcbiIpOworCXJldHVybiAwOwogCi0JaWYgKHJlcXVl
c3RfaXJxKEhQNjgwX1RTX0lSUSwgaHA2ODBfdHNfaW50ZXJydXB0LAotCQkJSVJRRl9ESVNBQkxF
RCwgTU9ETkFNRSwgMCkgPCAwKSB7Ci0JCXByaW50ayhLRVJOX0VSUiAiaHA2ODBfdG91Y2hzY3Jl
ZW4uYzogQ2FuJ3QgYWxsb2NhdGUgaXJxICVkXG4iLAotCQkgICAgICAgSFA2ODBfVFNfSVJRKTsK
LQkJZXJyID0gLUVCVVNZOwotCQlnb3RvIGZhaWwxOwotCX0KK2ZhaWwxOgorCWZyZWVfaXJxKEhQ
NjgwX1RTX0lSUSwgcGRldik7CitmYWlsMjoKKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBO
VUxMKTsKKyAgICAJaW5wdXRfZnJlZV9kZXZpY2UoaW5wdXRfZGV2KTsKK2ZhaWwzOgorCWtmcmVl
KGpvcm5hZGFfdHMpOworCXJldHVybiBlcnJvcjsKK30KIAotCWVyciA9IGlucHV0X3JlZ2lzdGVy
X2RldmljZShocDY4MF90c19kZXYpOwotCWlmIChlcnIpCi0JCWdvdG8gZmFpbDI7CitzdGF0aWMg
aW50IF9fZGV2ZXhpdCBqb3JuYWRhNjgwX3RzX3JlbW92ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQoreworCXN0cnVjdCBqb3JuYWRhX3RzICpqb3JuYWRhX3RzID0gcGxhdGZvcm1fZ2V0
X2RydmRhdGEocGRldik7CiAKKwlmcmVlX2lycShIUDY4MF9UU19JUlEsIHBkZXYpOwkKKwlwbGF0
Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBOVUxMKTsKKwlpbnB1dF91bnJlZ2lzdGVyX2RldmljZShq
b3JuYWRhX3RzLT5kZXYpOworCWtmcmVlKGpvcm5hZGFfdHMpOworCQogCXJldHVybiAwOworfQor
CitzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBqb3JuYWRhNjgwX3RzX2RyaXZlciA9IHsK
KwkucHJvYmUJPSBqb3JuYWRhNjgwX3RzX3Byb2JlLAorCS5yZW1vdmUJPSBqb3JuYWRhNjgwX3Rz
X3JlbW92ZSwKKwkuZHJpdmVyID0geworCQkgICAgImpvcm5hZGFfdHMiLAorCX0KK307CiAKLSBm
YWlsMjoJZnJlZV9pcnEoSFA2ODBfVFNfSVJRLCBOVUxMKTsKLQljYW5jZWxfZGVsYXllZF93b3Jr
KCZ3b3JrKTsKLQlmbHVzaF9zY2hlZHVsZWRfd29yaygpOwotIGZhaWwxOglpbnB1dF9mcmVlX2Rl
dmljZShocDY4MF90c19kZXYpOwotCXJldHVybiBlcnI7CitzdGF0aWMgaW50IF9fZGV2aW5pdCBo
cDY4MF90c19pbml0KHZvaWQpCit7CisJcmV0dXJuIHBsYXRmb3JtX2RyaXZlcl9yZWdpc3Rlcigm
am9ybmFkYTY4MF90c19kcml2ZXIpOwogfQogCiBzdGF0aWMgdm9pZCBfX2V4aXQgaHA2ODBfdHNf
ZXhpdCh2b2lkKQogewotCWZyZWVfaXJxKEhQNjgwX1RTX0lSUSwgTlVMTCk7Ci0JY2FuY2VsX2Rl
bGF5ZWRfd29yaygmd29yayk7Ci0JZmx1c2hfc2NoZWR1bGVkX3dvcmsoKTsKLQlpbnB1dF91bnJl
Z2lzdGVyX2RldmljZShocDY4MF90c19kZXYpOworCXBsYXRmb3JtX2RyaXZlcl91bnJlZ2lzdGVy
KCZqb3JuYWRhNjgwX3RzX2RyaXZlcik7CiB9Ci0KIG1vZHVsZV9pbml0KGhwNjgwX3RzX2luaXQp
OwogbW9kdWxlX2V4aXQoaHA2ODBfdHNfZXhpdCk7CiAKLU1PRFVMRV9BVVRIT1IoIkFuZHJpeSBT
a3VseXNoLCBhc2t1bHlzaEBpbWFnZS5raWV2LnVhIik7Ci1NT0RVTEVfREVTQ1JJUFRJT04oIkhQ
IEpvcm5hZGEgNjgwIHRvdWNoc2NyZWVuIGRyaXZlciIpOworTU9EVUxFX0FVVEhPUigiS3Jpc3Rv
ZmZlciBFcmljc29uIDxLcmlzdG9mZmVyLkVyaWNzb25AZ21haWwuY29tPiIpOworLyogQmFzZWQg
b24gb3JpZ2luYWwgZGV2aWNlIGRyaXZlciBieSBBbmRyaXkgU2t1bHlzaCwgYXNrdWx5c2hAaW1h
Z2Uua2lldi51YSAqLworTU9EVUxFX0RFU0NSSVBUSU9OKCJIUCBKb3JuYWRhIDYyMC82NjAvNjgw
LzY5MCB0b3VjaHNjcmVlbiBwbGF0Zm9ybSBkcml2ZXIiKTsKIE1PRFVMRV9MSUNFTlNFKCJHUEwi
KTsK

--Multipart=_Thu__7_Feb_2008_14_24_01_+0100_XXMOZbyGJ6Y=vyrH--
