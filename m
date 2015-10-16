From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 Oct 2015 12:49:15 +0000
Subject: [PATCH/RFC v4 0/5] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
Message-Id: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Mike, Stephen, et al.,

As discussed at ELCE last week, here's my RFC introducing a new unified
binding and driver for the Renesas CPG (Clock Pulse Generator) and MSSR
(Module Standby and Software Reset) blocks.  This is supposed to be more
in-line with current CCF best practices, and allows expansion to cover
the module reset functionality in the future.

The new bindings are intended to be used initially for the new R-Car
Gen3 SoCs (r8a7795), but we may decide to migrate older SoCs somewhen in
the future.

  - Patch 1 introduces the new bindings,
  - Patch 2 introduces clock definitions for r8a7795, which are
    technically also part of the binding,
  - Patch 3 prepares the existing div6 driver for reuse,
  - Patch 4 introduces the new CPG/MSSR driver core, to be used by
    several SoC-specific drivers,
  - Patch 5 introduces the new r8a7795-specific driver.

The idea is to get the bindings (for r8a7795, i.e. patches 1 and 2)
accepted in v4.4, so we can continue developing and prepare final
support for r8a7795 in v4.5.

Compared to v3, the major change is the addition of a preliminary
version of the actual driver.

Implementation notes:
  - The driver contains lots of pr_debug() and WARN_ON() calls. Many of
    these will be removed in future versions,
  - Conversion between (sparse) clock IDs and (packed) clock indices
    will be reworked. Probably most of it can be handled in a macro when
    populating the r8a779*_mod_clks[] arrays,
  - Probably r8a779*_clk_types can be removed in favor of just using
    CLK_TYPE_CUSTOM, and differentiating based on cpg_core_clk.id. But
    the clk_types may make it easier to share code between different
    SoCs of the same family.
  - Most clock data is __initconst, to save memory in multi-platform
    kernels,
  - Setting CLK_ENABLE_HAND_OFF for critical clocks (e.g. the GIC clock)
    is implemented (if CLK_ENABLE_HAND_OFF is available),
  - Support for using special core clocks for power management (e.g. the
    ZB clock on r8a73a4/sh7a0) is not yet fully implemented,
  - Module clocks in DTS are no longer defines, but literal numbers
    matching the numbers in the datasheet (just like IRQs),
  - include/dt-bindings/clock/*-cpg-mssr.h now contains all core clock
    outputs, as listed in the datasheet,
  - Should include/dt-bindings/clock/*-cpg-mssr.h use contiguous
    numbering, or should the same clock use the same number for
    different SoCs of the same family?

Memory considerations on r8a7791/koelsch:
  - Static size impact:
      - DTB: -7.5 KiB
      - initdata: +8 KiB (due to PAGE_SIZE rounding, actual + ca. 5 KiB)
      - reserved: -24 KiB (includes unflattened DTB)
  - However, the big saving seems to be in the runtime memory usage.
    MemAvailable has increased by 248 KiB, presumably due to less
    memory being used by the in-memory device tree representation.

For your convenience, I pushed these patches, the r8a7795 DTS
conversion, and a Proof-of-Concept for R-Car M2-W (r8a7791) to the
topic/cpg-mssr-v4 branch (based on topic/gen3-latest) of my
renesas-drivers repository at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/=
?h=3Dtopic/cpg-mssr-v4

Thanks for your comments!

References:
  - v3 =3D "[PATCH/RFC v3 0/3] clk: shmobile: Add new Renesas CPG/MSSR DT
    bindings" (http://www.spinics.net/lists/linux-sh/msg45870.html)
  - v2+ =E2=89=88 "[PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8"
    (http://www.spinics.net/lists/linux-clk/msg03288.html)
  - v2 =3D "[PATCH/RFC v2 0/4] Renesas CPG/MSTP DT Binding Proposal"
    (http://www.spinics.net/lists/linux-clk/msg03132.html)
  - v1 =3D "Renesas CPG/MSTP DT Binding Proposal"
    (http://www.spinics.net/lists/linux-clk/msg01189.html)

Geert Uytterhoeven (5):
  [RFC] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
  [RFC] clk: shmobile: Add r8a7795 CPG Core Clock Definitions
  [RFC] clk: shmobile: div6: Extract cpg_div6_register()
  [RFC] clk: shmobile: cpg-mssr: Add new CPG/MSSR driver core
  [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver

 .../devicetree/bindings/clock/renesas,cpg-mssr.txt |  71 +++
 drivers/clk/shmobile/Makefile                      |   3 +-
 drivers/clk/shmobile/clk-cpg-mssr.c                | 578 +++++++++++++++++=
++++
 drivers/clk/shmobile/clk-cpg-mssr.h                | 118 +++++
 drivers/clk/shmobile/clk-div6.c                    | 119 +++--
 drivers/clk/shmobile/clk-div6.h                    |   3 +
 drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c        | 373 +++++++++++++
 include/dt-bindings/clock/r8a7795-cpg-mssr.h       |  63 +++
 include/dt-bindings/clock/renesas-cpg-mssr.h       |  15 +
 9 files changed, 1297 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mss=
r.txt
 create mode 100644 drivers/clk/shmobile/clk-cpg-mssr.c
 create mode 100644 drivers/clk/shmobile/clk-cpg-mssr.h
 create mode 100644 drivers/clk/shmobile/clk-div6.h
 create mode 100644 drivers/clk/shmobile/clk-r8a7795-cpg-mssr.c
 create mode 100644 include/dt-bindings/clock/r8a7795-cpg-mssr.h
 create mode 100644 include/dt-bindings/clock/renesas-cpg-mssr.h

--=20
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
							    -- Linus Torvalds
