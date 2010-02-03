From: Dan Williams <dan.j.williams@intel.com>
Date: Wed, 03 Feb 2010 00:36:48 +0000
Subject: Re: [PATCH 3/3 v2] sh: implement DMA_SLAVE capability in SH dmaengine
Message-Id: <4B68C520.5000607@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190825120.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190825120.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dan Williams wrote:
> Guennadi Liakhovetski wrote:
>> Tested to work with a SIU ASoC driver on sh7722 (migor).
>>
>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> ---
> [..]
>> +       /*
>> +        * Called under dma_list_mutex, take care to perform all slave channel
>> +        * ID manipulations under that lock.
>> +        */
> 
> Not that I think we will ever see scalability patches aimed at breaking 
> up the "big dma_list_mutex lock", but it makes me a bit uneasy that this 
> relies on an internal implementation detail of dmaengine.  Please add a 
> private lock here.
> 

...or perhaps change the comment to say that this relies on the 
guarantee from dmaengine that alloc_chan_resources never runs 
concurrently with itself or free_chan_resources.  Which is an externally 
visible guarantee of dmaengine.

--
Dan
