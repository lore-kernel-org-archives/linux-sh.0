From: Simon Horman <horms@verge.net.au>
Date: Tue, 23 Dec 2014 00:15:06 +0000
Subject: Re: [PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
Message-Id: <20141223001506.GC2817@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094234.7039.79623.sendpatchset@w520>
In-Reply-To: <20141217094234.7039.79623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 23, 2014 at 09:12:34AM +0900, Simon Horman wrote:
> On Mon, Dec 22, 2014 at 11:10:26AM +0100, Geert Uytterhoeven wrote:
> > On Wed, Dec 17, 2014 at 10:42 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > >
> > > --- 0001/arch/arm/mach-shmobile/Kconfig
> > > +++ work/arch/arm/mach-shmobile/Kconfig 2014-12-16 19:11:36.000000000 +0900
> > > @@ -52,6 +52,11 @@ config ARCH_R7S72100
> > >         bool "RZ/A1H (R7S72100)"
> > >         select SYS_SUPPORTS_SH_MTU2
> > >
> > > +config ARCH_SH73A0
> > > +       bool "SH-Mobile AG5 (R8A73A00)"
> > > +       select ARCH_RMOBILE
> > > +       select RENESAS_INTC_IRQPIN
> > > +
> > >  config ARCH_R8A7740
> > >         bool "R-Mobile A1 (R8A77400)"
> > >         select ARCH_RMOBILE
> > 
> > Shall we keep this sorted?
> > That does mean the entries for the old SH73xx are at the end of the
> > list, though.
> 
> Sorting it is nice. But are other entries out of order?
> In either case, feel free to submit a cleanup.

Sorry, for some reason I thought I had queued up the above patch.

I think sorting makes sense. And it looks like the other entries are already
sorted. So adjusting this patch seems like a good idea to me. But I'll
let Magnus decide.
