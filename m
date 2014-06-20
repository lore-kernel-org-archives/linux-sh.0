From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Jun 2014 10:17:24 +0000
Subject: [PATCH/POC 0/2] ARM: shmobile: koelsch legacy: Enable DMA for MSIOF
Message-Id: <1403259446-13696-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This proof-of-concept patch series enables DMA support for MSIOF on
r8a7791/koelsch legacy.

It's independent from the series "[PATCH/RFC 0/2] spi: sh-msiof: Add DT DMA
support on r8a7791", but it depends on my series "[PATCH v3 0/5] ARM:
shmobile: MSIOF integration on koelsch/lager legacy" and "[PATCH 0/4] ARM:
shmobile: koelsch legacy: Enable DMA for QSPI".

This was tested on r8a7791/koelsch.

  [1/2] ARM: shmobile: r8a7791: Add MSIOF DMA support
  [1/2] ARM: shmobile: koelsch legacy: Enable DMA for MSIOF

 arch/arm/mach-shmobile/board-koelsch.c        | 9 ++++++---
 arch/arm/mach-shmobile/include/mach/r8a7791.h | 6 ++++++
 arch/arm/mach-shmobile/setup-r8a7791.c        | 5 ++++-
 3 files changed, 16 insertions(+), 4 deletions(-)

As non-DT board support is no longer developed, I don't expect this to be
applied.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
