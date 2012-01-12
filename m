From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 12 Jan 2012 00:41:13 +0000
Subject: Re: MMCIF support on sh7757lcr
Message-Id: <4F0E2C29.8070203@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201101646050.530@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201101646050.530@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi-san,

2012/01/11 17:24, Guennadi Liakhovetski wrote:
> Right, it is detected upon driver initialisation, but id it were a normal 
> slot, card ejects and inserts wouldn't be recognised. In this case we have 
> to specify MMC_CAP_NONREMOVABLE among controller sapabilities:
> 
> static struct sh_mmcif_plat_data sh_mmcif_plat = {
> 	...
> 	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
> 				MMC_CAP_NONREMOVABLE,

Thank you very much for your point.
I will write a patch for this.

Best regards,
Yoshihiro Shimoda

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
