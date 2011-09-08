From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 08 Sep 2011 08:52:11 +0000
Subject: Re: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <CABMQnVLws9xeAyu5iWVT7MqRYmBBDYKSkn1P+fAbpzj-b_Pv3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi,

Your patch does not seem to have a meaning.
In the case of 29bit, CAC/UNCAC_ADDR may not return a right address.
I think that it is to use P1SEGADDR, and P2SEGADDR in CAC/UNCAC_ADDR
to easily revise this.
I attached my patch.

Best regards,
  Nobuhiro

From b1f83e75a2dc5a61671d18e8f472450561c9eea7 Mon Sep 17 00:00:00 2001
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 8 Sep 2011 17:37:24 +0900
Subject: [PATCH] sh: Fix address calculation of CAC_ADDR and
UNCAC_ADDR in 29bit mode

In the case of 29bit mode, CAC/UNCAC_ADDR does not return a right address.
This revises this problem by using P1SEGADDR and P2SEGADDR in 29bit mode.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/include/asm/page.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
index 822d608..abcc4dc 100644
--- a/arch/sh/include/asm/page.h
+++ b/arch/sh/include/asm/page.h
@@ -141,8 +141,13 @@ typedef struct page *pgtable_t;
 #endif /* !__ASSEMBLY__ */

 #ifdef CONFIG_UNCACHED_MAPPING
+#if defined(CONFIG_29BIT)
+#define UNCAC_ADDR(addr)	P2SEGADDR(addr)
+#define CAC_ADDR(addr)		P1SEGADDR(addr)
+#else
 #define UNCAC_ADDR(addr)	((addr) - PAGE_OFFSET + uncached_start)
 #define CAC_ADDR(addr)		((addr) - uncached_start + PAGE_OFFSET)
+#endif
 #else
 #define UNCAC_ADDR(addr)	((addr))
 #define CAC_ADDR(addr)		((addr))
--=20
1.7.5.4

2011/9/1 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>:
>
> Hi Ebihara-san, and Paul
>
> Thank you for your report.
>
>> i think you can run linux-3.0.4 kernel on your Ecovec (SH7724) board
>> in this debug-code.
>>
>>
>> =A0void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum dma_data_direction direc=
tion)
>> =A0{
>> =A0 =A0 =A0 =A0 =A0void *addr;
>>
>> =A0 =A0 =A0 =A0 =A0addr =3D __in_29bit_mode() ?
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)CAC_ADDR((unsigned long)vaddr) : v=
addr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)P1SEGADDR((unsigned long)vaddr) : =
vaddr;
>
> Paul
>
> I guess your patch tried to share code for sh32/sh64.
> and CAC_ADDR() should be equal P1SEGADDR(), correct ?
>
> I'm not filmier with memory control, but
> on Ecovec case, 1st (and crash case) dma_cache_sync() caller is
> ${LINUX}/arch/sh/mm/consistent.c :: dma_generic_alloc_coherent()
>
> it tried
>
> =A0 =A0 =A0 =A0ret =3D (void *)__get_free_pages(gfp, order);
> =A0 =A0 =A0 =A0(snip)
> =A0 =A0 =A0 =A0dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);
>
> This "ret" is "8e000000" for now.
>
> but CAC_ADDR(xx)/P1SEGADDR(xx) is defined as below
>
> CAC_ADDR(addr) =A0((addr) - uncached_start + PAGE_OFFSET)
> P1SEGADDR(a) =A0 =A0((__typeof__(a))(((unsigned long)(a) & 0x1fffffff) | =
P1SEG))
>
> I guess this "ret" should be uncached area if dma_cache_sync(xx) use CAC_=
ADDR(xx).
>
> If I apply below patch, Ecovec start works without crash, but I'm not sur=
e.
> Is this correct patch ?
>
> --------------------
> diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
> index f251b5f..198234a 100644
> --- a/arch/sh/mm/consistent.c
> +++ b/arch/sh/mm/consistent.c
> @@ -48,7 +48,7 @@ void *dma_generic_alloc_coherent(struct device *dev, si=
ze_t si
> =A0 =A0 =A0 =A0 * Pages from the page allocator may have data present in
> =A0 =A0 =A0 =A0 * cache. So flush the cache before using uncached memory.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);
> + =A0 =A0 =A0 dma_cache_sync(dev, UNCAC_ADDR(ret), size, DMA_BIDIRECTIONA=
L);
>
> =A0 =A0 =A0 =A0ret_nocache =3D (void __force *)ioremap_nocache(virt_to_ph=
ys(ret), size);
> =A0 =A0 =A0 =A0if (!ret_nocache) {
> -------------------------
>
> But I'm afraid below comment of dma_generic_alloc_coherent()
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Pages from the page allocator may have data present in
> =A0 =A0 =A0 =A0 * cache. So flush the cache before using uncached memory.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0dma_cache_sync(dev, ret, size, DMA_BIDIRECTIONAL);
>
>
> Best regards
> ---
> Kuninori Morimoto
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Nobuhiro Iwamatsu
