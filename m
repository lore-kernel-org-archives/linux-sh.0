From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 30 Oct 2014 13:41:05 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <20141030134105.GC23852@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="c3bfwLpm8qysLVxt"
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-sh@vger.kernel.org


--c3bfwLpm8qysLVxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> > --- 0001/drivers/dma/Makefile
> > +++ work/drivers/dma/Makefile 2014-10-29 13:14:24.000000000 +0900
> > @@ -20,6 +20,7 @@ obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
> >  obj-$(CONFIG_MX3_IPU) += ipu/
> >  obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
> >  obj-$(CONFIG_SH_DMAE_BASE) += sh/
> > +obj-$(CONFIG_RCAR_DMAC) += sh/
> >  obj-$(CONFIG_COH901318) += coh901318.o coh901318_lli.o
> >  obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
> >  obj-$(CONFIG_IMX_SDMA) += imx-sdma.o

I had a similar patch when doing I2C DMA development. However, I simply
used:
	obj-y += sh/

Since we are not compling anything by default.


--c3bfwLpm8qysLVxt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUUj/xAAoJEBQN5MwUoCm20GEQAJ0R8ASO0FrZiK2pRT+6b7fb
21VPUen3EPGeYnMda18vGPu1EQFXFcGp+hGiWFiI+Vcs2dSUmWG84IwWBdxjbDlJ
9c87DVV8c15dCZ6JdcTZwRO6UeT6CUdFXJhhpEuON9Rk25rBUoK7OuqB7sgWccKU
V6nlIhCjT1Cx6TG8svSDGqtucn0tO016ydluN+34DJCqXidR1VRj+GV8Hj5n3P+J
68SFJKodWIMXFEadDfijQBoDtEZJnYhfKvhWyIcOup772SlFAqidpE/YaF2lOYOt
AHV0XtmvV/bk3oyNIJg3yAuE96UmfhArvgXibHqUpTi0eDvuMDTF/Kexag0V0use
M4L6CFy87zPP0nGbMnaUjx/hBTbHudAp8M2IgH1yho3Tknt5c2UGo34/FsCfoRcZ
VhS+mnMKfLklMddEmzOvW7r4T2tl4fZNgNrMK5y97WliZKlzipGpa5Zob+A1fqcQ
/jX6moKWO0/pKXqQ4lyUy/37SAqdu8M7VWNImF9sZ7T8G40fLHUoazInQo4yKpj7
yHEN8iJonKM80hhaHQMoNbujsJOreqzCH75qk3vl7uM1EPWYj+518t1k8fcHsqth
KWFdlYCWiHlcykPqRgtTuPcuYvidMuGw8I7wIz5K9GqtGqynEmRCn8pxycD5IlYq
/ZV+kWQPF5h7ahSTjXcZ
=dyRA
-----END PGP SIGNATURE-----

--c3bfwLpm8qysLVxt--
