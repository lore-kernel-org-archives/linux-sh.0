From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Mon, 21 Dec 2015 16:49:58 +0000
Subject: Re: [PATCH v2 2/9] ARM: mvebu: kirkwood: Add compatible property to "partitions" node
Message-Id: <87vb7rrbk9.fsf@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450694033-27717-1-git-send-email-geert+renesas@glider.be>
 <1450694033-27717-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1450694033-27717-3-git-send-email-geert+renesas@glider.be>
 (Geert Uytterhoeven's message of "Mon, 21 Dec 2015 11:33:46 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi Geert,
=20
 On lun., d=C3=A9c. 21 2015, Geert Uytterhoeven <geert+renesas@glider.be> w=
rote:

> As of commit e488ca9f8d4f62c2 ("doc: dt: mtd: partitions: add compatible
> property to "partitions" node"), the "partitions" subnode of an SPI
> FLASH device node must have a compatible property. The partitions are no
> longer detected if it is not present.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied on mvebu/dt

Thanks,

Gregory

> ---
> v2:
>   - New.
> ---
>  arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts b/arch/arm/=
boot/dts/kirkwood-pogoplug-series-4.dts
> index 1db6f2c506cce320..8082d64266a37c33 100644
> --- a/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> +++ b/arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
> @@ -131,6 +131,7 @@
>  	chip-delay =3D <40>;
>  	status =3D "okay";
>  	partitions {
> +		compatible =3D "fixed-partitions";
>  		#address-cells =3D <1>;
>  		#size-cells =3D <1>;
> =20
> --=20
> 1.9.1
>

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
