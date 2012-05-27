From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 27 May 2012 08:35:21 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add missing GPIO IRQ configuration on mackerel
Message-Id: <CANqRtoSTMTcCf180supP2Em97QXuQ4kiyoNt3fik8es-3LbyLA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u7hovvdt9.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Fri, May 25, 2012 at 3:52 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Fri, 25 May 2012, Magnus Damm wrote:
>
>> Hi Guennadi,
>>
>> On Thu, May 24, 2012 at 10:18 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > SDHI0 card-detect GPIO IRQ on mackarel currently works, because it is =
the
>> > default configuration of IRQ26. However, we should not rely on this and
>> > should configure the function explicitly.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>>
>> This looks like a regression fix. Can you please point out which
>> commit that caused this?
>
> No, I don't think it is one. My original commit, that added the SDHI0
> card-detect GPIO IRQ feature was already missing the configuration call:
>
> commit 4bff4a7ee4b9e487a1bc1d31082e77b6a381418a
> Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Date: =A0 Wed May 11 16:51:20 2011 +0000
>
> =A0 =A0ARM: arch-shmobile: support SDHI card detection on mackerel, using=
 a GPIO

Ah, so you mean that this breakage wasn't created recently enough and
therefore not a regression?

Just to know what is happening, I believe the breakage was caused by
this commit:

commit 2b3e38c4fbeb88092390f7c29b4934212abe9ded
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date:   Mon Apr 16 23:09:13 2012 +0200

    ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO
hotplug helper

   This also fixes the following modular mmc build failure:

    arch/arm/mach-shmobile/built-in.o: In function `ag5evm_sdhi0_gpio_cd':
    pfc-sh73a0.c:(.text+0x7c0): undefined reference to `mmc_detect_change'

It contains this lovely hunk:

@@ -1481,7 +1471,6 @@ static void __init mackerel_init(void)
        irq_set_irq_type(IRQ21, IRQ_TYPE_LEVEL_HIGH);

        /* enable SDHI0 */
-       gpio_request(GPIO_FN_SDHICD0, NULL);
        gpio_request(GPIO_FN_SDHIWP0, NULL);
        gpio_request(GPIO_FN_SDHICMD0, NULL);
        gpio_request(GPIO_FN_SDHICLK0, NULL);

So I believe it worked fine before that commit, but of course the
above commit fixed another error.

I have now exceeded my yearly limit of SD related build and runtime
issues. In the future, _please_ try to cause less breakage.

/ magnus
