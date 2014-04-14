From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 18:15:36 +0000
Subject: [PATCH v3 0/5] ARM: shmobile: MSIOF integration on koelsch/lager legacy
Message-Id: <1397499341-11964-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon,

This patch series integrates legacy support for the MSIOF module in the
Renesas R-Car H2 (r8a7790) and M2 (r8a7791) SoCs on the Lager and Koelsch
development boards.

  - [1/5] ARM: shmobile: r8a7790: Add MSIOF clocks
  - [2/5] ARM: shmobile: r8a7791: Add MSIOF clocks
  - [3/5] ARM: shmobile: lager legacy: Add MSIOF support
  - [4/5] ARM: shmobile: koelsch legacy: Add MSIOF support
  - [5/5] ARM: shmobile: koelsch/lager defconfig: Enable MSIOF

These are the remaining patches not taken from v2.
Changelogs are available in the individual patches.

Thanks for applying!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
