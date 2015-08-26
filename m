From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:13:46 +0000
Subject: [PATCH 0/6] arm64: renesas: r8a7795/salvator-x Serial Support
Message-Id: <1440612832-17627-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi,

This patch series enhances serial port support on r8a7795/Salvator-X:
  - Add dummy dma-controller nodes, so we can start describing DMA
    channels for DMA slaves now, leading to less patch conflicts later,
  - Add all (H)SCIF device nodes (incl. clocks, clock domain, and DMA
    properties),
  - Enable SCIF1 on serial1,
  - Proof-of-concept of using HSCIF1 on serial1 use a DT overlay.

This series depends on "[PATCH 0/3] arm64: renesas: r8a7795 clock
updates".

Unlike SCIF1 (on serial1) and SCIF2 (on serial0), HSCIF1 on serial1
doesn't use the default pinctrl config, hence it's functionality depends
on enabling CONFIG_PINCTRL and "[PATCH 0/5] pinctrl: sh-pfc: r8a7795:
(H)SCIF Updates".

SCIF1 and HSCIF1 were tested on r8a7795/salvator-x.

Geert Uytterhoeven (6):
  arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
  arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
  arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
  arm64: renesas: r8a7795 dtsi: Add all HSCIF nodes
  arm64: renesas: salvator-x: Enable SCIF1 on serial1
  [POC] arm64: renesas: salvator-x dts: Add overlay for HSCIF1

 arch/arm64/boot/dts/renesas/Makefile               |   5 +
 .../dts/renesas/r8a7795-salvator-x-hscif1.dtso     |  57 +++++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  12 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 177 +++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h          |  10 ++
 5 files changed, 261 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x-hscif1.dtso

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
