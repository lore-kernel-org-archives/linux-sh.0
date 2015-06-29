From: Simon Horman <horms@verge.net.au>
Date: Mon, 29 Jun 2015 08:32:52 +0000
Subject: Re: [PATCH v2 00/06] ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2
Message-Id: <20150629083252.GA12565@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150625085716.24543.84444.sendpatchset@little-apple>
In-Reply-To: <20150625085716.24543.84444.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 26, 2015 at 02:39:26PM +0900, Simon Horman wrote:
> On Fri, Jun 26, 2015 at 02:25:08PM +0900, Simon Horman wrote:
> > On Thu, Jun 25, 2015 at 05:57:16PM +0900, Magnus Damm wrote:
> > > ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2
> > > 
> > > [PATCH v2 01/06] ARM: shmobile: r8a7779: Configure IRLM mode via DT
> > > [PATCH v2 02/06] ARM: shmobile: r8a7779: Generic CCF and timer support
> > > [PATCH v2 03/06] ARM: shmobile: r8a7779: Generic SMP ops
> > > [PATCH v2 04/06] ARM: shmobile: marzen-reference: Remove C board code
> > > [PATCH v2 05/06] ARM: shmobile: Remove Marzen from shmobile_defconfig
> > > [PATCH v2 06/06] ARM: shmobile: r8a7779: Cleanup header file
> > > 
> > > Now when "irqchip: renesas-intc-irqpin: r8a7779 IRLM setup support" is
> > > merged we can continue to cleanup r8a7779 and Marzen.
> > > 
> > > With these patches applied the r8a7779 SoC gets DT-only multiplatform
> > > support and old C board code for multiplatform gets removed.
> > > 
> > > The legacy r8a7779 Marzen code is not touched by this series, but
> > > with these patches applied basic r8a7779 multiplatform SoC support
> > > is done and only a few I/O devices are legacy-only.
> > > 
> > > Only minor changes since V1, fixed build issues for the legacy case.
> > > Boot tested with shmobile_defconfig on real hardware. Built using
> > > marzen_defconfig as well but no testing in such case.
> > > 
> > > We probably want to figure out a way how to handle kernel configuration
> > > of regulators...
> > 
> > Shall I queue this up or would you rather wait until some progress
> > is made on regulators?
> 
> I now see that there is an unresolved discussion of how to handle SMP
> in thread stemming from "[PATCH 03/05] ARM: shmobile: r8a7779: Generic SoC
> SMP support". I am holding off on this series accordingly.

That discussion appears to be continuing.

I have gone ahead and queued up the first to patches of
the series, as listed above, as they seem to lie outside the discussion.
