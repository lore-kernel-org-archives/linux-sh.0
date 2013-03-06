From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Mar 2013 08:54:04 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: fixup INDTx address
Message-Id: <CANqRtoREUrT_S73nA34kFfXBwaNc7fWGPjvWNSQb55bpfPJAWA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lia3pn80.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Phil

On Wed, Mar 6, 2013 at 5:50 PM,  <phil.edworthy@renesas.com> wrote:
>> > Hmm, this isn't what you want. I sent a similar patch on this a while
> back
>> > before realising that the problem is that the pfc driver doesn't
> support
>> > separate input and output data registers, only one reg for both input
> and
>> > output. With the code as it is, the gpio pins act as outputs. Changing
> the
>> > addresses as per this patch means the gpios act now as inputs.
>>
>> Hi Phil,
>>
>> Thanks for guiding people in the right direction. GPIOS on r8a7779 is
>> a bit tricky in general. Both IN and OUT registers as well as IRQ
>> demux support.
>>
>> From my point of view, switching to the recently posted gpio-rcar.c
>> driver should take care of all these issues.
>> [PATCH] gpio: Renesas R-Car GPIO driver
> I hadn't seen that, thanks for pointing it out.
>
>> We do however need to work on how to make GPIO and PFC coexist.
> Yes, that is certainly an issue...

Yeah, (un?)fortunately it's something we need on a wide range of SoCs
including EMEV2, R-Car H1, R-Car M1A and a bunch of newer SoCs as
well.

Thanks,

/ magnus
