From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Mon, 24 Aug 2015 10:44:15 +0000
Subject: Re: [PATCH 24/25 v7][RFC] Local: Hack: of: Limit FDT size for CRC check on arm64
Message-Id: <55DAF57F.3050202@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twrp5si9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twrp5si9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

Thanks for your patch.

I wonder this patch is really needed for Gen3 support.
The commit log and the referred weblink discussed about
the issue of UEFI firmware boot up non-EFI kernel on Juno board.

In the meantime, I guess UEFI support is out of Gen3 support scope.
Then, maybe, we don't need this patch.

Could you try kernel boot without this patch ?

Thanks.

On 8/24/2015 9:32 AM, Kuninori Morimoto wrote:
> From: Jon Medhurst <tixy@linaro.org>
>
> There is a bug in the UEFI implementation used on Juno and 64-bit
> FVPs which corrupts the reported size of the FDT. Work around this
> by limiting the size for CRC checks to 2MB.
>
> See http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/310106.html
>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> ---
> v5 -> v7
>
>   - no change
>
>   drivers/of/fdt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index 07496560..53f8c82 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -28,6 +28,12 @@
>   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>   #include <asm/page.h>
>
> +#ifdef CONFIG_ARM64
> +#define fdt_crc_size_hack(_s)	min(fdt_totalsize(_s),(unsigned)0x200000)
> +#else
> +#define fdt_crc_size_hack(_s)	fdt_totalsize(_s)
> +#endif
> +
>   /*
>    * of_fdt_limit_memory - limit the number of regions in the /memory node
>    * @limit: maximum entries
> @@ -1059,7 +1065,7 @@ bool __init early_init_dt_verify(void *params)
>   	/* Setup flat device-tree pointer */
>   	initial_boot_params = params;
>   	of_fdt_crc32 = crc32_be(~0, initial_boot_params,
> -				fdt_totalsize(initial_boot_params));
> +				fdt_crc_size_hack(initial_boot_params));
>   	return true;
>   }
>
> @@ -1155,7 +1161,7 @@ static int __init of_fdt_raw_init(void)
>   		return 0;
>
>   	if (of_fdt_crc32 != crc32_be(~0, initial_boot_params,
> -				     fdt_totalsize(initial_boot_params))) {
> +				     fdt_crc_size_hack(initial_boot_params))) {
>   		pr_warn("fdt: not creating '/sys/firmware/fdt': CRC check failed\n");
>   		return 0;
>   	}
>
