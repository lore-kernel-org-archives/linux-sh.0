From: Wolfram Sang <wsa@the-dreams.de>
Date: Fri, 23 Oct 2015 09:45:00 +0000
Subject: Re: [PATCH 5/9] i2c: rcar: init new messages in irq
Message-Id: <20151023094500.GD13380@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NklN7DEeGtkPCoo3"
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
 <1917001.aD8sIkvx7f@avalon>
 <20151023080601.GC1642@katana>
 <2048622.tkxROUAu7P@avalon>
In-Reply-To: <2048622.tkxROUAu7P@avalon>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> I had CONFIG_DRM_FBDEV_EMULATION disabled. I've then enabled it but also=
=20
> merged git://people.freedesktop.org/~airlied/linux next in my branch, whi=
ch=20
> probably fixes the problem.

So, your tree is not strictly renesas-drivers-2015-10-13-v4.3-rc5?

> > I fixed it locally and will see if I see ADV7511 problems. I cannot
> > fully test HDMI probably, because it seems that this HDMI->DVI chain I
> > have does not work.
>=20
> It's supposed to be supported, so that might be something we need to fix.=
 More=20
> work for me \o/ :-)

:/ Let me know if I can send you debug output.

> > Okay, so before any 'modetest' activity. Which kernelconfig?
> > shmobile_defconfig?
>=20
> .config attached.

That one also probes for me... I only disabled DHCP and added my
initramfs. I patched the fbdev build error out and changed Lager dts to
use i2c-rcar (instead of i2c-sh_mobile).

Can you enable CONFIG_I2C_DEBUG_CORE in the config, apply this patch,
and send me the trace output and bootlog?

Thanks,

   Wolfram

diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 1921294afc87ce..cd56f77550cac1 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -418,6 +418,7 @@ static irqreturn_t rcar_i2c_irq(int irq, void *ptr)
 	rcar_i2c_write(priv, ICMCR, val & RCAR_BUS_MASK_DATA);
=20
 	msr =3D rcar_i2c_read(priv, ICMSR);
+trace_printk("msr %08x\n", msr);
=20
 	/* Only handle interrupts that are currently enabled */
 	msr &=3D rcar_i2c_read(priv, ICMIER);


--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWKgGcAAoJEBQN5MwUoCm24MgQAIWgg5KLZWW2sql/4owbaYRm
Lv71sZ8kEFz+qo3ZmdZx1rIYXJUbTLlhe8IJsTbOfbzn7Yg6EE3M+qWuFG4lMBzu
sE8NDRV0PE/mA/oFQoZ1yp5X5Wkq0p6U1VygTd3Gc/lHKFJN4bO7GX3YHSbe1UZo
+hsZF43BRDj+V870bx8D38PMIY4nQ6UsiRveXVh+qBZuDaZe6fwfYHAiqLKMEetg
TuDJdu5U7wTmz3XQifalLTqNOLJo5skCdq1IWhzeuAhZq2wy4K906afeYaXDe/R2
8XLVjAUi9TkuCbKZEhkx4ViJGYYoltqGpNGL2y8ilKi24hiz9QZFBOEF2pRPqVyk
+wdA/khRVBC9y+hMiFeYrfOgSNvxpkmvftGnGJIKIlABptGvhh92a35PPCg2abSf
05n3TBerR5y3UuhZN2XUoKAwDoExl9L4edRdgCKwJ9+9Ve/7xqLpnGWW3tcNIepB
kopRYJ6fCiMbBVJNBvyj2vlnaIDdQfRAa6YpzJJJ1Xruik2qaPhcJr1rhaHwWwAM
oTOmvEWblWRxO4dAzL4h5xU+aIy5MkTl4XT6517GUs7s5gUhOq+itXPlahI1ok3W
hBLckTSwyOQ7LXCzmBlZuodK++7vvNyy2npb0Z6+AzNa8Wae1a56cnh24d45ZYzT
ewIdY421MgNSgO4LzeWt
=ulWa
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
