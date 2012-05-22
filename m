From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Tue, 22 May 2012 06:22:28 +0000
Subject: Re: [PATCH 2/4] sh: sh4: Change the specification method of IRQ to SCIx_IRQ_MUXED
Message-Id: <CABMQnV+Rr-J=r+Z0oxjDGwRRbpGetb4-kahRgaa==mn6y6qUCA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334286843-3297-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1334286843-3297-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2012/5/18 Paul Mundt <lethal@linux-sh.org>:
> On Fri, Apr 13, 2012 at 12:14:01PM +0900, Nobuhiro Iwamatsu wrote:
>> Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for th=
is.
>> And change use to evt2irq(), without specifying the value of IRQ directl=
y.
>> This is correction to the SH4 series.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>> =A0arch/sh/kernel/cpu/sh4/setup-sh7750.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/sh/kernel/cpu/sh4/setup-sh7750.c b/arch/sh/kernel/cpu/=
sh4/setup-sh7750.c
>> index 98cc0c7..56b3bdc 100644
>> --- a/arch/sh/kernel/cpu/sh4/setup-sh7750.c
>> +++ b/arch/sh/kernel/cpu/sh4/setup-sh7750.c
>> @@ -43,7 +43,7 @@ static struct plat_sci_port sci_platform_data =3D {
>> =A0 =A0 =A0 .scscr =A0 =A0 =A0 =A0 =A0=3D SCSCR_TE | SCSCR_RE,
>> =A0 =A0 =A0 .scbrr_algo_id =A0=3D SCBRR_ALGO_2,
>> =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D PORT_SCI,
>> - =A0 =A0 .irqs =A0 =A0 =A0 =A0 =A0 =3D { 23, 23, 23, 0 },
>> + =A0 =A0 .irqs =A0 =A0 =A0 =A0 =A0 =3D SCIx_IRQ_MUXED(evt2irq(0xE40)),
>> =A0 =A0 =A0 .regshift =A0 =A0 =A0 =3D 2,
>> =A0};
>>
> 23 is actually 0x4e0, 0xe40 would be 98. Fortunately git merge collided
> on this while I was merging my evt2irq migration branch, as it's unlikely
> anyone would have noticed this for some time..

Sorry, and thanks.

Nobuhiro

--=20
Nobuhiro Iwamatsu
