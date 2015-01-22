From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Jan 2015 12:05:53 +0000
Subject: Re: [PATCH 07/11] ARM: shmobile: bockw: add pins and clock to ethernet controller in DT
Message-Id: <CAMuHMdWjaPWuwP8BB8zmbnfHariT0eOPVD6iBMQ96kkLrXCkgw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421857262-16607-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1421857262-16607-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 22, 2015 at 12:57 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > --- a/arch/arm/boot/dts/r8a7778-bockw.dts
>> > +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
>> > @@ -47,8 +47,12 @@
>> >     };
>> >
>> >     ethernet@18300000 {
>> > +           pinctrl-0 = <&ether_pins>;
>> > +           pinctrl-names = "default";
>> > +
>>
>> What Ether pins? This is an external LAN controller!
>
> The external LAN9220 is connected to the LBSC bus controller. You should thus
> add a DT node for the bus controller, and move the ethernet controller node as
> a child of that node. See Geert's "[PATCH 5/9] ARM: shmobile: r8a73a4 dtsi:
> Add Bus State Controller node" and "[PATCH 6/9] ARM: shmobile: ape6evm dts:
> Move Ethernet node to BSC".

According to the datasheet, the LBSC clock is the CLKOUT clock, which cannot
be turned off. So a "simple-bus" compatible property should be sufficient.

>> >             compatible = "smsc,lan9220", "smsc,lan9115";

The Bock-W schematic diagrams say it's an "smsc,lan89218", so please
add that entry, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
