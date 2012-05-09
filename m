From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 09 May 2012 14:52:47 +0000
Subject: Re: [PATCH] mach-shmobile: Emma Mobile EV2 SMP prototype code
Message-Id: <CANqRtoSwLJKw-8CiHo8ATV4kXKwULPcC1P7_no1tiNLVH-j_eA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120509075407.5991.60556.sendpatchset@w520>
 <201205091212.08239.arnd@arndb.de> <4FAA6DE6.3040001@arm.com>
 <201205091345.34404.arnd@arndb.de>
In-Reply-To: <201205091345.34404.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

On Wed, May 9, 2012 at 10:45 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 May 2012, Marc Zyngier wrote:
>> On 09/05/12 13:12, Arnd Bergmann wrote:
>> > On Wednesday 09 May 2012, Magnus Damm wrote:
>> >> =A0static unsigned int __init shmobile_smp_get_core_count(void)
>> >> =A0{
>> >> @@ -31,6 +32,9 @@ static unsigned int __init shmobile_smp_
>> >> =A0 =A0if (is_r8a7779())
>> >> =A0 =A0 =A0 =A0 =A0 =A0return r8a7779_get_core_count();
>> >>
>> >> + =A0if (is_emev2())
>> >> + =A0 =A0 =A0 =A0 =A0return emev2_get_core_count();
>> >> +
>> >> =A0 =A0return 1;
>> >> =A0}
>> >>
>> >> @@ -41,6 +45,9 @@ static void __init shmobile_smp_prepare_
>> >>
>> >> =A0 =A0if (is_r8a7779())
>> >> =A0 =A0 =A0 =A0 =A0 =A0r8a7779_smp_prepare_cpus();
>> >> +
>> >> + =A0if (is_emev2())
>> >> + =A0 =A0 =A0 =A0 =A0emev2_smp_prepare_cpus();
>> >> =A0}
>> >>
>> >> =A0int shmobile_platform_cpu_kill(unsigned int cpu)
>> >> ...
>> >
>> > This shows that we really want an abstraction for soc-specific SMP ops
>> > even within one platform, and we'll need the same thing for multiplatf=
orm.
>> >
>> > Marc Zyngier already proposed a solution for this last year, but I
>> > think we couldn't agree on the details back then before he lost intere=
st.
>> > I think we should pick that up again and get it into 3.6 so the code a=
bove
>> > can be simplified and we can do the multiplatform solution. We'll prob=
ably
>> > discuss the details in Hong Kong in a couple of weeks, so there is no
>> > point in changing it now, but I'd hope that you can migrate this to
>> > whatever we come up with in the following merge window.
>>
>> I'm happy to revive the series if there is an interest.
>
> Ok, good. I think we were almost there the last time, but I don't
> know if Russell still had any objections. Magnus, can you comment on
> the "[PATCH v6 09/15] ARM: SoC: convert shmobile SMP to SoC descriptor"
> patch from February to see if it fits your needs?

I took the liberty to give some comments here instead. I've gone
through the patch and it looks good in general. I have not tested it
but I'd be happy to fix whatever fallout that may happen.

The patch is pretty close to be a perfect fit from my point of view.
This is definitely a step in the right direction. I am however a bit
hesitant with how the CPU hotplug code ended up, but at the same time
I don't really have any better suggestions. I think I simply need to
convert it to be a full per-soc implementation.

Thanks!

/ magnus
