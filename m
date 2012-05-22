From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 May 2012 08:09:15 +0000
Subject: Re: [PATCH 08/11] ARM: mach-shmobile: armadillo800eva: add HDMI support
Message-Id: <87pq9wab88.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <877gw5aqy8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877gw5aqy8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> > @@ -5,7 +5,6 @@ CONFIG_IKCONFIG_PROC=y
> >  CONFIG_LOG_BUF_SHIFT
> >  # CONFIG_UTS_NS is not set
> >  # CONFIG_IPC_NS is not set
> > -# CONFIG_USER_NS is not set
> >  # CONFIG_PID_NS is not set
> >  CONFIG_SYSFS_DEPRECATED=y
> >  CONFIG_SYSFS_DEPRECATED_V2=y
> 
> I just noticed this now, but why are you enabling deprecated APIs for a
> new platform?

No reason.
Old .config had it.
Should I remove it ?

Best regards
---
Kuninori Morimoto
