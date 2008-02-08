From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Fri, 08 Feb 2008 02:57:07 +0000
Subject: Re: Requestirq() = freeze for touchscreendriver
Message-Id: <aec7e5c30802071857s5b5fe3dahdefd3fc8ac5238d5@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Kristoffer,

On Feb 7, 2008 10:24 PM, Kristoffer Ericson
<kristoffer.ericson@gmail.com> wrote:
> Greetings,
>
> These patches are against vanilla 2.6.24, but should apply cleanly to linux-2.6 also. hp6xx_ts_input.patch creates platform_driver for the touchscreen, not much is kept from the old.
>
> The booting comes to "waiting to aquire IRQ" and then freezes. So it happens in one of these lines :
>
>         printk(KERN_INFO "ts: waiting to request IRQ\n");
>         error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
>                         IRQF_DISABLED, "HP6XX Touchscreen Driver", pdev);

You need to track down exactly why the system is freezing. Some recommendations:

- Figure out how the device is hooked up to the processor. IRQn? IRLn? PINTn?
- Verify that you are using the correct IRQ number by calculating it
from the vector number.
- Add a printk in the interrupt handler (hp680_ts_interrupt), see if
you get any printouts.
- Is the interrupt shared with someone else? Disable that user and try again.
- Add/modify the irq demuxer in the machvec (.mv_irq_demux) to print
out all irqs.
- Remove as many working devices as possible from your kernel and try again.
- Check that the interrupt sensing is correct. Is it level triggered?
Active high? Edge triggered?
- Make sure the mask and priority bit fields are correct in the
cpu-specific INTC tables.

Good luck!

/ magnus
