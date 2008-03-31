From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 31 Mar 2008 22:36:08 +0000
Subject: Re: [i2c] [PATCH] i2c: SuperH Mobile I2C Bus Controller V4
Message-Id: <20080331153608.09293906.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080328093530.32474.78684.sendpatchset@rx1.opensource.se>
	<20080329175732.GA9638@fluff.org.uk>
In-Reply-To: <20080329175732.GA9638@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben-linux@fluff.org>
Cc: magnus.damm@gmail.com, i2c@lm-sensors.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Sat, 29 Mar 2008 17:57:32 +0000
Ben Dooks <ben-linux@fluff.org> wrote:

> On Fri, Mar 28, 2008 at 06:35:30PM +0900, Magnus Damm wrote:
> > This is V4 of the SuperH Mobile I2C Controller Driver. A simple Master
> > only driver for the I2C block included in processors such as sh7343,
> > sh7722 and sh7723. Tested on a sh7722 MigoR using a rs5c732b rtc.
> > 
> > Changes since V3:
> >  - Added SUPERH Kconfig dependency
> >  - Use spin_lock_irqsave() and spin_unlock_irqrestore()
> >  - Use IRQF_DISABLED
> >  - Checkpatch fixes
> > Changes since V2:
> >  - dev_xxx() use
> >  - Kill off superfluous ioarea resource
> >  - Add SMBus emulation
> > Changes since V1:
> >  - Use clk_get()/clk_put()/clk_get_rate() to get peripheral clock rate.
> >  - Use pdev->dev.bus_id instead of dev->name
> 
> Do we really need these in the change message, we tend to assume that
> the changes before submission aren't really relevant. I would advise
> on removing these.

They are valuable for people who have reviewed earlier versions of the
patchset so yes, please do maintain them.

I will snip them out when I merge them however - this short-term
inter-version information isn't appropriate to the final git commit.


