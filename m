From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 13 Nov 2015 08:08:06 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document SoC specific bindings
Message-Id: <CAMuHMdWA6G+9YtGCnUx5iUUuC8HVJt9LPev82f5dCdCuVer9Fw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
	<20151112232805.GA5562@rob-hp-laptop>
In-Reply-To: <20151112232805.GA5562@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Hi Rob,

On Fri, Nov 13, 2015 at 12:28 AM, Rob Herring <robh@kernel.org> wrote:
>> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
>> index 09daeef1ff22..5b902ac8d97e 100644
>> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
>> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
>> @@ -14,7 +14,14 @@ not described in these device tree bindings.
>>
>>  Required Properties:
>>
>> -- compatible: must contain "renesas,rcar-dmac"
>> +- compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.
>
> Somehow Renesas has ended up being backwards from everyone else that
> does <vendor>,<chip>-<block>. Oh well...

I know. Renesas has a mix of both :-(

As in this case the generic one does follow the "<vendor>,<family>-<block>"
pattern ("renesas,rcar-dmac"), it may make sense to use
"renesas,<soctype>-dmac", to avoid having a mix in the bindings for the same
block.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
