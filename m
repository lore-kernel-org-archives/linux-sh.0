Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D65C433E0
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D024B22227
	for <linux-sh@archiver.kernel.org>; Mon, 18 Jan 2021 20:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390390AbhARUTa (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:19:30 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:38671 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390162AbhARUTH (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Mon, 18 Jan 2021 15:19:07 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l1aym-001vcD-Ql; Mon, 18 Jan 2021 21:18:24 +0100
Received: from p5b13a61e.dip0.t-ipconnect.de ([91.19.166.30] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l1aym-001gGz-3R; Mon, 18 Jan 2021 21:18:24 +0100
Subject: Re: [PATCH] sh: remove CONFIG_IDE from most defconfig
To:     Christoph Hellwig <hch@lst.de>, ysato@users.sourceforge.jp,
        dalias@libc.org
Cc:     linux-sh@vger.kernel.org
References: <20200924043139.522028-1-hch@lst.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <11317ded-4ac1-f8e4-0303-1fadb55d1a5a@physik.fu-berlin.de>
Date:   Mon, 18 Jan 2021 21:18:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20200924043139.522028-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.166.30
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

Hello!

On 9/24/20 6:31 AM, Christoph Hellwig wrote:
> Remove CONFIG_IDE from defconfigs that did not actually select chipset
> drivers, and switch ones that have libata drivers to libata.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
> index f0073ed3994771..48b457d59e790a 100644
> --- a/arch/sh/configs/sh03_defconfig
> +++ b/arch/sh/configs/sh03_defconfig
> ---
>  arch/sh/configs/landisk_defconfig  | 9 ++++-----
>  arch/sh/configs/microdev_defconfig | 2 --
>  arch/sh/configs/sdk7780_defconfig  | 6 ++----
>  arch/sh/configs/sdk7786_defconfig  | 3 ---
>  arch/sh/configs/se7750_defconfig   | 1 -
>  arch/sh/configs/sh03_defconfig     | 3 ---
>  6 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/sh/configs/landisk_defconfig b/arch/sh/configs/landisk_defconfig
> index ba6ec042606f5d..e6c5ddf070c008 100644
> --- a/arch/sh/configs/landisk_defconfig
> +++ b/arch/sh/configs/landisk_defconfig
> @@ -27,13 +27,12 @@ CONFIG_NETFILTER=y
>  CONFIG_ATALK=m
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=y
> -CONFIG_BLK_DEV_OFFBOARD=y
> -CONFIG_BLK_DEV_GENERIC=y
> -CONFIG_BLK_DEV_AEC62XX=y
> +CONFIG_ATA=y
> +CONFIG_ATA_GENERIC=y
> +CONFIG_PATA_ATP867X=y
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
> +CONFIG_BLK_DEV_SR=y
>  CONFIG_SCSI_MULTI_LUN=y
>  CONFIG_MD=y
>  CONFIG_BLK_DEV_MD=m
> diff --git a/arch/sh/configs/microdev_defconfig b/arch/sh/configs/microdev_defconfig
> index c65667d00313ba..e9825196dd66af 100644
> --- a/arch/sh/configs/microdev_defconfig
> +++ b/arch/sh/configs/microdev_defconfig
> @@ -20,8 +20,6 @@ CONFIG_IP_PNP=y
>  # CONFIG_IPV6 is not set
>  # CONFIG_FW_LOADER is not set
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=y
>  CONFIG_NETDEVICES=y
>  CONFIG_NET_ETHERNET=y
>  CONFIG_SMC91X=y
> diff --git a/arch/sh/configs/sdk7780_defconfig b/arch/sh/configs/sdk7780_defconfig
> index d10a0414123a51..d00376eb044f8a 100644
> --- a/arch/sh/configs/sdk7780_defconfig
> +++ b/arch/sh/configs/sdk7780_defconfig
> @@ -44,16 +44,14 @@ CONFIG_NET_SCHED=y
>  CONFIG_PARPORT=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=y
> -CONFIG_BLK_DEV_PLATFORM=y
> -CONFIG_BLK_DEV_GENERIC=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
>  CONFIG_CHR_DEV_SG=y
>  CONFIG_SCSI_SPI_ATTRS=y
>  CONFIG_SCSI_FC_ATTRS=y
>  CONFIG_ATA=y
> +CONFIG_ATA_GENERIC=y
> +CONFIG_PATA_PLATFORM=y
>  CONFIG_MD=y
>  CONFIG_BLK_DEV_DM=y
>  CONFIG_NETDEVICES=y
> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_defconfig
> index 61bec46ebd66a8..4a44cac640bc94 100644
> --- a/arch/sh/configs/sdk7786_defconfig
> +++ b/arch/sh/configs/sdk7786_defconfig
> @@ -116,9 +116,6 @@ CONFIG_MTD_UBI_GLUEBI=m
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_CRYPTOLOOP=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=y
> -CONFIG_BLK_DEV_PLATFORM=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_BLK_DEV_SR=y
>  CONFIG_SCSI_MULTI_LUN=y
> diff --git a/arch/sh/configs/se7750_defconfig b/arch/sh/configs/se7750_defconfig
> index 3f1c13799d799c..4defc7628a498a 100644
> --- a/arch/sh/configs/se7750_defconfig
> +++ b/arch/sh/configs/se7750_defconfig
> @@ -29,7 +29,6 @@ CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_CFI=y
>  CONFIG_MTD_CFI_AMDSTD=y
>  CONFIG_MTD_ROM=y
> -CONFIG_IDE=y
>  CONFIG_SCSI=y
>  CONFIG_NETDEVICES=y
>  CONFIG_NET_ETHERNET=y
> diff --git a/arch/sh/configs/sh03_defconfig b/arch/sh/configs/sh03_defconfig
> index f0073ed3994771..48b457d59e790a 100644
> --- a/arch/sh/configs/sh03_defconfig
> +++ b/arch/sh/configs/sh03_defconfig
> @@ -39,9 +39,6 @@ CONFIG_IP_PNP_RARP=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_NBD=y
>  CONFIG_BLK_DEV_RAM=y
> -CONFIG_IDE=y
> -CONFIG_BLK_DEV_IDECD=m
> -CONFIG_BLK_DEV_IDETAPE=m
>  CONFIG_SCSI=m
>  CONFIG_BLK_DEV_SD=m
>  CONFIG_BLK_DEV_SR=m

Seems this has fallen off the table. What about the change that Geert suggested
with regards the LANDISK board?

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

