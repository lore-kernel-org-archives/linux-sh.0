From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Oct 2015 06:53:26 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: add QSPI DT support
Message-Id: <CAMuHMdWzhasOwUe8dOba_QwpMfwR-3w_obO0aszr0R4XcBa24Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1738678.v21ITp1gYW@wasted.cogentembedded.com>
 <20151012000453.GC20025@verge.net.au>
In-Reply-To: <20151012000453.GC20025@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Oct 12, 2015 at 2:04 AM, Simon Horman <horms@verge.net.au> wrote:
>> +     flash@0 {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             compatible = "spansion,s25fl512s", "jedec,spi-nor";
>
> spansion,s25fl512s is used in several dt files but it seems to be
> undocumented. Do we have a plan to resolve this?

Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt:

- compatible : May include a device-specific string consisting of the
               manufacturer and name of the chip. Bear in mind the DT binding
               is not Linux-only, but in case of Linux, see the "m25p_ids"
               table in drivers/mtd/devices/m25p80.c for the list of supported
               chips.
               Must also include "jedec,spi-nor" for any SPI NOR flash that can
               be identified by the JEDEC READ ID opcode (0x9F).

Hence it's OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
