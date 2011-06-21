From: Simon Horman <horms@verge.net.au>
Date: Tue, 21 Jun 2011 10:57:35 +0000
Subject: Re: Crash dumping on sh7372 Mackerel
Message-Id: <20110621105729.GG2292@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <BANLkTi=DgEtZwiigMvm4XptoB3uKqpXvLA@mail.gmail.com>
In-Reply-To: <BANLkTi=DgEtZwiigMvm4XptoB3uKqpXvLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Tue, Jun 21, 2011 at 07:28:39PM +0900, Magnus Damm wrote:
> On Tue, Jun 21, 2011 at 2:46 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Jun 20, 2011 at 10:07:40PM +0900, Magnus Damm wrote:
> >> Linux-3.0-rc or more exactly linux-2.6 git
> >> 95d17b7168eacf1f97f2d1d087ebe7a648c30051 is known to be working, but
> >> the attached prototype patch
> >> "linux-3.0-arm-crash-copy-oldmem-page-ioremap-fix-20110618.patch" is
> >> needed to properly access the /proc/vmcore file. Build the kernel as a
> >> regular uImage. This image is referred to as uImage-crash.
> >
> > [snip]
> >
> > Hi Magnus,
> >
> > do you have any plans to submit this patch for inclusion upstream?
> >
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >>  arch/arm/kernel/crash_dump.c |   14 ++++++++++----
> >>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> Hey Simon,
> 
> Yes, right now it's on my TODO list, but I intend to post it to the
> ARM list and perhaps also to the friendly tracker.

Thanks. Please consider CCing kexec@lists.infradead.org.
