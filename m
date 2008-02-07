From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 07 Feb 2008 01:06:00 +0000
Subject: Requestirq() = freeze for touchscreendriver
Message-Id: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Greetings,

Been bugtracking touchscreen driver, seems like it gets stuck on IRQ request. irq = 35 in this case. Im still
bad at recalculating but vect 0x660 = 35?

I've rewritten the driver to platform driver (old driver been broken for approx 2-3months now anyways), so I've added it
to hp6xx_devices_setup to make it start with rest of devices (keyboard / leds / ....)


from my arch/sh/boards/hp6xx/setup.c:
static struct platform_device jornadats_device = {
	.name		= "jornada_ts",
	.id		= -1,
};

static struct platform_device *hp6xx_devices[] __initdata = {
	&cf_ide_device,
	&jornadakbd_device,
	&jornadats_device,
	&hp6xxled_device,
};

static void __init hp6xx_init_irq(void)
{
	/* Gets touchscreen and powerbutton IRQ working */
	plat_irq_setup_pins(IRQ_MODE_IRQ);
}

static int __init hp6xx_devices_setup(void)
{
	return platform_add_devices(hp6xx_devices, ARRAY_SIZE(hp6xx_devices));
}

I got two other likely candidates :
1) the new base io_map I added (strange that nothing else fails though)
2) plat_irq_setup MUST be finished before hp6xx_devices_setup starts, otherwise
   I suspect the IRQ3 would never reach IRQ_MODE.

static void __iomem *port_map(unsigned long port, unsigned int size)
{
    /* this is for all drivers actually accepting io_offset */
    if (0xf300<=port && port<=0xf31f)
	port = port - 0xf000;

    /* non-port? then just return it */
    if (PXSEG(port))
	return (void __iomem *)(port);

    /* add base value and return it */
    return (void __iomem *)(0xba000000 + port);
}

Ideas?
