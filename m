From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 22 Jul 2010 13:55:17 +0000
Subject: Re: [bisected] sh_cmt Division by zero in kernel.
Message-Id: <AANLkTimaaDUURan7-HEq2rlPNGLRG781yeIS3Y0dPVK-@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4C46A102.6000805@arndnet.de>
In-Reply-To: <4C46A102.6000805@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Arnd,

Thanks for reporting and bisecting.

On Wed, Jul 21, 2010 at 4:25 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
> Hi,
>
> when booting recent genesis-2.6 head on an AP4EVB board a division by zero
> in kernel is reported:
> (Looks identical to: http://thread.gmane.org/gmane.linux.ports.sh.devel/8=
497)
>
>
> [ =A0 =A00.000000] =A0sh_cmt.10: using deprecated clock lookup
> [ =A0 =A00.000000] =A0sh_cmt.10: used for clock events
> [ =A0 =A00.000000] =A0sh_cmt.10: used for periodic clock events
> [ =A0 =A00.000000] Division by zero in kernel.
> [ =A0 =A00.000000] Backtrace:
> [ =A0 =A00.000000] [<c0028f08>] (dump_backtrace+0x0/0x110) from [<c0202ec=
c>] (dump_stack+0x18/0x1c)
> [ =A0 =A00.000000] =A0r6:c0298978 r5:cf80e600 r4:cf801460 r3:c02a37ac
> [ =A0 =A00.000000] [<c0202eb4>] (dump_stack+0x0/0x1c) from [<c002904c>] (=
__div0+0x18/0x20)
> [ =A0 =A00.000000] [<c0029034>] (__div0+0x0/0x20) from [<c01177fc> ](Ldiv=
0+0x8/0x10)
> [ =A0 =A00.000000] [<c0202444>] (sh_cmt_probe+0x0/0x4e4) from [<c0016f40>=
 ](early_platform_driver_probe+0x1c8/0x264)
> [ =A0 =A00.000000] [<c0016d78>] (early_platform_driver_probe+0x0/0x264) f=
rom[<c000cbb8>] (shmobile_late_time_init+0x24/0x2c)
> [ =A0 =A00.000000] [<c000cb94>] (shmobile_late_time_init+0x0/0x2c) from[<=
c0008978>] (start_kernel+0x208/0x2a8)
> [ =A0 =A00.000000] [<c0008770>] (start_kernel+0x0/0x2a8) from [<40008034>=
](0x40008034)
> [ =A0 =A00.000000] =A0r5:c02bd1f0 r4:10c53c7d
> [ =A0 =A00.000000] =A0sh_cmt.10: used as clock source
>
> and as a result time is running too fast.
> For example sleep 60 on bash returns after a few seconds.

I suspect 5967d33ce8a030f01a716fc0b25fcb03744a5fda fixes the issue
with the time running too fast.

> Git bisect identified following commit as bad:
>
> commit f4d7c3565c1692c54d9152b52090fe73f0029e37
> Author: Paul Mundt <lethal@linux-sh.org>
> Date: =A0 Wed Jun 2 17:10:44 2010 +0900
>
> =A0 =A0clocksource: sh_cmt: compute mult and shift before registration
> =A0 =A0 =A0 Based on the sh_tmu change in 66f49121ffa41a19c59965b31b046d8=
368fec3c7
> =A0 =A0("clocksource: sh_tmu: compute mult and shift before registration"=
).
> =A0 =A0The same issues impact the sh_cmt driver, so we take the same appr=
oach
> =A0 =A0here.
> =A0 =A0 =A0 Cc: stable@kernel.org
> =A0 =A0Signed-off-by: Paul Mundt <lethal@linux-sh.org>

If you revert that one (and perhaps
5967d33ce8a030f01a716fc0b25fcb03744a5fda as well), does it fix your
crash?

Thanks,

/ magnus
