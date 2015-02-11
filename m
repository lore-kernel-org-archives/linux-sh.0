From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Feb 2015 07:48:23 +0000
Subject: Re: [PATCH v2 08/15] ARM: shmobile: r8a7778, bockw: add internal ethernet controller to DT
Message-Id: <CAMuHMdWqKHYZXQyUaj8D45Y1RfiThW4wWouing0rne=0NZ7THw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1423497763-3450-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1423497763-3450-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Feb 11, 2015 at 4:54 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> --- a/arch/arm/boot/dts/r8a7778-bockw.dts
>> +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
>> @@ -59,6 +59,11 @@
>>       };
>>  };
>>
>> +&ether {
>> +     pinctrl-0 = <&ether_pins>;
>> +     pinctrl-names = "default";
>
> The internal ethernet controller isn't used on the BockW board, its pins are
> used for display. I thus wouldn't add it to r8a7778-bockw.dts.

Depending on SW62 (and parts of SW84/85)...

>> +};

There's no 'status = "okay";', so it is still disabled.

What about adding a comment about the switches?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
