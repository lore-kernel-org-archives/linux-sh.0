From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 18 Dec 2019 19:48:11 +0000
Subject: [PATCH 5/6] sh: sh7264: Remove bogus SSU GPIO function definitions
Message-Id: <20191218194812.12741-6-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20191218194812.12741-1-geert+renesas@glider.be>
In-Reply-To: <20191218194812.12741-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

SH7264 has no Synchronous Serial Communication Unit (SSU).
Remove the bogus enum IDs, which caused holes in pinmux_func_gpios[].

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Presumably this has been copied from sh7203.

The runtime-check under development reports:

    sh7264_pfc: empty function gpio 118
    sh7264_pfc: empty function gpio 119
    sh7264_pfc: empty function gpio 120
    sh7264_pfc: empty function gpio 121
    sh7264_pfc: empty function gpio 122
    sh7264_pfc: empty function gpio 123
    sh7264_pfc: empty function gpio 124
    sh7264_pfc: empty function gpio 125
    sh7264_pfc: empty function gpio 126
    sh7264_pfc: empty function gpio 127
    sh7264_pfc: empty function gpio 128
    sh7264_pfc: empty function gpio 129
    sh7264_pfc: empty function gpio 130
    sh7264_pfc: empty function gpio 131
    sh7264_pfc: empty function gpio 132
    sh7264_pfc: empty function gpio 133
---
 arch/sh/include/cpu-sh2a/cpu/sh7264.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/sh/include/cpu-sh2a/cpu/sh7264.h b/arch/sh/include/cpu-sh2a/cpu/sh7264.h
index d12c1918684518b3..8a1338aaf10a5c41 100644
--- a/arch/sh/include/cpu-sh2a/cpu/sh7264.h
+++ b/arch/sh/include/cpu-sh2a/cpu/sh7264.h
@@ -112,12 +112,6 @@ enum {
 	GPIO_FN_TIOC0D, GPIO_FN_TIOC0C, GPIO_FN_TIOC0B, GPIO_FN_TIOC0A,
 	GPIO_FN_TCLKD, GPIO_FN_TCLKC, GPIO_FN_TCLKB, GPIO_FN_TCLKA,
 
-	/* SSU */
-	GPIO_FN_SCS0_PD, GPIO_FN_SSO0_PD, GPIO_FN_SSI0_PD, GPIO_FN_SSCK0_PD,
-	GPIO_FN_SCS0_PF, GPIO_FN_SSO0_PF, GPIO_FN_SSI0_PF, GPIO_FN_SSCK0_PF,
-	GPIO_FN_SCS1_PD, GPIO_FN_SSO1_PD, GPIO_FN_SSI1_PD, GPIO_FN_SSCK1_PD,
-	GPIO_FN_SCS1_PF, GPIO_FN_SSO1_PF, GPIO_FN_SSI1_PF, GPIO_FN_SSCK1_PF,
-
 	/* SCIF */
 	GPIO_FN_SCK0, GPIO_FN_SCK1, GPIO_FN_SCK2, GPIO_FN_SCK3,
 	GPIO_FN_RXD0, GPIO_FN_RXD1, GPIO_FN_RXD2, GPIO_FN_RXD3,
-- 
2.17.1
