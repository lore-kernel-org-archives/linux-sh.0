From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 16 Mar 2011 00:37:50 +0000
Subject: Re: [PATCH 4/4 v4] mmc, ARM: Add zboot from eSD support for SuperH
Message-Id: <AANLkTimgwpP-WTGF-E=KO3TAXDX7FP4WnW3XQiHi0Ton@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1300071435-26759-1-git-send-email-horms@verge.net.au>
	<1300071435-26759-5-git-send-email-horms@verge.net.au>
	<20110315222738.GA23288@verge.net.au>
In-Reply-To: <20110315222738.GA23288@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Thanks for your work on this!

On Wed, Mar 16, 2011 at 7:27 AM, Simon Horman <horms@verge.net.au> wrote:
> This allows a ROM-able zImage to be written to eSD and for SuperH Mobile
> ARM to boot directly from the SDHI hardware block.
>
> This is achieved by the MaskROM loading the first portion of the image in=
to
> MERAM and then jumping to it. =A0This portion contains loader code which
> copies the entire image to SDRAM and jumps to it. From there the zImage
> boot code proceeds as normal, uncompressing the image into its final
> location and then jumping to it.
>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
>
> ---
>
> This patch is based on the for-next branch of
> Russell King's linux-2.6-arm tree
>
> v2
> * Consistently use __raw_readw(). As pointed out by Paul Mundt
>
> v3
> * Remove mmcif_update_progress2(), it was for debugging during development
> * Move CPU specific code into mach/sdhi.h
> =A0As requested by Magnus Damm
> * Use linux/mmc/tmio.h now that it exists
> * Remove SDHI_EXT_SWAP, it is unused
> * Replace use of MMCIF_PROGRESS_* with MMC_PROGRESS_*
> * Don't include linux/mmc/sh_mmcif.h
> =A0+ Replace use of MMCIF_CE_RESP_CMD12 with RESP_CMD12
> =A0+ Include linux/io.h
>
> v4
> * Move definition of SDHI_BASE into CPU-specific code.
> =A0Thanks to Magnus Damm.
> ---

> +asmlinkage void mmc_loader(unsigned short *buf, unsigned long len)
> +{
> + =A0 =A0 =A0 int high_capacity;
> +
> + =A0 =A0 =A0 mmc_init_progress();
> +
> + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_ENTER);
> + =A0 =A0 =A0 sdhi_boot_enter();
> +
> + =A0 =A0 =A0 /* setup SDHI hardware */
> + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_INIT);
> + =A0 =A0 =A0 high_capacity =3D sdhi_boot_init(SDHI_BASE);
> + =A0 =A0 =A0 if (high_capacity < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_LOAD);
> + =A0 =A0 =A0 /* load kernel */
> + =A0 =A0 =A0 if (sdhi_boot_do_read(SDHI_BASE, high_capacity,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, /* Kernel is=
 at block 1 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (len + TMIO_BBS=
 - 1) / TMIO_BBS, buf))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;
> +
> + =A0 =A0 =A0 sdhi_boot_cleanup();
> +
> + =A0 =A0 =A0 mmc_update_progress(MMC_PROGRESS_DONE);
> +
> + =A0 =A0 =A0 return;
> +err:
> + =A0 =A0 =A0 __raw_writel(__raw_readl(PORTR031_000DR) | 1, PORTR031_000D=
R);
> + =A0 =A0 =A0 for(;;);
> +
> +}

Sorry for not catching this earlier, but this __raw_writel() to
PORTR031_000DR is cpu specific as well. So please move that to the CPU
specific code.

Not sure if it makes sense at this point, but perhaps it's a good idea
to move the mmc_loader() function into the CPU specific portion. As
you know, the CPU itself has multiple SDHI hardware blocks, and
because of that we want the common SDHI loader to be written to
support any SDHI hardware block instance.

Right now the SDHI_BASE variable is limiting the shared SDHI loader
code to a fixed hardware block instance. That's fine because we only
boot from a single SDHI hardware block instance on sh7372, but future
processors most likely support selecting boot SDHI hardware block
instance.

Apart from those minor bits I think the code is getting into a really
good shape!

Thanks,

/ magnus
