From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Date: Tue, 15 Oct 2019 22:31:55 +0000
Subject: [PATCH 1/6 v2] sh: Move cmpxchg-xchg.h to asm-generic
Message-Id: <20191015223154.7wcsc7x5edrpasfc@flow>
List-Id: <linux-sh.vger.kernel.org>
References: <20191013221310.30748-1-sebastian@breakpoint.cc>
 <20191013221310.30748-2-sebastian@breakpoint.cc>
 <CAK8P3a0q+03=uNcnnHrGqHGOcAO3-mytxSmoBWLtHY+5StMNOQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0q+03=uNcnnHrGqHGOcAO3-mytxSmoBWLtHY+5StMNOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

The header file is very generic and could be reused by other
architectures as long as they provide __cmpxchg_u32().

Move sh's cmpxchg-xchg.h to asm-generic.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
v1=E2=80=A6v2: s@__ASM_SH_CMPXCHG_XCHG_H@__ASM_GENERIC_CMPXCHG_XCHG_H@

 arch/sh/include/asm/Kbuild                                  | 1 +
 {arch/sh/include/asm =3D> include/asm-generic}/cmpxchg-xchg.h | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)
 rename {arch/sh/include/asm =3D> include/asm-generic}/cmpxchg-xchg.h (91%)

diff --git a/arch/sh/include/asm/Kbuild b/arch/sh/include/asm/Kbuild
index 51a54df22c110..08c1d96286d9d 100644
--- a/arch/sh/include/asm/Kbuild
+++ b/arch/sh/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generated-y +=3D syscall_table.h
+generic-y +=3D cmpxchg-xchg.h
 generic-y +=3D compat.h
 generic-y +=3D current.h
 generic-y +=3D delay.h
diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/include/asm-generic/cmpxc=
hg-xchg.h
similarity index 91%
rename from arch/sh/include/asm/cmpxchg-xchg.h
rename to include/asm-generic/cmpxchg-xchg.h
index c373f21efe4d9..c9acd6ff8741d 100644
--- a/arch/sh/include/asm/cmpxchg-xchg.h
+++ b/include/asm-generic/cmpxchg-xchg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __ASM_SH_CMPXCHG_XCHG_H
-#define __ASM_SH_CMPXCHG_XCHG_H
+#ifndef __ASM_GENERIC_CMPXCHG_XCHG_H
+#define __ASM_GENERIC_CMPXCHG_XCHG_H
=20
 /*
  * Copyright (C) 2016 Red Hat, Inc.
@@ -47,4 +47,4 @@ static inline unsigned long xchg_u8(volatile u8 *m, unsig=
ned long val)
 	return __xchg_cmpxchg(m, val, sizeof *m);
 }
=20
-#endif /* __ASM_SH_CMPXCHG_XCHG_H */
+#endif /* __ASM_GENERIC_CMPXCHG_XCHG_H */
--=20
2.23.0
