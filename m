From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 03 Sep 2015 08:31:18 +0000
Subject: Re: [PATCH 9/9 v2] sh-pfc: r8a7795: add SCIFx support
Message-Id: <87h9nbq4yx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oahkql0v.wl%kuninori.morimoto.gx@renesas.com>
	<87bndkqkuu.wl%kuninori.morimoto.gx@renesas.com>
	<CANqRtoSg_DcAQ2Z9e-Fd=LxH1qwsyYBx4hDGrkeLDuEKqZfFaw@mail.gmail.com>
In-Reply-To: <CANqRtoSg_DcAQ2Z9e-Fd=LxH1qwsyYBx4hDGrkeLDuEKqZfFaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Magnus

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > This patch adds SCIF0/1/2/3/4/5
> >
> > Original patch was created by Geert,
> > and Kuninori Morimoto updated it
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> > v1 -> v2
> >
> >  - Add Laurent Acked-by
> 
> Thanks for your update, Morimoto-san!
> 
> One quick question from my side: Is it intentional that you have the
> "From: Kuninori Morimoto.." line at the top?
> 
> It looks a bit strange to me. Since Geert wrote the patch according to
> your commit message and his Signed-off-by is at the top, shouldn't the
> top line also be "From: Geert Uytterhoeven..."?

1st SCIF support patch included only SCIF2,
and Geert sent updated patch series which included bugfix.
And I merged these patches to this patch.
So, I kept my "From".
but I puted Geert on top of Signed-off-by since
non SCIF2 are came from Geert (= big volume)
I'm not sure how to do in this case ...

Best regards
---
Kuninori Morimoto
