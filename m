From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 08 Apr 2014 13:55:27 +0000
Subject: Re: [PATCH 2/9] ARM: shmobile: r8a7790: add dma defines for sys and audio dmacs
Message-Id: <5343FFCF.6040809@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk> <1396901229-29117-3-git-send-email-ben.dooks@codethink.co.uk> <1756954.RD74mEdSeA@avalon>
In-Reply-To: <1756954.RD74mEdSeA@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org

On 08/04/14 14:22, Laurent Pinchart wrote:
> Hi Ben
>
> Thank you for the patch.
>
> On Monday 07 April 2014 21:07:02 Ben Dooks wrote:
>> Add the DMA resource IDs for the R8A7790 Audio and SYS DMA controllers
>> for use when specifying DMA handles.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   include/dt-bindings/dma/r8a7790-dma.h | 223 +++++++++++++++++++++++++++++++
>>   1 file changed, 223 insertions(+)
>>   create mode 100644 include/dt-bindings/dma/r8a7790-dma.h
>>
>> diff --git a/include/dt-bindings/dma/r8a7790-dma.h
>> b/include/dt-bindings/dma/r8a7790-dma.h new file mode 100644
>> index 0000000..7c52132
>> --- /dev/null
>> +++ b/include/dt-bindings/dma/r8a7790-dma.h
>> @@ -0,0 +1,223 @@
>> +/*
>> + * R8A7790 System and Audio DMA channel resource identifiers
>> + *
>> + * Copyirght (c) 2014 Codethink Ltd.
>> + *	Ben Dooks <ben.dooks@codethink.co.uk>
>> + *
>> + * Licensed under GPLv2
>> +*/
>> +
>> +/* System DMAC */
>> +
>> +#define R8A7790_DMA_SCIFA0_TX	(0x21)
>
> Do we really need parentheses ? Also, doesn't the kernel favor lower-case hex
> values ?

Parentheses are useful to stop accidental concatenation
so I like them and would prefer them to stay.

Not sure on the case for the hex constants.



-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
