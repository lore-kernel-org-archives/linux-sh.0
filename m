Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84F1E4B2
	for <linux-sh@vger.kernel.org>; Tue,  8 Apr 2025 13:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744117825; cv=none; b=j6/uYuPiQS+ZtgDrJuAb5yz2fgX5D1yPz1Hgo5ryOScWEVKqA31XZS081IA2I+PfkXeDQnc1BtPTUtdqXUnbGFBF9yT91ela4gMqoQBt9MZQaBlEXg+TBlg5e0y+q1UXVx+qYbU39b2ljU0YUZk6HmHu62JppTZPaDr0fgKapco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744117825; c=relaxed/simple;
	bh=qB6d6QkSryDloxaWdVux4/ao5/NuNn5NtovzT1k8bRM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7eMuVmNwOUsCqdQMWPKDDSRawJD+iRUoWDwTW4izU0yDHN91z7Jt5+GE8rHWRjoCifNVwBZKa73ZkPsoxTyAR0mABHznNy2WuWVPv5eiGVsbMolaztMfkZimwCWVf8RtSRWWrYmAjU53AJMmPHMEziEG78YVeQJSBQlbsqqPnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=kZOfpiOs; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="kZOfpiOs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4Tnuv1Eg39kdeS2vh8rfuM4F/Oaj1zrr3alU5FZMpSU=; t=1744117821; x=1744722621; 
	b=kZOfpiOs0FQaLefx9KcNnCXSwuY9LK3Bdf4k6pKSkM8QEgIZqTXWd2DG5ft+XAIhgkGC1BA99pe
	GPc/fJ5TZ3zKmLdfch4zfIEZTGqnFOWEi6uw5IonDjHJUCul8+/o2VJ2gT5PdjMZqvchiI6EUmJbx
	llt0aR9+TLdXZWYQsirPPATDKNxwwCJ62V9ESAKU5oaeOwjK/TiwI0qCWG5LprWk/1MVmYLsgMQwI
	svz7olna49Y/9EEbfXA1qAAjqHQ1zAdzqeB7BMyWIllW4NqtIETYRz2PhuJoyI6q6rzZhrUWNxjmT
	N2Y3KhKUjik9B8iduQXfw/Juc9w2GlZ5dOJA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1u28iT-00000001c4O-3nZ0; Tue, 08 Apr 2025 15:10:13 +0200
Received: from p5dc5515a.dip0.t-ipconnect.de ([93.197.81.90] helo=[192.168.178.61])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1u28iT-00000002uE0-3477; Tue, 08 Apr 2025 15:10:13 +0200
Message-ID: <0fa5c6c87fd38d71fcd4bee24affa3c57ed180c1.camel@physik.fu-berlin.de>
Subject: Re: Did I ever post my sh fdpic-on-mmu patch here?
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Rob Landley <rob@landley.net>
Cc: linux-sh@vger.kernel.org
Date: Tue, 08 Apr 2025 15:10:13 +0200
In-Reply-To: <3699fd5c-a856-4f9f-a4c6-edc9f76e6cf8@landley.net>
References: <11c0bf9e-0918-4739-8245-41a8bfa2bf1a@landley.net>
	 <034795475781c8ccd10b553ebe8517eaf1f01bbc.camel@physik.fu-berlin.de>
	 <3699fd5c-a856-4f9f-a4c6-edc9f76e6cf8@landley.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Rob,

On Tue, 2025-04-08 at 07:59 -0500, Rob Landley wrote:
> > Could you post the patch with git-send-email so that it's inline and ca=
n be
> > reviewed on the list?
>=20
> Dreamhost's outgoing smtp server requires ssl and a login, so probably=
=20
> not easily? But let's see...
>=20
> $ man git-send-email
> No manual entry for git-send-email
> $ git help send-email
> No manual entry for gitsend-email
> $ git send-email
> git: 'send-email' is not a git command. See 'git --help'.
> $ git-send-email
> bash: git-send-email: command not found

On Ubuntu/Debian, Fedore and openSUSE, you need to install the package
git-email for git send-email to work.

To set it up and send a kernel patch with, I recommend this guide:

https://nickdesaulniers.github.io/blog/2017/05/16/submitting-your-first-pat=
ch-to-the-linux-kernel-and-responding-to-feedback/

> Oh good grief, here:
>=20
> From: Rob Landley <rob@landley.net>
>=20
> Allow CONFIG_BINFMT_ELF_FDPIC loader to build on sh4 with mmu, same as ar=
m.
>=20
> --
>=20
>   arch/sh/kernel/setup.c |   25 +++++++++++++++++++++++++
>   fs/Kconfig.binfmt      |    2 +-
>   2 files changed, 26 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index d3175f09b3aa..effda8b21370 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -404,3 +404,28 @@ void __init arch_cpu_finalize_init(void)
>   #endif
>   	*p =3D '\0';
>   }
> +
> +#if defined(CONFIG_MMU) && defined(CONFIG_BINFMT_ELF_FDPIC)
> +
> +#include <linux/personality.h>
> +#include <linux/elf-fdpic.h>
> +
> +void elf_fdpic_arch_lay_out_mm(struct elf_fdpic_params *exec_params,
> +                               struct elf_fdpic_params *interp_params,
> +                               unsigned long *start_stack,
> +                               unsigned long *start_brk)
> +{
> +	set_personality((current->personality & ~PER_MASK) | PER_LINUX);
> +
> +        exec_params->load_addr =3D 0x8000;
> +        interp_params->load_addr =3D ELF_ET_DYN_BASE;
> +        *start_stack =3D TASK_SIZE - SZ_16M;
> +
> +        if ((exec_params->flags & ELF_FDPIC_FLAG_ARRANGEMENT) =3D=3D=20
> ELF_FDPIC_FLAG_INDEPENDENT) {
> +                exec_params->flags &=3D ~ELF_FDPIC_FLAG_ARRANGEMENT;
> +                exec_params->flags |=3D ELF_FDPIC_FLAG_CONSTDISP;
> +        }
> +}
> +
> +#endif
> +
> diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
> index f5693164ca9a..ba8c5fc81da4 100644
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -58,7 +58,7 @@ config ARCH_USE_GNU_PROPERTY
>   config BINFMT_ELF_FDPIC
>   	bool "Kernel support for FDPIC ELF binaries"
>   	default y if !BINFMT_ELF
> -	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)
> +	depends on ARM || SUPERH || ((M68K || RISCV || XTENSA) && !MMU)
>   	select ELFCORE
>   	help
>   	  ELF FDPIC binaries are based on ELF, but allow the individual load
>=20
> > This makes it easier for review and pick up with the
> > b4 utility
>=20
> https://landley.net/notes-2024.html#09-04-2024
>=20
> > and it's easily accessible though patchwork.
>=20
> The above is "xclip -sel c < file.patch" which I then pasted "as=20
> quotation" into thunderbird and hit delete twice at the start of each=20
> line to take the "> " off but it's still in the magic "blue text because=
=20
> quotation" state that _should_ prevent line wrapping? (It does for the=
=20
> UI, I _think_ that carries through to sending? No of course disabling=20
> HTML email doesn't stop the compose window from maintaining unwanted=20
> markup...)
>=20
> If that doesn't work, I have to track down a version of the no-wordwrap=
=20
> plugin that works with current thunderbird. (The one I was using went=20
> away in plugin api version skew du jour during the distro upgrade that=
=20
> might let me back onto the python version treadmill b4 enforces.)

Please try to follow the guide above first and if that fails, we can still
find a way. I just want to make sure the proper format is chosen so it goes
through the right channels.

If everything else fails, I can send the patch on your behalf while keeping
your authorship.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
