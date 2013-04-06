From: Bastian Hecht <hechtb@gmail.com>
Date: Sat, 06 Apr 2013 13:59:04 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: Armadillo800EVA: Reference DT implementation
Message-Id: <CABYn4sxKz8fc5DXQ-gSFndUVv0Muz-64gFC7zNN5i3bdwmSs-Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87txxzk77s.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

2013/4/5 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
> Hi Bastian,
>
> On Friday 05 April 2013 13:28:07 Bastian Hecht wrote:
>> 2013/4/5 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
>> > Hi Bastian,
>> >
>> > On Thursday 04 April 2013 17:58:40 Bastian Hecht wrote:
>> >> 2013/4/4 Laurent Pinchart <laurent.pinchart@ideasonboard.com>:
>> >> > Hi Bastian,
>> >> >
>> >> > Thanks for the patch.
>> >>
>> >> [snip]
>> >>
>> >> >> +     /* Touchscreen */
>> >> >> +     gpio_request(GPIO_FN_IRQ10,     NULL); /* TP_INT */
>> >> >
>> >> > Please, no function GPIO in reference DT implementations.
>> >>
>> >> As far as I understood the pinctrl framework, we choose preconfigured
>> >> settings (in pfc-r8a7740.c) for each device we want to run. We identify
>> >> these devices by their names, like sh-sci.1. How does that work with
>> >> devices connected to busses like the I2C controller for which we can't
>> >> know which GPIOs we need in advance as it is board dependent?
>> >
>> > pfc-r8a7740.c defines pin groups and functions. It's then up to board and
>> > DT files to map the groups and functions they need to devices. The
>> > mappings can be selected explicitly by drivers, or, for default mappings,
>> > automatically by the device core. Please see the eva_pinctrl_map array in
>> > arch/arm/mach-shmobile/board-armadillo800eva.c for mapping examples.
>>
>> Thanks for the explanation.
>>
>> >> >> +     gpio_request_one(166, GPIOF_OUT_INIT_HIGH, NULL); /* TP_RST_B */
>> >> >
>> >> > The GPIO should be passed to the touchscreen driver through DT. As we
>> >> > have no GPIO DT bindings for the r8a7740 yet, an option would be to
>> >> > pass it through platform data (using OF_DEV_AUXDATA).
>> >>
>> >> I don't see who would use that data. Does your suggestion include to
>> >> expand the st1232 driver?
>> >
>> > There's two options here. The one I was suggesting indeed involved
>> > modifying the st1232 driver to handle the reset signal explicitly. The
>> > other option would be to use pinctrl mappings to configure the GPIO. This
>> > isn't possible yet with the PFC driver but I'm working on it.
>>
>> Ah now I'm on track, I guess. So the idea is to be self-contained the st1232
>> needs to be supplied with 2 GPIOs and while the IRQ GPIO is given
>> (indirectly) by the IRQ number, the reset signal is missing. The
>> "gpio_request(GPIO_FN_IRQ10,     NULL)" is purely board specific to route
>> the IRQ signal correctly
>
> That's correct. Such muxing should be performed using a default pinmux entry
> for the st1232 that you will need to add to the pinctrl maps table. The IRQ
> number is already passed to the st1232 through I2C board info, so no change is
> needed there.

Ok I've prepared a RFC-patch that does this. There are multiple things
unclear though:
1st) do we need that at all? The touchscreen works without any
function change, that means simply removing
"gpio_request(GPIO_FN_IRQ10,     NULL); /* TP_INT */" doesn't break
it.
2nd) I the device name chosen correctly? I took the underlying I2C controller.
3rd) have I correctly augmented the pin mux groups? The data seems
quite redundant to the info in pinmux_irqs[].

And because of 1st, it's hard for me to decide if I made correct changes or not.

>> while the reset signal is already muxed correctly by default and just the
>> output value is changed.
>
> That's correct as well. The reset GPIO number should be passed to the st1232
> through platform data/DT, and the st1232 driver should request the GPIO and
> control the reset signal as needed.
>
>> So I'll have a look at the driver and see if I can add the reset GPIO code.
>
> Great, thank you.
>

So this was very straightforward, the patch is out.

Thanks!

 Bastian
