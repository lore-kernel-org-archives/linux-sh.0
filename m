From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Sep 2010 09:23:23 +0000
Subject: Re: [PATCH] sh: ecovec24: modify tsc2007 platform settings
Message-Id: <w3plj74u19x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxs8idw5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxs8idw5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> > This patch modify x_plate_ohms to correct value for tsc2007 panel,
> > and removed un-necessary ts_get_pendown_state()
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Applied, thanks.

Ohh Sorry Paul
This patch (and ARM: mach-shmobile: ap4evb: modify tsc2007 platform settings)
has same issue.
So, please revert it.

Best regards
--
Kuninori Morimoto
 
