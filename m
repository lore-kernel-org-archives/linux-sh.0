From: Simon Horman <horms@verge.net.au>
Date: Thu, 29 Jan 2015 08:53:45 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: Instantiate GIC from C board code in legacy builds
Message-Id: <20150129085344.GC21851@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150129072532.25107.17303.sendpatchset@little-apple>
In-Reply-To: <20150129072532.25107.17303.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 29, 2015 at 09:03:53AM +0100, Geert Uytterhoeven wrote:
> On Thu, Jan 29, 2015 at 8:25 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> > domain."), the Lager legacy board support is known to be broken.
> >
> > The IRQ numbers of the GIC are now virtual, and no longer match the
> > hardcoded hardware IRQ numbers in the legacy platform board code.
> >
> > To fix this issue specific to non-multiplatform r8a7790 and Lager:
> >  1) Instantiate the GIC from platform board code and also
> >  2) Skip over the DT arch timer as well as
> >  3) Force delay setup based on DT CPU frequency
> >
> > With these 3 fixes in place interrupts on Lager are now unbroken.
> 
> Thanks!
> 
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.
