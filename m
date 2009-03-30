From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Mar 2009 23:32:33 +0000
Subject: Re: regression in 2.6.29-git3 on SH/Dreamcast
Message-Id: <20090330233233.GJ19535@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1238353446.6471.14.camel@localhost.localdomain> <1238369758.6471.16.camel@localhost.localdomain> <20090330071755.GA30234@roarinelk.homelinux.net>
In-Reply-To: <20090330071755.GA30234@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon, Mar 30, 2009 at 09:17:56AM +0200, Manuel Lauss wrote:
> Hi Adrian,
> 
> On Mon, Mar 30, 2009 at 12:35:58AM +0100, Adrian McMenamin wrote:
> > On Sun, 2009-03-29 at 20:04 +0100, Adrian McMenamin wrote:
> > > While 2.6.29 boots cleanly on the Dreamcast, later revisions are likely
> > > to crash with an OOM condition (this is a race, it doesn't happen on
> > > every boot, but on about one in every three or four).
> > > 
> > 
> > Still don't know why this timer patch is tipping the machine over, but I
> > have found that if I set CONFIG_NO_HZ=y then the machine will boot with
> > the patch applied.
> 
> I found that enabling swapfile support in Kconfig also reduces the frequency
> of OOMs on my sh7760.   While I don't experience your particular problem, my
> personal observation is that since around >2.6.22 linux-sh may OOM without
> actual swapspace a lot sooner  (i.e. post 2.6.25 I can't even do "emerge -pv
> world" without the kernel OOMing on me! This is with unreviewed platform code,
> so take this info with a mountain of salt).
> 
On a board with how much memory? What SLAB allocator are you using? This
is the first I have heard about any such issues, and if our memory
consumption drastically went up somewhere it would have been nice to know
when this became a problem. The Dreamcast is fixed at 16MB, and the
system in general is close to being OOM before it even makes it all the
way up. It would also be helpful to see the numbers with SLOB, which
should by the default on all of these systems.
