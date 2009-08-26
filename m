From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 26 Aug 2009 10:09:14 +0000
Subject: Re: Current ms7724se LAN doesn't work
Message-Id: <uiqgahool.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your hard work

> It looks like the driver is accessing hardware from probe, so you need
> to force a resume after enable. The LCDC driver does just that:
> 
>        pm_runtime_enable(priv->dev);
>        pm_runtime_resume(priv->dev);
> 
> Hopefully that should do the trick. Can you try this fix on top of
> Paul's patch Morimoto-san?

hmm...
I tried Paul's patch + pm_runtime_resume
But it still doesn't work for me...

Best regards
--
Kuninori Morimoto
