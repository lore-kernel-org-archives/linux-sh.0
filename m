From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 19 Jun 2012 04:59:02 +0000
Subject: Re: [PATCH 2/4] ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
Message-Id: <87zk7zsxrh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87aa00t4y2.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aa00t4y2.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Kobayashi-san

Thank you for testing patch

> After applying this patch, I can mount and read/write to eMMC.
> Is it enough to test?
> Or how do I know DMAEngine is working properly?

Can you check /proc/interrupts ?
Did your dmaeXX increment ?

Best regards
---
Kuninori Morimoto
