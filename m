From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 27 May 2012 09:48:52 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add missing GPIO IRQ configuration on mackerel
Message-Id: <CANqRtoQq3yLnmNOTjmw-H1A7tL4Rs-XkYpVhhFPt6DXa7ZvjUw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Sun, May 27, 2012 at 5:54 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 27 May 2012, Magnus Damm wrote:
>
>> On Fri, May 25, 2012 at 3:52 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > On Fri, 25 May 2012, Magnus Damm wrote:
>> >
>> >> Hi Guennadi,
>> >>
>> >> On Thu, May 24, 2012 at 10:18 PM, Guennadi Liakhovetski
>> >> <g.liakhovetski@gmx.de> wrote:
>> >> > SDHI0 card-detect GPIO IRQ on mackarel currently works, because it =
is the
>> >> > default configuration of IRQ26. However, we should not rely on this=
 and
>> >> > should configure the function explicitly.
>> >> >
>> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> >>
>> >> This looks like a regression fix. Can you please point out which
>> >> commit that caused this?
>> >
>> > No, I don't think it is one. My original commit, that added the SDHI0
>> > card-detect GPIO IRQ feature was already missing the configuration cal=
l:
>> >
>> > commit 4bff4a7ee4b9e487a1bc1d31082e77b6a381418a
>> > Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > Date: =A0 Wed May 11 16:51:20 2011 +0000
>> >
>> > =A0 =A0ARM: arch-shmobile: support SDHI card detection on mackerel, us=
ing a GPIO
>>
>> Ah, so you mean that this breakage wasn't created recently enough and
>> therefore not a regression?
>>
>> Just to know what is happening, I believe the breakage was caused by
>> this commit:
>>
>> commit 2b3e38c4fbeb88092390f7c29b4934212abe9ded
>> Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> Date: =A0 Mon Apr 16 23:09:13 2012 +0200
>>
>> =A0 =A0 ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO
>> hotplug helper
>>
>> =A0 =A0This also fixes the following modular mmc build failure:
>>
>> =A0 =A0 arch/arm/mach-shmobile/built-in.o: In function `ag5evm_sdhi0_gpi=
o_cd':
>> =A0 =A0 pfc-sh73a0.c:(.text+0x7c0): undefined reference to `mmc_detect_c=
hange'
>>
>> It contains this lovely hunk:
>>
>> @@ -1481,7 +1471,6 @@ static void __init mackerel_init(void)
>> =A0 =A0 =A0 =A0 irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);
>>
>> =A0 =A0 =A0 =A0 /* enable SDHI0 */
>> - =A0 =A0 =A0 gpio_request(GPIO_FN_SDHICD0, NULL);
>> =A0 =A0 =A0 =A0 gpio_request(GPIO_FN_SDHIWP0, NULL);
>> =A0 =A0 =A0 =A0 gpio_request(GPIO_FN_SDHICMD0, NULL);
>> =A0 =A0 =A0 =A0 gpio_request(GPIO_FN_SDHICLK0, NULL);
>>
>> So I believe it worked fine before that commit, but of course the
>> above commit fixed another error.
>
> I'm not sure this is the case. What is needed for PORT172 to be configured
> to trigger IRQ26 is a write to MSEL1CR, clearing bit 26:
>
> =A0 =A0 =A0 =A0PINMUX_DATA(IRQ26_121_MARK, =A0 =A0 PORT121_FN0, =A0 =A0MS=
EL1CR_26_1),
> =A0 =A0 =A0 =A0PINMUX_DATA(IRQ26_172_MARK, =A0 =A0 PORT172_FN0, =A0 =A0MS=
EL1CR_26_0),
>
> right? Did the above
>
> =A0 =A0 =A0 =A0gpio_request(GPIO_FN_SDHICD0, NULL);
>
> really do that? My understanding was, that the above configured this
>
> =A0 =A0 =A0 =A0PINMUX_DATA(SDHICD0_MARK, =A0 =A0 =A0 =A0 =A0 =A0 =A0 PORT=
172_FN1),
>
> Was I wrong?

My point is that the code worked fine with the native SDHI CD hotplug
and after that it all seems to go downhill.

The original board code uses the SDHI native CD pin function for
hotplug. In such a case you should request GPIO_FN_SDHICD0 or perhaps
the pull-up version of that pin function.

When moving over to GPIO hotplug then you obviously shouldn't use the
CD pin function. You should use GPIO, and in this particular case
GPIO_FN_IRQ26_172.

It's as easy as that.

To clarify and map out invalid ways to use the hardware, if you use
the SDHI native CD without requesting the CD pin function then you're
relying on reset value or some boot loader setting. This is wrong, so
don't do that. If you're using the SDHI native CD but requesting the
GPIO pin then you're also wrong. You are relying on reserved behavior
of the hardware. This may work on some certain ES of the device but
not for instance on newer ones. So don't rely on reserved behavior. If
you use GPIO hotplug without requesting the pin then you're also
wrong. In general, if you are using a pin without requesting it then
you're wrong. Also, regarding IRQ pins, certain SoCs have multiple
versions of for instance IRQ26. So you need to request the correct pin
in that case too so you don't rely on some hardware setting that isn't
mapped out by software.

With the above in mind, commit
4bff4a7ee4b9e487a1bc1d31082e77b6a381418a is incorrect because it is
using SDHI native CD but assuming that you would get GPIO-based
interrupts. I assumed you developed this spending more time hacking it
until it "works" than actually thinking of if what you're doing is
right or not. Or perhaps it is difficult to tell right from wrong from
your side. Anyway, it may happen to work with this commit applied, but
just because it "works" doesn't mean you should write code like that.

Furthermore, commit 2b3e38c4fbeb88092390f7c29b4934212abe9ded is also
incorrect because you remove the SDHI native CD pin function and use
GPIO to read the pin state, but you forget to request the proper pin.
So you rely on the boot loader setting or reset value which is
incorrect. In this case it may also work by luck.

If you have problems using that GPIO with IRQs on a certain board then
don't move over to GPIO hotplug. We don't want hacks. If the MSEL bits
in the PFC code doesn't clear bits as you expect to get IRQs then you
need to map out those dependencies in the PFC code.

In the end, you need to request the correct pin. In the future with
PINCTRL we will use a different framework, but the idea is the same.
And you will get same failures if you forget to request a certain pin
state or if you rely on some reserved functionality.

So _please_ if you are unsure why code is there then don't remove it.
And it seems that I need to review your code in great detail. Sorry
for not doing that properly.

Thanks,

/ magnus
