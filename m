From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Jun 2015 07:44:49 +0000
Subject: Re: [PATCH 0/6][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <871th489vy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87616pwp7a.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87616pwp7a.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

Thank you for your feedback

> From my point of view any kind of software policy is fine. So either
> we disable write protection or we make use of it somehow.
> 
> My only request related to this is to make sure the DT format can
> support any kind of software policy. As usual we should use DT to
> describe the hardware and later in the future we may be able to change
> software policy (if needed) without updating DT. So please take this
> into consideration when designing Gen3 CPG DT.

Yes, DT can be headache.
Our current plan is to use current driver/DT (with disabling write protection)
We don't know this is good idea or not.
Let's discuss it again on v2 patch-set

Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
