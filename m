From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Apr 2013 05:19:52 +0000
Subject: Re: [PATCH 1/6] clk: sh: add sh_clk_reparent_register()
Message-Id: <87mwt7j72j.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9ph5h0c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9ph5h0c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> On Tue, Apr 02, 2013 at 04:06:15AM -0700, Kuninori Morimoto wrote:
> > Some SuperH clocks need to decide its parent clock from
> > specified register.
> > This patch adds sh_clk_reparent_register() for this purpose
> 
> Could somebody review this change?

This is one of v1 patch set, and this patch (= [1/6]) was removed on v2 patch set

Please see

Subject: [PATCH 0/6 v2] ARM: shmobile: r8a73a4: detailed clock topology support
Date: Fri, 05 Apr 2013 13:19:58 +0900



Best regards
---
Kuninori Morimoto
