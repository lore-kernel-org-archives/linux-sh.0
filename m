From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Feb 2010 01:56:52 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh7377 and G4EVM pinmux support
Message-Id: <20100215015652.GB18636@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B750CDE.60802@renesas.com>
In-Reply-To: <4B750CDE.60802@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 12, 2010 at 05:10:06PM +0900, NISHIMOTO Hiroki wrote:
> Add support for the sh 7377 pinmux using drivers/sh/pfc.c
> and some LEDs on G4EVM.

On Fri, Feb 12, 2010 at 05:11:18PM +0900, NISHIMOTO Hiroki wrote:
> Add G4EVM platform data and a magic setup sequence to
> initialize the r8a66597 block aka USBHS in sh7377.

I'll add these for the 2.6.34 queue, however..

> @@ -137,6 +179,23 @@ static void __init g4evm_init(void)
>  	gpio_direction_output(GPIO_PORT113, 1);
>  	gpio_export(GPIO_PORT113, 1);
>  
> +	/* USBHS */
> +	gpio_request(GPIO_FN_VBUS_0, NULL);
> +	gpio_request(GPIO_FN_PWEN, NULL);
> +	gpio_request(GPIO_FN_OVCN, NULL);
> +	gpio_request(GPIO_FN_OVCN2, NULL);
> +	gpio_request(GPIO_FN_EXTLP, NULL);
> +	gpio_request(GPIO_FN_IDIN, NULL);
> +
> +	/* enable clock in SMSTPCR3 */
> +	__raw_writel(__raw_readl(0xe615013c) & ~(1 << 22), 0xe615013c);
> +
This is unacceptable (and yes, I realize you are just copying this
verbatim from G3, so I am not singling anyone out). We have the clock
framework for a reason, and the only reason to do these sort of hacks is
because the clock framework support hasn't been sufficiently developed
for this CPU.

I'll make it simple -- I will not be applying any additional patches that
toggle clock or module stop bits independently outside of the clock
framework. If the clock framework isn't being treated as a priority now,
this is just going to turn in to a complete mess. The clock framework
should be the only thing that is a priority for these parts at the
moment, and any effort put in to workarounds is just going to be dropped
on the floor.

The clock framework is a requirement, not a suggestion. Failure to adhere
to this simple principle and organize priorities accordingly will result
in no additional blocks being clocked. Prioritize accordingly.

In any event, as the merge window is nigh upon us, this should provide
ample opportunity to get the clock framework implemented properly for
2.6.35, at which point we can start enabling other blocks again.
