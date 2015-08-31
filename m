From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 31 Aug 2015 06:29:07 +0000
Subject: [PATCH v8 00/07] Renesas R-Car H3 (r8a7795) integration patches V8
Message-Id: <20150831062907.24004.79614.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Renesas R-Car H3 (r8a7795) integration patches V8

[PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
[PATCH v8 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
[PATCH v8 03/07] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
[PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
[PATCH v8 05/07] arm64: renesas: r8a7795: enable PFC
[PATCH v8 06/07] arm64: renesas: add Salvator-X board support on DTS
[PATCH v8 07/07] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC

This is V8 of the R-Car H3 SoC support which contains a simplified
series of initial r8a7795 support including:
- Single CPU core, Arch timer, GIC
- CPG and MSTP
- r8a7795 SCIF0->SCIF6
- PFC
- Salvator-X DEBUG0 and DEBUG1 serial ports.

The latest version posted by Morimoto-san is V7:
[PATCH 00/25 v7][RFC] arm64: Renesas Gen3 initial patch

Previous V7 version contained both driver modifications and arm64 integration
code in a single series including USB support. The series contained 25 patches
(and growning) but the base portion with PFC and CPG were not yet stabilized
due to too large PFC patch and CPG DT binding discussions.

In this series several patches have been folded together. My apoligies to
people with large out of tree collections for causing rebase pain, but
without changing this may turn into an unmanageable mess.

The following example hopefully shows how this series simplifies things:
Looking and SCIF2 and the Salvator-X serial ports, the initial SCIF2 patch
only enabled SCIF2 while the other SCIF instances were added by a separate
patch later on. The second Salvator-X serial port was then also enabled. On
top of this the SCIF2 serial port had some issues which resulted in pinctrl
changes. On top of that we had CPG changes that needed to go in as well...

So in previous series we had:
  [PATCH 9/25] arm64: renesas: r8a7795: Add SCIF2 support
  [PATCH 1/6] arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
  [PATCH 3/6] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
  [PATCH 15/25] arm64: renesas: add Salvator-X board support on DTS
  [PATCH 5/5] arm64: renesas: salvator-x: Update SCIF2 pin group
  [PATCH 5/6] arm64: renesas: salvator-x: Enable SCIF1 on serial1

With this series we have:
 [PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
 [PATCH v8 06/07] arm64: renesas: add Salvator-X board support on DTS

I believe we should keep on folding in changes in a smaller manageable
patch series until we get the base and the dependencies stabilized.

Regarding dependencies, this V8 integration series depends on the following:

CPG:
[PATCH v4 00/05] Renesas R-Car Gen3 CPG support V4

PFC:
[PATCH 0/2][RFC] pinctrl: sh-pfc: r8a7795 support

SCIF:
[PATCH] serial: sh-sci: Add device tree support for r8a7795

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against cc4a47b53bed0fdf02cea9fab559e619eb1f15bb of renesas-drivers

 Documentation/devicetree/bindings/arm/shmobile.txt |    4 
 arch/arm64/Kconfig.platforms                       |   16 
 arch/arm64/boot/dts/Makefile                       |    1 
 arch/arm64/boot/dts/renesas/Makefile               |    5 
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   58 +++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  369 ++++++++++++++++++++
 arch/arm64/configs/defconfig                       |    5 
 include/dt-bindings/clock/r8a7795-clock.h          |   44 ++
 8 files changed, 502 insertions(+)
