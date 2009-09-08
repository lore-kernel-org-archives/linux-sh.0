From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 08 Sep 2009 03:54:39 +0000
Subject: Re: [PATCH v7 ] dmaengine: sh: Add Support SuperH DMA Engine driver
Message-Id: <20090908035439.GA8711@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4AA47D5F.8060204@renesas.com>
In-Reply-To: <4AA47D5F.8060204@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 07, 2009 at 12:26:23PM +0900, Nobuhiro Iwamatsu wrote:
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
> 
Acked-by: Paul Mundt <lethal@linux-sh.org>
