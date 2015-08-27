From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2015 11:14:07 +0000
Subject: Re: [PATCH/RFC 07/10] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <CAMuHMdXzrMzOup0xnrBWO9_+gUf+jBavLq_=LiUnt+PrSByD5w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 12:40 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
>> +       phy0: ethernet-phy@0 {
>> +               rxc-skew-ps = <900>;
>> +               rxdv-skew-ps = <0>;
>> +               rxd0-skew-ps = <0>;
>> +               rxd1-skew-ps = <0>;
>> +               rxd2-skew-ps = <0>;
>> +               rxd3-skew-ps = <0>;
>> +               txc-skew-ps = <900>;
>> +               txen-skew-ps = <0>;
>> +               txd0-skew-ps = <0>;
>> +               txd1-skew-ps = <0>;
>> +               txd2-skew-ps = <0>;
>> +               txd3-skew-ps = <0>;
>
>
>    Hm, and the PHY driver can parse all this?

Please see drivers/net/phy/micrel.c:ksz9021_config_init().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
