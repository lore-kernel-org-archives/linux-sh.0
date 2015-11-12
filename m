From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Nov 2015 15:54:41 +0000
Subject: [PATCH v6 0/5] clk: shmobile: Add new CPG/MSSR driver
Message-Id: <1447343686-2038-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-clk@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Mike, Stephen, et al.,

This series adds a new driver for the Renesas CPG (Clock Pulse
Generator) and MSSR (Module Standby and Software Reset) blocks for R-Car
H3 (r8a7795).  This is supposed to be more in-line with current CCF best
practices, and allows expansion to cover the module reset functionality
in the future. This drivers follows the DT bindings in
Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt, which have
been accepted in clk/clk-next.
Support for other SoCs may be added later.

  - Patch 1 reworks configuration after the removal of shmobile-legacy,
    and prepares for the advent of arm64 support, where
    CONFIG_ARCH_SHMOBILE_MULTI is not defined.
  - Patch 2 makes clock-output-names optional in the DIV6 driver.
    This is a bit unrelated, but I had sent this patch before, and
    there's a contextual dependency,
  - Patch 3 prepares the existing DIV6 driver for reuse,
  - Patch 4 introduces the new CPG/MSSR driver core, to be used by
    several SoC-specific drivers,
  - Patch 5 introduces the new r8a7795-specific driver.

Compared to v5, only the r8a7795-specific driver (patch 5) received a
few bug fixes and enhancements.  More detailed changelog information is
available in the individual patches.

For your convenience, I pushed these patches and its dependencies to the
topic/cpg-mssr-v6 branch of my renesas-drivers repository at
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/=
?h=3Dtopic/cpg-mssr-v6.

A full integration for R-Car Gen3 is available in the topic/gen3-latest
branch.

Thanks!

References:
  - v5 =3D "[PATCH v5 0/5] clk: shmobile: Add new CPG/MSSR driver"
    (https://lkml.org/lkml/2015/10/29/198)
  - v4 =3D "[PATCH/RFC v4 0/5] clk: shmobile: Add new Renesas CPG/MSSR DT
    bindings" (http://www.spinics.net/lists/devicetree/msg98342.html)
  - v3 =3D "[PATCH/RFC v3 0/3] clk: shmobile: Add new Renesas CPG/MSSR DT
    bindings" (http://www.spinics.net/lists/linux-sh/msg45870.html)
  - v2+ =E2=89=88 "[PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8"
    (http://www.spinics.net/lists/linux-clk/msg03288.html)
  - v2 =3D "[PATCH/RFC v2 0/4] Renesas CPG/MSTP DT Binding Proposal"
    (http://www.spinics.net/lists/linux-clk/msg03132.html)
  - v1 =3D "Renesas CPG/MSTP DT Binding Proposal"
    (http://www.spinics.net/lists/linux-clk/msg01189.html)


Geert Uytterhoeven (4):
  clk: shmobile: div6: Make clock-output-names optional
  clk: shmobile: div6: Extract cpg_div6_register()
  clk: shmobile: Add new CPG/MSSR driver core
  clk: shmobile: r8a7795: Add new CPG/MSSR driver

Magnus Damm (1):
  clk: shmobile: Rework CONFIG_ARCH_SHMOBILE_MULTI

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |   4 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/shmobile/Makefile                      |  24 +-
 drivers/clk/shmobile/clk-div6.c                    | 137 +++--
 drivers/clk/shmobile/clk-div6.h                    |   7 +
 drivers/clk/shmobile/r8a7795-cpg-mssr.c            | 382 +++++++++++++
 drivers/clk/shmobile/renesas-cpg-mssr.c            | 593 +++++++++++++++++=
++++
 drivers/clk/shmobile/renesas-cpg-mssr.h            | 132 +++++
 8 files changed, 1217 insertions(+), 63 deletions(-)
 create mode 100644 drivers/clk/shmobile/clk-div6.h
 create mode 100644 drivers/clk/shmobile/r8a7795-cpg-mssr.c
 create mode 100644 drivers/clk/shmobile/renesas-cpg-mssr.c
 create mode 100644 drivers/clk/shmobile/renesas-cpg-mssr.h

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
