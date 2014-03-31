From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Mar 2014 09:55:52 +0000
Subject: Re: [PATCH 2/7] gpio: rcar: Add optional functional clock to bindings
Message-Id: <CAMuHMdWmpM1GEWfXeaisY470c9dCDc+0BTAot242=TLHGt7W8Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395953262-4290-1-git-send-email-geert@linux-m68k.org>
	<1395953262-4290-3-git-send-email-geert@linux-m68k.org>
	<1522709.FsOoKumPXz@avalon>
In-Reply-To: <1522709.FsOoKumPXz@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Laurent,

On Fri, Mar 28, 2014 at 5:53 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
>> +++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
>> @@ -21,6 +21,10 @@ Required Properties:
>>      GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
>>    - gpio-ranges: Range of pins managed by the GPIO controller.
>>
>> +Optional properties:
>> +
>> +  - clocks: Must contain a reference to the functional clock.
>> +
>
> I would make the property mandatory. Obviously the driver needs to consider it
> as optional in order not to break the DT ABI, but the specification should
> make it mandatory in order to ensure that all future implementations will
> specify the clock.

I think it has to stay optional: unless I misinterpreted the datasheet, r8a7778
doesn't have MSTP bits for the GPIO modules. I guess it's the same for
other R-Car Gen1 like r8a7779. So it looks like the bits were added in
R-Car Gen2.

Hence I'll just add ", if present", unless the Best Practice is to put such
properties under "Required properties" or "Recommended properties"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
