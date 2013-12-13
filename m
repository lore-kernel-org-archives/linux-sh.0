From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Dec 2013 08:51:00 +0000
Subject: Re: [PATCH] sh: Add EXPORT_SYMBOL(min_low_pfn) and EXPORT_SYMBOL(max_low_pfn) to sh_ksyms_32.c
Message-Id: <CAMuHMdVa_+aBK3qnSPLj9DrVGB_77y5t97idskR_cGTrc1N8Yw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1386893438-23573-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Dec 13, 2013 at 8:56 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 13 Dec 2013 09:10:38 +0900 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com> wrote:
>
>> Min_low_pfn and max_low_pfn were used in pfn_valid macro if defined
>> CONFIG_FLATMEM. When the functions that use the pfn_valid is used in driver
>> module, max_low_pfn and min_low_pfn is to undefined, and fail to build.
>>
>> ----
>> ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
>> ERROR: "max_low_pfn" [drivers/block/aoe/aoe.ko] undefined!
>
> This could be a sign that the aoe driver is doing something which it
> shouldn't be doing.
>
> z:/usr/src/25> grep pfn drivers/block/aoe/*.[ch]
> z:/usr/src/25>
>
> Confused.  Can you please work out precisely where in AOE this
> reference is occurring?

From my patch for mips, it's due to virt_addr_valid(), which calls pfn_valid()
on most architectures, cfr.
http://marc.info/?l=linux-kernel&m5672726823050&w=1.

Note that Ralf decided to fix it differently, by uninlining virt_addr_valid:

commit d3ce88431892b703b04769566338a89eda6b0477
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Fri Dec 28 15:34:40 2012 +0100

    MIPS: Fix modpost error in modules attepting to use virt_addr_valid().

    ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!

    Fixed by moving the implementation of virt_addr_valid() into the kernel
    proper and exporting it which removes the pains of an inline or macro
    implementation.

    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
index bf84e48ad669..dbaec94046da 100644
--- a/arch/mips/include/asm/page.h
+++ b/arch/mips/include/asm/page.h
@@ -198,7 +198,10 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 #endif

 #define virt_to_page(kaddr)    pfn_to_page(PFN_DOWN(virt_to_phys(kaddr)))
-#define virt_addr_valid(kaddr) pfn_valid(PFN_DOWN(virt_to_phys(kaddr)))
+
+extern int __virt_addr_valid(const volatile void *kaddr);
+#define virt_addr_valid(kaddr)                                         \
+       __virt_addr_valid((const volatile void *) (kaddr))

 #define VM_DATA_DEFAULT_FLAGS  (VM_READ | VM_WRITE | VM_EXEC | \
                                 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index cacfd31e8ec9..7657fd21cd3f 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -190,3 +190,9 @@ void __iounmap(const volatile void __iomem *addr)

 EXPORT_SYMBOL(__ioremap);
 EXPORT_SYMBOL(__iounmap);
+
+int __virt_addr_valid(const volatile void *kaddr)
+{
+       return pfn_valid(PFN_DOWN(virt_to_phys(kaddr)));
+}
+EXPORT_SYMBOL_GPL(__virt_addr_valid);

BTW, ia64 exports both min_low_pfn and max_low_pfn,
metag exports min_low_pfn.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
