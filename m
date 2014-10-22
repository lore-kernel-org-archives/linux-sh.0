From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 22 Oct 2014 09:38:26 +0000
Subject: [PATCH 0/3] ARM: shmobile: r8a7740/armadillo800eva dts: Enable TMU0
Message-Id: <1413970709-26607-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi all,

It seems the TMU got lost from armadillo800eva-reference at some point
in time, and thus the conversion to DT was forgotten.
This series extends the existing bindings to cover r8a7740, adds the device
nodes on r8a7740, and enables TMU0 on armadillo800eva-multiplatform.

Geert Uytterhoeven (3):
  clocksource: sh_tmu: Document R-Mobile r8a7740 binding
  ARM: shmobile: r8a7740 dtsi: Add TMU0 and TMU1 device nodes
  ARM: shmobile: armadillo800eva dts: Enable TMU0

 .../devicetree/bindings/timer/renesas,tmu.txt      |  3 ++-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |  4 ++++
 arch/arm/boot/dts/r8a7740.dtsi                     | 28 ++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
