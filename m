From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Feb 2014 11:32:32 +0000
Subject: Re: [PATCH] ARM: shmobile: set proper DMA masks for Ether devices
Message-Id: <52FB5BD0.10707@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201402120255.25037.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 12-02-2014 5:35, Simon Horman wrote:

>> Ether MAC is a DMA-capable device and so should have 'dev.dma_mask' and
>> 'dev.coherent_dma_mask' fields set properly, to reflect 32-bit DMA addressing
>> ability.  Currently, the code works without DMA masks but in the future, when
>> support for NETIF_F_HIGHDMA & NETIF_F_SG would be added to the 'sh_eth' driver,
>> the DMA masks should start to matter...

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> Hi Sergei,

> please split this series up so there is a separate patch for each board.

    Hm, I, contrariwise, gathered all board patches in the single patch. Could 
you elaborate on why you deem it necessary to split it?

> Thanks

WBR, Sergei

