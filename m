From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Oct 2015 15:06:08 +0000
Subject: Re: [PATCH/RFC v2] sh-pfc: r8a7795: add EtherAVB support
Message-Id: <CAMuHMdUYSvNdwNXDLVX-Q9F527mWpKtmj8O+-mCoTSFeXuF+xg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442556001-7041-1-git-send-email-horms+renesas@verge.net.au>
	<CACRpkdbAU10yAeZPgrXdxHQuyviXs55LWAsa54M9jDMmObM-5A@mail.gmail.com>
In-Reply-To: <CACRpkdbAU10yAeZPgrXdxHQuyviXs55LWAsa54M9jDMmObM-5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Simon Horman <horms+renesas@verge.net.au>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

Hi Linus,

On Fri, Oct 16, 2015 at 4:34 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Sep 18, 2015 at 8:00 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
>
>> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>>
>> This patch adds EthernetAVB
>>
>> Based on a much lager patch by Takeshi Kihara which was
>> originally posted by Kuninori Morimoto.
>>
>> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> [horms: extracted from a larger patch;
>>         corrected swapped {MATCH,CAPTURE_A} pins]
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>> ---
>> v2
>> * Added Reviewed-by
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I assume Geert will send me this as a pull request.

This one (and the r8a7795 audio patches) is already in your tree,
thanks to you taking my last
pull request :-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
