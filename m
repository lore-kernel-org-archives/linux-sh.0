From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 26 Dec 2019 11:03:55 +0000
Subject: Re: [PATCH] scsi: don't memset to zero after dma_alloc_coherent
Message-Id: <a3b27b94-1ab6-c33f-611c-56143fd390f8@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191225132327.7121-1-yukuai3@huawei.com>
In-Reply-To: <20191225132327.7121-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yu kuai <yukuai3@huawei.com>, ysato@users.sourceforge.jp, dalias@libc.org, aacraid@microsemi.com, jejb@linux.ibm.com, martin.petersen@oracle.com, sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com, suganath-prabu.subramani@broadcom.com
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, zhengbin13@huawei.com, yi.zhang@huawei.com

Hello!

On 25.12.2019 16:23, yu kuai wrote:

> dma_alloc_coherent already zeros out memory, so memset to zero is not
> needed.
> 
> Signed-off-by: yu kuai <yukuai3@huawei.com>
> ---
>   arch/sh/mm/consistent.c             | 2 --

    How this one is related to SCSI?

>   drivers/scsi/dpt_i2o.c              | 4 ----
>   drivers/scsi/mpt3sas/mpt3sas_base.c | 1 -
>   drivers/scsi/mvsas/mv_init.c        | 4 ----
>   drivers/scsi/pmcraid.c              | 1 -
>   5 files changed, 12 deletions(-)
[...]

MBR, Sergei
