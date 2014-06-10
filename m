From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Jun 2014 08:23:14 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7790: add MSTP10 support on DTSI
Message-Id: <878up5cgw6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert, Simon


> > If so, Unfortunately, we need put "R8A7790_CLK_SCU" before "R8A7790_CLK_SRCx",
> > because SCU(ALL) is parent clock of SRCn.
> 
> IC. I didn't look up the parent clock relations.
> However, SCU_ALL = 17, while its children are 18-31, so numerical order
> should be fine.

Hmm.. indeed
I had been confused about it.

I sent v2 patches before getting your feedback...
Before sending v3 patches, I want to get Simon's opinion.
I will send v3 patches if Simon can accept [1/3][2/3] (and [3/3] too?) now.
If not, I will say "Thank you for your feedback" to Geert,
but, not send v3. because this is [RFC] patches.

