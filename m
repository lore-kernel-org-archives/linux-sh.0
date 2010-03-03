From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Wed, 03 Mar 2010 06:19:20 +0000
Subject: Re: [PATCH to v2.6.33] sh: Fix cannot booting zImage using
Message-Id: <29ab51dc1003022219r6702522du71286ef5654cfb2b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc1002150037i60fb846dt60a739cfddb39d08@mail.gmail.com>
In-Reply-To: <29ab51dc1002150037i60fb846dt60a739cfddb39d08@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi , Paul.

I'm sorry for this late reply.

2010/2/16 Paul Mundt <lethal@linux-sh.org>:
> On Mon, Feb 15, 2010 at 05:37:50PM +0900, Nobuhiro Iwamatsu wrote:
>> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/mi=
sc.c
>> index d509a50..5ff6dfc 100644
>> --- a/arch/sh/boot/compressed/misc.c
>> +++ b/arch/sh/boot/compressed/misc.c
>> @@ -117,7 +117,7 @@ void decompress_kernel(void)
>> =A0 =A0 =A0 output_addr =3D (CONFIG_MEMORY_START + 0x2000);
>> =A0#else
>> =A0 =A0 =A0 output_addr =3D __pa((unsigned long)&_text+PAGE_SIZE);
>> -#ifdef CONFIG_29BIT
>> +#if defined(CONFIG_29BIT) || defined(CONFIG_PMB_FIXED)
>> =A0 =A0 =A0 output_addr |=3D P2SEG;
>> =A0#endif
>> =A0#endif
>
> This isn't technically a regresion, since it obviously never worked
> before either. While we could do this for 2.6.33, things have already
> changed quite a bit for 2.6.34, and ideally we will have ripped out the
> fixed PMB mess entirely by 2.6.35. In light of its pending demise I'm
> not terribly inclined to merge stop-gap patches for single kernel
> versions.

I did wrong understanding.
I understood your point.

>
> Now, regarding fixed PMB.. The biggest issue with this scheme at the
> moment is that the boot loader sets up absurd mappings and wastes
> almost all of the PMB space in the process, as well as forcing P2 on us,
> none of which are things we want. The differences we have to contend with
> are the differing entry points, where we do the vmsplit, and where the
> uncached mapping is placed. Now that the uncached mapping is constructed
> following the cached one and simply maps a single page for kernel text we
> end up getting quite a bit of our address space back, even if it's only
> usable by the PMB. The entry point variations we still have to contend
> with, but we can abstract that more cleanly, and other non-PMB parts have
> a vested interest there as well. Variable vmsplit work is on-going, so
> that should be something else that pops up in the not so distant future.
>
> Initially I had considered tolerating the existence of fixed PMB mode,
> but the boot loader as usual doesn't seem to do anything of merit with
> the leeway that it's given, so the best course of action will simply be
> to blow away whatever the boot loader has done and have the kernel manage
> all of the mappings. We already have the transitioning logic in place, so
> with a bit of work we should be able to throw out the fixed PMB stuff
> entirely. Even on platforms that aren't going to use sparsemem vmemmap,
> the larger PCI windows mean we're going to be using up more vmalloc
> space, which we can at least pad a bit by stuffing spare P2 space in to a
> PMB-backed VMA to fix up transparent PMB use through ioremap(), which
> otherwise is virtual address space that the TLB can't touch.

I see.

Best regards,
  Nobuhiro


--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
