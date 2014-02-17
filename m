From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 17 Feb 2014 07:54:10 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7791: add i2c master nodes to dtsi
Message-Id: <20140217075410.GA2633@katana>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
List-Id: <linux-sh.vger.kernel.org>
References: <1392543658-5030-1-git-send-email-wsa@the-dreams.de>
 <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1392543658-5030-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 16, 2014 at 10:40:55AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa@sang-engineering.com>
>=20
> Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>

=46rom your other mail:

"[2/5] needs to be reworked to exclude the r8a7790 compatible string."

> +		compatible =3D "renesas,i2c-r8a7791", "renesas,i2c-r8a7790";

Why is that? From my knowledge, you start with the exact compatible
property and hardware compatible entries may follow. This is backed up
by Documentation/devicetree/usage-model.txt:

=3D=3D=3D

The 'compatible' property contains a sorted list of strings starting
with the exact name of the machine, followed by an optional list of
boards it is compatible with sorted from most compatible to least.

=3D=3D=3D

And from the devicetree wiki [1]:

=3D=3D=3D

compatible is a list of strings. The first string in the list specifies
the exact device that the node represents in the form
"<manufacturer>,<model>". The following strings represent other devices
that the device is compatible with.

For example, the Freescale MPC8349 System on Chip (SoC) has a serial
device which implements the National Semiconductor ns16550 register
interface. The compatible property for the MPC8349 serial device should
therefore be: compatible =3D "fsl,mpc8349-uart", "ns16550". In this case,
fsl,mpc8349-uart specifies the exact device, and ns16550 states that it
is register-level compatible with a National Semiconductor 16550 UART.

Note: ns16550 doesn't have a manufacturer prefix purely for historical
reasons. All new compatible values should use the manufacturer prefix.

This practice allows existing device drivers to be bound to a newer
device, while still uniquely identifying the exact hardware.

=3D=3D=3D

Has this changed?


[1 ]http://www.devicetree.org/Device_Tree_Usage#Understanding_the_compatibl=
e_Property

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTAcAiAAoJEBQN5MwUoCm2Jz4P/irjokpgCIwmmN9zSwYYnfyN
5lxs8ayfujF4lko7g+5UbaNiP0O/FcJj2czhx086hn97qDBTWLB92spr3OLZEkGs
6+30Nokl1utcm3KLsmEf6IGQ9RusBUs6/MGC+S6pb6Ygcf5VnKOvnduLU6cuq5FD
Ho54Lg0aiFb93D/jcAarg3WINRYdHDV4l35oC7yRzrvAEP5OeuCbDV0+tuPNMudE
IZTZ8YIKkFPpzvLjUaSV+XE+Rn62JTyiKUy1wKVU7bUhKisn5tgZAaq1m+O2hGyn
bRXWOl1rNWmfcTNmHxwzToRSTzvUp4ax3vQCUARIAMLbMw2vcLtTXbZ7JgpNNZqv
DcdYYm+wtK2zxG/d2RMYktfpSoFLqCfnBXQpaS9c2EZRlUfGG8Qc3qAX163xObEO
sMjwdc6hqC7c0v+jsECUGp8EtFR4v0MYxXzs4J1mIXHTj+BFCoCTgyTwK+fYv4kJ
ikzzxHGoLS5kjcKqQL0y6ndyxwxlRTamKFJqItgNdBpG7kXHHniHjIkg9/I//wv/
v9HU2+eoFwkgnGYcuMGe5XeygwabaMYXenCGxOMI6qA/NvnthViS47DlJa7OW1UU
VmPduFbGthdG5fSpR8oPYdGyWFxbpCM8jLCcyv/FKNJ/j/Y+auXdrAZzfTiHFOEj
HT8PENMF+IFB9AeRQ7WF
=/EyY
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
