From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 01 Jun 2009 10:50:40 +0000
Subject: Re: [PATCH] clocksource: SuperH TMU Timer driver
Message-Id: <aec7e5c30906010350n78632cb8va56f342ea8e3d4ca@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090501065100.8800.99808.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090501065100.8800.99808.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Kawasaki-san,

2009/5/30 Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>:
> Hi Magnus, could you provide an answer to my question on SH-TMU?
>
> Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> This patch adds a TMU driver for the SuperH architecture.

>> + =A0 =A0 /* reload delta value in case of periodic timer */
>> + =A0 =A0 if (periodic)
>> + =A0 =A0 =A0 =A0 =A0 =A0 sh_tmu_write(p, TCOR, delta);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 sh_tmu_write(p, TCOR, 0);

> In some occasions, qemu-sh prints out a lot of warnings on timer
> with this message : 'Timer with period zero. disabling.'
>
> I made some investigation, and found that the warnings are printed
> after zero value is set to TCOR. =A0I checked SH7785 hardware manual,
> but could not find any description what happens when zero value set
> to TCOR.

Thanks for investigating. I read a few SH manuals before converting
the old driver, but I couldn't find any description of zero value.
Same as you.

The idea with zero value TCOR comes from the old driver. It may be
there for some historical reason, or it may just be plain wrong. I've
sometimes seen interrupt bursts with the old tmu driver which may be
related.

> According to the code above, I guess that TMU works as a non-periodic
> one-shot timer when the TCOR value is zero. Is it right?

Yes, you are correct.

Maybe we should disable the timer channel in a different way. I'm open
to suggestions. =3D)

Cheers,

/ magnus
