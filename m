From: Simon Horman <horms@verge.net.au>
Date: Fri, 02 Oct 2015 08:08:15 +0000
Subject: Re: [PATCH v10 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <20151002080815.GA5625@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20151002025551.28158.20307.sendpatchset@little-apple>
In-Reply-To: <20151002025551.28158.20307.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 02, 2015 at 09:11:50AM +0200, Geert Uytterhoeven wrote:
> On Fri, Oct 2, 2015 at 4:55 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > --- 0012/include/dt-bindings/clock/r8a7795-clock.h
> > +++ work/include/dt-bindings/clock/r8a7795-clock.h      2015-10-01 19:24:51.200513000 +0900
> > @@ -22,8 +22,14 @@
> >  /* MSTP1 */
> >
> >  /* MSTP2 */
> > +#define R8A7795_CLK_SCIF5              202
> > +#define R8A7795_CLK_SCIF4              203
> > +#define R8A7795_CLK_SCIF3              204
> > +#define R8A7795_CLK_SCIF1              206
> > +#define R8A7795_CLK_SCIF0              207
> >
> >  /* MSTP3 */
> > +#define R8A7795_CLK_SCIF2              210
> 
> 310

Thanks, I will fix that.

I plan to wait a little to accumulate more changes.
But if for some reason you need this in a hurry I can
push an updated topic branch ASAP.
