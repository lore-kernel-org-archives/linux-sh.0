From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 03 Sep 2015 08:48:02 +0000
Subject: Re: [PATCH 9/9 v2] sh-pfc: r8a7795: add SCIFx support
Message-Id: <CAMuHMdUn9q5GD9PbcfEwcnjz5tEiSdmgSsRXHZUGrUPnz56EWQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oahkql0v.wl%kuninori.morimoto.gx@renesas.com>
	<87bndkqkuu.wl%kuninori.morimoto.gx@renesas.com>
	<CANqRtoSg_DcAQ2Z9e-Fd=LxH1qwsyYBx4hDGrkeLDuEKqZfFaw@mail.gmail.com>
	<87h9nbq4yx.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87h9nbq4yx.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Thu, Sep 3, 2015 at 10:31 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> >
>> > This patch adds SCIF0/1/2/3/4/5
>> >
>> > Original patch was created by Geert,
>> > and Kuninori Morimoto updated it
>> >
>> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> > ---
>> > v1 -> v2
>> >
>> >  - Add Laurent Acked-by
>>
>> Thanks for your update, Morimoto-san!
>>
>> One quick question from my side: Is it intentional that you have the
>> "From: Kuninori Morimoto.." line at the top?
>>
>> It looks a bit strange to me. Since Geert wrote the patch according to
>> your commit message and his Signed-off-by is at the top, shouldn't the
>> top line also be "From: Geert Uytterhoeven..."?
>
> 1st SCIF support patch included only SCIF2,
> and Geert sent updated patch series which included bugfix.
> And I merged these patches to this patch.
> So, I kept my "From".
> but I puted Geert on top of Signed-off-by since
> non SCIF2 are came from Geert (= big volume)
> I'm not sure how to do in this case ...

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds SCIF0/1/2/3/4/5

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[geert: Added SCIF0/1/3/4/5]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Note the SoB order, and the "[...]" part.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
