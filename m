From: Shea Levy <shea@shealevy.com>
Date: Sun, 25 Mar 2018 22:20:02 +0000
Subject: Re: [PATCH 01/16] initrd: Add generic code path for common initrd unloading logic.
Message-Id: <87r2o7u7al.fsf@xps13.shealevy.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <linux-sh.vger.kernel.org>
References: <20180324174458.26423-1-shea@shealevy.com> <20180324174458.26423-2-shea@shealevy.com> <20180325191740.Horde.Cymi0yr0xcQQV1s42wkNkg2@messagerie.si.c-s.fr>
In-Reply-To: <20180325191740.Horde.Cymi0yr0xcQQV1s42wkNkg2@messagerie.si.c-s.fr>
To: LEROY Christophe <christophe.leroy@c-s.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-parisc@vger.kernel.org, openrisc@lists.librecores.org, nios2-dev@lists.rocketboards.org, linux-m68k@lists.linux-m68k.org, uclinux-h8-devel@lists.sourceforge.jp, linux-c6x-dev@linux-c6x.org, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

LEROY Christophe <christophe.leroy@c-s.fr> writes:

> Shea Levy <shea@shealevy.com> a =C3=A9crit=C2=A0:
>
>> Signed-off-by: Shea Levy <shea@shealevy.com>
>> ---
>>  init/initramfs.c | 7 +++++++
>>  usr/Kconfig      | 4 ++++
>>  2 files changed, 11 insertions(+)
>>
>> diff --git a/init/initramfs.c b/init/initramfs.c
>> index 7e99a0038942..de5ce873eb5a 100644
>> --- a/init/initramfs.c
>> +++ b/init/initramfs.c
>> @@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
>>  #include <linux/initrd.h>
>>  #include <linux/kexec.h>
>>
>> +#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
>> +void free_initrd_mem(unsigned long start, unsigned long end)
>> +{
>> +       free_reserved_area((void *)start, (void *)end, -1, "initrd");
>> +}
>> +#endif
>
> In powerpc this was an __init function. Why not also put the generic=20=20
> one in __init section ?
>

v2 series sent, thanks!

>
> Christophe
>
>
>> +
>>  static void __init free_initrd(void)
>>  {
>>  #ifdef CONFIG_KEXEC_CORE
>> diff --git a/usr/Kconfig b/usr/Kconfig
>> index 43658b8a975e..fd79d4d6fa26 100644
>> --- a/usr/Kconfig
>> +++ b/usr/Kconfig
>> @@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
>>  	default ".lzma" if RD_LZMA
>>  	default ".bz2"  if RD_BZIP2
>>  	default ""
>> +
>> +# Arches can select this for a generic initrd unloading codepath
>> +config INITRAMFS_GENERIC_UNLOAD
>> +	bool
>> --
>> 2.16.2

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE6ESKvwKkwnxgMLnaXAvWlX2G/icFAlq4IJIACgkQXAvWlX2G
/ie5Kg//WRsmE69HlU4LGgsmarn8fdi2QRuZ+l/ywz9000PwGi2Rf2prd6YfK03r
r/JSOgq3kCyGN2ifjCa++0IAvJT438Yzjxieqi5t28mm58I9VOfaWhGebd9gq4vV
xaFLnrTlbSYSPMlhm4gbjDv13na+i+qm6Gqje/TF5AILIHTXxfxg//SgKY0vaAPi
xBZJCaCEZJdO84/mVKeqO/Ape+/ibxtmjDtc/CIxyt8uSPeBqDqkxyQO8/1DFXea
UhYDdnzRyqzG4JGgC+CvrV6T6b8Z5yKFUx3w0CSfE69ypeYHNnzCRVOsPNGxFGQD
v1INTKVjedr9J9PvrtZZmRKHgmzwRgVWPp9uiNIcxxJcuywfeoI/sZwYRRfM2wnB
1pMZsQI1Z4a9GIZ/j9GORajQlKOGp0SDSEDFBLBQ5JS7X4CnFrN/6b/I+AMeBzLa
rK70FQwikNVuWXpOtRh0BEJClYE6HdjRqrkvnOt181vZOb8GPVabu69a7xI8fGCm
B7nn+GLpD3SUGNRaUfWk76hrt+Kz2Dlg/5ATDcEHlkw+ZQypwR18Wop2qcuVcpsp
XjiACAXCDtI5vyud3S0d9ucED0YV90VFdnFfSOs0OXnGPrOfj2Zo6sKPMHxpNzF4
ni7nW+ciXNm79Ex05TQdxB4Z6hZ5g6/NFkdbGrOEvjUvcFBNnEM=
=IIzv
-----END PGP SIGNATURE-----
--=-=-=--
