From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Mar 2018 07:25:08 +0000
Subject: Re: [PATCH 2/5] arch/sh: pcie-sh7786: set CLK_SET_TO_ENABLE on the PCIe PHY clock
Message-Id: <CAMuHMdUfay87f5Gm=RTpG5wtNUJzBDf2XvsR6WHWN4+Pgw3SLQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20180326212527.12565-3-thomas.petazzoni@bootlin.com>
In-Reply-To: <20180326212527.12565-3-thomas.petazzoni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Thomas,

On Mon, Mar 26, 2018 at 11:25 PM, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:
> The PCIe PHY clock (bit 0 of register SH4A_PCIEPHYCTRL) is enabled by

s/CTRL/CTLR/

> setting the bit, and disabled by clearing the bit, so let's use the
> CLK_SET_TO_ENABLE flag to tell this to the SH clock subsystem.
>
> Without this, the clock is effectively disabled when it's needed, and
> enabled when not.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks for your patch!

> --- a/arch/sh/drivers/pci/pcie-sh7786.c
> +++ b/arch/sh/drivers/pci/pcie-sh7786.c
> @@ -240,6 +240,7 @@ static int __init pcie_clk_init(struct sh7786_pcie_port *port)
>         clk->parent = &fixed_pciexclkp;
>         clk->enable_reg = (void __iomem *)(chan->reg_base + SH4A_PCIEPHYCTLR);
>         clk->enable_bit = BITS_CKE;
> +       clk->flags = CLK_SET_TO_ENABLE;
>
>         ret = sh_clk_mstp_register(clk, 1);
>         if (unlikely(ret < 0))

As this is not an MSTP clock, I think it must not be registered as an MSTP
clock, but use another/its own clock type.

Note that the real MSTP clock is the functional clock port->fclk:

$ git grep pcie.*_fck
arch/sh/drivers/pci/pcie-sh7786.c:      snprintf(fclk_name,
sizeof(fclk_name), "pcie%d_fck", port->index);
arch/sh/kernel/cpu/sh4a/clock-sh7786.c: CLKDEV_CON_ID("pcie2_fck",
&mstp_clks[MSTP110]),
arch/sh/kernel/cpu/sh4a/clock-sh7786.c: CLKDEV_CON_ID("pcie1_fck",
&mstp_clks[MSTP109]),
arch/sh/kernel/cpu/sh4a/clock-sh7786.c: CLKDEV_CON_ID("pcie0_fck",
&mstp_clks[MSTP108]),

Upon closer look, port->phy_clk is used only in phy_init(). Instead of
modelling it as a clock, you can just replace the calls to
clk_{en,dis}able(&port->phy_clk) by setting/clearing BITS_CKE in
SH4A_PCIEPHYCTLR. Which is basically reverting the phy_clk part of commit
c524ebf5a6b78d25 ("sh: pci: clock framework support for SH7786 PCIe.") ;-)
Nevertheless, that sounds like the right solution to me.

BTW, I'm wondering if the loop checking SH4A_PCIEPHYSR should be done before
BITS_CKE is cleared again, as it is accessing the PCIe PHY registers.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
