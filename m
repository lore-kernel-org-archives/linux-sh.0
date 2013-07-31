From: Simon Horman <horms@verge.net.au>
Date: Wed, 31 Jul 2013 07:33:21 +0000
Subject: Re: [PATCH] ARM: shmobile: emev2: add PMU information to emev2.dtsi
Message-Id: <20130731073320.GH5090@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724034240.30596.52917.sendpatchset@w520>
 <20130731063900.GA5090@verge.net.au>
 <20130731070550.GA28921@verge.net.au>
 <CANqRtoTVVp5xY7monC6c87Ni=pS5dNG=fS_isAg3qZNQCzaNNg@mail.gmail.com>
In-Reply-To: <CANqRtoTVVp5xY7monC6c87Ni=pS5dNG=fS_isAg3qZNQCzaNNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Tetsuyuki Kobayashi <koba@kmckk.co.jp>, SH-Linux <linux-sh@vger.kernel.org>

On Wed, Jul 31, 2013 at 04:11:23PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Wed, Jul 31, 2013 at 4:05 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Wed, Jul 31, 2013 at 03:39:04PM +0900, Simon Horman wrote:
> >> On Wed, Jul 24, 2013 at 12:42:40PM +0900, Magnus Damm wrote:
> >> > From: Magnus Damm <damm@opensource.se>
> >> >
> >> > Add PMU information to emev2.dtsi. With this
> >> > included KZM9D DT reference may use the PMU.
> >>
> >> Thanks, I will queue this up for v3.12 in the dt2 branch.
> >
> > When booting a debian armel userspace with this patch applied on top of
> > renesas-devel-20130731 I see the following.
> >
> > I do not observe this problem with the sh73a0 or r8a7740 versions
> > of this patch applied, though I assume that in the case of the r8a7740
> > that is because it is UP.
> 
> Looks like the STI clockevent rating patch is missing. SMP operation
> of EMEV2 is broken without that patch.

Thanks, that patch resolves the problem that I was seeing.

I'll put it into devel for now in topic/em_sti.
topic/ indicating that is isn't queued-up yet as
I'd like to give the clocksource people a chance to review it.
