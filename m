From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 09:43:21 +0000
Subject: Re: [PATCH v2 3/4] ARM: shmobile: ape6evm-reference: add CPUFreq support
Message-Id: <CANqRtoQ2iKJfEV82Kda1wqyV4+EuHvZd9ODzTKd7t7RfePiOYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1373038006-19973-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guenandi,

On Mon, Jul 8, 2013 at 6:26 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Mon, 8 Jul 2013, Magnus Damm wrote:
>
>> On Mon, Jul 8, 2013 at 5:00 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > On Mon, 8 Jul 2013, Guennadi Liakhovetski wrote:
>> >
>> > [snip]
>> >
>> >> Or have I misunderstood? As for your other idea:
>> >>
>> >> <quote>
>> >> Also, in parallel with platform device in C board
>> >> code you should add DT nodes for the DT reference board support.
>> >> </quote>
>> >>
>> >> Do you mean adding that "cpufreq-cpu0" device from DT? That's (currently)
>> >> impossible. The cpufreq-cpu0.c driver doesn't have an .of_match_table
>> >> field. Since otherwise this is a DT-specific driver - it parses CPU0 DT
>> >> data - I don't think that was an oversight of the author, instead it must
>> >> have been their conscious decision. Exact reasons are unknown to me.
>> >
>> > Ok, I think, I know why. Probably, because that "device" doesn't describe
>> > "real hardware," instead, it's just a driver activation helper.
>>
>> Well, it is most likely a software application configuration thing
>> hidden as a platform device, so obviously it should not be described
>> via DT.
>
> exactly
>
>> But regardless of that:
>> - I don't want it called from DT_MACHINE in setup-xxx.c
>> (It is not a SoC-specific thing, so don't make my SoC code ugly, solve
>> it in a generic way instead)
>
> I think, this is exactly how it is designed atm: it is assumed to be an
> SoC-specific thing which driver to use for CPUFreq, and that's exactly
> what other cpufreq-cpu0 users (imx) do now to register the device -

We want to use cpufreq to scale the CPU clock frequency. As you
probably know, all ARM cores are driven by clocks, so this is not a
unique problem to a certain SoC. However, depending on the hardware
clock scaling may or may not be available. In some cases you may have
multiple clocks that need scaling.

So it's a not a SoC specific issue IMO. It needs to be solved somehow
in a coherent way for MULTIPLATFORM.

> instantiate it from .init_machine in their DT_MACHINE_START() block. So, I
> don't see an alternative way to add cpufreq-cpu0 support to generic SoC
> support. But if you think, we might have boards with APE6, where we don't
> want this device to be registered at all, sure, we can remove it. But then
> we won't be able to use cpufreq-cpu0 on any APE6 boards with the generic
> DT_MACHINE at all.

It boils down to that I don't want anyone to use the DT_MACHINE stuff
in setup-xxx.c and assume something "special" will be added. We want
to be standard. Is the standard not good enough? Then improve it, on a
higher level.

> Basically, I see the following 3 possibilities in our case:
>
> 1. .config - you don't want to depend on this for multiplatform support
> 2. DT - you cannot regiater the cpufreq-cpu0 device from it, because it's
> not describing hardware, and they don't want to run _any_ code from this
> driver on unsupported hardware

But you already have the following information in DT, no?

+&cpu0 {
+       cpu0-supply = <&vdd_dvfs>;
+       operating-points = <
+               /* kHz  uV */
+               1950000 1115000
+               1462500  995000
+       >;
+       voltage-tolerance = <1>; /* 1% */
+};

So which software is going to consume this information?

> 3. DT_MACHINE

Or you can work with the community to figure out a more generic way
how to enable this in a better way.

> Other possibilities like kernel parameter or user-space - not sure they
> are good enough either.

Well, to me anything is better than closet hacking where non-SoC
properties are put in SoC specific code.

>> - I don't want you to add tiny functions and header files that just
>> result in a single line of code.
>> (Call it directly from the DT reference board code until you figure
>> out how to do it in a generic way)
>
> That I don't care that much about. If I misunderstood your wish - sorry, I
> can remove that function and register the device directly.

Please do.

Thanks,

/ magnus
