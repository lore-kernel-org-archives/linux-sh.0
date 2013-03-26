From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Mar 2013 06:45:35 +0000
Subject: Re: [PATCH 0/2 v2] thermal: rcar: fixup registration failure case
Message-Id: <87k3ouirqs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87620gqbbe.wl%kuninori.morimoto.gx@renesas.com>
	<874ng0qb9f.wl%kuninori.morimoto.gx@renesas.com>
	<1364200856.2465.48.camel@rzhang1-mobl4>
	<871ub3j9r3.wl%kuninori.morimoto.gx@renesas.com>
	<87sj3iiu5m.wl%kuninori.morimoto.gx@renesas.com>
	<87r4j2itio.wl%kuninori.morimoto.gx@renesas.com>
	<1364279455.2821.2.camel@rzhang1-mobl4>
In-Reply-To: <1364279455.2821.2.camel@rzhang1-mobl4>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Zhang Rui <rui.zhang@intel.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-pm@vger.kernel.org, Linux-SH <linux-sh@vger.kernel.org>


Hi Zhang

> On Mon, 2013-03-25 at 23:07 -0700, Kuninori Morimoto wrote:
> > Hi Zhang
> > 
> > These are v2 patch set of rcar_thermal driver fixup
> > I noticed that v1 patch had bug.
> > 
> it seems that you did not run any test for the previous patch set, not
> even build test.

Sorry about my v1 patch set.

My v1 (v2 too) based on not only your branch (= your branch + SH-ML patch set)
Of course I tested v1 patch set,

But I missed when I git-format-patch.
I'm sorry about it again

> have you tried this patch set before sending out?

Yes, these are tesed on r8a73a4 APE6 board


Best regards
---
Kuninori Morimoto
