From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 09 Mar 2012 13:12:11 +0000
Subject: Re: [PATCH 02/03] ARM: mach-shmobile: sh7372 generic board support via DT
Message-Id: <CANqRtoSLYOuxtWuNsQAFH97eyi+Dv_x0Zek-yp-2j+USXi9ang@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110630094710.10442.59532.sendpatchset@t400s>
In-Reply-To: <20110630094710.10442.59532.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Arnd,

On Wed, Mar 7, 2012 at 10:41 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 07 March 2012, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add generic DT board support for the sh7372 SoC.
>>
>> SCIF serial ports and timers are kept as regular
>> platform devices. Other on-chip and on-board devices
>> should be configured via the device tree.
>>
>> Tested on the mackerel board via kexec using a zImage
>> kernel with an appended dtb.
>
> This looks good as a start, very nice!

Thanks for checking the code! I appreciate your input!

>> =A0arch/arm/mach-shmobile/setup-sh7372.c | =A0 39 ++++++++++++++++++++++=
+++++++++++
>> =A01 file changed, 39 insertions(+)
>
> I think so far everyone has added the device tree source files to the ker=
nel
> when they did the conversion. I'd suggest you do that, too.

Sure, that indeed sounds like a good idea. I intend to hack on V2 next
week and that is most likely a good time to include dts and dtsi
files. At this point they are rather boring due to interrupt bindings
not working, so we cannot even hook up board specific ethernet
controllers via the device tree due to lack of interrupts. My plan is
to hack up some IRQ domain prototype code to play more with the DT and
also create some proper dts/dtsi files.

>> --- 0034/arch/arm/mach-shmobile/setup-sh7372.c
>> +++ work/arch/arm/mach-shmobile/setup-sh7372.c =A0 =A0 =A0 =A02012-03-06=
 14:04:36.000000000 +0900
>> @@ -1082,3 +1082,42 @@ void __init sh7372_add_early_devices(voi
>> =A0 =A0 =A0 /* override timer setup with soc-specific code */
>> =A0 =A0 =A0 shmobile_timer.init =3D sh7372_earlytimer_init;
>> =A0}
>> +
>> +#ifdef CONFIG_USE_OF
>> +
>> +void __init sh7372_add_early_devices_dt(void)
>> +{
>> + =A0 =A0 shmobile_setup_delay(800, 1, 3); /* Cortex-A8 @ 800MHz */
>> +
>> + =A0 =A0 early_platform_add_devices(sh7372_early_devices,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_S=
IZE(sh7372_early_devices));
>> +
>> + =A0 =A0 /* setup early console here as well */
>> + =A0 =A0 shmobile_setup_console();
>> +}
>
> Are these always 800MHz? Maybe it would be better to read the "clock-freq=
uency"
> property from the root node and use the value that is given for a particu=
lar
> board.

You are correct that the CPU frequency may change depending on a few
things. At this point the actual hardware is configured to use with
whatever value the boot loader has setup for us, which should work
well with the worst case loops-per-jiffy value based on the spec of
the SoC.

My idea with the code above is keep it as simple as possible and be
fail safe. So the 800 Mhz value in this case is coming from the sh7372
data sheet as the maximum allowed frequency for sh7372. The point in
setting the maximum allowed frequency is to come up with a OK worst
case loops per jiffy value without using any timer during early boot.
The non-DT mach-shmobile platforms are using early platform driver
code to allow setting up a timer early during boot, and this timer is
then used with the common calibrate delay loops-per-jiffy calculation
code. With this shmobile_setup_delay() function we can delay the timer
creation until whenever the normal driver model code is setting up
drivers. This should make it easy to use DT for timers too.

So, as you pointed out, the frequency setting may not be fixed. Both
the boot loader setting may be different and we may also use frequency
scaling over time to adjust the frequency. Whenever we change the
frequency we do want to update the loops-per-jiffy to reflect the new
value. Ideally I'd like to use the common calibrate delay code to
figure out the timing in a generic way, and this is something that
certainly can be done whenever the full driver model is up and
running. Or at least we could have some shared ARM core specific delay
presets somewhere under arch/arm.

Initially my patch had some late initcall that recalculated the delay
after the driver model (and also timers) have been initialized. This
looked like it would work in theory and it would match well with
whatever that needs to be done together with cpu frequency scaling.
This sounds a bit like what you requested. However, it seems to me
that the generic calibrate delay code that ARM is using doesn't allow
updating the loops-per-jiffy value! The loops-per-jiffy value is
stored in a static per-cpu variable and the code does not seem to like
recalculating the delay after the first time. Perhaps someone is
working on fixing that up. Architectures like blackfin do their own
thing and do not make use of the generic calibrate delay code, and I
believe they update the loops-per-jiffy directly from their cpufreq
drivers. ARM platforms that do frequency scaling must use some other
technique.

Anyway, so based on this I decided to go with a static worst case
frequency value to calculate a safe loops-per-jiffy value and at the
same time add "adjust generic calibrate delay code to allow updating
frequency over time" to my TODO list. I feel it is better to solve
that issue in a generic way and use the common calibrate delay code to
calculate a proper delay value instead of extending my local
mach-shmobile code more.

Does it sound sane?

Thanks,

/ magnus
