From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 04 Feb 2015 14:34:03 +0000
Subject: Re: [PATCH v2 2/5] ARM: shmobile: r8a7740: Migrate to generic l2c OF initialization
Message-Id: <7800327.b3sMA1XGtZ@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
 <1423059315-28519-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1423059315-28519-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wednesday 04 February 2015 15:15:12 Geert Uytterhoeven wrote:
>  DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
> +       .l2c_aux_val    = L2C_AUX_CTRL_SHARED_OVERRIDE,
> +       .l2c_aux_mask   = ~L2C_AUX_CTRL_SHARED_OVERRIDE,
>         .map_io         = r8a7740_map_io,
>         .init_early     = shmobile_init_delay,
>         .init_irq       = r8a7740_init_irq_of,

+Russell

I'd hope we could avoid having any overrides in here that are not
specified in DT. I can never remember what we discussed about particular
bits in the past though. Is this bit something we could add a binding
for, or could we make it enabled by default?

I assume you have to add it because the boot loader sets the wrong
default, right?

	Arnd
