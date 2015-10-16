From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 Oct 2015 14:05:14 +0000
Subject: [PATCH 0/2] ARM: shmobile: rcar-gen2 dtsi: Remove bogus imp_clk nodes
Message-Id: <1445004316-17235-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

In the R-Car Gen2 family, only R-Car H2 and V2H have an IMP core and an
IMP clock. Hence remove the bogus imp_clk nodes from the R-Car M2-W and
E2 DTSes.

Geert Uytterhoeven (2):
  ARM: shmobile: r8a7794 dtsi: Remove bogus imp_clk node
  ARM: shmobile: r8a7791 dtsi: Remove bogus imp_clk node

 arch/arm/boot/dts/r8a7791.dtsi | 8 --------
 arch/arm/boot/dts/r8a7794.dtsi | 8 --------
 2 files changed, 16 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
