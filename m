From: Andrey Utkin <andrey.krieger.utkin@gmail.com>
Date: Thu, 17 Jul 2014 13:28:25 +0000
Subject: [PATCH 3/3] arch/sh/kernel/ptrace_{32,64}.c: drop negativity checks for unsigned long addr
Message-Id: <1405603705-12625-1-git-send-email-andrey.krieger.utkin@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-sh@vger.kernel.org
Cc: eparis@redhat.com, Andrey Utkin <andrey.krieger.utkin@gmail.com>

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=80381
Reported-by: David Binderman <dcb314@hotmail.com>
Signed-off-by: Andrey Utkin <andrey.krieger.utkin@gmail.com>
---
 arch/sh/kernel/ptrace_32.c | 4 ++--
 arch/sh/kernel/ptrace_64.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index c1a6b89..78effcb 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -379,7 +379,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
 		unsigned long tmp;
=20
 		ret =3D -EIO;
-		if ((addr & 3) || addr < 0 ||
+		if ((addr & 3) ||
 		    addr > sizeof(struct user) - 3)
 			break;
=20
@@ -419,7 +419,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
=20
 	case PTRACE_POKEUSR: /* write the word at location addr in the USER area =
*/
 		ret =3D -EIO;
-		if ((addr & 3) || addr < 0 ||
+		if ((addr & 3) ||
 		    addr > sizeof(struct user) - 3)
 			break;
=20
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 5cea973..138b2b1 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -395,7 +395,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
 		unsigned long tmp;
=20
 		ret =3D -EIO;
-		if ((addr & 3) || addr < 0)
+		if (addr & 3)
 			break;
=20
 		if (addr < sizeof(struct pt_regs))
@@ -423,7 +423,7 @@ long arch_ptrace(struct task_struct *child, long reques=
t,
                    this could crash the kernel or result in a security
                    loophole. */
 		ret =3D -EIO;
-		if ((addr & 3) || addr < 0)
+		if (addr & 3)
 			break;
=20
 		if (addr < sizeof(struct pt_regs)) {
--=20
1.8.5.5

