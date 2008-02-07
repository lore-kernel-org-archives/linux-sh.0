From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 07 Feb 2008 02:38:14 +0000
Subject: Re: Requestirq() = freeze for touchscreendriver
Message-Id: <20080207023814.GF13945@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 07, 2008 at 02:06:00AM +0100, Kristoffer Ericson wrote:
> Been bugtracking touchscreen driver, seems like it gets stuck on IRQ request. irq = 35 in this case. Im still
> bad at recalculating but vect 0x660 = 35?
> 
The math for calculating this can be found in the headers. Write a test
app to convert for you if you aren't sure.

> static void __init hp6xx_init_irq(void)
> {
> 	/* Gets touchscreen and powerbutton IRQ working */
> 	plat_irq_setup_pins(IRQ_MODE_IRQ);
> }
> 
> static int __init hp6xx_devices_setup(void)
> {
> 	return platform_add_devices(hp6xx_devices, ARRAY_SIZE(hp6xx_devices));
> }
> 
> I got two other likely candidates :
> 1) the new base io_map I added (strange that nothing else fails though)
> 2) plat_irq_setup MUST be finished before hp6xx_devices_setup starts, otherwise
>    I suspect the IRQ3 would never reach IRQ_MODE.
> 
Unfortunately you've not posted enough context to figure out the
initialization sequence. Please post your patch (and as a patch, not an
inlined file) if you want feedback.
