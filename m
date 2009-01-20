From: Matt Fleming <matt@console-pimps.org>
Date: Tue, 20 Jan 2009 21:14:38 +0000
Subject: [PATCH 2/2] sh: Use the atomic_t "counter" member
Message-Id: <1232486078-11227-2-git-send-email-matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1232486078-11227-1-git-send-email-matt@console-pimps.org>
In-Reply-To: <1232486078-11227-1-git-send-email-matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

Now that atomic_t is a generic opaque type for all architectures, it is
unwise to use intimate knowledge of its internals when manipulating it.

Instead of relying on the "counter" member being at offset 0 from the
beginning of an atomic_t, explicitly reference the member. This guards
us from any changes to the layout of the beginning of the atomic_t type.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/atomic-irq.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/atomic-irq.h b/arch/sh/include/asm/atomic-irq.h
index 74f7943..a0b3480 100644
--- a/arch/sh/include/asm/atomic-irq.h
+++ b/arch/sh/include/asm/atomic-irq.h
@@ -11,7 +11,7 @@ static inline void atomic_add(int i, atomic_t *v)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	*(long *)v += i;
+	v->counter += i;
 	local_irq_restore(flags);
 }
 
@@ -20,7 +20,7 @@ static inline void atomic_sub(int i, atomic_t *v)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	*(long *)v -= i;
+	v->counter -= i;
 	local_irq_restore(flags);
 }
 
@@ -29,9 +29,9 @@ static inline int atomic_add_return(int i, atomic_t *v)
 	unsigned long temp, flags;
 
 	local_irq_save(flags);
-	temp = *(long *)v;
+	temp = v->counter;
 	temp += i;
-	*(long *)v = temp;
+	v->counter = temp;
 	local_irq_restore(flags);
 
 	return temp;
@@ -42,9 +42,9 @@ static inline int atomic_sub_return(int i, atomic_t *v)
 	unsigned long temp, flags;
 
 	local_irq_save(flags);
-	temp = *(long *)v;
+	temp = v->counter;
 	temp -= i;
-	*(long *)v = temp;
+	v->counter = temp;
 	local_irq_restore(flags);
 
 	return temp;
@@ -55,7 +55,7 @@ static inline void atomic_clear_mask(unsigned int mask, atomic_t *v)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	*(long *)v &= ~mask;
+	v->counter &= ~mask;
 	local_irq_restore(flags);
 }
 
@@ -64,7 +64,7 @@ static inline void atomic_set_mask(unsigned int mask, atomic_t *v)
 	unsigned long flags;
 
 	local_irq_save(flags);
-	*(long *)v |= mask;
+	v->counter |= mask;
 	local_irq_restore(flags);
 }
 
-- 
1.5.6.3

