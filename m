From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 Sep 2017 08:40:53 +0000
Subject: [PATCH v2 resend 0/4] sh: sh7722/sh7757i/sh7264/sh7269: Fix pinctrl registration
Message-Id: <1505205657-18012-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-sh@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Andrew,

I'm resending this to you due to unresponsiveness from the SuperH
maintainers (v2 sent before on May 11, pinged on June 30 and August 14).

Magnus Damm reported that on sh7722/Migo-R, pinctrl registration fails
with:

    sh-pfc pfc-sh7722: pin 0 already registered
    sh-pfc pfc-sh7722: error during pin registration
    sh-pfc pfc-sh7722: could not register: -22
    sh-pfc: probe of pfc-sh7722 failed with error -22

pinmux_pins[] is initialized through PINMUX_GPIO(), using designated
array initializers, where the GPIO_* enums serve as indices.
Apparently GPIO_PTQ7 was defined in the enum, but never used.
If enum values are defined, but never used, pinmux_pins[] contains
(zero-filled) holes.  Hence such entries are treated as pin zero, which
was registered before, and pinctrl registration fails.

I can't see how this ever worked, as at the time of commit f5e25ae52feff2dc
("sh-pfc: Add sh7722 pinmux support"), pinmux_gpios[] in
drivers/pinctrl/sh-pfc/pfc-sh7722.c already had the hole, and
drivers/pinctrl/core.c already had the check.

Some scripting revealed a few more broken drivers:
  - sh7757 has four holes, due to nonexistent GPIO_PT[JLNQ]7_RESV.
  - sh7264 and sh7269 define GPIO_PH[0-7], but don't use it with
    PINMUX_GPIO().

Patch 1 fixes the issue on sh7722, and was tested.
Patches 3-4 should fix the issue on the other 3 SoCs, but was untested due
to lack of hardware.

Changes compared to v1:
  - Replace fake error messages by references to sh7722,
  - Add Reviewed-by, Tested-by.

Thanks for applying!

Geert Uytterhoeven (4):
  sh: sh7722: Remove nonexistent GPIO_PTQ7 to fix pinctrl registration
  sh: sh7757: Remove nonexistent GPIO_PT[JLNQ]7_RESV to fix pinctrl
    registration
  sh: sh7264: Remove nonexistent GPIO_PH[0-7] to fix pinctrl
    registration
  sh: sh7269: Remove nonexistent GPIO_PH[0-7] to fix pinctrl
    registration

 arch/sh/include/cpu-sh2a/cpu/sh7264.h | 4 +---
 arch/sh/include/cpu-sh2a/cpu/sh7269.h | 4 +---
 arch/sh/include/cpu-sh4/cpu/sh7722.h  | 2 +-
 arch/sh/include/cpu-sh4/cpu/sh7757.h  | 8 ++++----
 4 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
