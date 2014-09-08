From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 08 Sep 2014 07:36:49 +0000
Subject: Re: [PATCH] mmc: tmio: enable odd number size transfer
Message-Id: <87r3zmo969.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq9eohuc.wl%kuninori.morimoto.gx@gmail.com>
	<CAMuHMdUJK1Mmd_S+-hGFoshgRbpHKG5OH2w7AFHNaQG5qyvNaw@mail.gmail.com>
In-Reply-To: <CAMuHMdUJK1Mmd_S+-hGFoshgRbpHKG5OH2w7AFHNaQG5qyvNaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Geert

 > +       buf8 = (u8 *)(buf + ((count - 1) >> 1));
> 
> The "-1" is not really needed.

This -1 is needed.

We want to have...
count - offset
1       0
2       0
3       1
4       1
...

> I think it's better to use shifts for both read and write, and add an
> le16_to_cpu()/
> cpu_to_le16() if needed.

I see. will fix in v2


Best regards
---
Kuninori Morimoto
