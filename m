From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 02 Feb 2010 04:04:20 +0000
Subject: Re: [PATCH] mtd: trivial sh_flctl changes
Message-Id: <20100202040420.GF13428@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100127091721.21320.90312.sendpatchset@rxone.opensource.se>
	<4B66B44C.3060305@renesas.com>
	<20100127091120.21312.77488.sendpatchset@rxone.opensource.se>
	<4B66B41C.4020904@renesas.com>
In-Reply-To: <4B66B44C.3060305@renesas.com> <4B66B41C.4020904@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Cc: linux-mtd@lists.infradead.org, Magnus Damm <magnus.damm@gmail.com>, dwmw2@infradead.org, linux-sh@vger.kernel.org

On Mon, Feb 01, 2010 at 07:59:40PM +0900, Yoshihiro Shimoda wrote:
> Magnus Damm wrote:
> > This patch contains a few changes for the sh_flctl driver:
> >  - not sh7723-only driver - get rid of kconfig dependency
> >  - use dev_err() instead of printk()
> >  - use __devinit and __devexit for probe()/remove()
> >  - fix probe() return values
> 
> Thank you for your patch.
> 
> Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

On Mon, Feb 01, 2010 at 08:00:28PM +0900, Yoshihiro Shimoda wrote:
> Magnus Damm wrote:
> > This patch extends the sh_flctl driver with support
> > for 16-bit bus configuration using SEL_16BIT and
> > support for multiplexed pins using SHBUSSEL.
> 
> Thank you very much for your patch again!
> 
> Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

I've applied both of these, thanks.
