From: morimoto.kuninori@renesas.com
Date: Fri, 05 Dec 2008 03:11:09 +0000
Subject: Re: [PATCH] Add icb clk setting for SH7723 on sh_mobile_lcdcfb.c
Message-Id: <uprk7tiya.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uskp3tl9v.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uskp3tl9v.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thanks for checking patch.

> The LCDC can be used with or without the ICB on sh7723. Right now
> we're using it perfectly fine without the ICB.
(snip)
> Adding ICB support in general is a quite difficult task since there
> are many hardware blocks that are affected. And I really think we
> should benchmark these things to see that we implement them correctly.

I can understand.
And sorry, I had only stupid idea.

Best regards
--
Kuninori Morimoto
