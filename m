From: "Szafranek, Michael" <Michael.Szafranek@emtrion.de>
Date: Tue, 14 Dec 2010 09:15:05 +0000
Subject: AW: sh: sh7723/7724 nmi: nmi stops DMA transfers
Message-Id: <95F51F4B902CAC40AF459205F6322F0187A9C8F881@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Yes, I saw this notifier chain but I didn't think that it was so simple.
So, I reworked my patch, it's a little simpler than yours. But it works fin=
e. I'm not sure which is the preferable.

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c in=
dex 8272087..5a1c6f9 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -276,6 +276,26 @@ static struct dma_info sh_dmac_info =3D {
        .flags          =3D DMAC_CHANNELS_TEI_CAPABLE,
 };

+#if defined(CONFIG_CPU_SUBTYPE_SH7723) ||
+defined(CONFIG_CPU_SUBTYPE_SH7724)
+int sh_dma_notifier(struct notifier_block *nb, unsigned long val, void
+*args) {
+       if (!in_nmi())
+               return NOTIFY_DONE;
+
+       /* every NMI usually stops all active DMA transfers. */
+       /* Reset DMA channels so that the transfers are resumed */
+       dmaor_reset(0);
+       dmaor_reset(1);
+
+       return NOTIFY_OK;
+}
+
+static struct notifier_block sh_dma_nb =3D {
+       .notifier_call  =3D sh_dma_notifier,
+       .priority       =3D 0,
+};
+#endif
+
 #ifdef CONFIG_CPU_SH4
 static unsigned int get_dma_error_irq(int n)  { @@ -330,6 +350,12 @@ stati=
c int __init sh_dmac_init(void)
                return i;
 #endif

+#if defined(CONFIG_CPU_SUBTYPE_SH7723) || defined(CONFIG_CPU_SUBTYPE_SH772=
4)
+       i =3D register_die_notifier(&sh_dma_nb);
+       if (unlikely(i !=3D 0))
+               return i;
+#endif
+
        return register_dmac(info);
 }

@@ -338,6 +364,10 @@ static void __exit sh_dmac_exit(void)  #ifdef CONFIG_C=
PU_SH4
        int n;

+#if defined(CONFIG_CPU_SUBTYPE_SH7723) || defined(CONFIG_CPU_SUBTYPE_SH772=
4)
+       unregister_die_notifier(&sh_dma_nb);
+#endif
+
        for (n =3D 0; n < NR_DMAE; n++) {
                free_irq(get_dma_error_irq(n), (void *)dmae_name[n]);
        }
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c index eb6b54d..76dd7=
0b 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -849,6 +849,22 @@ static irqreturn_t sh_dmae_err(int irq, void *data)  }=
  #endif

+#if defined(CONFIG_CPU_SUBTYPE_SH7723) ||
+defined(CONFIG_CPU_SUBTYPE_SH7724)
+int dmae_notifier_call(struct notifier_block *nb, unsigned long val,
+void *args) {
+       struct sh_dmae_device *shdev =3D container_of(nb, struct sh_dmae_de=
vice,
+nb);
+
+       if (!in_nmi())
+               return NOTIFY_DONE;
+
+       /* every NMI usually stops all active DMA transfers. */
+       /* Reset DMA channels so that the transfers are resumed */
+       sh_dmae_rst(shdev);
+
+       return NOTIFY_OK;
+}
+#endif
+
 static void dmae_do_tasklet(unsigned long data)  {
        struct sh_dmae_chan *sh_chan =3D (struct sh_dmae_chan *)data; @@ -1=
085,6 +1101,18 @@ static int __init sh_dmae_probe(struct platform_device *p=
dev)
        chanirq_res =3D errirq_res;
 #endif /* CONFIG_CPU_SH4 || CONFIG_ARCH_SHMOBILE */

+
+#if defined(CONFIG_CPU_SUBTYPE_SH7723) || defined(CONFIG_CPU_SUBTYPE_SH772=
4)
+       shdev->nb.notifier_call =3D dmae_notifier_call;
+       shdev->nb.priority      =3D 0;
+
+       err =3D register_die_notifier(&shdev->nb);
+       if (err) {
+               dev_err(&pdev->dev, "Registering NMI notifier failed\n");
+               goto eirqres;
+       }
+#endif
+
        if (chanirq_res->start =3D chanirq_res->end &&
            !platform_get_resource(pdev, IORESOURCE_IRQ, 1)) {
                /* Special case - all multiplexed */
@@ -1157,6 +1185,10 @@ static int __exit sh_dmae_remove(struct platform_dev=
ice *pdev)
        struct resource *res;
        int errirq =3D platform_get_irq(pdev, 0);

+#if defined(CONFIG_CPU_SUBTYPE_SH7723) || defined(CONFIG_CPU_SUBTYPE_SH772=
4)
+       unregister_die_notifier(&shdev->nb);
+#endif
+
        dma_async_device_unregister(&shdev->common);

        if (errirq > 0)
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h index 4021275..2a017=
54 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -43,6 +43,9 @@ struct sh_dmae_device {
        struct dma_device common;
        struct sh_dmae_chan *chan[SH_DMAC_MAX_CHANNELS];
        struct sh_dmae_pdata *pdata;
+#if defined(CONFIG_CPU_SUBTYPE_SH7723) || defined(CONFIG_CPU_SUBTYPE_SH772=
4)
+       struct notifier_block nb;
+#endif
        u32 __iomem *chan_reg;
        u16 __iomem *dmars;
 };


-----Urspr=FCngliche Nachricht-----
Von: linux-sh-owner@vger.kernel.org [mailto:linux-sh-owner@vger.kernel.org]=
 Im Auftrag von Paul Mundt
Gesendet: Montag, 13. Dezember 2010 11:29
An: Szafranek, Michael
Cc: linux-sh@vger.kernel.org
Betreff: Re: sh: sh7723/7724 nmi: nmi stops DMA transfers

On Mon, Dec 13, 2010 at 10:19:54AM +0100, Szafranek, Michael wrote:
> I've got a patch that fixes a problem when a NMI occurs which stops
> DMA transfers. The code in the patch resumes the DMA transfers. But it
> does not look like the proper place to solve this problem. If you
> could give me a hint were to move the code.
>
> diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c index
> 0830c2a..67f24bc 100644
> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
>         switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
>         case NOTIFY_OK:
...

You surely must have noticed the notifier chain literally right above where=
 you decided to add your hack?


-----Urspr=FCngliche Nachricht-----
Von: linux-sh-owner@vger.kernel.org [mailto:linux-sh-owner@vger.kernel.org]=
 Im Auftrag von Paul Mundt
Gesendet: Montag, 13. Dezember 2010 11:29
An: Szafranek, Michael
Cc: linux-sh@vger.kernel.org
Betreff: Re: sh: sh7723/7724 nmi: nmi stops DMA transfers

On Mon, Dec 13, 2010 at 10:19:54AM +0100, Szafranek, Michael wrote:
> I've got a patch that fixes a problem when a NMI occurs which stops DMA
> transfers. The code in the patch resumes the DMA transfers. But it does
> not look like the proper place to solve this problem. If you could give
> me a hint were to move the code.
>
> diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
> index 0830c2a..67f24bc 100644
> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
>         switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
>         case NOTIFY_OK:
...

You surely must have noticed the notifier chain literally right above
where you decided to add your hack?

> @@ -111,6 +115,22 @@ BUILD_TRAP_HANDLER(nmi)
>                 printk(KERN_ALERT "Got NMI, but nobody cared. Ignoring...=
\n");
>                 break;
>         }
> -
> +
> +/* every NMI usually stops all active DMA transfers. These lines simply =
reanimate the */
> +/* DMA channels so that the transfers are resumed                       =
              */
> +#if defined(CONFIG_SH_HICO7723) || defined(CONFIG_SH_HICO7724)
> +       dmaor =3D __raw_readw(SH_DMAC_BASE0 + DMAOR);
> +       dmaor &=3D ~(DMAOR_NMIF | DMAOR_AE); // resetting NMI flag and ad=
dress error flag
> +       __raw_writew( dmaor, SH_DMAC_BASE0 + DMAOR );
> +       dmaor |=3D DMAOR_INIT;               // restarting DMA
> +       __raw_writew( dmaor, SH_DMAC_BASE0 + DMAOR );
> +
> +       dmaor =3D __raw_readw(SH_DMAC_BASE1 + DMAOR);
> +       dmaor &=3D ~(DMAOR_NMIF | DMAOR_AE); // resetting NMI flag and ad=
dress error flag
> +       __raw_writew( dmaor, SH_DMAC_BASE1 + DMAOR );
> +       dmaor |=3D DMAOR_INIT;               // restarting DMA
> +       __raw_writew( dmaor, SH_DMAC_BASE1 + DMAOR );
> +#endif
> +
>         nmi_exit();
> }
>
Simply register a die notifier in the DMA driver and take care of this
there.
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_____________________________________

Amtsgericht Mannheim
HRB 110 300
Gesch=E4ftsf=FChrer: Dieter Baur, Ramona Maurer
_____________________________________

Important Note:
- This e-mail may contain trade secrets or privileged, undisclosed or other=
wise confidential information.
- If you have received this e-mail in error, you are hereby notified that a=
ny review, copying or distribution of it is strictly prohibited.
- Please inform us immediately and destroy the original transmittal.

Thank you for your cooperation.
