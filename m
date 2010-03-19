From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 19 Mar 2010 08:02:49 +0000
Subject: Re: [PATCH 01/05] dmaengine: shdma: Remove sh_dmae_slave_chan_id enum
Message-Id: <aec7e5c31003190102w3584813cq5ae5f9f1007453de@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044638.17051.97049.sendpatchset@t400s>
In-Reply-To: <20100319044638.17051.97049.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hey Guennadi,

On Fri, Mar 19, 2010 at 4:30 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 19 Mar 2010, Magnus Damm wrote:
>> --- 0001/arch/sh/include/asm/dmaengine.h
>> +++ work/arch/sh/include/asm/dmaengine.h =A0 =A0 =A02010-03-18 23:30:46.=
000000000 +0900
>> @@ -17,7 +17,7 @@
>>
>> =A0#define SH_DMAC_MAX_CHANNELS 6
>>
>> -enum sh_dmae_slave_chan_id {
>> +enum {
>> =A0 =A0 =A0 SHDMA_SLAVE_SCIF0_TX,
>> =A0 =A0 =A0 SHDMA_SLAVE_SCIF0_RX,
>> =A0 =A0 =A0 SHDMA_SLAVE_SCIF1_TX,
>> @@ -38,7 +38,7 @@ enum sh_dmae_slave_chan_id {
>> =A0};
>>
>> =A0struct sh_dmae_slave_config {
>> - =A0 =A0 enum sh_dmae_slave_chan_id =A0 =A0 =A0slave_id;
>> + =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0slave_id;
>
> I think, INT_MAX DMA slave IDs will be enough;) So, you could just use an
> int to save typing and to reserve -1 (or -EINVAL) as an invalid DMA ID. As
> I am currencly realising, it can be useful, e.g., if you want to enable
> DMA only on Rx and not on Tx of some device. This, of course, throughout
> this patch.

Reserving some number sounds like a good plan, but exactly what is the
best is a different question. If I'm allowed to nitpick then I think
its wasteful to use one bit for the sign when only needing one value
to mark unused. So I'd prefer to go with unsigned and 0 as unused mark
and the rest as valid ids.

>> --- 0001/drivers/dma/shdma.c
>> +++ work/drivers/dma/shdma.c =A02010-03-18 23:30:46.000000000 +0900
>> @@ -266,7 +266,7 @@ static struct sh_desc *sh_dmae_get_desc(
>> =A0}
>>
>> =A0static struct sh_dmae_slave_config *sh_dmae_find_slave(
>> - =A0 =A0 struct sh_dmae_chan *sh_chan, enum sh_dmae_slave_chan_id slave=
_id)
>> + =A0 =A0 struct sh_dmae_chan *sh_chan, struct sh_dmae_slave *param)
>
> This doesn't seem to be needed, at least, not in this patch.

Well, I have to change the function to something, no? =3D)

Cheers,

/ magnus
