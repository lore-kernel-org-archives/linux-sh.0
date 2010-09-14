From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Sep 2010 09:42:31 +0000
Subject: Re: [PATCH] sh: ecovec24: modify tsc2007 platform settings
Message-Id: <w3phbhsu0e0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pmxs8idw5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pmxs8idw5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Thanks for your work

> Ok, I wasn't sure exactly what was going on. I had applied it in the ARM
> case also, but then reverted it in order for
> 
> "ARM: mach-shmobile: ap4evb: modify touchpanel judgment condition"
> 
> to apply. However, I didn't see any similar patch for ecovec, so should
> we just leave ecovec as it is?

Sorry about these stupid patches.

1) X  sh: ecovec24: modify tsc2007 platform settings
2) X  ARM: mach-shmobile: ap4evb: modify tsc2007 platform settings
3) O  ARM: mach-shmobile: ap4evb: modify touchpanel judgment condition

3) is bug fix patch for ap4evb board. -> this patch is needed.
1), 2) add new feature but had issue. -> these are new bug

Best regards
--
Kuninori Morimoto
 
