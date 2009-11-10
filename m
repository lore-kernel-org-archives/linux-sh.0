From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 10 Nov 2009 09:49:03 +0000
Subject: Re: [PATCH v7 ] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <Pine.LNX.4.64.0911101026160.5074@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4AA47D5F.8060204@renesas.com>
In-Reply-To: <4AA47D5F.8060204@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all

On Mon, 7 Sep 2009, Nobuhiro Iwamatsu wrote:

> Hi,
> 
> Dan Williams wrote:
> 
> > Yes, the locking looks better in this version.  Can you respin this
> > patch against async_tx.git/next [1]?  The 'tx_list' field of struct
> > dma_async_tx_descriptor is set to be removed in 2.6.32, so you need to
> > define it locally in struct sh_desc.  Once that is done and you get an
> > ack from Paul I will add this to the queue for 2.6.32.
> > 
> 
> I remove tx_list from source and check working. This work fine.
> I resend patch.
> 
> Paul, could you check and ack this patch?

got a question to this driver: so far it only exports the DMA_MEMCPY 
capability. But the DMAC is also serving various onboard and external 
peripherals, which is normally done using the DMA_SLAVE capability. Is 
this what is supported by this driver using the .set_chcr() and 
.set_dmars() API extensions? Wouldn't it be better to switch to DMA_SLAVE 
and replace those callbacks with just some static channel parameters, 
provided by the board? Isn't providing those callbacks also dangerous, 
because you don't know in what context the user is calling them so, you 
cannot ensure proper locking?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
