From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 27 Dec 2010 00:57:50 +0000
Subject: Re: SDHI polling
Message-Id: <AANLkTik0RJdRm+JNWoQsa6jPxBxoFmTx6v+iK9135Xou@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101226224506.GD21535@verge.net.au>
In-Reply-To: <20101226224506.GD21535@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 27, 2010 at 9:23 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Dec 27, 2010 at 07:59:15AM +0900, Magnus Damm wrote:
>> Hi Simon,
>>
>> On Mon, Dec 27, 2010 at 7:45 AM, Simon Horman <horms@verge.net.au> wrote:
>> > I have it in mind to run the SDHI hardware block in some sort of
>> > polling mode - that is, with interrupts disabled - during early
>> > boot. Does this make any sense?
>>
>> I guess it depends on how early you mean. =)
>>
>> Usually you want to make use of interrupts if they are available, but
>> for really early code there is no interrupt support. So the in-kernel
>> early printk support is implemented without any interrupts for
>> instance. At least this is true for the SCIF driver used by SH and
>> SH-Mobile / R-Mobile, pretty sure it applies to other hardware
>> platforms as well.
>>
>> As for the SDHI version of the MMC loader, I think you should do the
>> same as the MMCIF loader that is present in
>> include/linux/mmc/sh_mmcif.h. As you know it gets compiled into a
>> separate image together with the rest of the zImage loader. No
>> interrupt handling is available in that code, so just implementing
>> things using polling mode is good enough.
>>
>> I'm not 100% sure about U-boot these days, but I wouldn't be surprised
>> if many boot loaders only implement polling.
>
> My plan is to implement the SDHI version of the MMC loader along
> the same lines of the MMCIF version. That plan involves early boot
> where there are no interrupts.
>
> My question was really to ask if from a hardware point of view it is
> possible/reasonable to read from an MMC card using SHDI without interrupts.
> I gather that the answer is yes.

I believe that is possible, yes. Maybe you can ask around for some
out-of-tree SDHI u-boot excellence to use as an example. I imagine
such code may use polling. =)

> If the answer is no then I will need to deviate from my
> based-on-MMCIF-MMC-boot plan.

No need to deviate IMO.  Also, I don't think it's worth implementing
interrupt handling in the tiny zImage decompressor blob.

Thanks,

/ magnus
