From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 27 Aug 2015 19:02:26 +0000
Subject: [PATCH 0/5] arm64: renesas: r8a7795 MSIOF SPI Support
Message-Id: <1440702151-1406-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi,

This patch series adds preliminary support for MSIOF on r8a7795/R-Car
H3:
  - Update MSIOF DT binding docs,
  - Add core clocks pll1_div2 and mso, and update the DIV6 DT binding
    docs,
  - Add MSIOF nodes.

As there are no SPI devices connected to MSIOF on the Salvator-X
development board, this wasn't fully tested.

To test MSIOF0 on Salvator-X, you can connect an SPI slave to the
CP[1-4] test pins, and pinctrl and SPI slave nodes to
arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts like:

    &pfc {
	    msiof0_pins: msiof0 {
		    renesas,groups = "msiof0_clk", "msiof0_sync", "msiof0_rxd",
				     "msiof0_txd";
		    renesas,function = "msiof0";
	    };
    };

    &msiof0 {
	    pinctrl-0 = <&msiof0_pins>;
	    pinctrl-names = "default";

	    status = "okay";

	    my-device@0 {
		    spi-max-frequency = <6000000>;
		    compatible = "my-compatible";
		    reg = <0>;
	    };
    };

Note that there's an issue with pinctrl on MSIOF0:

    sh-pfc e6060000.pfc: cannot locate data/mark enum_id for mark 1594
    spi_sh_msiof e6e90000.spi: Error applying setting, reverse things back
	    
Mark 1594 is MSIOF0_SCK_MARK.

As the default function for the pins connected to CP[1-4] is MSIOF0, it
should work regardless of the incomplete pinctrl data.

Geert Uytterhoeven (5):
  [RFC] spi: sh-msiof: Add support for R-Car H3
  clk: shmobile: r8a7795: Document DIV6 clock bindings
  arm64: renesas: r8a7795 dtsi: Add pll1_div2 clock
  arm64: renesas: r8a7795 dtsi: Add mso MSIOF parent clock
  arm64: renesas: r8a7795 dtsi: Add all MSIOF nodes

 .../bindings/clock/renesas,cpg-div6-clocks.txt     |  1 +
 Documentation/devicetree/bindings/spi/sh-msiof.txt |  3 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 83 +++++++++++++++++++++-
 drivers/spi/spi-sh-msiof.c                         |  1 +
 include/dt-bindings/clock/r8a7795-clock.h          |  4 ++
 5 files changed, 89 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
