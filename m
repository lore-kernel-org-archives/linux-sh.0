From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Jun 2012 00:47:51 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: mmc->f_max heuristic
Message-Id: <20120621004751.GB10003@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1340171905-12534-1-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1206200845590.20254@axis700.grange>
 <20120620070227.GN20030@verge.net.au>
 <A389CA2909F7E548A28A6A30A9446C0903651FAAD5@REAMBX.NA.RTA>
In-Reply-To: <A389CA2909F7E548A28A6A30A9446C0903651FAAD5@REAMBX.NA.RTA>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Brandt, Chris" <Chris.Brandt@renesas.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Wed, Jun 20, 2012 at 07:56:44AM -0700, Brandt, Chris wrote:
> > I would be very happy if someone with access to
> > the documentation could shed some further light on this.
> 
> According to the SH7757 manual, setting the CLKDIV[3:0] in the CE_CLK_CTRL register 0xF selects Pck as the bus clock frequency. So, unlike other devices where Pck/2 (CLKDIV[3:0]=0) is the max bus speed, the SH7757 can run at Pck when CLKDIV=0xF.

Thanks Chris,

please correct me if I am wrong, but that seems to indicate the heuristic
is correct. At least for the sh7757 and sh7372.
