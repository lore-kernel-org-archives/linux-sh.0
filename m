From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 26 Dec 2019 11:16:58 +0000
Subject: Re: [PATCH] scsi: don't memset to zero after dma_alloc_coherent
Message-Id: <68771eb5-03c4-422b-9956-930a0e3c9de8@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191225132327.7121-1-yukuai3@huawei.com>
 <a3b27b94-1ab6-c33f-611c-56143fd390f8@cogentembedded.com>
 <958ffbe5-f3da-da16-9f2b-05923d13485b@huawei.com>
In-Reply-To: <958ffbe5-f3da-da16-9f2b-05923d13485b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "yukuai (C)" <yukuai3@huawei.com>, ysato@users.sourceforge.jp, dalias@libc.org, aacraid@microsemi.com, jejb@linux.ibm.com, martin.petersen@oracle.com, sathya.prakash@broadcom.com, chaitra.basappa@broadcom.com, suganath-prabu.subramani@broadcom.com
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, MPT-FusionLinux.pdl@broadcom.com, zhengbin13@huawei.com, yi.zhang@huawei.com

On 26.12.2019 14:13, yukuai (C) wrote:

>>> dma_alloc_coherent already zeros out memory, so memset to zero is not
>>> needed.
>>>
>>> Signed-off-by: yu kuai <yukuai3@huawei.com>
>>> ---
>>>   arch/sh/mm/consistent.c             | 2 --
>>
>>     How this one is related to SCSI?
>>
> Thank you for your response!
> I put them in the same patch because I thougt they are the same situation. I'm 
> sorry if it's not appropriate.

    I'd recommend to split such patch to (at least) different subsystems, e.g. 
arch/sh/ part, drivers/scsi/ part.

> Yu Kuai

MBR, Sergei
