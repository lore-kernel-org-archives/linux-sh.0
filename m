From: jacopo mondi <jacopo@jmondi.org>
Date: Tue, 17 Apr 2018 13:59:20 +0000
Subject: Re: [PATCH] sh: mm: Fix unprotected access to struct device
Message-Id: <20180417135920.GA3519@w540>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
List-Id: <linux-sh.vger.kernel.org>
References: <1523972123-5700-1-git-send-email-jacopo+renesas@jmondi.org>
 <20180417155407.49c981b3@windsurf.numericable.fr>
In-Reply-To: <20180417155407.49c981b3@windsurf.numericable.fr>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, ysato@users.sourceforge.jp, dalias@libc.org, thomas.petazzoni@free-electrons.com, robin.murphy@arm.com, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Thomas,

On Tue, Apr 17, 2018 at 03:54:07PM +0200, Thomas Petazzoni wrote:
> Hello,
>
> On Tue, 17 Apr 2018 15:35:23 +0200, Jacopo Mondi wrote:
> > With commit ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping
> > operations observe dev->dma_pfn_offset") the generic DMA allocation
> > function on which the SH 'dma_alloc_coherent()' function relies on,
> > access the 'dma_pfn_offset' field of struct device.
> >
> > Unfortunately the 'dma_generic_alloc_coherent()' function is called from
> > several places with a NULL struct device argument, halting the CPU
> > during the boot process.
> >
> > This patch fixes the issue protecting access to dev->dma_pfn_offset,
> > with a trivial check for validity. It also passes a valid 'struct device'
> > in the 'platform_resource_setup_memory' function which is the main user
> > of 'dma_alloc_coherent()', and inserting a WARN_ON() check to make future
> > (and existing) bogus users of this function they're should provide a valid
> > 'struct device' whenever possible.
> >
> > Fixes: ce88313069c36eef80f21fd7 ("arch/sh: make the DMA mapping operations observe dev->dma_pfn_offset")
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> I would have done two commits here, one to fix:
>
>   dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
>
> and one to switch to the WARN_ON + if(dev) model. But I don't really
> care either way, so:

I thought about doing the same, but as this commit is a fix to be
applied on top of v4.17-rc1, and it's likely being fast tracked as it
breaks SH architecture (at least SH7722) I thought it was good to keep
all of that in a single commit.

>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
>

Thank you

> Note that even with the if (dev) check, you don't avoid all possible
> regressions. For example, some parts of the sh_eth driver were passing
> a non-NULL struct device, but it was the wrong struct device (the one
> inside struct net_device, and not the one part of struct
> platform_device). I fixed that for sh_eth, but there could be other
> drivers doing bogus things.

Well, not that much we can do here for other bogus users, right?

Thanks
   j

>
> Best regards,
>
> Thomas
> --
> Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJa1f24AAoJEHI0Bo8WoVY840IQALaB81SHpTqof7NTZbGORgyz
I+p+ypFul09euQc8LW4L+B3T8YBbzwiTv/vEO9gWLkjDwJTt8UbM74gBpIUXDzEh
H+ynibBH2PjUexNXequJx+1qQEgYcyZKxl294N3ewDXVkhGeaZHwEwyC+ISlVmai
lVFigH7rezqBNT8Y3vdXbAypUiIF/wIawG+uwMJpemi4h7gTjLQU4WiSq9d+/rPI
M2T4YkRnjyAiMleejmaXOgOueyGn4oB2zHK/UxMZ8w2zLiCLao2ulS1aIr214pcY
HafrzD+8iZb8CLcTgRc+xTQIQNwcjtuAuVDenqtY1RH0twf/jOeHPLAeo+jFxHoz
EitF4XSPBtl1LgPubTsmUKobBzayBr+f2aTjjf1gHYVMIJtwOSROD0a9GUMqNMTX
dWFI6aZF3aHiQV2z/9KmPuvj4K5cK2kYW97FIWBKTHw6oly2DlRJ5M6GjVdknq0x
j5VGI2O67sUiFtACj+e8pxSAnqbp4IJL1fuhgng+pq+vKaYBYiMqqK+xwHJPNV7+
TYz1KDpujK9EXn2VLTq/o/WjKXTpbfsIqsNoof3u0B+7p02Qvr0Ybh6hunk8iogP
VWX2nMV+WBFkP9/1I4L1jJ5yBEP4M/34gQykw1E/yowYfkcQZzlsQ8a56C0d8CDx
eCWB2KcQB4oNoL0/gSCU
=enzU
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--
