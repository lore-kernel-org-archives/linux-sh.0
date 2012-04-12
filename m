From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 12 Apr 2012 06:39:29 +0000
Subject: Re: [PATCH 1/2 v2] sh: Add initial support for SH7734 CPU subtype
Message-Id: <CABMQnV+7b1Fdzm0UngtWd3K-j48BczSFfLkXpHyhGksneGPfhw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1334188415-14427-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1334188415-14427-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

2012/4/12 Paul Mundt <lethal@linux-sh.org>:
> On Thu, Apr 12, 2012 at 08:53:34AM +0900, Nobuhiro Iwamatsu wrote:
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
>> ---
>>
>> V2: Fix build clock framework on 3.4-rc2
>>
> If you are adding a new CPU then you at least need some changelog
> outlining some basic information about it, what you are supporting, etc.
>

OK, I will add.
>> +struct clk *clks[] =3D {
>> + =A0 =A0 &sh7734_ifs_clk,
>> + =A0 =A0 &sh7734_sfs_clk,
>> + =A0 =A0 &sh7734_bfs_clk,
>> + =A0 =A0 &sh7734_mfs_clk,
>> + =A0 =A0 &sh7734_s1fs_clk,
>> + =A0 =A0 &sh7734_pfs_clk,
>> +};
>> +
> These are all div4 clocks, use the div4 clock API.
>

OK, I will change to use div4 clock API.

>> +#include <linux/usb/ehci-sh.h>
>
> I don't see this in mainline or my tree. If you are going to send me
> patches that you know won't build or have a dependency that hasn't been
> met, you either need to state it clearly, or I'll just ignore the entire
> series.
>
>> +/* SCIF */
>> +static struct plat_sci_port scif0_platform_data =3D {
>> + =A0 =A0 .mapbase =A0 =A0 =A0 =A0=3D 0xFFE40000,
>> + =A0 =A0 .flags =A0 =A0 =A0 =A0 =A0=3D UPF_BOOT_AUTOCONF,
>> + =A0 =A0 .scscr =A0 =A0 =A0 =A0 =A0=3D SCSCR_RE | SCSCR_TE | SCSCR_REIE,
>> + =A0 =A0 .scbrr_algo_id =A0=3D SCBRR_ALGO_2,
>> + =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D PORT_SCIF,
>> + =A0 =A0 .irqs =A0 =A0 =A0 =A0 =A0 =3D { evt2irq(0x8C0),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 evt2irq(0x8C0),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 evt2irq(0x8C0),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 evt2irq(0x8C0) },
>> + =A0 =A0 .regtype =A0 =A0 =A0 =A0=3D SCIx_SH4_SCIF_REGTYPE,
>> +};
>> +
> You can use SCIx_IRQ_MUXED() for these.

OK, I will change to use SCIx_IRQ_MUXED .

Best regards,
  Nobuhiro

--=20
Nobuhiro Iwamatsu
