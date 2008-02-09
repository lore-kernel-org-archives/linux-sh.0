From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 09 Feb 2008 03:54:06 +0000
Subject: Re: Requestirq() = freeze for touchscreendriver
Message-Id: <20080209035406.GA24581@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
In-Reply-To: <20080207020600.1651cbf5.Kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2008 at 07:30:42PM +0100, Kristoffer Ericson wrote:
> On Fri, 8 Feb 2008 11:57:07 +0900
> "Magnus Damm" <magnus.damm@gmail.com> wrote:
> > On Feb 7, 2008 10:24 PM, Kristoffer Ericson
> > <kristoffer.ericson@gmail.com> wrote:
> > > These patches are against vanilla 2.6.24, but should apply cleanly
> > > to linux-2.6 also. hp6xx_ts_input.patch creates platform_driver for
> > > the touchscreen, not much is kept from the old.
> > >
> > > The booting comes to "waiting to aquire IRQ" and then freezes. So
> > > it happens in one of these lines :
> > >
> > >         printk(KERN_INFO "ts: waiting to request IRQ\n");
> > >         error = request_irq(HP680_TS_IRQ, hp680_ts_interrupt,
> > >                         IRQF_DISABLED, "HP6XX Touchscreen Driver", pdev);
> > 
> > You need to track down exactly why the system is freezing. Some
> > recommendations:
> 
> I added some printk's into the interrupt and when I startup I end up
> with a massive loop of those printk's. Atleast its not frozen :)
> 
From the sounds of it the IRQ is being enabled and not being acked
correctly. The behaviour you describe is generally what happens with
unacked level IRQs that remain asserted.

Do any of the other IRQ0-IRQ7 IRQs work properly for you on hp6xx?
Compare with before and after the INTC changes, and double check your pin
setup.
