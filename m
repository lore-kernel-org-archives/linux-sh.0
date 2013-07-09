From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 09 Jul 2013 09:18:40 +0000
Subject: Re: [RFC][PATCH] ARM: shmobile: bockw: add DT reference
Message-Id: <CANqRtoSdG70c=1RVerNHX3w_UNY+Htc9bb_QQXDkx3LZSUzsaA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8761wkt9q0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Jul 9, 2013 at 6:13 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Magnus
>
> Thank you for checking patch
>
>> > +       lan0@18000000 {
>> > +               compatible = "smsc,lan9115";
>> > +               reg = <0x18300000 0x100>;
>> > +               phy-mode = "mii";
>> > +               interrupt-parent = <&gic>;
>> > +               interrupts = <0 (0x3b - 32) 0x4>; /* gic iid of IRQ0 */
>> > +               reg-io-width = <4>;
>> > +               vddvario-supply = <&fixedregulator3v3>;
>> > +               vdd33a-supply = <&fixedregulator3v3>;
>> > +       };
>> > +};
>>
>> This portion about the SMSC chip, I think the interrupt bit looks strange here.
>>
>> Since the SMSC chip is an external ethernet controller it will use an
>> external IRQ pin. It looks like IRQ0 is used according to the comment.
>> But if IRQ0 is used then you should use IRQ0 from some other interrupt
>> parent - not GIC. I realize you may have some chained FPGA setup for
>> interrupts that complicates things, but perhaps the FPGA can be
>> configured to be transparent somehow in a static way and just let
>> interrupts go straight through?
>>
>> Anyway, I recommend you to remove the SMSC bits for now and resend
>> this patch without ethernet controller as a start. Then we can deal
>> with the ethernet controller as an incremental patch.
>
> OK, will do

Thanks.

> my apology is that this is marzen-reference style.
>
> # board-marzen.c is using irq_pin(1) (= IRQ1),
> # but board-marzen-reference.dts is using 28 (= GIC)

Ok, I understand. It looks like Marzen DT reference is broken. Perhaps
it was written before INTC irqpin or gpio-rcar.c existed.

I wonder, when you have time, can you work with the author of the
Marzen DT reference patch to improve the situation?

Thanks for your help.

Cheers,

/ magnus
