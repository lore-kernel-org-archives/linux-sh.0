From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Sun, 04 Aug 2013 23:53:31 +0000
Subject: Re: [PATCH 1/3 v3] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <87eha9t3lz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei, Ben

Thank you for your reply

> >> + if (IS_ERR(phy)) {
> >> + pr_err("it doesn't have usb phy driver\n");
> >
> > I would still like this message corrected.
> 
> Yes, something like "cannot get usb2 phy driver"

Thank you for re-pointing it
I will fix it and send v4 patch soon

Best regards
---
Kuninori Morimoto
