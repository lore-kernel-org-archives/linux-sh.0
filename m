From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 11 Jan 2016 08:01:15 +0000
Subject: Re: [RFC v2 2/4] dt-bindings: i2c: mux: demux-pinctrl: add bindings
Message-Id: <CAMuHMdUFdXxGv9wa66WQsX97EVgQYwhhhz+iduZdKSny_ZQT6g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452088285-6427-1-git-send-email-wsa@the-dreams.de>
	<1452088285-6427-3-git-send-email-wsa@the-dreams.de>
	<20160111025200.GA5993@rob-hp-laptop>
In-Reply-To: <20160111025200.GA5993@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Jan Luebbe <jlu@pengutronix.de>

Hi Rob,

On Mon, Jan 11, 2016 at 3:52 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 06, 2016 at 02:51:23PM +0100, Wolfram Sang wrote:
>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>>
>> These bindings allow an I2C bus to switch between multiple masters. This
>> is not hot-swichting because connected I2C slaves will be
>
> s/swichting/switching/
>
>> re-instantiated. It is meant to select the best I2C core at runtime once
>> the task is known. Example: Prefer i2c-gpio over another I2C core
>> because of HW errata affetcing your use case.
>
> This seems okay to me. I don't like not having the i2c devices under the
> i2c controller, but not really much we can do about that.
>
> I have another usecase which might end up needing a similar structure
> as this. That is the whole question of how to deal with capes, hats,
> shields and various daughterboards. For I2C devices on a daughterboard,
> we need to be able to have a DT overlay for the daughterboard described
> in terms of the connector(s) and independent of the host. Then the
> base DT needs to define the mapping from the connector to the host

Indeed. Currently an i2c bus is described in DT as tied to an i2c controller,
while physically it's tied to a bunch of pins. Tying the bus to a controller
is done through pinctrl.

> controller. A complicating factor would be having devices on the same
> bus but split across the main and daughter boards. I don't see anything
> specific to change here, but just want to throw that out.

Can't the daughter board DTS just add more child devices to the mainboard bus?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
