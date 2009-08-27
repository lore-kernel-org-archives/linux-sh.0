From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 27 Aug 2009 08:58:05 +0000
Subject: Re: current kernel say "Unaligned kernel access on behalf"
Message-Id: <umy5lhbvm.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uocq2ghqd.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uocq2ghqd.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> What happened is that I added a change that starts to report these fixups
> for the kernel as well. Previously these were being just silently fixed
> up. There is no change in functionality, they've just been added as a
> debugging aid. Though in retrospect, KERN_NOTICE is probably the wrong
> thing for kernel fixups, so I'll switch them over to KERN_DEBUG.

OK. I understand.
Thank you

Best regards
--
Kuninori Morimoto
 
