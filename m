From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 10:32:17 +0000
Subject: [PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9
Message-Id: <20150903103217.26791.32559.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Renesas R-Car H3 (r8a7795) integration patches V9

[PATCH v9 01/07][RFC] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
[PATCH v9 02/07][RFC] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
[PATCH v9 03/07][RFC] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
[PATCH v9 04/07][RFC] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
[PATCH v9 05/07][RFC] arm64: renesas: r8a7795: enable PFC
[PATCH v9 06/07][RFC] arm64: renesas: add Salvator-X board support on DTS
[PATCH v9 07/07][RFC] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC

This is V9 of the R-Car H3 SoC support which contains a simplified
series of initial r8a7795 support including:
- Single CPU core, Arch timer, GIC
- CPG and MSTP
- r8a7795 SCIF0->SCIF6
- PFC
- Salvator-X DEBUG0 and DEBUG1 serial ports.

At this point this series is not considered as stable enough for upstream
merge so in V9 I've added [RFC] to the patches. . The quality of the
patches and the system performance seems stable enough to me, but the
patch series below for CPG, PFC and SCIF are not yet included in -next
so until the DT bindings have been agreed on this series will be kept
at [RFC] state.

Regarding dependencies, for build time there are no special dependencies.
As for runtime this V9 integration series depends on the following:

CPG:
[PATCH v6 00/05] Renesas R-Car Gen3 CPG support V6

PFC:
[PATCH 0/9 v2] sh-pfc: modify PINMUX_IPSR_MSEL() and r8a7795 support

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

 Written against e2a147e of renesas-drivers

 Documentation/devicetree/bindings/arm/shmobile.txt |    4 
 arch/arm64/Kconfig.platforms                       |   17 
 arch/arm64/boot/dts/Makefile                       |    1 
 arch/arm64/boot/dts/renesas/Makefile               |    4 
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   58 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  367 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    5 
 include/dt-bindings/clock/r8a7795-clock.h          |   44 ++
 8 files changed, 500 insertions(+)
