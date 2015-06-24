From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Jun 2015 01:14:27 +0000
Subject: Re: [PATCH 00/02] ARM: shmobile: Update HAVE_ARM_ARCH_TIMER Kconfig bits
Message-Id: <20150624011426.GA31396@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621063515.6194.80456.sendpatchset@little-apple>
In-Reply-To: <20150621063515.6194.80456.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 22, 2015 at 11:50:48AM +0200, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Sun, Jun 21, 2015 at 8:35 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > ARM: shmobile: Update HAVE_ARM_ARCH_TIMER Kconfig bits
> >
> > [PATCH 01/02] ARM: shmobile: Select HAVE_ARM_ARCH_TIMER from Kconfig
> > [PATCH 02/02] ARM: shmobile: Drop HAVE_ARM_ARCH_TIMER from defconfig
> >
> > Convert ARM mach-shmobile to select HAVE_ARM_ARCH_TIMER from Kconfig
> > based on if the enabled SoC contains ARM arch timer IP or not.
> >
> > Recent SoCs like R-Car Gen2 series and r8a73a4 include Cortex-A7 and/or
> > Cortex-A15 hardware including arch timer, so select HAVE_ARM_ARCH_TIMER
> > in such case.
> >
> > In case only older SoCs with Cortex-A9 are enabled then the arch timer
> > does not have to be enabled.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> on sh73a0/kzm9g, r8a7740/armadillo, r8a73a4/ape6evm, r8a7791/koelsch,
> using individual .configs (i.e. HAVE_ARM_ARCH_TIMER is set/unset depending
> on SoC).

Thanks for testing. I have queued these up.
