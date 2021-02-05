Return-Path: <linux-sh-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC463C433DB
	for <linux-sh@archiver.kernel.org>; Fri,  5 Feb 2021 20:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D4D64E30
	for <linux-sh@archiver.kernel.org>; Fri,  5 Feb 2021 20:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhBES3D (ORCPT <rfc822;linux-sh@archiver.kernel.org>);
        Fri, 5 Feb 2021 13:29:03 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:4297 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbhBEPNQ (ORCPT
        <rfc822;linux-sh@vger.kernel.org>); Fri, 5 Feb 2021 10:13:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B601d778b0000>; Fri, 05 Feb 2021 08:51:23 -0800
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 16:51:22 +0000
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Feb
 2021 16:51:18 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 5 Feb 2021 16:51:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrKMI8+DM+eoH6up4Cz7WmTU+VMziCYUNlYcJyjKO+wYt8heEPCRoVuv3kQ+3B1RyGwRACvQFekPdcg/jzo1ggUaGfFMPeF3yZ84zxHVJba4bkvGaGc59l0ispnMKulc52LXKQm1+KB0EU/Uv8DSweZHYHQg1+EzUViW+DmVEaeXj481AEQVFV9NXJmPp7z7BPYJLrdC2iuIsIa+4a4gokiwHKnGB+wXxh1Lwn57WOOiPvhooHliX/S0FRVB+AuSJOVXv6ZxmHY29LDGLOkPoQlXAqFK25uIokmzVgiYsDxzS6D/iKFe/mGJ43vFVOsGjKrs7eg/1fmJvMhXJuYAQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1LS3cG1cQTFsLvem3P2GfggAuj5MfjtrblP3tNTGmuw=;
 b=SREeU8bOiqbx43hTeVCbPWNha6PgZCn5RjBMUhXvheVotXWci1e/2gSiDz26NQMLUHOTegObhRvyE2Opsf9Hi7+SwzBBYunIUgWU5vMiulziwBQCP+5hbb8bmSedhPpZ3mfcssuBc16YEuAaahnu0fv+VfxTepPbamh8G5kXkEpP3QsTyH6v/1qhSFHJVyhHZ+A2Exyty6P8Lgijh2jQdw+eemzp1kYW5rwVavlfMQdbrlHhsOVbGfUet04elRDk56SwDCvaB4dOGCv4A4jSQUvjbrZ3uF85ix4zwND2+r6pUN2jwcZDknwwt5Qk1tVV/bRl7HMEdZ6LqDZAVlW+aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.24; Fri, 5 Feb
 2021 16:51:15 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3825.025; Fri, 5 Feb 2021
 16:51:15 +0000
Date:   Fri, 5 Feb 2021 12:51:13 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>
CC:     Avihai Horon <avihaih@nvidia.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>
Subject: Re: drivers/infiniband/core/uverbs_std_types_device.c:299:29:
 sparse: sparse: incorrect type in argument 1 (different address spaces)
Message-ID: <20210205165113.GV4247@nvidia.com>
References: <202102020130.LmreFXR5-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202102020130.LmreFXR5-lkp@intel.com>
X-ClientProxiedBy: BL0PR02CA0063.namprd02.prod.outlook.com
 (2603:10b6:207:3d::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0063.namprd02.prod.outlook.com (2603:10b6:207:3d::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Fri, 5 Feb 2021 16:51:14 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1l84K9-003xMG-Lh; Fri, 05 Feb 2021 12:51:13 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612543883; bh=1LS3cG1cQTFsLvem3P2GfggAuj5MfjtrblP3tNTGmuw=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=lIMD1UdrafM6UqUYoqsf3cJmfwcoJVmbTkiCyHZXs6GSvxxifYeZPEN46CBRqQCgf
         nGPJgDvyNaB8y3M6VN89ysmHrorlrmd1Yggnc7EYZdRxF9WmOqVncsfAmG+Qdi2acd
         zZlTp1fSqhmSIDeYEjwB2Dhuewq1qpCq8woa5/VsWFW9Y7Kq9Pfp6cGv7zu7tPManh
         mAO0ga3af6/E2F7fOeIzmCf39aWcnnuE4sMUZvNYwFb4dEiP9lXdXI25IN0NgfBqS8
         XXdZ1akLwQqukEApksqOsm1F8iG5oE9vpH//9+YksDWVK0FZ14ojg1qhf+NYOmId5q
         BATk3BGfFHm4A==
Precedence: bulk
List-ID: <linux-sh.vger.kernel.org>
X-Mailing-List: linux-sh@vger.kernel.org

On Tue, Feb 02, 2021 at 01:40:33AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1048ba83fb1c00cd24172e23e8263972f6b5d9ac
> commit: 9f85cbe50aa044a46f0a22fda323fa27b80c82da RDMA/uverbs: Expose the new GID query API to user space
> date:   4 months ago
> config: sh-randconfig-s031-20210201 (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.3-215-g0fb77bb6-dirty
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9f85cbe50aa044a46f0a22fda323fa27b80c82da
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 9f85cbe50aa044a46f0a22fda323fa27b80c82da
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> "sparse warnings: (new ones prefixed by >>)"
> >> drivers/infiniband/core/uverbs_std_types_device.c:299:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __user *__cl_addr @@
>    drivers/infiniband/core/uverbs_std_types_device.c:299:29: sparse:     expected void *addr
>    drivers/infiniband/core/uverbs_std_types_device.c:299:29: sparse:     got void [noderef] __user *__cl_addr
>    drivers/infiniband/core/uverbs_std_types_device.c:115:15: sparse: sparse: cast truncates bits from constant value (ffff0001 becomes 1)
>    drivers/infiniband/core/uverbs_std_types_device.c:195:15: sparse: sparse: cast truncates bits from constant value (ffffff01 becomes 1)

This is a bug in  arch/sh/include/asm/page.h:

__kernel_size_t __clear_user(void *addr, __kernel_size_t size);

#define clear_user(addr,n)						\
...
		__cl_size = __clear_user(__cl_addr, __cl_size);		\

__clear_user() needs to take a void __user *addr

Jason
