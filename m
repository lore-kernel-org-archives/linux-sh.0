From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 06 Mar 2013 13:05:52 +0000
Subject: Re: [PATCH] irqchip: Renesas INTC External IRQ pin driver
Message-Id: <alpine.LFD.2.02.1303061405200.22263@ionos>
List-Id: <linux-sh.vger.kernel.org>
References: <20130218142834.28739.39417.sendpatchset@w520> <20130306042304.GA2896@verge.net.au> <alpine.LFD.2.02.1303061058250.22263@ionos> <20130306114622.GE6684@verge.net.au>
In-Reply-To: <20130306114622.GE6684@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, benh@kernel.crashing.org, grant.likely@secretlab.ca

On Wed, 6 Mar 2013, Simon Horman wrote:

> On Wed, Mar 06, 2013 at 11:01:14AM +0100, Thomas Gleixner wrote:
> > On Wed, 6 Mar 2013, Simon Horman wrote:
> > > On Mon, Feb 18, 2013 at 11:28:34PM +0900, Magnus Damm wrote:
> > > > The SoCs using this driver are currently mainly used
> > > > together with regular platform devices so this driver
> > > > allows configuration via platform data to support things
> > > > like static interrupt base address. DT support will
> > > > be added incrementally in the not so distant future.
> > > 
> > > Hi Thomas,
> > > 
> > > I'm wondering how you would like to handle merging this driver.
> > > I can think of three options but I'm sure there are others.
> > > 
> > > * You can take the patches (there is a follow-up series) yourself.
> > > * I can prepare a pull request for you
> > > * I can prepare a pull request for arm-soc with the shmobile patches that
> > >   enable the driver on the r8a7779 and sh73a0.
> > > 
> > > The last option is possibly the easiest.
> > 
> > Correct.
> > 
> > > But in that case I'd appreciate an Ack from you on this patch.
> > 
> > You want to pick the V2 series, which already has my blessing:
> > 
> >     https://lkml.org/lkml/2013/2/26/305
> > 
> > For merging it through arm-soc you have my ack now :)
> 
> Thanks, I have that.
> 
> It seems that V2 adds onto this patch rather than replaces it.
> So could I also get an Ack for this patch too?

Ah,. right. V2 is an incremental fix for V1. Yes, please add my Ack.

Thanks,

	tglx
 
