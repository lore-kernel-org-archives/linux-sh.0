From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 31 Jul 2013 13:38:59 +0000
Subject: Re: [PATCH v2 2/3] ARM: shmobile: ape6evm: update MMC0, SDHI0 and SDHI1 with correct regulators
Message-Id: <1473338.nxzu34u9VJ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1375274416-23455-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1375274416-23455-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

On Wednesday 31 July 2013 15:15:21 Guennadi Liakhovetski wrote:
> On Wed, 31 Jul 2013, Laurent Pinchart wrote:
> > On Wednesday 31 July 2013 14:40:15 Guennadi Liakhovetski wrote:
> > > Currently a dummy fixed always-on regulator is used for all 3 SD/MMC
> > > interfaces on ape6evm. This patch updates the board to use correct
> > > supplies for MMC0, SDHI0 and SDHI1 VDD. SDHI0 VccQ supply regulator
> > > should be implemented in a separate patch.
> > > 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > ---
> > > 
> > > v2: improve comments.
> > > 
> > >  arch/arm/mach-shmobile/board-ape6evm.c |   54 ++++++++++++++++++++-----
> > >  1 files changed, 46 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-ape6evm.c
> > > b/arch/arm/mach-shmobile/board-ape6evm.c index c5e6cba..823de50 100644
> > > --- a/arch/arm/mach-shmobile/board-ape6evm.c
> > > +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> > > @@ -59,16 +59,49 @@ static const struct smsc911x_platform_config
> > > lan9220_data __initconst = { };
> > >  /*
> > > - * On APE6EVM power is supplied to MMCIF by a tps80032 regulator. For
> > > now
> > > - * we model a VDD supply to MMCIF, using a fixed 3.3V regulator. Also
> > > use
> > > - * the static power supply for SDHI0 and SDHI1, whereas SDHI0's VccQ is
> > > - * also supplied by the same tps80032 regulator and thus can also be
> > > - * adjusted dynamically.
> > > + * MMC0 power supplies:
> > > + * Both Vcc and VccQ to eMMC on APE6EVM are supplied by a tps80032
> > > voltage
> > > + * regulator. Until support for it is added to this file we simulate
> > > the
> > > + * Vcc supply by a fixed always-on regulator
> > >   */
> > > -static struct regulator_consumer_supply fixed3v3_power_consumers[] > > > +static struct regulator_consumer_supply vcc_mmc0_consumers[] > > >  {
> > >  	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
> > > 
> > > +};
> > > +
> > > +/*
> > > + * SDHI0 power supplies:
> > > + * Vcc to SDHI0 on APE6EVM is supplied by a GPIO-switchable regulator.
> > > VccQ is + * provided by the same tps80032 regulator as both MMC0
> > > voltages - see comment + * above
> > > + */
> > > +static struct regulator_consumer_supply vcc_sdhi0_consumers[] > > > +{
> > >  	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
> > > +};
> > > +
> > > +static struct regulator_init_data vcc_sdhi0_init_data = {
> > > +	.constraints = {
> > > +		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> > > +	},
> > > +	.num_consumer_supplies  = ARRAY_SIZE(vcc_sdhi0_consumers),
> > > +	.consumer_supplies      = vcc_sdhi0_consumers,
> > > +};
> > > +
> > > +static const struct fixed_voltage_config vcc_sdhi0_info __initconst = {
> > > +	.supply_name = "SDHI0 Vcc",
> > > +	.microvolts = 3000000,
> > 
> > Despite being called VSD_3V0 in the schematics, I think the voltage is
> > 3.3V.
>
> The documents are indeed contradictory. The voltage is called VSD_3V0,
> however, as you correctly point out, on another page the schematics show
> "LDO 300mA 3.3V." However, the board documentation specifies: "LDO14:
> 2.95V / 300 mA" for VSD_3V0... The microSD specification says operating
> voltage is between 2.7 and 3.6V, so, either should work. Obviously, I
> don't care either way, updating both affected patches would be a matter of
> minutes. Any votes? :)

I've checked on the board and the regulator is marked "RBBON". According to 
http://www.ricoh.com/LSI/product_power/mark/ME-RP114N.pdf it's an RP114N331D, 
and thus outputs 3.3V.

> > > +	.gpio = 76,
> > > +	.enable_high = 1,
> > > +	.init_data = &vcc_sdhi0_init_data,
> > > +};

-- 
Regards,

Laurent Pinchart

