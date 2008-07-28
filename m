From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 28 Jul 2008 09:45:27 +0000
Subject: Re: kernel (sometimes) boot
Message-Id: <20080728094526.GB32151@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <488D864C.30808@spesonline.com>
In-Reply-To: <488D864C.30808@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 28, 2008 at 11:30:21AM +0200, Manuel Lauss wrote:
> On Mon, Jul 28, 2008 at 10:41:48AM +0200, Luca Santini wrote:
> > . loading smc91c96 driver fails at probe()
> 
> Check MMIO area (chip is at 0x02000000 - 0x0200001f according to the
> ESDOK7760 manual available from renesas website if you didn't change any of
> the DIP switches on the board), and correct IRQ (9 if I interpret the
> schematics correctly)
> 
> Also, you need to edit drivers/net/smc91x.h and add an entry for your board
> to the jungle of ifdefs in there.
> I.e. like this:
> 
This isn't necessary anymore, you are able to specificy everything you
need through the platform data these days (this is true for smc91x as
well as smc911x). So you can reduce the following:

> ---- 8< ----
> [...]
> #elif defined(CONFIG_SH_EDOSK7760)
> 
> #define SMC_CAN_USE_8BIT        0
> #define SMC_CAN_USE_16BIT       1
> #define SMC_CAN_USE_32BIT       0
> #define SMC_NOWAIT              1
> 
> #define SMC_IO_SHIFT            0
> 
> #define SMC_inw(a, r)           inw((unsigned long)((a) + (r)))
> #define SMC_outw(v, a, r)       outw(v, (unsigned long)((a) + (r)))
> #define SMC_insw(a, r, p, l)    insw( (unsigned long)((a) + (r)), p, l)
> #define SMC_outsw(a, r, p, l)   outsw((unsigned long)((a) + (r)), p, l)
> 
> #define RPC_LSA_DEFAULT         RPC_LED_TX_RX
> #define RPC_LSB_DEFAULT         RPC_LED_100_10
> 
> #define SMC_IRQ_FLAGS           (0)
> 
> #define set_irq_type(irq, type) do { } while (0)
> 
> #elif defined(....
> 
> ---- 8< ----
> 
to:

static struct smc91x_platdata smc91x_info = {
	.flags = SMC91X_USE_16BIT,
};

And then pass that in under the platform device. We already do that today
for migor, se7722, etc.
