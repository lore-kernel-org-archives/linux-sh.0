From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 12 Oct 2015 11:37:40 +0000
Subject: [PATCH/RFC v3 0/3] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
Message-Id: <1444649863-17796-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Mike, Stephen, et al.,

As discussed at ELCE last week, here's my RFC introducing a new unified
binding for the Renesas CPG (Clock Pulse Generator) and MSSR (Module
Standby and Software Reset) blocks.  These bindings are supposed to be
more in-line with current CCF best practices, and allow expansion to
cover the module reset functionality in the future.  They are intended
to be used initially for the new R-Car Gen3 SoCs (r8a7795), but we may
decide to migrate older SoCs somewhen in the future.

  - The first patch is an RFC introducing the new bindings.
  - Patches 2 and 3 are Proof-of-Concepts of the CPG Core Clock
    Definitions for the already supported R-Car M2-W (r8a7791) SoC, and
    for the new R-Car H3 (r8a7795) SoC.

The idea is to get the bindings (for r8a7795) accepted in v4.4, so we
can continue developing and prepare final support for r8a7795 in v4.5.

I will post preliminary code and DT patches for both r8a7791 (POC) and
r8a7795 (mandatory) as soon as possible.

Thanks for your comments!

References:
  - v2+ =E2=89=88 [PATCH v8 00/05] Renesas R-Car Gen3 CPG support V8"
    (http://www.spinics.net/lists/linux-clk/msg03288.html)
  - v2 =3D "[PATCH/RFC v2 0/4] Renesas CPG/MSTP DT Binding Proposal"
    (http://www.spinics.net/lists/linux-clk/msg03132.html)
  - v1 =3D "Renesas CPG/MSTP DT Binding Proposal"
    (http://www.spinics.net/lists/linux-clk/msg01189.html)

Geert Uytterhoeven (3):
  [RFC] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
  [POC] clk: shmobile: Add r8a7791 CPG Core Clock Definitions
  [POC] clk: shmobile: Add r8a7795 CPG Core Clock Definitions

 .../devicetree/bindings/clock/renesas,cpg-mssr.txt | 71 ++++++++++++++++++=
++++
 include/dt-bindings/clock/r8a7791-cpg-mssr.h       | 22 +++++++
 include/dt-bindings/clock/r8a7795-cpg-mssr.h       | 17 ++++++
 include/dt-bindings/clock/renesas-cpg-mssr.h       | 15 +++++
 4 files changed, 125 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mss=
r.txt
 create mode 100644 include/dt-bindings/clock/r8a7791-cpg-mssr.h
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
