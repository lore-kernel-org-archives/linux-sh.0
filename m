From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 14:36:31 +0000
Subject: [PATCH v2 1/9] sh: fault: Fix duplicate printing of "PC:"
Message-Id: <20200617143639.18315-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617143639.18315-1-geert+renesas@glider.be>
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Somewhere along the patch handling path, both the old "printk(KERN_ALERT
...)" and the new "pr_alert(...)" were retained, leading to the
duplicate printing of "PC:".

Drop the old one.

Fixes: eaabf98b0932a540 ("sh: fault: modernize printing of kernel messages")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/sh/mm/fault.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index fbe1f2fe9a8c8f55..acd1c75994983825 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -208,7 +208,6 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
 	if (!oops_may_print())
 		return;
 
-	printk(KERN_ALERT "PC:");
 	pr_alert("BUG: unable to handle kernel %s at %08lx\n",
 		 address < PAGE_SIZE ? "NULL pointer dereference"
 				     : "paging request",
-- 
2.17.1
