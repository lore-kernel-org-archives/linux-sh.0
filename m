From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Jun 2014 08:42:21 +0000
Subject: [PATCH 0/3] ARM: shmobile: rcar-gen2: rcar_gen2_scan_mem() updates
Message-Id: <1402562544-4527-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

This is a small series with updates for rcar_gen2_scan_mem().

The first one fixes compiler warnings due to commit
9d0c4dfedd96ee54fc075b16d02f82499c8cc3a6 ("of/fdt:
update of_get_flat_dt_prop in prep for libfdt") landing in Linus' tree.
Note that this commit is not in renesas-devel-v3.15-20140612.

The other two are fixes for the remaining review comments I had.
As I was touching the file anyway, I implemented them myself. Magnus, I
hope you don't mind.

Geert Uytterhoeven (3):
  [1/3] ARM: shmobile: rcar-gen2: Update for of_get_flat_dt_prop() update
  [2/3] ARM: shmobile: rcar-gen2: Use "1ULL" instead of "(u64)1"
  [3/3] ARM: shmobile: rcar-gen2: Remove useless copied section for LongTrail

 arch/arm/mach-shmobile/setup-rcar-gen2.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
