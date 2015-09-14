From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2015 12:46:06 +0000
Subject: Re: [PATCH 00/14] SCI clocks cleanup
Message-Id: <CAMuHMdX9bL=0Uydt7iJGsRDVukvNF5nLfRaTtT3upxWMuzELUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 14, 2015 at 2:37 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> There are a few more to fix up:
>>   - The example in new
>>     Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
>>   - New arch/arm64/boot/dts/renesas/r8a7795.dtsi
>
> I haven't included these in the patch series as they're not present in Simon's
> devel branch.

I understand.

>>   - The new old kid on the block: arch/h8300/boot/dts
>
> And I have missed that one. If you take the series in your tree for SCI BRG
> clock development, could you add a patch to handle h8300 ?

I handle these.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
