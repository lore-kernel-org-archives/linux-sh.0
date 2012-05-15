From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 May 2012 23:33:31 +0000
Subject: Re: [PATCH 0/2] ARM: mach-shmobile: KZM9G SMP support
Message-Id: <CANqRtoTtrSVPTiD6759OB8R8rhQT3OFsUE_bGyeiGNConqt2XQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehqspl59.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehqspl59.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, May 15, 2012 at 6:25 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Magnus, Simon
>
>> > --------------------------------------------------
>> > commit e2c31b3fdd48274e9deb450e21279e54dfa02ccd
>> > Author: Magnus Damm <damm@opensource.se>
>> > Date: =A0 Tue Jan 17 20:10:49 2012 +0900
>> >
>> > =A0 =A0ARM: mach-shmobile: sh73a0 IRQ sparse alloc fix
>> > --------------------------------------------------
>> >
>> > It seems interrupt numbering issue.
>> > intc_pint0_desc and IRQ17 - IRQ31 are using same irq number.
>> > Magnus, how to solve this issue ?
>>
>> I'm not sure which way is best right now, but can you please try to
>> fix it yourself? Take a piece of paper, write down the IRQ ranges that
>> are being used by Linux. If there are any collision then please try to
>> use some unused area.
>
> I checked again this issue

Thank you!

> At first, below patch modify INTCS_VECT_BASE from 0x2200 to 0x3400.
> Then, IRQ16-IRQ31 interrupt number will be 800.
>
> --------------------------------------------------------
> commit 1ee8299a9ec1ce5137a044c7768293007b9a3267
> Author: Magnus Damm <damm@opensource.se>
> Date: =A0 Wed Mar 28 19:22:54 2012 +0900
>
> =A0 =A0ARM: mach-shmobile: Use 0x3400 as INTCS vector offset

Ok, this patch is included in linux-next. It is most likely the cause
of the problem.

> And, below patch modify PINT IRQ base nuber from 768 to 800.
> Then, conflict happen around 800.
>
> --------------------------------------------------------
> commit 0df1a838d678fc6ab49f983a19e905f6a42297a0
> Author: Magnus Damm <damm@opensource.se>
> Date: =A0 Tue Jan 17 20:05:40 2012 +0900
>
> =A0 =A0ARM: mach-shmobile: sh73a0 PINT IRQ base fix

I agree with your observation.

> If I revert 1ee8299a9ec1ce5137a044c7768293007b9a3267 commit,
> or, if I added this patch, it start works without WARNING.
>
> ---------------------------
> diff --git a/arch/arm/mach-shmobile/include/mach/sh73a0.h b/arch/arm/mach=
-shmobi
> index ac75857..a418518 100644
> --- a/arch/arm/mach-shmobile/include/mach/sh73a0.h
> +++ b/arch/arm/mach-shmobile/include/mach/sh73a0.h
> @@ -519,7 +519,7 @@ enum {
> =A0};
>
> =A0/* PINT interrupts are located at Linux IRQ 800 and up */
> -#define SH73A0_PINT0_IRQ(irq) ((irq) + 800)
> -#define SH73A0_PINT1_IRQ(irq) ((irq) + 832)
> +#define SH73A0_PINT0_IRQ(irq) ((irq) + 700)
> +#define SH73A0_PINT1_IRQ(irq) ((irq) + 732)

So the patch "ARM: mach-shmobile: Use 0x3400 as INTCS vector offset"
moves up INTCS from 0x2200 to 0x3400. It is interesting that you
decide to move the PINT interrupts down instead of up, but perhaps you
are hitting the ceiling.

By the way, did you find the special sh73a0 IRQ handling code using
INTCS_VECT_RELOC() in intc-sh73a0.c? It is using 0x3400 + 0x1000 as
base.

In general I'm fine with your change since you say that you've tested
the code, but please remember to also adjust the comment so it stays
in sync with the code.

Can you please update and send a new patch to the mailing list?

Thank you!

/ magnus
