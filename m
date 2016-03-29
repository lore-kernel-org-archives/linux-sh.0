From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Mar 2016 00:06:28 +0000
Subject: Re: [PATCH] drivers: sh: Use ARCH_RENESAS
Message-Id: <20160329000628.GE18162@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 28, 2016 at 09:16:51AM -0400, Rich Felker wrote:
> On Wed, Mar 02, 2016 at 09:25:54AM +0100, Geert Uytterhoeven wrote:
> > Hi Simon,
> > 
> > On Wed, Mar 2, 2016 at 2:43 AM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > > Make use of ARCH_RENESAS in place of ARCH_SHMOBILE.
> > >
> > > This is part of an ongoing process to migrate from ARCH_SHMOBILE to
> > > ARCH_RENESAS the motivation for which being that RENESAS seems to be a more
> > > appropriate name than SHMOBILE for the majority of Renesas ARM based SoCs.
> > >
> > > ARCH_RENESAS should cover all cases where both CONFIG_OF and
> > > ARCH_SHMOBILE are enabled.
> > >
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > If you intend to drop ARCH_SHMOBILE from arch/arm/mach-shmobile/Kconfig before
> > dropping the whole "if (...) { ... }" block below" (cfr. "drivers: sh: Stop
> > using the legacy clock domain on ARM",
> > http://www.spinics.net/lists/linux-renesas-soc/msg00869.html).
> > 
> > Note that the SH-people may resurrect (a variant of) the block when they start
> > migrating to DT and CCF.
> 
> I can't say for sure at this point, but I think instead of searching
> for a node by compatible I would want to represent the relationship
> between the nodes semantically in the device tree. We can address that
> when we get there, though. If we're stuck with device-provided device
> trees that don't fully represent the relationships we might have to
> keep kludges for searching.

Thanks for the feedback.

At this point I think it would be best to drop the block in question.
It should not be difficult to add it back if and when it is needed again.
