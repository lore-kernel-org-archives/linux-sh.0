From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 16 May 2014 15:26:48 +0000
Subject: [PATCH/RFC 0/7] ARM: shmobile: r8a7791: Add preliminary DMA support
Message-Id: <1400254015-29539-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series adds preliminary DMA support for r8a7791, based on the
work for r8a7790 by Ben Dooks (cfr. "[PATCH v2 0/9] Updates Renesas OF-DMA
code").

  - [1/7] DMA: shdma: Add r8a7791 support
  - [2/7] ARM: shmobile: r8a7791 dtsi: add SYS-DMAC clocks
  - [3/7] ARM: shmobile: r8a7791: Add SYS-DMAC channel definitions for
	  bindings
  - [4/7] ARM: shmobile: r8a7791 dtsi: Add SYS-DMAC0 and SYS-DMAC1 nodes
  - [5/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
  - [6/7] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF
  - [7/7] ARM: shmobile: koelsch dts: Enable sysdma0 and sysdma1

This is NOT meant to be applied yet, hence the RFC status, as so far I
couldn't get it to actually work.

I tried refreshing Guennadi's old patch set to add DMA support to MSIOF
(http://comments.gmane.org/gmane.linux.ports.sh.devel/12303), but it
seems DMA never sends data to MSIOF, causing MSIOF to refuse enabling
its sync signal (setting TFSE fails).

I've also tried replacing SDHI2 on Koelsch by MMCIF0, as Ben's patches
used MMCIF1 on Lager, but that also failed. Apparently sh_mmcif doesn't
even work on Koelsch without DMA?

Perhaps I missed some other patches?

Thanks for your comments!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

