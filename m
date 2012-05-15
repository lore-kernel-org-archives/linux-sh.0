From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 May 2012 02:27:11 +0000
Subject: Re: [PATCH 0/2] ARM: mach-shmobile: KZM9G SMP support
Message-Id: <CANqRtoQpMqZbKEH8SSTmY=87JV9w0wsHfqSJu3Lf0h4nq2CW+A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehqspl59.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehqspl59.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, May 15, 2012 at 10:33 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Simon, and Magnus
>
> Thank you for checking, but...
>
>> I am having a little trouble with SMP on the kzm9g. =A0I am using Rafael=
's
>> renesas/next branch (5658c94), which includes all the patches above. The
>> only local change I have is to add KZM-A9-GT to mach-types. Perhaps I ne=
ed
>> some other patches?
>>
>>
>> Using the default config I do get a prompt, but I see the following along
>> the way, multiple times.
>>
>> intc: Registered controller 'sh73a0-intcs' with 77 IRQs
>> intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs
>> intc: Registered controller 'sh73a0-pint0' with 32 IRQs
>> intc: Registered controller 'sh73a0-pint1' with 8 IRQs
>> ------------[ cut here ]------------
>> WARNING: at arch/arm/mach-shmobile/intc-sh73a0.c:450 sh73a0_init_irq+0x1=
0c/0x1d0()
>> Modules linked in:
>> Backtrace:
>> [<c0012768>] (dump_backtrace+0x0/0x110) from [<c02cf524>] (dump_stack+0x=
18/0x1c) r7:00000009 r6:000001c2 r5:c0394620 r4:00000000
>> [<c02cf50c>] (dump_stack+0x0/0x1c) from [<c001c9f0>] (warn_slowpath_comm=
on+0x54/0x6c)
>> [<c001c99c>] (warn_slowpath_common+0x0/0x6c) from [<c001ca2c>] (warn_slo=
wpath_null+0x24/0x2c) r9:412fc098 r8:c0350121 r7:00000000 r6:c03e7128 r5:00=
000320 r4:00000011
>> [<c001ca08>] (warn_slowpath_null+0x0/0x2c) from [<c0394620>] (sh73a0_ini=
t_irq+0x10c/0x1d0)
>> [<c0394514>] (sh73a0_init_irq+0x0/0x1d0) from [<c039061c>] (init_IRQ+0x1=
c/0x24)
>> [<c0390600>] (init_IRQ+0x0/0x24) from [<c038f828>] (start_kernel+0x198/0=
x2ac)
>> [<c038f690>] (start_kernel+0x0/0x2ac) from [<41008040>] (0x41008040) r8:=
4100406a r7:c03c1b24 r6:c03aaa44 r5:c03be47c r4:10c5387d
>> ---[ end trace 1b75b31a2719ed1c ]---
>> ------------[ cut here ]------------
>
> This WARNING happen from this patch.
>
> --------------------------------------------------
> commit e2c31b3fdd48274e9deb450e21279e54dfa02ccd
> Author: Magnus Damm <damm@opensource.se>
> Date: =A0 Tue Jan 17 20:10:49 2012 +0900
>
> =A0 =A0ARM: mach-shmobile: sh73a0 IRQ sparse alloc fix
> --------------------------------------------------
>
> It seems interrupt numbering issue.
> intc_pint0_desc and IRQ17 - IRQ31 are using same irq number.
> Magnus, how to solve this issue ?

I'm not sure which way is best right now, but can you please try to
fix it yourself? Take a piece of paper, write down the IRQ ranges that
are being used by Linux. If there are any collision then please try to
use some unused area.

Thank you!

/ magnus
