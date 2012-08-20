From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Date: Mon, 20 Aug 2012 05:33:42 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <5031CC36.4040204@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hello

(2012/08/20 13:45), Kuninori Morimoto wrote:
>=20
> Hi Paul
> Cc Magnus, Kobayashi-san
>=20
>>> irq: irq_domain_associate_many(<no-node>, irqbaseT5, hwbaseT5, count=3D=
1)
>>> irq: irq_domain_associate_many(<no-node>, irqbaseT6, hwbaseT6, count=3D=
1)
>>> irq: irq_domain_associate_many(<no-node>, irqbaseT7, hwbaseT7, count=3D=
1)
>>> irq: irq_domain_associate_many(<no-node>, irqbaseT8, hwbaseT8, count=3D=
1)
>>> irq: irq_domain_associate_many(<no-node>, irqbaseT9, hwbaseT9, count=3D=
1)
>>> irq: irq_domain_associate_many(<no-node>, irqbaseU0, hwbaseU0, count=3D=
1)
>>> irq: irq_domain_associate_many(<no-node>, irqbaseU1, hwbaseU1, count=3D=
1)
>>> irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=3D=
1)
>>> ------------[ cut here ]------------
>>> WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/ir=
qdomain.)
>>> error: irq_desc already associated; irqU2 hwirq=3D0x228
>>
>> Well, that's certainly a valid bug. hwirq 552 is already bound to the
>> previous controller, and the vector in question is being registered a
>> second time under another controller. This looks to be RTDMAC_2_DEI6 (0x=
1300),
>> but the rest descends in to macro hell, so it's not obvious why the same
>> vector is being registered in multiple places.
>=20
>=20
> I'm not sure why, but this patch solved problem ?
>=20
> -------------------------------------------
> diff --git a/arch/arm/mach-shmobile/intc-sh73a0.c b/arch/arm/mach-shmobil=
e/intc-
> index ee44740..a6eae4f 100644
> --- a/arch/arm/mach-shmobile/intc-sh73a0.c
> +++ b/arch/arm/mach-shmobile/intc-sh73a0.c
> @@ -259,7 +259,7 @@ static int sh73a0_set_wake(struct irq_data *data, uns=
igned i
>          return 0; /* always allow wakeup */
>   }
>  =20
> -#define RELOC_BASE 0x1000
> +#define RELOC_BASE 0x1200
>  =20
>   /* INTCA IRQ pins at INTCS + 0x1000 to make space for GIC+INTC handling=
 */
>   #define INTCS_VECT_RELOC(n, vect) INTCS_VECT((n), (vect) + RELOC_BASE)
>=20
>=20

FYI,=20
I tried this patch, too. I got the following log. It seems no conflicts.


NR_IRQS:16 nr_irqs:16 16
irq: Allocated domain of type 0 @0xce802800
intc: Registered controller 'sh73a0-intcs' with 77 IRQs
irq: Allocated domain of type 3 @0xce802940
irq: irq_domain_associate_many(<no-node>, irqbaseD8, hwbaseD8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseD9, hwbaseD9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseF4, hwbaseF4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseF5, hwbaseF5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseF6, hwbaseF6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseF7, hwbaseF7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseF8, hwbaseF8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseG2, hwbaseG2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseG5, hwbaseG5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseG6, hwbaseG6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseG7, hwbaseG7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseG9, hwbaseG9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseH0, hwbaseH0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseI2, hwbaseI2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseI3, hwbaseI3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseI4, hwbaseI4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseI5, hwbaseI5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseP0, hwbaseP0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseP5, hwbaseP5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseQ6, hwbaseQ6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseQ7, hwbaseQ7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseQ8, hwbaseQ8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseR0, hwbaseR0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseR1, hwbaseR1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseR2, hwbaseR2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseR3, hwbaseR3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseR4, hwbaseR4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseR5, hwbaseR5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseR6, hwbaseR6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseC2, hwbaseC2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseC4, hwbaseC4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseC6, hwbaseC6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseC7, hwbaseC7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseC8, hwbaseC8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseD3, hwbaseD3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseD4, hwbaseD4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseD5, hwbaseD5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseU3, hwbaseU3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseU4, hwbaseU4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseU5, hwbaseU5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseU6, hwbaseU6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseU7, hwbaseU7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseX4, hwbaseX4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseX7, hwbaseX7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseX8, hwbaseX8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseX9, hwbaseX9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseY0, hwbaseY0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseY1, hwbaseY1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseY2, hwbaseY2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseY3, hwbaseY3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseY4, hwbaseY4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase`0, hwbase`0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase`1, hwbase`1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase`2, hwbase`2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase`3, hwbase`3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase`4, hwbase`4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase`8, hwbase`8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase`9, hwbase`9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasea5, hwbasea5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasea6, hwbasea6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasea8, hwbasea8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasea9, hwbasea9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb0, hwbaseb0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb1, hwbaseb1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb3, hwbaseb3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb4, hwbaseb4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb5, hwbaseb5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb6, hwbaseb6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb7, hwbaseb7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb8, hwbaseb8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseb9, hwbaseb9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasec0, hwbasec0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasec1, hwbasec1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasec2, hwbasec2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasec3, hwbasec3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseh0, hwbaseh0, count=3D1)
intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs
irq: Allocated domain of type 3 @0xce8029c0
irq: irq_domain_associate_many(<no-node>, irqbaseV0, hwbaseV0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV1, hwbaseV1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV2, hwbaseV2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV3, hwbaseV3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV4, hwbaseV4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV5, hwbaseV5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV6, hwbaseV6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV7, hwbaseV7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV8, hwbaseV8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseV9, hwbaseV9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseW0, hwbaseW0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseW1, hwbaseW1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseW2, hwbaseW2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseW3, hwbaseW3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseW4, hwbaseW4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseW5, hwbaseW5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbase=944, hwbase=944, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=945, hwbase=945, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=946, hwbase=946, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=947, hwbase=947, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=948, hwbase=948, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=949, hwbase=949, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=950, hwbase=950, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=951, hwbase=951, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=952, hwbase=952, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=953, hwbase=953, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=954, hwbase=954, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=955, hwbase=955, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=956, hwbase=956, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=957, hwbase=957, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=958, hwbase=958, count=3D=
1)
irq: irq_domain_associate_many(<no-node>, irqbase=959, hwbase=959, count=3D=
1)
intc: Registered controller 'sh73a0-pint0' with 32 IRQs
irq: Allocated domain of type 3 @0xce802a00
irq: irq_domain_associate_many(<no-node>, irqbasep0, hwbasep0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep1, hwbasep1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep2, hwbasep2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep3, hwbasep3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep4, hwbasep4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep5, hwbasep5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep6, hwbasep6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep7, hwbasep7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep8, hwbasep8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbasep9, hwbasep9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq0, hwbaseq0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq1, hwbaseq1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq2, hwbaseq2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq3, hwbaseq3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq4, hwbaseq4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq5, hwbaseq5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq6, hwbaseq6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq7, hwbaseq7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq8, hwbaseq8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaseq9, hwbaseq9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser0, hwbaser0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser1, hwbaser1, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser2, hwbaser2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser3, hwbaser3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser4, hwbaser4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser5, hwbaser5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser6, hwbaser6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser7, hwbaser7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser8, hwbaser8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbaser9, hwbaser9, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases0, hwbases0, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases1, hwbases1, count=3D1)
intc: Registered controller 'sh73a0-pint1' with 8 IRQs
irq: Allocated domain of type 3 @0xce802ac0
irq: irq_domain_associate_many(<no-node>, irqbases2, hwbases2, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases3, hwbases3, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases4, hwbases4, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases5, hwbases5, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases6, hwbases6, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases7, hwbases7, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases8, hwbases8, count=3D1)
irq: irq_domain_associate_many(<no-node>, irqbases9, hwbases9, count=3D1)
sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 348966092=
0ms
Console: colour dummy device 80x30
console [tty0] enabled

