Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1731401B
	for <linux-sh@vger.kernel.org>; Sat, 26 Jul 2025 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753542748; cv=none; b=b50sNamPyodAangIFWHpszPl+9PouNPs7/zxVJxJ+GwNTAwohph5HIbhOEdSL/nrfqlZ/CXPnCpFRMh/rDCIhTuhaPe3xKqQcDfSipig7s6s1/nrntSX590w6TJvA1S9FPE+OavvLxe/AvwJMU4R8SimN+CgP2fYqKdAyjmIavM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753542748; c=relaxed/simple;
	bh=6P1ruv61hwkd+gnxgsWRzMkwdRvS5fCByEgkF9lbOXU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gc6BNC47kutMIHPri0ZczKtFdj5XTkPZyheIQJ+xwitBG4EVvN0dj7fJaZdz5R32LIAoPT/PsUvKp0GRkamO+1JuouQwRTdem0BjOH7xm1E8UaGH+S6nr1AMQ5RWDL2t4sD2S5uAC6k+zbUDgFqOIa/GOr/BOhakA/+lEZgefW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=WXzno1Dc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="WXzno1Dc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SVNDx25B7rquYb6lO8NUdRJIYlK9ZndTBks1jZmGpGo=; t=1753542744; x=1754147544; 
	b=WXzno1Dcr0jkQrJr5y1iGyP5jTlLvy1fkJtZAiqQ+k9CzBnPntfMGEP0Yjf3CEHo5DrpW3Nwj75
	9u9kYYVc9OoEb9IDw709k1ZFr5FojnkJliQOG8oZ3xsP+Rb8z8+1lRC1jVjT3OPe27WeLuHk6SkO8
	+JfMbFjptH3p7I4HustfP47fCcOekBlqKYtUP0RAWvLUtmUi8NVjIoYS1mArpYuvXSDVOmsn/ZxzA
	gg7k6zZQZEQLZ5dboZOaOBj2eWZrnr0ullcBvJGDvMC7ks4Wjs37irVrPaUu7kcfI6fpr2q4L+6Oy
	IQOwqt4Jvg0sjTKl160WpQ7YOU/9Ajnd6lZA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ufgZN-00000000zLp-1RJB; Sat, 26 Jul 2025 17:12:17 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ufgZN-000000021zv-0J6A; Sat, 26 Jul 2025 17:12:17 +0200
Message-ID: <3760fe04cbc98d6ad63b68c29481de6bda774632.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Do not use hyphen in exported variable name
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Ben Hutchings <benh@debian.org>
Cc: linux-sh@vger.kernel.org
Date: Sat, 26 Jul 2025 17:12:16 +0200
In-Reply-To: <aHkNBHnFT68xvwjK@decadent.org.uk>
References: <aHkNBHnFT68xvwjK@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Ben,

On Thu, 2025-07-17 at 16:47 +0200, Ben Hutchings wrote:
> arch/sh/Makefile defines and exports ld-bfd to be used by
> arch/sh/boot/compressed/Makefile and arch/sh/boot/romimage/Makefile.
> However some shells, including dash, will not pass through environment
> variables whose name includes a hyphen.  Usually GNU make does not use
> a shell to recurse, but if e.g. $(srctree) contains '~' it will use a
> shell here.
>=20
> Other instances of this problem were previously fixed by commits
> 2bfbe7881ee0 "kbuild: Do not use hyphen in exported variable name"
> and 82977af93a0d "sh: rename suffix-y to suffix_y".
>=20
> Rename the variable to ld_bfd.
>=20
> References: https://buildd.debian.org/status/fetch.php?pkg=3Dlinux&arch=
=3Dsh4&ver=3D4.13%7Erc5-1%7Eexp1&stamp=3D1502943967&raw=3D0
> Fixes: 7b022d07a0fd ("sh: Tidy up the ldscript output format specifier.")
> Signed-off-by: Ben Hutchings <benh@debian.org>
> ---
> v2: Updated after the use of suffix-y was fixed separately.
>=20
> v1 is archived at
> https://lore.kernel.org/linux-sh/20170819213109.GJ18698@decadent.org.uk/
>=20
>  arch/sh/Makefile                 | 10 +++++-----
>  arch/sh/boot/compressed/Makefile |  4 ++--
>  arch/sh/boot/romimage/Makefile   |  4 ++--
>  3 files changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index cab2f9c011a8..7b420424b6d7 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -103,16 +103,16 @@ UTS_MACHINE		:=3D sh
>  LDFLAGS_vmlinux		+=3D -e _stext
> =20
>  ifdef CONFIG_CPU_LITTLE_ENDIAN
> -ld-bfd			:=3D elf32-sh-linux
> -LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64 --oformat $(ld-bfd)
> +ld_bfd			:=3D elf32-sh-linux
> +LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64 --oformat $(ld_bfd)
>  KBUILD_LDFLAGS		+=3D -EL
>  else
> -ld-bfd			:=3D elf32-shbig-linux
> -LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64+4 --oformat $(ld-bfd=
)
> +ld_bfd			:=3D elf32-shbig-linux
> +LDFLAGS_vmlinux		+=3D --defsym jiffies=3Djiffies_64+4 --oformat $(ld_bfd=
)
>  KBUILD_LDFLAGS		+=3D -EB
>  endif
> =20
> -export ld-bfd
> +export ld_bfd
> =20
>  # Mach groups
>  machdir-$(CONFIG_SOLUTION_ENGINE)		+=3D mach-se
> diff --git a/arch/sh/boot/compressed/Makefile b/arch/sh/boot/compressed/M=
akefile
> index 8bc319ff54bf..58df491778b2 100644
> --- a/arch/sh/boot/compressed/Makefile
> +++ b/arch/sh/boot/compressed/Makefile
> @@ -27,7 +27,7 @@ endif
> =20
>  ccflags-remove-$(CONFIG_MCOUNT) +=3D -pg
> =20
> -LDFLAGS_vmlinux :=3D --oformat $(ld-bfd) -Ttext $(IMAGE_OFFSET) -e start=
up \
> +LDFLAGS_vmlinux :=3D --oformat $(ld_bfd) -Ttext $(IMAGE_OFFSET) -e start=
up \
>  		   -T $(obj)/../../kernel/vmlinux.lds
> =20
>  KBUILD_CFLAGS +=3D -DDISABLE_BRANCH_PROFILING
> @@ -51,7 +51,7 @@ $(obj)/vmlinux.bin.lzo: $(obj)/vmlinux.bin FORCE
> =20
>  OBJCOPYFLAGS +=3D -R .empty_zero_page
> =20
> -LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld-bfd) -T
> +LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld_bfd) -T
> =20
>  $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/vmlinux.bin.$(suffix_y) FORCE
>  	$(call if_changed,ld)
> diff --git a/arch/sh/boot/romimage/Makefile b/arch/sh/boot/romimage/Makef=
ile
> index c7c8be58400c..17b03df0a8de 100644
> --- a/arch/sh/boot/romimage/Makefile
> +++ b/arch/sh/boot/romimage/Makefile
> @@ -13,7 +13,7 @@ mmcif-obj-$(CONFIG_CPU_SUBTYPE_SH7724)	:=3D $(obj)/mmci=
f-sh7724.o
>  load-$(CONFIG_ROMIMAGE_MMCIF)		:=3D $(mmcif-load-y)
>  obj-$(CONFIG_ROMIMAGE_MMCIF)		:=3D $(mmcif-obj-y)
> =20
> -LDFLAGS_vmlinux :=3D --oformat $(ld-bfd) -Ttext $(load-y) -e romstart \
> +LDFLAGS_vmlinux :=3D --oformat $(ld_bfd) -Ttext $(load-y) -e romstart \
>  		   -T $(obj)/../../kernel/vmlinux.lds
> =20
>  $(obj)/vmlinux: $(obj)/head.o $(obj-y) $(obj)/piggy.o FORCE
> @@ -24,7 +24,7 @@ OBJCOPYFLAGS +=3D -j .empty_zero_page
>  $(obj)/zeropage.bin: vmlinux FORCE
>  	$(call if_changed,objcopy)
> =20
> -LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld-bfd) -T
> +LDFLAGS_piggy.o :=3D -r --format binary --oformat $(ld_bfd) -T
> =20
>  $(obj)/piggy.o: $(obj)/vmlinux.scr $(obj)/zeropage.bin arch/sh/boot/zIma=
ge FORCE
>  	$(call if_changed,ld)

Thanks for fixing this! Looks good to me. I will pick this up for v6.17.

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
