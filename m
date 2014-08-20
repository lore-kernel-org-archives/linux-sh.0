From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Aug 2014 14:28:30 +0000
Subject: [PATCH 0/4] ARM: shmobile: dtsi: interrupt-parent cleanups
Message-Id: <1408544914-21742-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon, Magnus,

This series cleans up interrupt-parent use, to match common use.
It makes sure there's an "interrupt-parent = <&gic>;" at the top, which is
thus inherited by all child nodes, and removes superflous "interrupt-parent"
properties from the individual child nodes.

This was tested on r8a7791/koelsch only.

Geert Uytterhoeven (4):
  ARM: shmobile: r8a7779 dtsi: Remove superfluous interrupt-parent
  ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
  ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
  ARM: shmobile: sh73a0 dtsi: Move interrupt-parent to the top

 arch/arm/boot/dts/r8a7779.dtsi |  6 ------
 arch/arm/boot/dts/r8a7790.dtsi |  1 -
 arch/arm/boot/dts/r8a7791.dtsi |  1 -
 arch/arm/boot/dts/sh73a0.dtsi  | 24 +-----------------------
 4 files changed, 1 insertion(+), 31 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
