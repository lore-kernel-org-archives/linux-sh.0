From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2015 13:16:03 +0000
Subject: Re: [PATCH] arm64: renesas: salvator-x: Setup ethernet0 alias for U-Boot
Message-Id: <CAMuHMdXUyL=v2wv8-zfOi0bH6fbs5bnHvDKE2yeaAi-6Ltz1Vg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446197120-4640-1-git-send-email-geert+renesas@glider.be>
	<5186464.J3dvUFu6c7@avalon>
In-Reply-To: <5186464.J3dvUFu6c7@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Linux-sh list <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Fri, Oct 30, 2015 at 2:06 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Friday 30 October 2015 10:25:20 Geert Uytterhoeven wrote:
>> Add an ethernet0 alias for the wired network card so that U-Boot can
>> find the device-node and add an appropriate "local-mac-address"
>> property.
>
> I like that :-) Can U-Boot add the property ? I thought it needed a
> placeholder.

At least for Salvator-X it does. See also the thread at
http://www.spinics.net/lists/arm-kernel/msg456841.html

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
