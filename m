From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Jan 2015 09:41:33 +0000
Subject: Re: [PATCH 1/2][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <87wq45sz1y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761ekokpf.wl%kuninori.morimoto.gx@renesas.com>
	<877fw6tm4v.wl%kuninori.morimoto.gx@renesas.com>
	<8761bqtm34.wl%kuninori.morimoto.gx@renesas.com>
	<16757441.qC3ryuq0R5@wuerfel>
In-Reply-To: <16757441.qC3ryuq0R5@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@linaro.org>, Mark Brown <broonie@kernel.org>, Simon <horms@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, dmaengine@vger.kernel.org


Hi xxx

Hi Arnd

> > Current rcar-audmapp is assuming that CHCR value are specified
> > from platform data or DTS bindings. but, it is possible to
> > calculate CHCR settings from src/dst address.
> > DTS bindings node can be reduced by this patch.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> The intention definitely looks good, but I'm worried that the
> table you add here might be too SoC specific.

Thank you

> > +struct id_addr_table {
> > +	u8  id;
> > +	u16 addr;
> > +};
> > +
> > +static u32 audmapp_addr_to_id(struct device *dev, u32 addr)
> > +{
> > +	struct id_addr_table ssi_id_table[] = {
> > +		{0x00, 0x0000}, /* SSI00 */
> > +		{0x01, 0x0400}, /* SSI01 */
> > +		{0x02, 0x0800}, /* SSI02 */
> > +		{0x03, 0x0C00}, /* SSI03 */
> > +		{0x04, 0x1000}, /* SSI10 */
> > +		{0x05, 0x1400}, /* SSI11 */
> > +		{0x06, 0x1800}, /* SSI12 */
> > +		{0x07, 0x1C00}, /* SSI13 */
> > +		{0x08, 0x2000}, /* SSI20 */
> 
> Isn't the address part here the physical address of the FIFO,
> which can be different for each implementation that contains
> an audmapp device?

These are IN/OUT physical address,
and hard coded / specified for audmapp.
Other address is not supported. 

ex) 
         audmapp
  [SRCx] --------> [SSIx]
     out          in
   address      address

Best regards
---
Kuninori Morimoto
