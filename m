From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 08:34:11 +0000
Subject: Re: [PATCH 00/05] SH-Mobile ARM dmaengine support V1
Message-Id: <20100323083411.GB30655@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044630.17051.16445.sendpatchset@t400s>
In-Reply-To: <20100319044630.17051.16445.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 01:46:30PM +0900, Magnus Damm wrote:
> [PATCH 01/05] dmaengine: shdma: Remove sh_dmae_slave_chan_id enum
> [PATCH 02/05] dmaengine: shdma: Common SH_DMA_SLAVE_NUMBER
> [PATCH 03/05] serial: sh-sci: Use sg_dma_len() and sg_dma_address()
> [PATCH 04/05] dmaengine: shdma: Introduce include/linux/sh_dma.h
> 
Ok, I've taken these in to the sh/dmaengine topic branch, particularly
since there's on-going work with the serial DMA stuff. I'll pull this in
to a topic branch in the genesis tree and apply the 5th one on top of
a bit later once I've dealt with the rest of the backlog.
