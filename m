From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 Jul 2015 07:27:12 +0000
Subject: Re: [PATCH 0/4 v2][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <87zj30ecvj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> > No objection about these Gen3 prototype patches ?
> > If so, I will post these in SH-ML and ARM-ML as formal (= non RFC) patch set
> 
> I still think it is strange that the SCIF is enabled in the defconfig
> but not in the DTS. =)

Oops, you are correct
I will remove it from defconfig, and send this patch set as formal patch

Best regards
---
Kuninori Morimoto
