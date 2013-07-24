From: Simon Horman <horms@verge.net.au>
Date: Wed, 24 Jul 2013 07:37:16 +0000
Subject: Re: [PATCH 0/6] DMA for MMCIF and SDHI devices in DT mode
Message-Id: <20130724073715.GC17045@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1374498981-5263-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1374498981-5263-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 24, 2013 at 04:18:42PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, Jul 23, 2013 at 10:47 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Mon, Jul 22, 2013 at 03:16:15PM +0200, Guennadi Liakhovetski wrote:
> >> This patch series adds DMA support for MMCIF and SDHI on APE6EVM,
> >> armadillo800eva and KZM9G in DT mode.
> >>
> >> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >>
> >> Guennadi Liakhovetski (6):
> >>   ARM: shmobile: ape6evm: add DMA support to MMCIF
> >>   ARM: shmobile: ape6evm-reference: enable DMA for the MMC interface
> >>   ARM: shmobile: armadillo800eva-reference: add MMCIF and SDHI DT nodes
> >>   ARM: shmobile: armadillo800eva-reference: add DMA to SDHI and MMCIF
> >>   ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
> >>   ARM: shmobile: kzm9g-reference: add DMA channels to MMCIF and SDHI DT
> >>
> >>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    |    3 +
> >>  .../boot/dts/r8a7740-armadillo800eva-reference.dts |   92 ++++++++++++++++++++
> >>  arch/arm/boot/dts/r8a7740.dtsi                     |   33 +++++++
> >>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |    9 ++
> >>  arch/arm/boot/dts/sh73a0.dtsi                      |   43 +++++++++
> >>  arch/arm/mach-shmobile/board-ape6evm.c             |    2 +
> >>  arch/arm/mach-shmobile/clock-sh73a0.c              |    1 +
> >>  arch/arm/mach-shmobile/setup-sh73a0.c              |    3 +
> >>  8 files changed, 186 insertions(+), 0 deletions(-)
> >
> > Magnus, could you review this?
> 
> I've now asked Guennadi to rework his DMAC DT v4 series and include a
> subset of these patches. These ones look fine, but I'd like to have
> them together with the DMAC DT bits to get the full picture if
> possible. I'm a bit hesitant with moving the SHDMA_SLAVE_xx bits into
> drivers/ when they are not going to be used by DT anyway.

Thanks, understood.
