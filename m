From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Date: Fri, 25 Sep 2020 08:30:37 +0000
Subject: Re: [PATCH] sh: remove CONFIG_IDE from most defconfig
Message-Id: <573773d1-89ca-1d99-9aaf-dc27fd58eaaa@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200924043139.522028-1-hch@lst.de>
In-Reply-To: <20200924043139.522028-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello!

On 24.09.2020 7:31, Christoph Hellwig wrote:

> Remove CONFIG_IDE from defconfigs that did not actually select chipset
> drivers, and switch ones that have libata drivers to libata.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
[...]
> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
> index 61bec46ebd66a8..4a44cac640bc94 100644
> --- a/arch/sh/configs/sdk7786_defconfig
> +++ b/arch/sh/configs/sdk7786_defconfig
> @@ -116,9 +116,6 @@ CONFIG_MTD_UBI_GLUEBI=m
>   CONFIG_BLK_DEV_LOOP=y
>   CONFIG_BLK_DEV_CRYPTOLOOP=y
>   CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=y
> -CONFIG_BLK_DEV_PLATFORM=y

    How about CONFIG_PATA_PLATFORM=y here?

>   CONFIG_BLK_DEV_SD=y
>   CONFIG_BLK_DEV_SR=y
>   CONFIG_SCSI_MULTI_LUN=y
[...]

MBR, Sergei
