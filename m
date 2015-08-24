From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:09:34 +0000
Subject: [PATCH 0/3] arm64: renesas: r8a7795/salvator-x extal clock override
Message-Id: <1440432577-9767-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi,

This patch series overrides the clock frequency and accuracy of the
external crystal oscillator. Without this all clocks have a rate of
zero.  This can be verified using "cat
/sys/kernel/debug/clk/clk_summary".

This is against "[PATCH 00/25 v7][RFC] arm64: Renesas Gen3 initial
patch".

Geert Uytterhoeven (3):
  arm64: renesas: r8a7795 dtsi: Rename extal clock node
  arm64: renesas: r8a7795 dtsi: Extal clock must be overridden
  arm64: renesas: salvator-x: Add missing extal clock override

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 5 +++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
