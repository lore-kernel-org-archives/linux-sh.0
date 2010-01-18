From: Peter Huewe <PeterHuewe@gmx.de>
Date: Mon, 18 Jan 2010 02:57:31 +0000
Subject: [PATCH] arch/sh: Fix build failure caused by missing semicolon / missing include
Message-Id: <201001180357.31594.PeterHuewe@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Paul Mundt <lethal@linux-sh.org>
Cc: Matt Fleming <matt@console-pimps.org>, Francesco Virlinzi <francesco.virlinzi@st.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, peterhuewe@gmx.de

From: Peter Huewe <peterhuewe@gmx.de>
Date: Mon, 18 Jan 2010 03:48:31 +0100

This patch fixes a build failure[1][2] for all sh configs, by fixing a
missing semicolon and a missing include file.

Build failure was introduced by the patch
	sh: fixed PMB mode refactoring [3]
	of Wed, 13 Jan 2010 09:31:48 +0000 (18:31 +0900)

References:
[1] http://kisskb.ellerman.id.au/kisskb/buildresult/2019836/
[2] http://kisskb.ellerman.id.au/kisskb/compiler/16/
[3] http://git.kernel.org/?p=3Dlinux/kernel/git/sfr/linux-next.git;a=3Dcomm=
it;h=A0ab36689a36e583b6e736f1c99ac8c9aebdad59

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
---
Patch against linux-next tree of 20100114
KernelVersion: next-20100114

 arch/sh/include/asm/mmu.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/include/asm/mmu.h b/arch/sh/include/asm/mmu.h
index 4b0882b..c5313e2 100644
--- a/arch/sh/include/asm/mmu.h
+++ b/arch/sh/include/asm/mmu.h
@@ -1,5 +1,6 @@
 #ifndef __MMU_H
 #define __MMU_H
+#include <linux/errno.h>
=20
 /*
  * Privileged Space Mapping Buffer (PMB) definitions
@@ -75,7 +76,7 @@ int pmb_init(void);
 static inline long pmb_remap(unsigned long virt, unsigned long phys,
 			     unsigned long size, unsigned long flags)
 {
-	return -EINVAL
+	return -EINVAL;
 }
=20
 static inline void pmb_unmap(unsigned long addr)
--=20
1.6.4.4

