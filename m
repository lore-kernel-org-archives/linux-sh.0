From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 08:11:03 +0000
Subject: Re: [PATCH 9/9 v2] sh-pfc: r8a7795: add SCIFx support
Message-Id: <CANqRtoSg_DcAQ2Z9e-Fd=LxH1qwsyYBx4hDGrkeLDuEKqZfFaw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oahkql0v.wl%kuninori.morimoto.gx@renesas.com>
	<87bndkqkuu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bndkqkuu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Thu, Sep 3, 2015 at 11:52 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch adds SCIF0/1/2/3/4/5
>
> Original patch was created by Geert,
> and Kuninori Morimoto updated it
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> v1 -> v2
>
>  - Add Laurent Acked-by

Thanks for your update, Morimoto-san!

One quick question from my side: Is it intentional that you have the
"From: Kuninori Morimoto.." line at the top?

It looks a bit strange to me. Since Geert wrote the patch according to
your commit message and his Signed-off-by is at the top, shouldn't the
top line also be "From: Geert Uytterhoeven..."?

Thanks,

/ magnus
