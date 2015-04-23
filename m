From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 23 Apr 2015 14:44:44 +0000
Subject: Re: [PATCH/RFC 00/03] irqchip: renesas-irqc: Fine grained Runtime PM support
Message-Id: <Pine.LNX.4.44L0.1504231040560.1529-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWN5E35e8CEzOKYRo4PXkzjMpxErg6akCOHKGtAf=D8tQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWN5E35e8CEzOKYRo4PXkzjMpxErg6akCOHKGtAf=D8tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

On Thu, 23 Apr 2015, Geert Uytterhoeven wrote:

> >> I'm afraid you can't call pm_runtime_get_sync() from these methods, as
> >> they may be called from interrupt context.
> >
> > Ouch. I know the clock framework has prepare/enable separated with
> > context, but with the irqchip callbacks I suppose no such separation
> 
> It's not the clock operations, but the pm_runtime operations that cannot be
> called from interrupt context.

In fact the pm_runtime operations _can_ be called from interrupt
context, provided the driver has first invoked pm_runtime_irq_safe().  
Of course, this requires that none of the runtime-PM callback routines
ever sleep or perform a blocking operation.

This is all explained in Documentation/power/runtime_pm.txt (search for 
"irq_safe").

Alan Stern

