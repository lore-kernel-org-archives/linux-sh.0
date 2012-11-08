From: Simon Horman <horms@verge.net.au>
Date: Thu, 08 Nov 2012 07:29:48 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: board used FSI driver's clock
Message-Id: <20121108072946.GJ20774@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 08, 2012 at 03:17:19PM +0900, Simon Horman wrote:
> On Thu, Nov 08, 2012 at 03:10:42PM +0900, Simon Horman wrote:
> > On Wed, Nov 07, 2012 at 09:56:33PM -0800, Kuninori Morimoto wrote:
> > > 
> > > Hi Simon
> > > 
> > > > > Kuninori Morimoto (8):
> > > > >   1) ARM: shmobile: add fsi external clock on r8a7740
> > > > >   2) ARM: shmobile: add fsi external clock sh7372
> > > > >   3) ARM: shmobile: mackerel: enable DMAEngine on USB Host
> > > > >   4) ARM: shmobile: use FSI driver's audio clock on armadillo800eva
> > > > >   5) ARM: shmobile: use FSI driver's audio clock on mackerel
> > > > >   6) ARM: shmobile: use FSI driver's audio clock on ap4evb
> > > > >   7) ARM: shmobile: sh7372: remove fsidivx clock
> > > > >   8) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
> > > (snip)
> > > > Thanks, I plan to apply 1, 2, 7 & 8 to the soc branch of the renesas tree and;
> > > > 3 - 6 to the boards branch of the reneas stree.
> > > > 
> > > > However, I am getting conflicts when applying your patches.
> > > > Could you either:
> > > > 
> > > > 1. Split the series in two
> > > > 
> > > >    a) 1, 2, 7 & 8 based on the soc branch of the renesas tree and;
> > > >    b) 3 - 6 based on the boards branch of the renesas tree
> > > > 
> > > > 2. Rebase the series on the next branch in the renesas tree.
> > > 
> > > I see, but I couldn't.
> > > Because FSI patch-set depends on FSI-DVI patch
> > > 
> > > d5a1a6ca8c142a9b0b1120d303ee90e86a7e83c2
> > > (ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks)
> > 
> > That commit is in the boards branch as far as I can see.
> > I will try to apply the board patches, they may be ok.
> > It was the first two soc patches that I had trouble with.
> > 
> > > and I find it on simon/boards branch (not soc branch).
> > >                  ~~~~~~~~~~~~
> > 
> > Strange, it seems to be here
> > http://git.kernel.org/?p=linux/kernel/git/horms/renesas.git;a=shortlog;h=refs/heads/soc
> > 
> > > What should I do in this case ?
> > 
> > Can you try to check your remote and fetch again?
> > 
> > If that fails I can manually apply the changes and send them to you for
> > review.
> 
> Sorry, I've noticed some problems with my branches.
> I'll shake them out and get back to you ASAP.

I have spoken of with Olof Johansson and based on his advice I have
based the boards branch on the soc branch.

The result is as follows. Could you check to see if it
a) looks sane
b) anything is missing

* 7e7477a (origin/boards, boards) ARM: shmobile: use FSI driver's audio clock on ap4evb
* 38f8b5f ARM: shmobile: use FSI driver's audio clock on mackerel
* 23d98fe ARM: shmobile: use FSI driver's audio clock on armadillo800eva
* 19bf12f ARM: shmobile: mackerel: enable DMAEngine on USB Host
* 6188248 ARM: shmobile: marzen: add USB OHCI driver support
* 4f75b75 ARM: shmobile: marzen: add USB EHCI driver support
* 44051e2 ARM: shmobile: marzen: add USB phy support
*   092cb53 Merge branch 'soc' into boards
|\  
| * c089609 (origin/soc, soc) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
| * 2a14f32 ARM: shmobile: sh7372: remove fsidivx clock
| * 2944628 ARM: shmobile: add fsi external clock sh7372
| * 8b0eadd ARM: shmobile: add fsi external clock on r8a7740
| * 7c4fd73 ARM: shmobile: r8a7740: add FSI-DVI clocks
| * dc3cad8 ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
| * 9ee8008 ARM: shmobile: sh7372: sh7372_fsidivX_clk become non-global
| * 9d626ec sh: clkfwk: add sh_clk_fsidiv_register()
| * 9d69f5b ARM: shmobile: r8a7779: add USB OHCI clock support
| * 8841954 ARM: shmobile: r8a7779: add USB EHCI clock support
| * 0a38429 ARM: shmobile: r8a7740: add USB24 clock explain
| * 167443b ARM: shmobile: r8a7779: PFC rename PENCx -> USB_PENCx
| * 86bc52e (arm-soc/renesas/soc) ARM: shmobile: r8a7740: Enable PMU
| * 40eaed7 ARM: mach-shmobile: add FLCTL DMA slave definitions for sh7372
| * ccc2a27 ARM: shmobile: r8a7779: add I2C driver support
| * 16c40ab ARM: shmobile: r8a7779: add I2C clock support
| * f92246e ARM: shmobile: r8a7779: add HSPI clock support
| * a41acc4 ARM: shmobile: r8a7740: fixup DT machine desc name typo
| * cdc7594 ARM: shmobile: r8a7779: Replace modify_scu_cpu_psr with scu_power_mode
| * e721295 ARM: shmobile: sh73a0: Replace modify_scu_cpu_psr with scu_power_mode
| * 865d90f ARM: shmobile: emev2: Replace modify_scu_cpu_psr with scu_power_mode
| * 2864b19 ARM: shmobile: Remove SH7377 support
| * ed9c075 ARM: shmobile: Remove SH7367 support
* | 631a7b5 (arm-soc/renesas/boards) ARM: shmobile: Remove G4EVM machine support
* | 6a800a0 ARM: shmobile: Remove G3EVM machine support
* | 0ce53cd ARM: mach-shmobile: Use DT_MACHINE for mackerel
* | b82573e ARM: shmobile: marzen: add HSPI support
* | 1efdf56 ARM: shmobile: armadillo800eva: enable restart
* | bd9e2e7 ARM: shmobile: kzm9g: enable DMAEngine on SHDI0 and SDHI2
* | 608c562 ARM: shmobile: kzm9g: enable three-axis digital accelerometer ADXL345
* | 8cec012 ARM: shmobile: kzm9g: enable magnetometer ak8975.
|/  
* ddffeb8 (tag: v3.7-rc1, origin/pmu, origin/master, origin/dt, origin/cleanup, arm-soc/ux500/soc, pmu, master, gpio, dt, cleanup) Linux 3.7-rc1


I have also update the next branch accordingly.

I have aslo added a new experimental branch, next+dependencies,
which is the next branch plus a merge of dependencies for FSI and USB
which are not in v3.7-rc1 or next. That is, dependencies that are in
branches of other trees.

