From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 01 Feb 2010 10:59:40 +0000
Subject: Re: [PATCH] mtd: trivial sh_flctl changes
Message-Id: <4B66B41C.4020904@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100127091120.21312.77488.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100127091120.21312.77488.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: dwmw2@infradead.org, lethal@linux-sh.org, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org

Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> This patch contains a few changes for the sh_flctl driver:
>  - not sh7723-only driver - get rid of kconfig dependency
>  - use dev_err() instead of printk()
>  - use __devinit and __devexit for probe()/remove()
>  - fix probe() return values
> 

Thank you for your patch.

Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Thanks,
Yoshihiro Shimoda
