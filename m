From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 29 May 2015 09:36:28 +0000
Subject: [PATCH 0/3] clk: shmobile: Document mandatory compatible fallbacks
Message-Id: <1432892191-24039-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Mike, Stephen,

Several DT binding docs for shmobile clock drivers declare that the
compatible value should be one out of a list of SoC-specific values and
a generic value.
However, the driver only binds against the generic value.
Hence document that the generic value is a mandatory fallback.

Thanks for applying!

Geert Uytterhoeven (3):
  clk: shmobile: mstp: Document mandatory compatible fallback
  clk: shmobile: rcar-gen2: Document mandatory compatible fallback
  clk: shmobile: rz: Document mandatory compatible fallback

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt     | 2 +-
 .../devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt          | 2 +-
 Documentation/devicetree/bindings/clock/renesas,rz-cpg-clocks.txt       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
