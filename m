From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 28 May 2009 15:33:56 +0000
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Message-Id: <Pine.LNX.4.44L0.0905281129090.3037-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 28 May 2009, Magnus Damm wrote:

> On Wed, May 27, 2009 at 11:30 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Wed, 27 May 2009, Magnus Damm wrote:
> >> PM: Runtime platform device power management
> 
> > Have you given any thought as to whether the platform_device_wakeup and
> > platform_device_idle calls should be restricted to process context?
> 
> Good question. The first thing that pops into my mind is to have same
> restrictions as clk_enable() and clk_disable(). To keep things simple
> I'd say that it's unlikely that any embedded platform driver would
> need to sleep during the dev_pm_ops callbacks. Maybe it makes sense to
> only allow _noirq variants of dev_pm_ops, not sure. Any ideas?

I don't know what would be appropriate for you.  USB power transitions
cannot be made in an atomic context, but the situation could well be
different for platform devices.  It's just something to be aware of.

(And by the way, the _noirq ops don't run in atomic context.  They run 
in process context with most interrupt deliveries disabled.  It's not 
the same thing -- they are allowed to sleep.)

Alan Stern

