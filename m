From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:45:19 +0000
Subject: [DEBUG 0/5] ARM: shmobile: r8a7791: MSTP debug code
Message-Id: <1397565924-23541-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi all,

This series contains the MSTP debug code I used for investigation and
development. It is _not_ meant to be applied!

  - [1/5] ARM: shmobile: r8a7791: Disable MSTP clocks
  - [2/5] r8a7791: show MSTP clock status during boot-up
  - [3/5] sh/cpg: Monitor MSTP clock enable/disable
  - [4/5] clk/mstp: Monitor MSTP clock enable/disable
  - [5/5] r8a7791: show MSTP clock status in /proc/cpuinfo

People working on other drivers (e.g. sound, SDHI, USB, ...) may want to
apply patch 1, to check if their driver correctly enables all needed clocks.
If deemed useful, this patch (or a less verbose version) could be applied,
though.

Patches 2-5 can be used to check which clocks are enabled at kernel start
time, to check when clocks are enabled/disabled, and to check which clocks
are enabled at an arbitrary moment in time.

All code should be multi-platform safe. I used it in a kernel that supports
and runs on both Koelsch and BeagleBone Black.

Have fun! ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
