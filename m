From: Lubomir Rintel <lkundrak@v3.sk>
Date: Wed, 30 Sep 2009 06:17:34 +0000
Subject: [PATCH] sh: Build fix: define __movmem
Message-Id: <1254291454-7436-1-git-send-email-lkundrak@v3.sk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>

ERROR: "__movmem" [net/irda/irda.ko] undefined!
ERROR: "__movmem" [fs/nfsd/nfsd.ko] undefined!
ERROR: "__movmem" [fs/lockd/lockd.ko] undefined!
ERROR: "__movmem" [crypto/sha1_generic.ko] undefined!
---
 arch/sh/kernel/sh_ksyms_32.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/sh_ksyms_32.c b/arch/sh/kernel/sh_ksyms_32.c
index fcc5de3..98b63de 100644
--- a/arch/sh/kernel/sh_ksyms_32.c
+++ b/arch/sh/kernel/sh_ksyms_32.c
@@ -84,6 +84,7 @@ DECLARE_EXPORT(__movstrSI60);
 DECLARE_EXPORT(__movstr_i4_even);
 DECLARE_EXPORT(__movstr_i4_odd);
 DECLARE_EXPORT(__movstrSI12_i4);
+DECLARE_EXPORT(__movmem);
 DECLARE_EXPORT(__movmem_i4_even);
 DECLARE_EXPORT(__movmem_i4_odd);
 DECLARE_EXPORT(__movmemSI12_i4);
-- 
1.6.4.4

