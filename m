From: Paul Bolle <pebolle@tiscali.nl>
Date: Wed, 18 Jun 2014 09:32:15 +0000
Subject: [PATCH] Remove CPU_SUBTYPE_SH7764
Message-Id: <1403083935.1984.74.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
	 <1391971686-9517-22-git-send-email-richard@nod.at>
	 <1391981761.25855.58.camel@x220> <1397554747.1985.35.camel@x220>
	 <CAMuHMdXawwgr7x=TFumDUh+c+-KZteHdp+NrnXTFcFcwT6gjRQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXawwgr7x=TFumDUh+c+-KZteHdp+NrnXTFcFcwT6gjRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
[pebolle@tiscali.nl: re-added dropped ||]
Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Submitted by Richard a few months ago as "[PATCH 21/28] Remove
CPU_SUBTYPE_SH7764".

Untested.

 arch/sh/drivers/dma/Kconfig                | 5 ++---
 arch/sh/include/cpu-sh4/cpu/dma-register.h | 1 -
 arch/sh/include/cpu-sh4a/cpu/dma.h         | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index cfd5b90a8628..78bc97b1d027 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -12,9 +12,8 @@ config SH_DMA_IRQ_MULTI
 	default y if CPU_SUBTYPE_SH7750  || CPU_SUBTYPE_SH7751  || \
 		     CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7750R || \
 		     CPU_SUBTYPE_SH7751R || CPU_SUBTYPE_SH7091  || \
-		     CPU_SUBTYPE_SH7763  || CPU_SUBTYPE_SH7764  || \
-		     CPU_SUBTYPE_SH7780  || CPU_SUBTYPE_SH7785  || \
-		     CPU_SUBTYPE_SH7760
+		     CPU_SUBTYPE_SH7763  || CPU_SUBTYPE_SH7780  || \
+		     CPU_SUBTYPE_SH7785  || CPU_SUBTYPE_SH7760
 
 config SH_DMA_API
 	depends on SH_DMA
diff --git a/arch/sh/include/cpu-sh4/cpu/dma-register.h b/arch/sh/include/cpu-sh4/cpu/dma-register.h
index 02788b6a03b7..9cd81e54056a 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-register.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-register.h
@@ -32,7 +32,6 @@
 #define CHCR_TS_HIGH_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
 #elif defined(CONFIG_CPU_SUBTYPE_SH7757) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7763) || \
-	defined(CONFIG_CPU_SUBTYPE_SH7764) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7780) || \
 	defined(CONFIG_CPU_SUBTYPE_SH7785)
 #define CHCR_TS_LOW_MASK	0x00000018
diff --git a/arch/sh/include/cpu-sh4a/cpu/dma.h b/arch/sh/include/cpu-sh4a/cpu/dma.h
index 89afb650ce25..8ceccceae844 100644
--- a/arch/sh/include/cpu-sh4a/cpu/dma.h
+++ b/arch/sh/include/cpu-sh4a/cpu/dma.h
@@ -14,8 +14,7 @@
 #define DMTE4_IRQ	evt2irq(0xb80)
 #define DMAE0_IRQ	evt2irq(0xbc0)	/* DMA Error IRQ*/
 #define SH_DMAC_BASE0	0xFE008020
-#elif defined(CONFIG_CPU_SUBTYPE_SH7763) || \
-	defined(CONFIG_CPU_SUBTYPE_SH7764)
+#elif defined(CONFIG_CPU_SUBTYPE_SH7763)
 #define DMTE0_IRQ	evt2irq(0x640)
 #define DMTE4_IRQ	evt2irq(0x780)
 #define DMAE0_IRQ	evt2irq(0x6c0)
-- 
1.9.3

