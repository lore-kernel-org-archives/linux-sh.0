From: Andrzej Hajda <a.hajda@samsung.com>
Date: Mon, 21 Sep 2015 13:34:07 +0000
Subject: [PATCH 35/38] ptrace: remove invalid check
Message-Id: <1442842450-29769-36-git-send-email-a.hajda@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1442842450-29769-1-git-send-email-a.hajda@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrzej Hajda <a.hajda@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Eric Paris <eparis@redhat.com>, linux-sh@vger.kernel.org

Unsigned values cannot be lesser than zero.

The problem has been detected using proposed semantic patch
scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].

[1]: http://permalink.gmane.org/gmane.linux.kernel/2038576

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 arch/sh/kernel/ptrace_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 5cea973..138b2b1 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -395,7 +395,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		unsigned long tmp;
 
 		ret = -EIO;
-		if ((addr & 3) || addr < 0)
+		if (addr & 3)
 			break;
 
 		if (addr < sizeof(struct pt_regs))
@@ -423,7 +423,7 @@ long arch_ptrace(struct task_struct *child, long request,
                    this could crash the kernel or result in a security
                    loophole. */
 		ret = -EIO;
-		if ((addr & 3) || addr < 0)
+		if (addr & 3)
 			break;
 
 		if (addr < sizeof(struct pt_regs)) {
-- 
1.9.1

