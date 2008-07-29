From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jul 2008 15:23:10 +0000
Subject: Re: SH7760: early_printk build broken
Message-Id: <20080729152310.GA3337@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080729142743.GA7017@roarinelk.homelinux.net>
In-Reply-To: <20080729142743.GA7017@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 29, 2008 at 04:27:43PM +0200, Manuel Lauss wrote:
> Hello Iwamatsu-san,
> 
> Commit c63847a3621d2bac054f5709783860ecabd0ee7e ("sh: Add SCIF2 support for SH7763.")
> broke build with CONFIG_EARLY_PRINTK enabled for me (SH7760):
> 
>   CC      arch/sh/kernel/early_printk.o
> /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c: In function 'scif_sercon_putc':
> /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c:84: error: implicit declaration of function 'sci_SCFDR_in'
> 
> I don't know immediately how to fix it though, could you please take a look?
> 
I see what happened. Proof that this file is such a ridiculous
clusterfuck it's hard to know where to even begin.

---

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index cd728df..e8d3633 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -463,6 +463,8 @@ SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
 SCIF_FNS(SCFDR,				0,  0, 0x1C, 16)
 SCIF_FNS(SCSPTR2,			0,  0, 0x20, 16)
 SCIF_FNS(SCLSR2, 			0,  0, 0x24, 16)
+#else
+SCIF_FNS(SCFDR,			     0x0e, 16, 0x1C, 16)
 #endif /* CONFIG_CPU_SUBTYPE_SH7763 */
 #else
 SCIF_FNS(SCFDR,                      0x0e, 16, 0x1C, 16)
