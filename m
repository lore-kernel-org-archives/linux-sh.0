From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 02 Mar 2015 18:32:46 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: R-Car Gen2: Add da9063/da9210 regulator quirk
Message-Id: <20150302183246.GA25839@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="1yeeQ81UyVL57Vl7"
List-Id: <linux-sh.vger.kernel.org>
References: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425317323-5898-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Geert,

On Mon, Mar 02, 2015 at 06:28:43PM +0100, Geert Uytterhoeven wrote:
> The r8a7791/koelsch development board has da9063 and da9210 regulators.
> Both regulators have their interrupt request lines tied to the same
> interrupt pin (IRQ2) on the SoC.
>=20
> After boot-up, both the da9063 and da9210 seem to assert their interrupt
> request lines.  Hence as soon as one driver requests this irq, it gets
> stuck in an interrupt storm, as it only manages to deassert its own
> interrupt request line, and the other driver hasn't installed an
> interrupt handler yet.
>=20
> To handle this, install a quirk that masks the interrupts in both the
> da9063 and da9210.  This quirk has to run after the i2c master driver
> has been initialized, but before the i2c slave drivers are initialized.
>=20
> On koelsch, the following happens:
>=20
>   - Cold boot or reboot using the da9063 restart handler:
>=20
> 	IRQ2 is asserted, installing da9063/da9210 regulator quirk
> 	...
> 	i2c i2c-6: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0x3fb
> 	i2c 6-0058: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0x3fb
> 	i2c 6-0058: Detected da9063
> 	i2c 6-0058: Masking da9063 interrupt sources
> 	i2c 6-0068: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0x3fb
> 	i2c 6-0068: Detected da9210
> 	i2c 6-0068: Masking da9210 interrupt sources
> 	i2c 6-0068: IRQ2 is not asserted, removing quirk
>=20
>   - Warm boot (reset button):
>=20
> 	rcar_gen2_regulator_quirk: IRQ2 is not asserted, not installing quirk
>=20
> Not-yet-signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Based on the schematics, I believe r8a7790/lager is also affected.

Boot log from Lager (cold boot & watchdog reboot):

[    0.117037] IRQ2 is asserted, installing da9063/da9210 regulator quirk
[    0.162803] i2c i2c-4: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.163050] i2c-sh_mobile e6500000.i2c: I2C adapter 4, bus speed 100000 =
Hz
[    0.164283] i2c i2c-5: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.164481] i2c-sh_mobile e6510000.i2c: I2C adapter 5, bus speed 100000 =
Hz
[    0.165836] i2c i2c-6: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.166352] i2c 6-0012: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.166425] i2c 6-0012: Detected ak4643
[    0.166891] i2c 6-0020: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.166963] i2c 6-0020: Detected adv7180
[    0.167421] i2c 6-0039: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.167494] i2c 6-0039: Detected adv7511w
[    0.167630] i2c-sh_mobile e6520000.i2c: I2C adapter 6, bus speed 100000 =
Hz
[    0.168805] i2c i2c-7: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.169343] i2c 7-0058: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.169415] i2c 7-0058: Detected da9063
[    0.169479] i2c 7-0058: Masking da9063 interrupt sources
[    0.175641] i2c 7-0068: regulator_quirk_notify: 1, IRQC_MONITOR =3D 0xb
[    0.175715] i2c 7-0068: Detected da9210
[    0.175778] i2c 7-0068: Masking da9210 interrupt sources
[    0.176757] i2c 7-0068: IRQ2 is not asserted, removing quirk

Reboot using reset:

[    0.117819] rcar_gen2_regulator_quirk: IRQ2 is not asserted, not install=
ing quirk

So, not surprisingly, no difference to Koelsch. For completeness, I disabled
installing the notifier and got the interrupt storm again. So:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

> +#ifdef CONFIG_I2C

Is it a realistic scenario that I2C and slave drivers are modules?

> +static int regulator_quirk_notify(struct notifier_block *nb,
> +				  unsigned long action, void *data);

This forward declaration can be skipped...

> +
> +static struct notifier_block regulator_quirk_nb =3D {
> +	.notifier_call =3D regulator_quirk_notify
> +};

=2E.. if you move this after the notfier function.

Other than that the code looks okay to me (given that this is a quirk
workaround).

Regards,

   Wolfram


--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9KzOAAoJEBQN5MwUoCm2LtkQAI+md66WJ+1ceE05TVLZvbeK
PGTs507QOX6kfME24hxIlSf4N8IzxN9JAK6/cLvxsGxMif5zyiunq3C5UzFSCEHe
6/cNnL1aqTrmomuBKxm7kJFfUvKdCWdftKBSivmU2ur6qkzPDWBkKwwvVQyI4W2W
c+EqKCWvTotzI3vFh+IY1qhSSqjHACZhBI1wHGtX4/jRLToss9TL3yI0xUdnr4tv
R0BHKms+ebB5E6m0E+P173DHOevcs5B2+w/+jCM032FTEreWQN+qcPd4aBdh0vQn
yAMxEO6fiQOIjwZOaGRk0hVaBqqDFBCxsBviW1YBg0/XWBIhkelyVIs1CHrjAh7B
SSsGvb2C+9BMc5af0G3CeJ8rVLwb95e68LwgRXtfVyTXrUKuHRVCGGn5XbWFdT7v
KFdJobo4Tp6dTNvVycaATyeDls4EjXO7NDHZ+5eWG8/8OCuskhqqtE9apDi3ugkL
ka2Jv7q55vPoXZymthc8v3LsdzuSUIYH7Xx+oRhFsqrqAH8eTZ5XFlXzNKFD5Msa
4FGpiLg4CSxCJLFNbWBYcs1uvBz0gIpvub20qb3sshTPM+nnfN+cMFy8HOjo/OJW
eD5Xm62lNe1sAEDhwo1ukmv4C90UkzMXa3iLHKrgubVcPzlXERrt6mL23H4SfgI4
mknW2ZY4RHGRF+xw5IVy
=/XEx
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
