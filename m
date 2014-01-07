From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Jan 2014 18:57:12 +0000
Subject: [PATCH 0/4] thermal: rcar: Add missing clock handling
Message-Id: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

    Hi all,

This patch series fixes a problem when the thermal-rcar device is
instantiated from the device tree on the r8a7791-based Koelsch development
board. The driver fails during initialization with:

    rcar_thermal e61f0000.thermal: thermal sensor was broken

This does not happen when using legacy platform devices.

This series was tested using Koelsch reference (DT) and non-reference
(legacy) kernel configurations. It was not tested on r8a7790/Lager
(which is very similar).

    [1/4] ARM: shmobile: r8a7791: Add thermal clock in device tree
    [2/4] ARM: shmobile: r8a7790: Add thermal clock in device tree
    [3/4] thermal: rcar: Add missing clock handling
    [4/4] thermal: rcar: Spelling s/delaye/delay/g

Thanks for your comments!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
