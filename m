From: Lars-Peter Clausen <lars@metafoo.de>
Date: Sat, 15 Aug 2015 09:40:36 +0000
Subject: Re: Issues with rcar-dmac and sh-sci
Message-Id: <55CF0914.2000803@metafoo.de>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1507162026200.821@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.10.1507162026200.821@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 08/15/2015 01:42 AM, Laurent Pinchart wrote:
> Hi Geert,
> 
> On Thursday 16 July 2015 20:36:49 Geert Uytterhoeven wrote:
>> 	Hi Laurent,
>>
>> While working on DMA for R-Car Gen2 using the sh-sci serial driver with
>> rcar-dmac, I ran into two issues:
>>
>>   1. Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA
>>      engine driver does not support resubmitting a DMA descriptor.
>>      I first tried the patch below, until I ran into the race condition,
>>      after which I changed sh-sci to not reuse DMA descriptors.
> 
> Is reusing descriptors something that the DMA engine API explicitly allows ?

No. It explicitly forbids it. dmaengine_submit() must always be called in a
pair with dmaenine_prep_*(). But there is some work in-progress to add
support for re-usable descriptors, see
http://www.spinics.net/lists/dmaengine/msg05554.html
