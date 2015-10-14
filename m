From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 14 Oct 2015 07:54:04 +0000
Subject: Re: [PATCH] ARM: shmobile: defconfig: enable HDMI output for RCar
Message-Id: <CAMuHMdVRBvZbM-nGWu1NA67vqXASzox2SnJUw2H0fcn7PcwjEQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1407974835-11064-1-git-send-email-khilman@linaro.org>
In-Reply-To: <1407974835-11064-1-git-send-email-khilman@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Wed, Oct 14, 2015 at 9:44 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Oct 14, 2015 at 4:07 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Wed, Oct 14, 2015 at 3:09 AM, Laurent Pinchart
>> <laurent.pinchart@ideasonboard.com> wrote:
>>>> Tested with a Lager board and using both I2C/IIC. Based on my testings in
>>>> Dublin with a Koelsch board, I'd be very surprised if it fails with Koelsch.
>>>> Laurent may prove me wrong ;)
>>>
>>> I've tried to reproduce the problem tonight and couldn't, even without your
>>> recent i2c-rcar patches :-/ I'll keep running tests on Koelsch with that
>>> configuration and make sure to report any issue I can find.
>>
>> The Koelsch that failed has a much newer U-Boot (b653737dfca2), which
>> only enables the MSTP clocks that are really needed, while you and I have
>> much older versions (I have b6af5fcc8dfc).
>
> With the new CPG-MSSR driver it should be possible to disable unused
> MSTP clocks in the kernel during boot without too much trouble, right?
> Of course it is not something that is needed right away, but DT
> architecture wise it seems possible to squeeze that in without having
> to update the DT binding.

Unused clocks are already disabled by the clock framework, but that
happens at late_initcall() time, i.e. after i2c probing.

Or do you mean disabling them upfront?
There are some clocks that must not be disabled. Some of them are not
documented.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
