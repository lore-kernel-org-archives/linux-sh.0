From: Michal Simek <monstr@monstr.eu>
Date: Tue, 02 Jun 2015 07:20:28 +0000
Subject: Re: [PATCH v2] ARM: l2c: Add support for the "arm, shared-override" property
Message-Id: <556D593C.1090002@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="7xfAmuxuEe9FD7NlEFnd3RlIVCbjLquab"
List-Id: <linux-sh.vger.kernel.org>
References: <1430990831-23825-1-git-send-email-geert+renesas@glider.be>
 <20150507160257.GA11067@e104818-lin.cambridge.arm.com>
 <20150515101028.GH2067@n2100.arm.linux.org.uk>
 <20150515135513.GH19345@e104818-lin.cambridge.arm.com>
In-Reply-To: <20150515135513.GH19345@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7xfAmuxuEe9FD7NlEFnd3RlIVCbjLquab
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 05/15/2015 03:55 PM, Catalin Marinas wrote:
> On Fri, May 15, 2015 at 11:10:28AM +0100, Russell King - ARM Linux wrot=
e:
>> On Thu, May 07, 2015 at 05:02:57PM +0100, Catalin Marinas wrote:
>>> On Thu, May 07, 2015 at 11:27:11AM +0200, Geert Uytterhoeven wrote:
>>>> diff --git a/Documentation/devicetree/bindings/arm/l2cc.txt b/Docume=
ntation/devicetree/bindings/arm/l2cc.txt
>>>> index 0dbabe9a6b0abb91..2484aed78c86546d 100644
>>>> --- a/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/l2cc.txt
>>>> @@ -67,6 +67,12 @@ Optional properties:
>>>>    disable if zero.
>>>>  - arm,prefetch-offset : Override prefetch offset value. Valid value=
s are
>>>>    0-7, 15, 23, and 31.
>>>> +- arm,shared-override : The default behavior of the pl310 cache con=
troller with
>>>> +  respect to the shareable attribute is to transform "normal memory=

>>>> +  non-cacheable transactions" into "cacheable no allocate" (for rea=
ds) or
>>>> +  "write through no write allocate" (for writes).
>>>> +  On systems where this may cause DMA buffer corruption, this prope=
rty must be
>>>> +  specified to indicate that such transforms are precluded.
>>>> =20
>>>>  Example:
>>>> =20
>>>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>>>> index e309c8f35af5af61..86d0e7461e5b0b18 100644
>>>> --- a/arch/arm/mm/cache-l2x0.c
>>>> +++ b/arch/arm/mm/cache-l2x0.c
>>>> @@ -1149,6 +1149,11 @@ static void __init l2c310_of_parse(const stru=
ct device_node *np,
>>>>  		}
>>>>  	}
>>>> =20
>>>> +	if (of_property_read_bool(np, "arm,shared-override")) {
>>>> +		*aux_val |=3D L2C_AUX_CTRL_SHARED_OVERRIDE;
>>>> +		*aux_mask &=3D ~L2C_AUX_CTRL_SHARED_OVERRIDE;
>>>> +	}
>>>> +
>>>>  	prefetch =3D l2x0_saved_regs.prefetch_ctrl;
>>>> =20
>>>>  	ret =3D of_property_read_u32(np, "arm,double-linefill", &val);
>>>
>>> It looks fine to me.
>>>
>>> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>>>
>>> (even better if a subsequent patch adds this property to all the dts
>>> files containing "arm,pl310" ;))
>>
>> Even better would be for the boot loader/firmware to set the bit.
>=20
> In an ideal world, I agree. But, arguably, we already set other bits in=

> the PL310 AUXCTRL register (and related cache controllers, just look at=

> the l2cc.txt bindings).
>=20
> If you want to rely on firmware, can we at least check this bit and
> print a warning? Or go a step further and refuse to enable PL310 when
> this bit is clear? Otherwise coherent (non-cacheable) DMA operations ar=
e
> not safe.
>=20

Any update on this one? I have the patch for Zynq pending and I want to
have any resolution on this in this generic way or simply by enabling it
via aux_mask as is here.
https://lkml.org/lkml/2015/5/12/51
This patch can be reverted when this generic solution reach mainline.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform



--7xfAmuxuEe9FD7NlEFnd3RlIVCbjLquab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlVtWUAACgkQykllyylKDCEKjACfQ1kniS1DNuiho3bok0WR6+t4
rBgAnA5y0WYDhXbouQQCJOWU7pno0tPs
=vSHA
-----END PGP SIGNATURE-----

--7xfAmuxuEe9FD7NlEFnd3RlIVCbjLquab--
