From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Thu, 27 Nov 2008 22:05:14 +0000
Subject: INTC woes on HP Jornada 600-series
Message-Id: <20081128000604.bd017244.kristoffer.ericson@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Fri__28_Nov_2008_00_06_04_+0100_TPR0jPnm8vb9cxk."
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

--Signature=_Fri__28_Nov_2008_00_06_04_+0100_TPR0jPnm8vb9cxk.
Content-Type: multipart/mixed;
 boundary="Multipart=_Fri__28_Nov_2008_00_06_04_+0100_huvcu4UeKv9p9Wj8"


--Multipart=_Fri__28_Nov_2008_00_06_04_+0100_huvcu4UeKv9p9Wj8
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greetings,

I recall bugging Magnus about adding this patch.
Rediscoverd it when I couldn't get the Compact Flash
going (se earlier mail).=20
Anyhow, I'm looking for the correct place to put
this.

With this patch applied, matt's patch works fine.

diff --git a/drivers/sh/intc.c b/drivers/sh/intc.c
index 58d24c5..8508f89 100644
--- a/drivers/sh/intc.c
+++ b/drivers/sh/intc.c
@@ -230,6 +230,18 @@ static void intc_disable(unsigned int irq)
 		intc_disable_fns[_INTC_MODE(handle)](addr, handle,intc_reg_fns\
 						     [_INTC_FN(handle)], irq);
 	}
+
+	#ifdef CONFIG_CPU_SUBTYPE_SH7709
+	/* We need to unmask IRQ0->IRQ5
+	 * to keep the interrupts coming.
+	 * Otherwise we end up with timeouts
+	 * on PCMCIA/CF devices. */
+	if ((irq > 31) && (irq < 37)) {
+		cpu =3D __raw_readb(0xA4000004); /* IRR0 */
+		cpu &=3D ~(1 << (irq - 32));
+		__raw_writeb(cpu, 0xA4000004);
+	}
+	#endif
 }
=20
 #if defined(CONFIG_CPU_SH3) || defined(CONFIG_CPU_SH4A)


--=20
Kristoffer Ericson <kristoffer.ericson@gmail.com>

--Multipart=_Fri__28_Nov_2008_00_06_04_+0100_huvcu4UeKv9p9Wj8
Content-Type: application/octet-stream;
 name="fix-intc-disabling-sh7709.patch"
Content-Disposition: attachment;
 filename="fix-intc-disabling-sh7709.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2gvaW50Yy5jIGIvZHJpdmVycy9zaC9pbnRjLmMKaW5kZXgg
NThkMjRjNS4uODUwOGY4OSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zaC9pbnRjLmMKKysrIGIvZHJp
dmVycy9zaC9pbnRjLmMKQEAgLTIzMCw2ICsyMzAsMTggQEAgc3RhdGljIHZvaWQgaW50Y19kaXNh
YmxlKHVuc2lnbmVkIGludCBpcnEpCiAJCWludGNfZGlzYWJsZV9mbnNbX0lOVENfTU9ERShoYW5k
bGUpXShhZGRyLCBoYW5kbGUsaW50Y19yZWdfZm5zXAogCQkJCQkJICAgICBbX0lOVENfRk4oaGFu
ZGxlKV0sIGlycSk7CiAJfQorCisJI2lmZGVmIENPTkZJR19DUFVfU1VCVFlQRV9TSDc3MDkKKwkv
KiBXZSBuZWVkIHRvIHVubWFzayBJUlEwLT5JUlE1CisJICogdG8ga2VlcCB0aGUgaW50ZXJydXB0
cyBjb21pbmcuCisJICogT3RoZXJ3aXNlIHdlIGVuZCB1cCB3aXRoIHRpbWVvdXRzCisJICogb24g
UENNQ0lBL0NGIGRldmljZXMuICovCisJaWYgKChpcnEgPiAzMSkgJiYgKGlycSA8IDM3KSkgewor
CQljcHUgPSBfX3Jhd19yZWFkYigweEE0MDAwMDA0KTsgLyogSVJSMCAqLworCQljcHUgJj0gfigx
IDw8IChpcnEgLSAzMikpOworCQlfX3Jhd193cml0ZWIoY3B1LCAweEE0MDAwMDA0KTsKKwl9CisJ
I2VuZGlmCiB9CiAKICNpZiBkZWZpbmVkKENPTkZJR19DUFVfU0gzKSB8fCBkZWZpbmVkKENPTkZJ
R19DUFVfU0g0QSkK

--Multipart=_Fri__28_Nov_2008_00_06_04_+0100_huvcu4UeKv9p9Wj8--

--Signature=_Fri__28_Nov_2008_00_06_04_+0100_TPR0jPnm8vb9cxk.
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkvJ9wACgkQPQls10ERAGfjpwCg6QyTiIZs7l0NdVz9Yz8iO5/H
jZ0Animf9G6cN7hTb0AA9Krd2452ah6D
=80LH
-----END PGP SIGNATURE-----

--Signature=_Fri__28_Nov_2008_00_06_04_+0100_TPR0jPnm8vb9cxk.--
