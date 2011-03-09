From: Stephen Wilson <wilsons@start.ca>
Date: Wed, 09 Mar 2011 00:31:57 +0000
Subject: [PATCH 1/5] x86: add context tag to mark mm when running a task in 32-bit compatibility mode
Message-Id: <1299630721-4337-2-git-send-email-wilsons@start.ca>
List-Id: <linux-sh.vger.kernel.org>
References: <1299630721-4337-1-git-send-email-wilsons@start.ca>
In-Reply-To: <1299630721-4337-1-git-send-email-wilsons@start.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Paul Mundt <lethal@linux-sh.org>, Andi Kleen <ak@linux.intel.com>, Michel Lespinasse <walken@google.com>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Stephen Wilson <wilsons@start.ca>

This tag is intended to mirror the thread info TIF_IA32 flag.  Will be used to
identify mm's which support 32 bit tasks running in compatibility mode without
requiring a reference to the task itself.

Signed-off-by: Stephen Wilson <wilsons@start.ca>
---
 arch/x86/include/asm/mmu.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 80a1dee..8a2e5b4 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -13,6 +13,12 @@ typedef struct {
 	int size;
 	struct mutex lock;
 	void *vdso;
+
+#ifdef CONFIG_X86_64
+	/* True if mm supports a task running in 32 bit compatibility mode. */
+	unsigned short compat;
+#endif
+
 } mm_context_t;
 
 #ifdef CONFIG_SMP
-- 
1.7.3.5

