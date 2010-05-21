From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 21 May 2010 01:27:41 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: g3evm: Add IrDA support
Message-Id: <w3pfx1mt56b.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <ueihglic5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <ueihglic5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Thank you for advice

> It should be noted that sh_sir presently is only built for SH and not
> ARCH_SHMOBILE. Adding ARCH_SHMOBILE blocks up on the asm/clock.h include
> and shows that the driver itself is using deprecated clock lookups. While
> none of this matters for the platform device data, you'll still need to
> post a patch that tidies up the sh_sir driver and allows us to enable it
> for the ARCH_SHMOBILE case.

Thanks. I will check it.
But there are 2 IrDA driver.
sh_sir / sh_irda

sh_sir  is used from SuperH chip (ex SH7724...).
sh_irda is used from SuperH ARM (ex g3)

and sh_irda is in linux-next / net-next now

Best regards
--
Kuninori Morimoto
 
