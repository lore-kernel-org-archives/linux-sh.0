From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 03:12:22 +0000
Subject: Re: [PATCH] Gen2 IPMMU and DU prototype
Message-Id: <CANqRtoSAOLoTwNtn2DoNXVcQfDrGUrrrGCiagvS6BzR0cxZ6fw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150930142242.25755.81946.sendpatchset@little-apple>
In-Reply-To: <20150930142242.25755.81946.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Thu, Oct 1, 2015 at 11:30 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.

Thanks for feedback!!

> On Wednesday 30 September 2015 23:22:42 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Here is a simple hack to enable the IPMMU on R-Car Gen2.
>>
>> The VGA port on r8a7790 Lager may be driven by the DU
>> and the IPMMU via the modetest utility to output some
>> test image.
>>
>> Actually the r8a7790 DU device is connected to the
>> IPMMU using two separate uTLBs, but the DU driver
>> is currently supporting all DU instances using a
>> single device. To make testing easily the r8a7790 DU
>> driver code is with this patch hacked to just cover
>> a single DU instance with a single IPMMU uTLB.
>
> You can reference multiple uTLBs in the DT ipmmus property. The ipmmu-vmsa
> driver currently requires all uTLBs to belong to the same IPMMU instance,
> which shouldn't be an issue here.

Sure, from a DT property point of view it seems possible to assign
multiple uTLBs to the DU node. I would like us to start integrating
the IPMMU on Gen2 and passing multiple uTLBs in case of r8a7790 must
be the right way to describe the hardware.

When it comes to the DU driver and memory management, from my point of
view Gen2 also seems to pass a single device pointer passed to
dma_alloc_writecombine(). I may be wrong, but to support multiple
uTLBs it looks like we need to pass different device pointers to
dma_alloc_writecombine() - unless some index is also passed how can
the IPMMU code otherwise know which uTLB to use?

So it looks like the device pointer issue both affects Gen2 and Gen3.
Of course I wish that wasn't the case, so please prove me wrong. =)

Cheers,

/ magnus
