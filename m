From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Date: Thu, 14 Feb 2008 16:42:32 +0000
Subject: Re: ioremap() on SH
Message-Id: <cda58cb80802140842x7aaf49cdw59dad74276df4ed1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
In-Reply-To: <cda58cb80802140636i69449582v6ecc03449df46b02@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu 14/02 23:57, Paul Mundt wrote:
> On Thu, Feb 14, 2008 at 03:36:31PM +0100, Franck Bui-Huu wrote:
> > I'm puzzled by the implementation of ioremap() on SH architecture.
> >
> > Here it is:
> >
> >         if (likely(PXSEG(offset) < P3SEG && PXSEG(last_addr) < P3SEG)) {
> >                 if (unlikely(flags & _PAGE_CACHABLE))
> >                         return (void __iomem *)P1SEGADDR(offset);
> >
> >                 return (void __iomem *)P2SEGADDR(offset);
> >         }
> >
> >         return __ioremap(offset, size, flags);
> >
> > where 'offset' is a physical address...
> >
> > If I understand correctly PXSEG(x) is used to get the segment of a
> > _virtual_ address, so doing PXSEG(offset) looks weird.
> >
> In 29-bit physical mode, there is no real differentiation. P1 and P2 are
> both non-translatable sections that refer to the low 512M (P1 is cached,
> and P2 is uncached). If you're using the MIPS terminology, these are
> KSEG0 and KSEG1 respectively. In the nommu context the logic is
> simplified since we don't really have that sort of segmentation, so
> there's still a direct 1:1 correlation between physical and virtual there
> also. Thus, we can take a P2 address with a cached remap and hand back
> the P1 equivalent, and vice versa for cached->uncached transitions.
>
> Page table mappings are only used for certain parts of P3 and other parts
> of the address space. There are also non-translatable holes in the
> address space further along that need special care, so there is further
> special casing for those.
>
> The comment above the __ioremap() prototype attempts to clarify some of
> this. There are additional notes in arch/sh/mm/ioremap_32.c as well,
> mostly relating to the special casing in the P3 address space.
>
> There are also cases where address space behaviour is determined by
> special PTE bits relative to a given chip-select. PCMCIA and CF via area
> 5 and area 6 are examples of this, and are traditionally why P3 remapping
> requires special handling. Other P3 addresses don't generally require
> special casing, and can use fairly standard page table mapping.
>
> sh64 on the other hand accomplishes similar behaviour through the mapping
> of 512M superpages in the DTLB (using wired entries), which can be seen
> in arch/sh/kernel/head_64.S.
>
> Hope that helps.

Hm, not really, I'm afraid.

Unfortunately I don't see how it addresses the points I raised:

What does PXSEG(offset) mean if 'offset' is a physical address ?

From my understanding this macro used to retreive a *virtual* address
segment from a *virtual* address. However PXSEG(offset) retrieves the
*virtual* address segment from a *physical* address which seems a no
sense.

Why doing the following test "PXSEG(offset) < P3SEG" where P3SEG yields
to 0xc0000000. If offset is 0xa0000000 for example, assuming that 32 bits
physical mode exists, what's ioremap returning ?

                Franck
