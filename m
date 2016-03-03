From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Mar 2016 00:56:46 +0000
Subject: Re: [PATCH] drivers: sh: Use ARCH_RENESAS
Message-Id: <20160303005645.GH23040@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1456882987-4502-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 03, 2016 at 09:07:13AM +0900, Simon Horman wrote:
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
> 
> At this point that is my intention.

I have queued this patch up for v4.6.

[snip]
