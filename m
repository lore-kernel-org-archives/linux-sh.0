From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 04 Sep 2013 08:44:18 +0000
Subject: Re: [PATCH] clocksource: em_sti: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <5226F2E2.3070202@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20130904080151.24562.91334.sendpatchset@w520> <20130904083727.GE17329@verge.net.au>
In-Reply-To: <20130904083727.GE17329@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, arnd@arndb.de, linux-sh@vger.kernel.org, sboyd@codeaurora.org, rob.herring@calxeda.com, olof@lixom.net, santosh.shilimkar@ti.com, grant.likely@linaro.org, tglx@linutronix.de

On 09/04/2013 10:37 AM, Simon Horman wrote:
> [ Droped johnstultz@linaro.org CC, the address seems to bounce

The address is john.stultz@linaro.org

>   Added Daniel Lezcano CC, I believe he handles clocksource these days ]

Right.

> On Wed, Sep 04, 2013 at 05:01:51PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Update the STI driver by setting cpu_possible_mask to make EMEV2
>> SMP work as expected together with the ARM broadcast timer.
>>
>> This breakage was introduced by:
>>
>> f7db706 ARM: 7674/1: smp: Avoid dummy clockevent being preferred over re=
al hardware clock-event
>>
>> Without this fix SMP operation is broken on EMEV2 since no
>> broadcast timer interrupts trigger on the secondary CPU cores.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>=20
> Tested-by: Simon Horman <horms+renesas@verge.net.au>
>=20
> I will let this sit for a few days to see if there is any further feedbac=
k.
>=20
>> ---
>>
>>  Thanks to feedback from Stephen Boyd this is is a reworked version of:
>>  [PATCH] clocksource: em_sti: Adjust clock event rating to fix SMP broad=
cast
>>
>>  drivers/clocksource/em_sti.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- 0001/drivers/clocksource/em_sti.c
>> +++ work/drivers/clocksource/em_sti.c	2013-09-04 16:51:42.000000000 +0900
>> @@ -301,7 +301,7 @@ static void em_sti_register_clockevent(s
>>  	ced->name =3D dev_name(&p->pdev->dev);
>>  	ced->features =3D CLOCK_EVT_FEAT_ONESHOT;
>>  	ced->rating =3D 200;
>> -	ced->cpumask =3D cpumask_of(0);
>> +	ced->cpumask =3D cpu_possible_mask;
>>  	ced->set_next_event =3D em_sti_clock_event_next;
>>  	ced->set_mode =3D em_sti_clock_event_mode;
>> =20
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

