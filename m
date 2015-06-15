From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Mon, 15 Jun 2015 08:41:14 +0000
Subject: Re: [PATCH 5/6][RFC] arm64: renesas: Add r8a7795 SoC support
Message-Id: <557E8FAA.2010506@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y4jlvait.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Magnus-san,

On 2015/06/15 17:30, Kuninori Morimoto wrote:
> Hi Magnus, Inami-san
>
>>> +       gic: interrupt-controller@0xf1010000 {
>>> +               compatible = "arm,gic-400", "arm,cortex-a15-gic";
>>> +               #interrupt-cells = <3>;
>>> +               #address-cells = <0>;
>>> +               interrupt-controller;
>>> +               reg = <0x0 0xf1010000 0 0x1000>,
>>> +                     <0x0 0xf1020000 0 0x2000>;
>>> +               interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_HIGH)>;
>>> +       };
>> Thanks for your efforts. On ARM v8, is ARM v7 compat string
>> "arm,cortex-a15-gic" really correct?
> I don't know detail of this.
> but, I guess current Inami-san's status is "create working something".
> Maybe he don't care small detail at this point.
> Do you think  "arm,gic-400" is very enough ?
> If so, I can drop it in v2

This is based on arch/arm64/boot/dts/arm/juno.dts.
Since "arm,cortex-a15-gic" is not required, please drop this.

Regards,
Inami

