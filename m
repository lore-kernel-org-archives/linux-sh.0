From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 21 May 2015 13:06:09 +0000
Subject: Renesas R-Car M2 Porter board? (was: [PATCH v3 11/11] ARM: shmobile: gose: enable R-Car Gen2 regulat
Message-Id: <CAMuHMdVVvOw6-hM4HfB_tXHV7-pSUdBgfcWJFh5_S2hcYich9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Does anyone have a Renesas R-Car M2 Porter board?
I think it's also affected, as it has both da9063/da9210.

Thanks!

---------- Forwarded message ----------
From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, May 21, 2015 at 12:48 PM
Subject: [PATCH v3 11/11] ARM: shmobile: gose: enable R-Car Gen2 regulator quirk
To: geert@linux-m68k.org, horms@verge.net.au,
linux-sh@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com,
kuninori.morimoto.gx@renesas.com
Cc: magnus.damm@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>


Regulator setup seems identical to Koelsch.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
index 384e6e9..62437b5 100644
--- a/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/regulator-quirk-rcar-gen2.c
@@ -123,7 +123,8 @@ static int __init rcar_gen2_regulator_quirk(void)
        u32 mon;

        if (!of_machine_is_compatible("renesas,koelsch") &&
-           !of_machine_is_compatible("renesas,lager"))
+           !of_machine_is_compatible("renesas,lager") &&
+           !of_machine_is_compatible("renesas,gose"))
                return -ENODEV;

        irqc = ioremap(IRQC_BASE, PAGE_SIZE);
--
2.3.5
