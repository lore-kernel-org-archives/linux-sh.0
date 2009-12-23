From: "Pietrek, Markus" <Markus.Pietrek@emtrion.de>
Date: Wed, 23 Dec 2009 08:38:10 +0000
Subject: AW: Probably cache synchronization issue on SH7723
Message-Id: <95F51F4B902CAC40AF459205F6322F0133E18561CD@BMK019S01.emtrion.local>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Matt,

update_mmu_cache() is called with vma =3D NULL in arch/sh/mm/fault_32.c. If=
 we then assume exec=3D1, the patch works fine.

diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index e9415d3..054bb8a 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -126,8 +126,10 @@ void __update_cache(struct vm_area_struct *vma,
 {
        struct page *page;
        unsigned long pfn =3D pte_pfn(pte);
+       /* flush any dirty data page before using it as a code page */
+       int exec =3D (vma !=3D NULL) ? (vma->vm_flags & VM_EXEC) : 1;

-       if (!boot_cpu_data.dcache.n_aliases)
+       if (!boot_cpu_data.dcache.n_aliases && !exec)
                return;

        page =3D pfn_to_page(pfn);
@@ -136,7 +138,7 @@ void __update_cache(struct vm_area_struct *vma,
                if (dirty) {
                        unsigned long addr =3D (unsigned long)page_address(=
page);

-                       if (pages_do_alias(addr, address & PAGE_MASK))
+                       if (exec || pages_do_alias(addr, address & PAGE_MAS=
K))
                                __flush_purge_region((void *)addr, PAGE_SIZ=
E);
                }
        }

Best regards,
Markus Pietrek

-----Urspr=FCngliche Nachricht-----
Von: Matt Fleming [mailto:matt@console-pimps.org]
Gesendet: Dienstag, 22. Dezember 2009 17:52
An: Pietrek, Markus
Cc: linux-sh@vger.kernel.org
Betreff: Re: Probably cache synchronization issue on SH7723

On Tue, Dec 22, 2009 at 05:18:16PM +0100, Pietrek, Markus wrote:
> Hi,
>
> Lacking some understanding of the caching system I'm not sure why in
> update_cache() some dirty pages are skipped. The following patch fixes
> my problem, but I'm not sure about any negative side effects.

Interesting! Good investigative work.

It's an optimisation so that we don't flush the dcache more than we need
to. There shouldn't be any negative side effects of your patch, it's
just a bit inefficient.

Having looked at the MIPS __update_cache() function I'm wondering if the
bug is that we should be flushing the cache if the page is executable.

Could you try this patch?

diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
index e9415d3..8460bbf 100644
--- a/arch/sh/mm/cache.c
+++ b/arch/sh/mm/cache.c
@@ -126,8 +126,9 @@ void __update_cache(struct vm_area_struct *vma,
 {
        struct page *page;
        unsigned long pfn =3D pte_pfn(pte);
+       int exec =3D (vma->vm_flags & VM_EXEC);

-       if (!boot_cpu_data.dcache.n_aliases)
+       if (!boot_cpu_data.dcache.n_aliases && !exec)
                return;

        page =3D pfn_to_page(pfn);
@@ -136,7 +137,7 @@ void __update_cache(struct vm_area_struct *vma,
                if (dirty) {
                        unsigned long addr =3D (unsigned long)page_address(=
page);

-                       if (pages_do_alias(addr, address & PAGE_MASK))
+                       if (exec || pages_do_alias(addr, address & PAGE_MAS=
K))
                                __flush_purge_region((void *)addr, PAGE_SIZ=
E);
                }
        }


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
