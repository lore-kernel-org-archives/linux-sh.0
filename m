From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 29 Jul 2009 10:14:14 +0000
Subject: Re: [PATCH] usb: r8a66597-hcd platform data on_chip support
Message-Id: <4A7020F6.3090506@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090717145955.17840.24106.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090717145955.17840.24106.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Convert the r8a66597-hcd driver to use the on_chip flag
> from platform data to enable on chip behaviour instead
> of relying on CONFIG_SUPERH_ON_CHIP_R8A66597 ugliness.
> 
> This makes the code cleaner and also allows us to support
> both external and internal r8a66597 with the same kernel.
> 
> It also makes the Kconfig part more future proof since
> we with this patch can add support for new processors
> with on-chip r8a66597 without modifying the Kconfig.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---

Thank you very much for your patch.
I tested this patch and it was working.

Acked-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

Thanks,
Yoshihiro Shimoda

