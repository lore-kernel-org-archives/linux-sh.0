From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 22 Feb 2010 01:02:56 +0000
Subject: Re: [PATCH] sh: sh7724: Add workaround for FSI sound
Message-Id: <uhbpa5bgf.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <upr41pseb.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <upr41pseb.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


> When FSI and Network (= NFS file system) had been used
> at the same time, the I/O of FSI was unstable.
> This patch modify the SPU2 clock which is used for FSI
> as nearly equal system clock for stable continuous operation.
> Special thanks to Jeremy.

I sent this patch, but I should used set_rate function.
And I wonder should I add it in FSI driver ?

Best regards
--
Kuninori Morimoto
 
