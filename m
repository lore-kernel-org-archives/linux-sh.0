From: Matthieu CASTET <matthieu.castet@parrot.com>
Date: Tue, 26 May 2009 15:02:58 +0000
Subject: Re: [PATCH] sched: Support current clocksource handling in fallback
Message-Id: <4A1C04A2.80404@parrot.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090526061532.GD9188@linux-sh.org> <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
In-Reply-To: <63386a3d0905260731m655bfee3q82a6f52d71fa3cef@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Ingo Molnar <mingo@elte.hu>, Andrew Victor <linux@maxim.org.za>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "peterz@infradead.org" <peterz@infradead.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>

Linus Walleij a =E9crit :
> 2009/5/26 Paul Mundt <lethal@linux-sh.org>:
>=20
>>  */
>>  unsigned long long __attribute__((weak)) sched_clock(void)
>>  {
>> +       /*
>> +        * Use the current clocksource when it becomes available later in
>> +        * the boot process, and ensure that it has a high enough rating
>> +        * to make it suitable for general use.
>> +        */
>> +       if (clock && clock->rating >=3D 100)
>> +               return cyc2ns(clock, clocksource_read(clock));
>> +
>> +       /* Otherwise just fall back on jiffies */
>>        return (unsigned long long)(jiffies - INITIAL_JIFFIES)
>>                                        * (NSEC_PER_SEC / HZ);
>>  }
This is buggy for fast clocksource that wrap often, because sched_clock
is not supposed to wrap.
That why custom implementation use cnt32_to_63 and a smaller shift
(around 8 -10) for conversion for timer unit to ns.

Look for example to arch/arm/mach-pxa/time.c implementation [1]

But we can image you make it generic.

Matthieu

[1]
/*
 * This is PXA's sched_clock implementation. This has a resolution
 * of at least 308 ns and a maximum value of 208 days.
 *
 * The return value is guaranteed to be monotonic in that range as
 * long as there is always less than 582 seconds between successive
 * calls to sched_clock() which should always be the case in practice.
 */
#define OSCR2NS_SCALE_FACTOR 10

static unsigned long oscr2ns_scale;

static void __init set_oscr2ns_scale(unsigned long oscr_rate)
{
    unsigned long long v =3D 1000000000ULL << OSCR2NS_SCALE_FACTOR;
    do_div(v, oscr_rate);
    oscr2ns_scale =3D v;
    /*
     * We want an even value to automatically clear the top bit
     * returned by cnt32_to_63() without an additional run time
     * instruction. So if the LSB is 1 then round it up.
     */
    if (oscr2ns_scale & 1)
        oscr2ns_scale++;
}

unsigned long long sched_clock(void)
{
    unsigned long long v =3D cnt32_to_63(OSCR);
    return (v * oscr2ns_scale) >> OSCR2NS_SCALE_FACTOR;
}
