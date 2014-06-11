From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jun 2014 08:12:21 +0000
Subject: "ak" vs "asahi-kasei" (was: Re: [PATCH 3/3 v3] ARM: shmobile: lager: add sound support on DT)
Message-Id: <CAMuHMdWTVBjFzA9L9Eqpq_2Xi9_NHkOCLrb_UjK611SBfwnc=Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>

Hi Morimoto-san,

CC devicetree, alsa-devel

On Wed, Jun 11, 2014 at 9:40 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> On Wed, Jun 11, 2014 at 8:54 AM, Kuninori Morimoto
>> <kuninori.morimoto.gx@renesas.com> wrote:
>> > +               compatible = "asahi-kasei,ak4643";
>>
>> As Sergei already commented,
>> Documentation/devicetree/bindings/vendor-prefixes.txt
>> says
>>
>>         ak      Asahi Kasei Corp.
>
> I know, but,
>
> grep asahi-kasei sound/soc/codecs/*
> sound/soc/codecs/ak4104.c:      { .compatible = "asahi-kasei,ak4104", },
> sound/soc/codecs/ak4554.c:      { .compatible = "asahi-kasei,ak4554" },
> sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4642",   .data = &ak4642_drvdata},
> sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4643",   .data = &ak4643_drvdata},
> sound/soc/codecs/ak4642.c:      { .compatible = "asahi-kasei,ak4648",   .data = &ak4648_drvdata},
> sound/soc/codecs/ak5386.c:      { .compatible = "asahi-kasei,ak5386", },
>
> ak4642 driver can't probe by "ak";

That's bad. And all but one of these match entries have been added
_after_ the addition of "ak" to vendor-prefixes.txt...

Outside sound, there's also "asahi-kasei,ak8975" vs. "ak,ak8975".

> My code is based on "code", not "document"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
