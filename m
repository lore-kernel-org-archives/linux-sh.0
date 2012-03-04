From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 04 Mar 2012 21:50:53 +0000
Subject: Re: [PATCH] sh_tmu / PM: Prevent power from being removed from TMU devices
Message-Id: <201203042250.53681.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201203030041.30244.rjw@sisk.pl>
In-Reply-To: <201203030041.30244.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sunday, March 04, 2012, Paul Mundt wrote:
> On Sat, Mar 03, 2012 at 12:41:30AM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > To prevent TMU devices from losing power define a fake "always busy"
> > suspend callback in the sh_tmu driver that will cause all attempts to
> > suspend the system to fail.  In addition to that, make the driver
> > change the runtime PM settings of TMU devices so that they appear to
> > be always "active" and make SH7372 add them to the A4R domain (where
> > they physically belong), to make the PM domains core take those
> > settings into consideration when attempting to remove power from A4R.
> > 
> > Proprer power management support will be added to the sh_tmu driver
> > in the future.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Presumably we also need the same for the MTU2 and CMT drivers?

Yes, we do in principle, although this isn't strictly necessary for things to
work at the moment.

I can post analogous patches for the other drivers if you want me to.

Thanks,
Rafael
