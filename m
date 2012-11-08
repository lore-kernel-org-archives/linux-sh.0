From: Simon Horman <horms@verge.net.au>
Date: Thu, 08 Nov 2012 09:08:58 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: board used FSI driver's clock
Message-Id: <20121108090855.GA11621@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87625g23os.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 07, 2012 at 11:58:08PM -0800, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for your hard work
> 
> > a) looks sane
> > b) anything is missing
> 
> > * 7e7477a (origin/boards, boards) ARM: shmobile: use FSI driver's audio clock on ap4evb
> 
> This patch chaned to use FSI driver's audio clock,
> then, it removed old style clock settings.
> But...
> 
> > * 38f8b5f ARM: shmobile: use FSI driver's audio clock on mackerel
> > * 23d98fe ARM: shmobile: use FSI driver's audio clock on armadillo800eva
> > * 19bf12f ARM: shmobile: mackerel: enable DMAEngine on USB Host
> > * 6188248 ARM: shmobile: marzen: add USB OHCI driver support
> > * 4f75b75 ARM: shmobile: marzen: add USB EHCI driver support
> > * 44051e2 ARM: shmobile: marzen: add USB phy support
> > *   092cb53 Merge branch 'soc' into boards
> > |\  
> > | * c089609 (origin/soc, soc) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
> > | * 2a14f32 ARM: shmobile: sh7372: remove fsidivx clock
> 
> These 2 patches are depend on above patches,
> becouse these patches remove sh7372_xxx fsi clocks (= old style clock).
> This means that there is compile error on ap4evb board from 2a14f32 to 38f8b5f.
> and it is not good for "git bisect"
> 
> Can you change patch order like this ?

Yes. I talked to Olof Johansson again and he offered a solution
which is to:

* Have the boards branch based on the soc branch and then;
* Add an soc2 branch which is based on the boards branch.

-> soc2 branch HEAD
>  xxxxxxx ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
>  xxxxxxx ARM: shmobile: sh7372: remove fsidivx clock
> ...
-> boards branch HEAD
>  xxxxxxx ARM: shmobile: use FSI driver's audio clock on ap4evb
>  xxxxxxx ARM: shmobile: use FSI driver's audio clock on mackerel
>  xxxxxxx ARM: shmobile: use FSI driver's audio clock on armadillo800eva
> ...
-> merge soc branch with already merged boards branch
-> soc branch HEAD
>  xxxxxxx ARM: shmobile: add fsi external clock sh7372
>  xxxxxxx ARM: shmobile: add fsi external clock on r8a7740
>  xxxxxxx ARM: shmobile: r8a7740: add FSI-DVI clocks
>  xxxxxxx ARM: shmobile: sh7372: use sh_clk_fsidiv_register() for FSI-DIV clocks
> ....
-> already merged soc branch HEAD

The result is as follows. I have also updated the next and
next+dependencies branches accordingly.

* d5b6890 (origin/soc2, soc2) ARM: shmobile: sh7372: sh7372_fsiXck_clk become non-global
* d14795f ARM: shmobile: sh7372: remove fsidivx clock
* 12818d8 (origin/boards, boards) ARM: shmobile: use FSI driver's audio clock on ap4evb
* 50ce2da ARM: shmobile: use FSI driver's audio clock on mackerel
* 13e35b4 ARM: shmobile: use FSI driver's audio clock on armadillo800eva
* c8c3243 ARM: shmobile: mackerel: enable DMAEngine on USB Host
* ac7c4ea ARM: shmobile: marzen: add USB OHCI driver support
* 94e1f7f ARM: shmobile: marzen: add USB EHCI driver support
* b5ce635 ARM: shmobile: marzen: add USB phy support
*   ab3ff12 Merge branch 'soc' into boards
|\  
| * 2944628 (origin/soc, soc) ARM: shmobile: add fsi external clock sh7372
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

