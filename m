From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Mon, 17 Nov 2008 07:49:58 +0000
Subject: Re: smsc911x in 2.6.29
Message-Id: <49212226.5020709@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <OF18129353.0F9B8038-ON802574F9.003C4672-802574F9.003D1A48@smsc.com>
In-Reply-To: <OF18129353.0F9B8038-ON802574F9.003C4672-802574F9.003D1A48@smsc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Steve.

Steve.Glendinning@smsc.com wrote:
> Hi Nobuhiro,
> 
> The second patch in my patchset adds support for dynamic bus 
> configuration, so the platform config must specify its bus width at 
> runtime.  I'm merging this patch through netdev, it should be queued up 
> for .29.

Oh, sorry.

> 
> You removed this support from the sh platform patches (.phy_interface 
> member of smsc911x_config):
> 
> -static struct smc911x_platdata smc911x_info = {
> -                .flags = SMC911X_USE_32BIT,
> -                .irq_flags = IRQF_TRIGGER_LOW,
> +static struct smsc911x_platform_config smsc911x_config = {
> +                .irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
> +                .irq_type = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
> +                .flags = SMSC911X_USE_32BIT,
> +                .phy_interface = PHY_INTERFACE_MODE_MII,
>  };
> 
> Can you add this back?  With the dynamic bus config patch applied, the 
> driver will BUG() if neither SMSC911X_USE_32BIT nor SMSC911X_USE_16BIT is 
> set.
Ok, I will check it.

Best regards,
  Nobuhiro
