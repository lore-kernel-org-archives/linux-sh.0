From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Sep 2015 10:22:38 +0000
Subject: [PATCH 00/05][RFC] Clock registration without parent name
Message-Id: <20150915102238.15716.91170.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: linux-sh@vger.kernel.org, mturquette@baylibre.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

Clock registration without parent name

[PATCH 01/05][RFC] clk: Initialize on-stack struct clk_init_data
[PATCH 02/05][RFC] clk: Add parent array to struct clk_init_data
[PATCH 03/05][RFC] clk: Allow NULL as parent names
[PATCH 04/05][RFC] clk: fixed-factor: Pass struct clk_init_data
[PATCH 05/05][RFC] clk: fixed-factor: Make use of parent array

This RFC series adds two experimental features to the CCF code:
1) Allow passing in an array of parent clocks during registration
2) Allow omitting parent name information in case of 1)

Unless the parent clock array pointer is set in clk_init_data
the CCF clock registration code behaves as usual.

Without this series it is not possible to use parents that have
multiple clock-indices in a single DT node but lacks the
clock-output-names property.

With this series it is possible to use "fixed-factor-clock"
hanging off a single DT node with multiple clock-indices but
without clock-output-names.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Developed against next-20150915, builds with shmobile_defconfig,
 tested with experimental R-Car Gen3 patch series included in
 renesas-drivers-2015-09-08-v4.2 (that omits clock-output-names)

 May be seen as an improved version of:
 [PATCH][RFC] clk: Use node name and index for clock name

 drivers/clk/at91/clk-h32mx.c              |    2 -
 drivers/clk/at91/clk-main.c               |    8 ++--
 drivers/clk/at91/clk-master.c             |    2 -
 drivers/clk/at91/clk-peripheral.c         |    4 +-
 drivers/clk/at91/clk-pll.c                |    2 -
 drivers/clk/at91/clk-plldiv.c             |    2 -
 drivers/clk/at91/clk-programmable.c       |    2 -
 drivers/clk/at91/clk-slow.c               |    8 ++--
 drivers/clk/at91/clk-smd.c                |    2 -
 drivers/clk/at91/clk-system.c             |    2 -
 drivers/clk/at91/clk-usb.c                |    6 +--
 drivers/clk/at91/clk-utmi.c               |    2 -
 drivers/clk/bcm/clk-iproc-armpll.c        |    2 -
 drivers/clk/bcm/clk-iproc-asiu.c          |    2 -
 drivers/clk/bcm/clk-iproc-pll.c           |    2 -
 drivers/clk/berlin/berlin2-avpll.c        |    4 +-
 drivers/clk/berlin/berlin2-pll.c          |    2 -
 drivers/clk/clk-axi-clkgen.c              |    2 -
 drivers/clk/clk-cdce925.c                 |    2 -
 drivers/clk/clk-composite.c               |    2 -
 drivers/clk/clk-divider.c                 |    2 -
 drivers/clk/clk-fixed-factor.c            |   50 +++++++++++++++++++----------
 drivers/clk/clk-fixed-rate.c              |    2 -
 drivers/clk/clk-fractional-divider.c      |    2 -
 drivers/clk/clk-gate.c                    |    2 -
 drivers/clk/clk-highbank.c                |    2 -
 drivers/clk/clk-ls1x.c                    |    2 -
 drivers/clk/clk-mb86s7x.c                 |    4 +-
 drivers/clk/clk-mux.c                     |    2 -
 drivers/clk/clk-nomadik.c                 |    4 +-
 drivers/clk/clk-pwm.c                     |    2 -
 drivers/clk/clk-qoriq.c                   |    2 -
 drivers/clk/clk-si5351.c                  |    2 -
 drivers/clk/clk-si570.c                   |    2 -
 drivers/clk/clk-stm32f4.c                 |    2 -
 drivers/clk/clk-u300.c                    |    4 +-
 drivers/clk/clk-vt8500.c                  |    4 +-
 drivers/clk/clk-xgene.c                   |    4 +-
 drivers/clk/clk.c                         |   33 +++++++++++++------
 drivers/clk/h8300/clk-h8s2678.c           |    2 -
 drivers/clk/hisilicon/clk-hi3620.c        |    2 -
 drivers/clk/hisilicon/clk-hi6220-stub.c   |    2 -
 drivers/clk/hisilicon/clk-hix5hd2.c       |    2 -
 drivers/clk/hisilicon/clkdivider-hi6220.c |    2 -
 drivers/clk/hisilicon/clkgate-separated.c |    2 -
 drivers/clk/imx/clk-busy.c                |    4 +-
 drivers/clk/imx/clk-cpu.c                 |    2 -
 drivers/clk/imx/clk-fixup-div.c           |    2 -
 drivers/clk/imx/clk-fixup-mux.c           |    2 -
 drivers/clk/imx/clk-gate-exclusive.c      |    2 -
 drivers/clk/imx/clk-gate2.c               |    2 -
 drivers/clk/imx/clk-pfd.c                 |    2 -
 drivers/clk/imx/clk-pllv1.c               |    2 -
 drivers/clk/imx/clk-pllv2.c               |    2 -
 drivers/clk/imx/clk-pllv3.c               |    2 -
 drivers/clk/ingenic/cgu.c                 |    2 -
 drivers/clk/keystone/gate.c               |    2 -
 drivers/clk/keystone/pll.c                |    2 -
 drivers/clk/meson/clk-cpu.c               |    2 -
 drivers/clk/meson/clk-pll.c               |    2 -
 drivers/clk/mmp/clk-apbc.c                |    2 -
 drivers/clk/mmp/clk-apmu.c                |    2 -
 drivers/clk/mmp/clk-frac.c                |    2 -
 drivers/clk/mmp/clk-gate.c                |    2 -
 drivers/clk/mmp/clk-mix.c                 |    2 -
 drivers/clk/mvebu/clk-corediv.c           |    2 -
 drivers/clk/mvebu/clk-cpu.c               |    2 -
 drivers/clk/mxs/clk-div.c                 |    2 -
 drivers/clk/mxs/clk-frac.c                |    2 -
 drivers/clk/mxs/clk-pll.c                 |    2 -
 drivers/clk/mxs/clk-ref.c                 |    2 -
 drivers/clk/pistachio/clk-pll.c           |    2 -
 drivers/clk/rockchip/clk-cpu.c            |    2 -
 drivers/clk/rockchip/clk-inverter.c       |    2 -
 drivers/clk/rockchip/clk-mmc-phase.c      |    2 -
 drivers/clk/rockchip/clk-pll.c            |    2 -
 drivers/clk/samsung/clk-cpu.c             |    2 -
 drivers/clk/samsung/clk-pll.c             |    4 +-
 drivers/clk/samsung/clk-s3c2410-dclk.c    |    2 -
 drivers/clk/shmobile/clk-div6.c           |    2 -
 drivers/clk/shmobile/clk-mstp.c           |    2 -
 drivers/clk/shmobile/clk-rcar-gen2.c      |    2 -
 drivers/clk/sirf/clk-atlas7.c             |    2 -
 drivers/clk/socfpga/clk-gate-a10.c        |    2 -
 drivers/clk/socfpga/clk-gate.c            |    2 -
 drivers/clk/socfpga/clk-periph-a10.c      |    2 -
 drivers/clk/socfpga/clk-periph.c          |    2 -
 drivers/clk/socfpga/clk-pll-a10.c         |    2 -
 drivers/clk/socfpga/clk-pll.c             |    2 -
 drivers/clk/spear/clk-aux-synth.c         |    2 -
 drivers/clk/spear/clk-frac-synth.c        |    2 -
 drivers/clk/spear/clk-gpt-synth.c         |    2 -
 drivers/clk/spear/clk-vco-pll.c           |    3 +
 drivers/clk/st/clk-flexgen.c              |    2 -
 drivers/clk/st/clkgen-fsyn.c              |    4 +-
 drivers/clk/st/clkgen-mux.c               |    2 -
 drivers/clk/st/clkgen-pll.c               |    2 -
 drivers/clk/sunxi/clk-sun6i-ar100.c       |    2 -
 drivers/clk/tegra/clk-audio-sync.c        |    2 -
 drivers/clk/tegra/clk-divider.c           |    2 -
 drivers/clk/tegra/clk-emc.c               |    2 -
 drivers/clk/tegra/clk-periph-gate.c       |    2 -
 drivers/clk/tegra/clk-periph.c            |    2 -
 drivers/clk/tegra/clk-pll-out.c           |    2 -
 drivers/clk/tegra/clk-pll.c               |    2 -
 drivers/clk/tegra/clk-super.c             |    2 -
 drivers/clk/ti/clk-dra7-atl.c             |    2 -
 drivers/clk/ti/divider.c                  |    2 -
 drivers/clk/ti/dpll.c                     |    4 +-
 drivers/clk/ti/gate.c                     |    2 -
 drivers/clk/ti/interface.c                |    2 -
 drivers/clk/ti/mux.c                      |    2 -
 drivers/clk/ux500/clk-prcc.c              |    2 -
 drivers/clk/ux500/clk-prcmu.c             |    2 -
 drivers/clk/ux500/clk-sysctrl.c           |    2 -
 drivers/clk/versatile/clk-icst.c          |    2 -
 drivers/clk/versatile/clk-sp810.c         |    2 -
 drivers/clk/versatile/clk-vexpress-osc.c  |    2 -
 drivers/clk/zte/clk.c                     |    4 +-
 include/linux/clk-provider.h              |    6 +++
 120 files changed, 202 insertions(+), 162 deletions(-)
