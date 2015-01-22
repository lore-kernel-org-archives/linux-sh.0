From: Simon Horman <horms@verge.net.au>
Date: Thu, 22 Jan 2015 02:19:14 +0000
Subject: Re: [PATCH v2] ARM: shmobile: No R-Car Gen2 CMA reservation when HIGHMEM=n
Message-Id: <20150122021913.GA31170@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150121050137.8410.36127.sendpatchset@little-apple>
In-Reply-To: <20150121050137.8410.36127.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Jan 21, 2015 at 02:01:37PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>=20
> Allow R-Car Gen2 platforms to boot with CMA enabled
> and HIGHMEM disabled. This patch adds code to check
> if the R-Car Gen2 specific memory reservation window
> is included in the kernel memory range or not. When
> HIGHMEM is disabled the R-Car Gen2 reservation area is
> outside the kernel memory range and in such case the
> memory reservation is simply skipped over.
>=20
> Without this patch the kernel boot hangs when CMA is
> enabled and HIGHMEM is disabled on the r8a7791 Koelsch
> hardware platform:
>=20
>     WARNING: CPU: 1 PID: 1 at mm/cma.c:113 cma_init_reserved_areas+0x88/0=
x1d4()
>     ...
>     WARNING: CPU: 1 PID: 1 at mm/cma.c:121 cma_init_reserved_areas+0xf8/0=
x1d4()
>     ...
>     Unable to handle kernel NULL pointer dereference at virtual address 0=
0000160
>     pgd =3D c0003000
>     [00000160] *pgd=80000040004003, *pmd=00000000
>     Internal error: Oops: 206 [#1] SMP ARM
>     Modules linked in:
>     CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
> 3.19.0-rc4-koelsch-01450-g7f9b6075ce12c3ea-dirty #735
>     Hardware name: Generic R8A7791 (Flattened Device Tree)
>     task: edc553c0 ti: edc56000 task.ti: edc56000
>     PC is at set_pfnblock_flags_mask+0x54/0xa0
>     LR is at 0x440
>=20
> In the current shmobile_defconfig HIGHMEM is enabled
> while CMA is disabled, so to trigger this the kernel
> configuration for both CMA and HIGHMEM needs to be
> adjusted.
>=20
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up for v3.21.

> ---
>=20
>  Changes since V1:
>  - Included error log and Tested-by from Geert - thanks!
>=20
>  Written on top of renesas-devel-20150114v2-v3.19-rc4
> =20
>  arch/arm/mach-shmobile/setup-rcar-gen2.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> --- 0001/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ work/arch/arm/mach-shmobile/setup-rcar-gen2.c	2015-01-15 14:20:47.089=
397114 +0900
> @@ -21,6 +21,7 @@
>  #include <linux/dma-contiguous.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/memblock.h>
>  #include <linux/of.h>
>  #include <linux/of_fdt.h>
>  #include <asm/mach/arch.h>
> @@ -197,7 +198,7 @@ void __init rcar_gen2_reserve(void)
> =20
>  	of_scan_flat_dt(rcar_gen2_scan_mem, &mrc);
>  #ifdef CONFIG_DMA_CMA
> -	if (mrc.size)
> +	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size))
>  		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
>  					    &rcar_gen2_dma_contiguous, true);
>  #endif
>=20
