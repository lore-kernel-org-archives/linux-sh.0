From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 15 Oct 2009 06:05:32 +0000
Subject: Re: [PATCH 04/14] sh: Obliterate the P1 area macros
Message-Id: <aec7e5c30910142305l1439f5e4p6750a208a8de41dc@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
In-Reply-To: <22db0c702ba4b19699c05c38c26a6061bd0bbf40.1254861984.git.matt@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Matt,

[CC Morimoto-san]

Thanks for your work on this!

On Wed, Oct 7, 2009 at 6:22 AM, Matt Fleming <matt@console-pimps.org> wrote:
> Replace the use of PHYSADDR() with __pa(). PHYSADDR() is based on the
> idea that all addresses in P1SEG are untranslated, so we can access an
> address's physical page as an offset from P1SEG. This doesn't work for
> CONFIG_PMB/CONFIG_PMB_FIXED because pages in P1SEG and P2SEG are used
> for PMB mappings and so can be translated to any physical address.
>
> Likewise, replace a P1SEGADDR() use with virt_to_phys().
>
> Signed-off-by: Matt Fleming <matt@console-pimps.org>
> ---
> =A0arch/sh/boot/compressed/misc.c =A0| =A0 =A02 +-
> =A0arch/sh/include/asm/addrspace.h | =A0 =A03 ---
> =A0arch/sh/kernel/machine_kexec.c =A0| =A0 =A02 +-
> =A0arch/sh/mm/cache-sh4.c =A0 =A0 =A0 =A0 =A0| =A0 =A04 ++--
> =A0arch/sh/mm/cache-sh7705.c =A0 =A0 =A0 | =A0 =A02 +-
> =A05 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/sh/boot/compressed/misc.c b/arch/sh/boot/compressed/mis=
c.c
> index fd56a71..b51b1fc 100644
> --- a/arch/sh/boot/compressed/misc.c
> +++ b/arch/sh/boot/compressed/misc.c
> @@ -131,7 +131,7 @@ void decompress_kernel(void)
> =A0#ifdef CONFIG_SUPERH64
> =A0 =A0 =A0 =A0output_addr =3D (CONFIG_MEMORY_START + 0x2000);
> =A0#else
> - =A0 =A0 =A0 output_addr =3D PHYSADDR((unsigned long)&_text+PAGE_SIZE);
> + =A0 =A0 =A0 output_addr =3D __pa((unsigned long)&_text+PAGE_SIZE);
> =A0#ifdef CONFIG_29BIT
> =A0 =A0 =A0 =A0output_addr |=3D P2SEG;
> =A0#endif
> diff --git a/arch/sh/include/asm/addrspace.h b/arch/sh/include/asm/addrsp=
ace.h
> index 80d4081..ebd6e49 100644
> --- a/arch/sh/include/asm/addrspace.h
> +++ b/arch/sh/include/asm/addrspace.h
> @@ -28,9 +28,6 @@
> =A0/* Returns the privileged segment base of a given address =A0*/
> =A0#define PXSEG(a) =A0 =A0 =A0 (((unsigned long)(a)) & 0xe0000000)
>
> -/* Returns the physical address of a PnSEG (n=3D1,2) address =A0 */
> -#define PHYSADDR(a) =A0 =A0(((unsigned long)(a)) & 0x1fffffff)
> -
> =A0#if defined(CONFIG_29BIT) || defined(CONFIG_PMB_FIXED)
> =A0/*
> =A0* Map an address to a certain privileged segment
> diff --git a/arch/sh/kernel/machine_kexec.c b/arch/sh/kernel/machine_kexe=
c.c
> index 7ea2704..de7cf54 100644
> --- a/arch/sh/kernel/machine_kexec.c
> +++ b/arch/sh/kernel/machine_kexec.c
> @@ -49,7 +49,7 @@ int machine_kexec_prepare(struct kimage *image)
> =A0 =A0 =A0 =A0/* older versions of kexec-tools are passing
> =A0 =A0 =A0 =A0 * the zImage entry point as a virtual address.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (image->start !=3D PHYSADDR(image->start))
> + =A0 =A0 =A0 if (image->start !=3D __pa(image->start))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL; /* upgrade your kexec-tool=
s */
>
> =A0 =A0 =A0 =A0return 0;

This change unfortunately breaks kexec. The PHYSADDR() macro masks but
__pa() subtracts so this breaks the physical address case.

Do you have any idea how to keep the previous behaviour? Worst case we
can just remove this check - it's been a while since I updated
kexec-tools now.

Cheers,

/ magnus
