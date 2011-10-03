From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 03 Oct 2011 07:32:37 +0000
Subject: Re: [PATCH 4/5 v2] ARM: mach-shmobile: r8a7740: Add i2c support
Message-Id: <87hb3qfs32.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r52ugasd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r52ugasd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your check

> > A1 chip has errata on I2C I/O pad reset, and this work-around is for it.
> > It is lasting errata.
> >
> > Shall I add this comment on patch (v3) ?
> 
> Nah, no need. It's not such a big deal IMO. I just wanted to check
> with you if SRCR solved the issue since that code will most likely
> become much cleaner. Also, if/when we add power domain support then
> you most likely will have to redo this fix after powering off. That's
> however a problem for later.

OK. I understand.
But it works well for now.
I hope it is good start for A1 chip

Best regards
---
Kuninori Morimoto
