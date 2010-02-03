From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 03 Feb 2010 17:58:45 +0000
Subject: Re: [PATCH 2/3 v3] sh: fix Transfer Size calculation in both DMA
Message-Id: <4B69B955.8080001@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002011958290.4617@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dan Williams wrote:
>>  arch/sh/drivers/dma/dma-sh.c           |    5 +-
> 
> This bit collides with 9d56dd3b "sh: Mass ctrl_in/outX to 
> __raw_read/writeX conversion." in Paul's tree.  I'm fine with these 
> going through the sh tree with my acked-by modulo that minor nit with 
> the dma_list_mutex comment in 3/3.

The other option would be for me to base async_tx.git/next on top of 
sh.git/master since my tree appears later in the linux-next merge order 
  (I would then make sure I merge after Paul during the .34 window). 
The only problem is that this removes the luxury of Paul rebasing the sh 
tree at his leisure (I would need to rebase as well before the result is 
seen by linux-next).  So I'll remain in ack-only mode on this set unless 
Paul signals that sh.git does not rebase.

--
Dan

