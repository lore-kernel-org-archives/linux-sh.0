From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 22 Jun 2019 11:42:08 +0000
Subject: [PATCH] sh: prevent warnings when using iounmap
Message-Id: <20190622114208.24427-1-sam@ravnborg.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Will Deacon <will.deacon@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@kernel.org>, Inki Dae <inki.dae@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Sam Ravnborg <sam@ravnborg.org>

When building drm/exynos for sh, as part of an allmodconfig build,
the following warning triggered:

  exynos7_drm_decon.c: In function ‘decon_remove’:
  exynos7_drm_decon.c:769:24: warning: unused variable ‘ctx’
    struct decon_context *ctx = dev_get_drvdata(&pdev->dev);

The ctx variable is only used as argument to iounmap().

In sh - allmodconfig CONFIG_MMU is not defined
so it ended up in:

\#define __iounmap(addr)	do { } while (0)
\#define iounmap		__iounmap

Fix the warning by introducing a static inline
function for iounmap.
This is similar to several other architectures.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Inki Dae <inki.dae@samsung.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/sh/include/asm/io.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index c28e37a344ad..ac0561960c52 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -369,7 +369,11 @@ static inline int iounmap_fixed(void __iomem *addr) { return -EINVAL; }
 
 #define ioremap_nocache	ioremap
 #define ioremap_uc	ioremap
-#define iounmap		__iounmap
+
+static inline void iounmap(void __iomem *addr)
+{
+	__iounmap(addr);
+}
 
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
-- 
2.20.1
