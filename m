From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 02:55:09 +0000
Subject: [PATCH v10 00/07] Renesas R-Car H3 (r8a7795) integration patches V10
Message-Id: <20151002025509.28158.23176.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Renesas R-Car H3 (r8a7795) integration patches V10

[PATCH v10 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
[PATCH v10 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
[PATCH v10 03/07] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
[PATCH v10 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
[PATCH v10 05/07] arm64: renesas: r8a7795: enable PFC
[PATCH v10 06/07] arm64: renesas: add Salvator-X board support on DTS
[PATCH v10 07/07] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC

This is V10 of the R-Car H3 SoC support which contains a simplified
series of initial r8a7795 support including:
- Single CPU core, Arch timer, GIC
- CPG and MSTP
- r8a7795 SCIF0->SCIF6
- PFC
- Salvator-X DEBUG0 and DEBUG1 serial ports.

Compared to V9 this V10 series is updated in a couple of ways:
- [RFC] is dropped since PFC DT is stable and CPG DT at least semi-stable
- For CCF the DT property clock-output-names is now included - thanks Geert!
- SCIF ports are updated to include DMAC and depend on MSSR in Patch 4/7
- Fixes for PLL1 and EXTAL are folded in

Regarding dependencies, for build time there are no special dependencies.
As for runtime this V10 integration series depends on the following:

CPG:
  [PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8
  [PATCH] clk: shmobile: Fix r8a7795 MSSR support

PFC:
  Patches queued up for upstream merge renesas-drivers branch sh-pfc-for-v4.4:
  d109e2a pinctrl: sh-pfc: r8a7795: add EtherAVB support

SCIF:
  [PATCH] serial: sh-sci: Add device tree support for r8a7795

For information about changes since latest version please see
the change log in each patch.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against 61a7cf8 of renesas-drivers
 Above includes PFC but the CPG series was added locally

 Documentation/devicetree/bindings/arm/shmobile.txt |    4 
 arch/arm64/Kconfig.platforms                       |   17 
 arch/arm64/boot/dts/Makefile                       |    1 
 arch/arm64/boot/dts/renesas/Makefile               |    4 
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   62 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  384 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    5 
 include/dt-bindings/clock/r8a7795-clock.h          |   44 ++
 8 files changed, 521 insertions(+)
