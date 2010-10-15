From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Oct 2010 06:42:55 +0000
Subject: Re: [PATCH 3/3] ARM: mach-shmobile: clock-sh7372: Add FSIDIV clock
Message-Id: <w3pfww80xe9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4lk11gd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

> Is there some particular reason why you can't just construct a rate table
> for FSIDIV instead? sh_clk_div6_register_ops() in drivers/sh/clk-cpg.c is
> an example of how to set it up. It's provided generically in the struct
> clk largely for these sorts of cases.

Sorry I didn't explain for detail.
The reason is treq table size.

FSIDIV dividing frequency bit is 16.
And struct cpufreq_frequency_table size is 8byte.

So, the table size will be 8 x 65535 = 512K byte if FSIDIV have it.
(ex) div6 case is 8 x 64 = 512 byte
     div4 case is 8 x 16 = 128 byte

I thought 512K byte is too big for kernel.

Best regards
--
Kuninori Morimoto
 
