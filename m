From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 29 May 2008 22:04:49 +0000
Subject: [2.6 patch] sh/kernel/cpu/irq/intc-sh5.c build fix
Message-Id: <20080529220449.GA1763@cs181133002.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This patch fixes the following build error caused by
commit a1dc4b59fa4af97ae68ee214d4d72bbd7c7ec1dc
(sh: intc_sh5 depends on cayman board for IRQ priority table.):

<--  snip  -->

...
  CC      arch/sh/kernel/cpu/irq/intc-sh5.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/cpu/irq/intc-sh5.c: In function 'plat_irq_setup':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/sh/kernel/cpu/irq/intc-sh5.c:257: error: expected declaration or statement at end of input
make[4]: *** [arch/sh/kernel/cpu/irq/intc-sh5.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
0d194eca3c8d5bddb10c9e61ab290e6e5aceab3f diff --git a/arch/sh/kernel/cpu/irq/intc-sh5.c b/arch/sh/kernel/cpu/irq/intc-sh5.c
index de45c6a..79baa47 100644
--- a/arch/sh/kernel/cpu/irq/intc-sh5.c
+++ b/arch/sh/kernel/cpu/irq/intc-sh5.c
@@ -242,6 +242,7 @@ void __init plat_irq_setup(void)
 				reg += 8;
 			}
 		}
+	}
 #endif
 
 	/*

