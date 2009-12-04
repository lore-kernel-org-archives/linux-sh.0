From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 04 Dec 2009 06:47:59 +0000
Subject: Re: Probably cache synchronization issue on SH7723
Message-Id: <20091204064759.GA13603@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 03, 2009 at 09:45:28PM +0900, Magnus Damm wrote:
> On Thu, Dec 3, 2009 at 9:36 PM, Markus Pietrek
> <Markus.Pietrek@emtrion.de> wrote:
> > when starting bigger graphical applications they suddenly stop with a
> > segmentation fault or a bus error. If I execute the application a second
> > time, everything is fine. Applications that are linked to shared libraries
> > are more likely to fail than statically linked applications.
> >
> > Changing the cache from write-back to write-through fixes it. Maybe the
> > instruction cache and the data cache are not synchronized correctly?
> >
> > I didn't have this problem with the linux-2.6.29 vanilla kernel. 2.6.32rc2
> > from git://git.kernel.org/pub/scm/linux/kernel/git/lethal/sh-2.6 introduced
> > it. And after a pull yesterday even /bin/init is failing.
> 
> I've found that sh7722 and sh7724 doesn't work with copy back cache
> right now, see below. There may be other issues as well, but going
> back to OK fixes it for my initramfs-only case.
> 
I've reverted the problematic parts of this patch for now, so that should
fix up these cases. There's an outstanding issue addressed by Matt's
patch that is being debugged now and which I will push once the remaining
faults on SH7724 have been resolved.

In any event, these changes are bound for 2.6.33, so stock 2.6.32 should
never have been impacted by any of this, and the remaining issues should
be sorted before 2.6.33-rc1. We'll give it another spin for 2.6.34.
