From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 31 May 2010 11:19:51 +0000
Subject: Re: [PATCH] sh_tmu: compute mult and shift before registration
Message-Id: <4C039B57.6010109@aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1275296994-12005-1-git-send-email-aurelien@aurel32.net>
In-Reply-To: <1275296994-12005-1-git-send-email-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Magnus Damm a =E9crit :
> Hey Aurelien,
>=20
> Thanks for your patch!
>=20
> On Mon, May 31, 2010 at 6:09 PM, Aurelien Jarno <aurelien@aurel32.net> wr=
ote:
>> Since commit 98962465ed9e6ea99c38e0af63fe1dcb5a79dc25 ("nohz: Prevent
>> clocksource wrapping during idle"), the CPU of an R2D board never goes
>> to idle. This commit assumes that mult and shift are assigned before
>> the clocksource is registered. As a consequence the safe maximum sleep
>> time is negative and the CPU never goes into idle.
>>
>> This patch fixes the problem by moving mult and shift initialization
>> from sh_tmu_clocksource_enable() to sh_tmu_register_clocksource().
>>
>> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
>> ---
>>  drivers/clocksource/sh_tmu.c |   14 +++++---------
>>  1 files changed, 5 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
>> index 8e44e14..e9e35aa 100644
>> --- a/drivers/clocksource/sh_tmu.c
>> +++ b/drivers/clocksource/sh_tmu.c
>> @@ -199,16 +199,8 @@ static cycle_t sh_tmu_clocksource_read(struct clock=
source *cs)
>>  static int sh_tmu_clocksource_enable(struct clocksource *cs)
>>  {
>>        struct sh_tmu_priv *p =3D cs_to_sh_tmu(cs);
>> -       int ret;
>> -
>> -       ret =3D sh_tmu_enable(p);
>> -       if (ret)
>> -               return ret;
>>
>> -       /* TODO: calculate good shift from rate and counter bit width */
>> -       cs->shift =3D 10;
>> -       cs->mult =3D clocksource_hz2mult(p->rate, cs->shift);
>> -       return 0;
>> +       return sh_tmu_enable(p);
>>  }
>>
>>  static void sh_tmu_clocksource_disable(struct clocksource *cs)
>> @@ -228,6 +220,10 @@ static int sh_tmu_register_clocksource(struct sh_tm=
u_priv *p,
>>        cs->disable =3D sh_tmu_clocksource_disable;
>>        cs->mask =3D CLOCKSOURCE_MASK(32);
>>        cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
>> +       /* TODO: calculate good shift from rate and counter bit width */
>> +       cs->shift =3D 10;
>> +       /* channel will be configured at parent clock / 4 */
>> +       cs->mult =3D clocksource_hz2mult(clk_get_rate(p->clk) / 4, cs->s=
hift);
>>        dev_info(&p->pdev->dev, "used as clock source\n");
>>        clocksource_register(cs);
>>        return 0;
>=20
> Hm, are you sure the clock is enabled at this point?
>
> The file include/linux/clk.h says that the clock has to be enabled
> before clk_get_rate() is called.
>=20

In practice yes, but as you said it seems that theoretically it is not
guaranteed, so it may break again in the future.

It probably means that if the clock is not already started we have to
start it, call clk_get_rate() and stop it.

That starts to ressemble to my first patch, that started and stoped the
clock before registering it:

diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
index 8e44e14..6f0fcfd 100644
--- a/drivers/clocksource/sh_tmu.c
+++ b/drivers/clocksource/sh_tmu.c
@@ -228,6 +228,8 @@ static int sh_tmu_register_clocksource(struct
sh_tmu_priv *p,
        cs->disable =3D sh_tmu_clocksource_disable;
        cs->mask =3D CLOCKSOURCE_MASK(32);
        cs->flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+       sh_tmu_clocksource_enable(cs);
+       sh_tmu_clocksource_disable(cs);
        dev_info(&p->pdev->dev, "used as clock source\n");
        clocksource_register(cs);
        return 0;


--=20
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
