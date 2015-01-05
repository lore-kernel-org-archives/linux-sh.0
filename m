From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 05 Jan 2015 14:28:09 +0000
Subject: Re: [RFC 0/4] prototype: switch I2C IP cores at runtime
Message-Id: <CAMuHMdWK1=y73NeptOumhj6iEnZ+PQyiFYu-CSTYwEQhWNWOKA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418674817-12809-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418674817-12809-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Wolfram,

On Mon, Dec 15, 2014 at 9:20 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Some SoC (like Renesas RCar Gen2) have different I2C IP cores with different
> feature sets. This is an experimental patch series to let those different IP
> cores access the same I2C bus at runtime. Finally, we have some code to talk

Thanks for your series!

> about :) Unlike previous sketched versions, this one does not require a
> remove/probe-cycle of I2C bus drivers which would mean complete
> reinitialization of all connected I2C clients. However, the first two patches

Not having to remove/probe all slaves is great!

> need serious discussion. So, have a look if you are interested...

I don't really have comments about the first two patches, as they are
"implementation details".

I'm mostly approaching this from the DT point of view, as DT describes the
hardware, so the description should reflect the actual hardware topology as
closely as possible.

Currently DT describes (let's keep using i2c as an example):
  - one ore more i2c masters (in .dtsi),
  - an i2c bus (in .dts), which is a child of one particular i2c master node,
  - pinctrl (in .dts) to link the i2c bus to one particular i2c master.

Obviously this does not match the hardware, as
  (1) pinctrl is dynamic, and
  (2) the i2c bus is not hard-tied to that specific i2c master instance.

What does describe the hardware is:
  - one or more i2c masters (in .dtsi),
  - pinctrl for the i2c masters (tables/code under drivers/pinctrl/),
  - an i2c bus (in .dts), defined by actual pin connections,
  - pinctrl (in .dts) to link the pin connections used by the i2c bus to one
    default i2c master (is this needed?).
With the above description, switching can be controlled from pinctrl,
triggered by the user or by availability of drivers and/or QoS.
Of course callbacks are needed to inform i2c masters (or the i2c subsystem
if you want to avoid remove/probe-cycles) if a bus is moved to another
master.

Your "i2c-demux" in DT is actually a description of an i2c bus.
But instead of linking it to pins, it contains a list of all i2c masters.
If I want to add an i2c-gpio master, I'll have to add it to DT. That sounds
insignificant, but (in theory) all I/O masters could be implemented using GPIO.
So one day someone may implement an xxx-gpio driver for whatever bus,
and I think it should be supported out-of-the-box. When using pins, and thus
describing the i2c bus in a pin-centric way, that will just work.

Notes: for other buses, it may be required to support using only a subset of
all pins, depending on which SoC module is used. E.g.
  - A QSPI FLASH uses 4 wires in quad transfer mode, but only 2 in dual
    or single transfer mode, and not all SPI masters support quad transfer
    mode,
  - A serial port may or may not support RTS/CTS depending on the used
    serial module.

So... let's hint "Send", wait and see...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
