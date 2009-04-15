From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 15 Apr 2009 12:03:48 +0000
Subject: Re: [PATCH 02/05] sh: arch earlytimer support
Message-Id: <aec7e5c30904150503i7b46c670n550fbaa96e209dc9@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090415105012.29940.70431.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090415105012.29940.70431.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Wed, Apr 15, 2009 at 8:42 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Wed, Apr 15, 2009 at 07:50:12PM +0900, Magnus Damm wrote:
>> --- 0001/arch/sh/kernel/time_32.c
>> +++ work/arch/sh/kernel/time_32.c =A0 =A0 2009-04-15 16:59:31.000000000 =
+0900
>> @@ -233,6 +234,14 @@ void __init time_init(void)
>> =A0 =A0 =A0 =A0* initialized for us.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 sys_timer =3D get_sys_timer();
>> +
>> + =A0 =A0 /* Make sure all compiled-in early timers register themselves.
>> + =A0 =A0 =A0* Run probe() for one "earlytimer" device.
>> + =A0 =A0 =A0*/
>> + =A0 =A0 early_platform_driver_register_all("earlytimer");
>> + =A0 =A0 if (early_platform_driver_probe("earlytimer", 1, 0))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> =A0 =A0 =A0 if (unlikely(!sys_timer))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 panic("System timer missing.\n");
>>
> What exactly is the plan for progression from here? If the CMT
> clocksource and clockevent drivers are filling the role of the old CMT
> driver, then the sys_timer stuff needs to be isolated. As it is now,
> platforms that only contain the CMT will still need to use the sys_timer
> version, especially if they don't have multiple channels.

Sorry about the unclear code. So the early platform stuff should be
moved up before get_sys_timer(). This way sys_timer will always be
NULL if earlytimer is used. I'll resend a new version.

/ magnus
