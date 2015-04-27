From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Apr 2015 16:26:35 +0000
Subject: Re: [PATCH] ARM: gic: Document Power and Clock Domain optional properties
Message-Id: <CAMuHMdXG_ME8S=GQgvWPL3n6PPDyhH96iBDzzhcddpNYGEML4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430146811-29862-1-git-send-email-geert+renesas@glider.be>
 <CAL_JsqKjXuGp0SRFAVWskJRfyeoko6ybtceJQcDzymshuz9wPw@mail.gmail.com>
In-Reply-To: <CAL_JsqKjXuGp0SRFAVWskJRfyeoko6ybtceJQcDzymshuz9wPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Apr 27, 2015 at 5:25 PM, Rob Herring <robherring2@gmail.com> wrote:
>> --- a/Documentation/devicetree/bindings/arm/gic.txt
>> +++ b/Documentation/devicetree/bindings/arm/gic.txt
>> @@ -58,6 +58,14 @@ Optional
>>    regions, used when the GIC doesn't have banked registers. The offset is
>>    cpu-offset * cpu-nr.
>>
>> +- power-domains : A phandle and PM domain specifier as defined by bindings of
>> +                 the power controller specified by phandle, used when the GIC
>> +                 is part of a Power or Clock Domain.
>
> "or Clock" should be removed?

No, both power domains and clock domains use the "power-domains"
property.

In case of clock domains, "power-domains" refers to the power controller,
which controls the clocks.
"clocks" is used for specifying the clock to control.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
