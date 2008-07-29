From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 29 Jul 2008 15:46:04 +0000
Subject: Re: SH7760: early_printk build broken
Message-Id: <20080729154604.GB3935@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080729142743.GA7017@roarinelk.homelinux.net>
In-Reply-To: <20080729142743.GA7017@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 30, 2008 at 12:45:39AM +0900, Paul Mundt wrote:
> On Wed, Jul 30, 2008 at 12:23:10AM +0900, Paul Mundt wrote:
> > On Tue, Jul 29, 2008 at 04:27:43PM +0200, Manuel Lauss wrote:
> > > Hello Iwamatsu-san,
> > > 
> > > Commit c63847a3621d2bac054f5709783860ecabd0ee7e ("sh: Add SCIF2 support for SH7763.")
> > > broke build with CONFIG_EARLY_PRINTK enabled for me (SH7760):
> > > 
> > >   CC      arch/sh/kernel/early_printk.o
> > > /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c: In function 'scif_sercon_putc':
> > > /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c:84: error: implicit declaration of function 'sci_SCFDR_in'
> > > 
> > > I don't know immediately how to fix it though, could you please take a look?
> > > 
> > I see what happened. Proof that this file is such a ridiculous
> > clusterfuck it's hard to know where to even begin.
> > 
> Here's a slightly more coherent version. It's really not worth trying to
> shoe-horn 7763 in with 7760/7780/7785. If it has any differences, it's
> always best to separate it out completely, or we are very quickly reduced
> to impossible to follow ifdef hell.
> 
> With the generic kgdbts stuff in now and the sh-bios users falling by the
> way side, sh-sci is long overdue for a total rewrite anyways. It's only
> been 6+ years since the last time I rewrote it anyways, when I had
> planned to get rid of sh-sci.h also.
> 
> The biggest mess comes from having it split between sh64/sh/h8300 (and
> probably RX in the not so distant future), and most of this sharing
> happened pre driver-model. Unfortunately these subtle variations across
> the blocks make supporting it a total pain. Now that we have totally
> different port types on newer parts it's necessary to rework a bit
> anyways (presently we shove SCIFA parts from SH-MobileR2 in as SCI
> ports), and the DMA auto requests start to matter on SMP parts (which of
> course has nothing in common with the previous SMP extensions that SH-2
> implemented back in the day to get around the fact that bus accesses were
> mutually exclusive..). ;-)

---

diff --git a/drivers/serial/sh-sci.h b/drivers/serial/sh-sci.h
index cd728df..8a0749e 100644
--- a/drivers/serial/sh-sci.h
+++ b/drivers/serial/sh-sci.h
@@ -451,19 +451,21 @@ SCIx_FNS(SCxSR,  0x08,  8, 0x10,  8, 0x08, 16, 0x10, 16, 0x04,  8)
 SCIx_FNS(SCxRDR, 0x0a,  8, 0x14,  8, 0x0A,  8, 0x14,  8, 0x05,  8)
 SCIF_FNS(SCFCR,                      0x0c,  8, 0x18, 16)
 #if defined(CONFIG_CPU_SUBTYPE_SH7760) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7763) || \
     defined(CONFIG_CPU_SUBTYPE_SH7780) || \
     defined(CONFIG_CPU_SUBTYPE_SH7785)
+SCIF_FNS(SCFDR,			     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
 SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
 SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
 SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
-#if defined(CONFIG_CPU_SUBTYPE_SH7763)
-/* SH7763 SCIF2 */
+#elif defined(CONFIG_CPU_SUBTYPE_SH7763)
 SCIF_FNS(SCFDR,				0,  0, 0x1C, 16)
 SCIF_FNS(SCSPTR2,			0,  0, 0x20, 16)
-SCIF_FNS(SCLSR2, 			0,  0, 0x24, 16)
-#endif /* CONFIG_CPU_SUBTYPE_SH7763 */
+SCIF_FNS(SCLSR2,			0,  0, 0x24, 16)
+SCIF_FNS(SCTFDR,		     0x0e, 16, 0x1C, 16)
+SCIF_FNS(SCRFDR,		     0x0e, 16, 0x20, 16)
+SCIF_FNS(SCSPTR,			0,  0, 0x24, 16)
+SCIF_FNS(SCLSR,				0,  0, 0x28, 16)
 #else
 SCIF_FNS(SCFDR,                      0x0e, 16, 0x1C, 16)
 #if defined(CONFIG_CPU_SUBTYPE_SH7722)
