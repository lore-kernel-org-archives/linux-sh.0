Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C172A1AA;
	Tue, 16 Jul 2024 10:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721126559; cv=none; b=etRjccUF4ry3YW7RX4cmIi70aAA8ZscZLjM13ONQcHo5RgCq7LPlyvWilPFfA2WNZ0Usbi4FCjrGZxufVbjt7RjhANE3qdGQiKasUxjXfRWpxrO9dVlKN9dRIHtS0rVoHVJRCmPTFFszlq0Kz64Lh5TpJ/3gPVBmAL9LjyFAIZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721126559; c=relaxed/simple;
	bh=7RFgBSAJPt04ugNtDQl1deQ9AiecSraMLJ21oXU/DcU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ArdLaO+7UgH6Q5wJNVR5jkcGYtkU6fSZg7DdZNaM9+W8pnjA4N50giYTfn1pNU0ves6m4MXnfc/c4Hnhl9SfaOn8E0AUKEjTLpZFvFZIYSnBg7DnjCAGhp0i5eXbgimqs1XJFj25S43Joj8CCDdWs2+yIenqSkBe1JcJCdZ0Cc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=P4Osg0Yc; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="P4Osg0Yc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SCZEah6PrbXpH+8WsAlk6jvlK8Lxwf0+bb+aHDaft3Q=; t=1721126555; x=1721731355; 
	b=P4Osg0YcIpE/9ickX5HeyJ7iCJ4buHCDKscwAJLZ5e+2zIpBEvYTHgpXTRd40FviSDEPP644fXy
	4UMVMboTGyu/cJ7W9TQoCYpx6JmYd6sOirXvjK+42yKLVdVgveWkBA5aAJNAo8ZwIQIAZ+tYGuI3P
	mqpOC4s7hWd69r+WpTniJZUeS03E4fnaL302Xc6BRQnYD/PWCtmQtylnnzE6WdH2JgsXXm+qvqVdw
	GYf2IRRCETkRXA3HePTZKPYBUkSFt2aMe8DFEGrqO844DheoeczUZVuttrSQXPiZ1UjSU4/N6L57M
	udTnOqPTPkDidhw/gEoPGJSB/XUYHkSG6tQQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sTfda-00000000z39-3Z71; Tue, 16 Jul 2024 12:42:26 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sTfda-000000023xN-2euo; Tue, 16 Jul 2024 12:42:26 +0200
Message-ID: <831887db73d9eafc50940315ed44139107bd5f2a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v4] sh: Restructure setup code to reserve memory regions
 earlier
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org,  kernel@quicinc.com
Date: Tue, 16 Jul 2024 12:42:25 +0200
In-Reply-To: <121b8077-bc6d-42a3-8ec2-c792e84bd947@quicinc.com>
References: <20240711214438.3920702-1-quic_obabatun@quicinc.com>
	 <a68b7cd0e3b143f023414feca279deb768d43575.camel@physik.fu-berlin.de>
	 <121b8077-bc6d-42a3-8ec2-c792e84bd947@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Mon, 2024-07-15 at 17:12 -0700, Oreoluwa Babatunde wrote:
> On 7/13/2024 12:58 AM, John Paul Adrian Glaubitz wrote:
>=20
> Hi Adrian,
>=20
> > > diff --git a/arch/sh/include/asm/setup.h b/arch/sh/include/asm/setup.=
h
> > > index 84bb23a771f3..f8b814fb1c7f 100644
> > > --- a/arch/sh/include/asm/setup.h
> > > +++ b/arch/sh/include/asm/setup.h
> > > @@ -19,7 +19,6 @@
> > >  #define COMMAND_LINE ((char *) (PARAM+0x100))
> > > =20
> > >  void sh_mv_setup(void);
> > > -void check_for_initrd(void);
> > >  void per_cpu_trap_init(void);
> > >  void sh_fdt_init(phys_addr_t dt_phys);
> > > =20
> > > diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> > > index 620e5cf8ae1e..8477491f4ffd 100644
> > > --- a/arch/sh/kernel/setup.c
> > > +++ b/arch/sh/kernel/setup.c
> > > @@ -35,6 +35,7 @@
> > >  #include <asm/io.h>
> > >  #include <asm/page.h>
> > >  #include <asm/elf.h>
> > > +#include <asm/kexec.h>
> > >  #include <asm/sections.h>
> > >  #include <asm/irq.h>
> > >  #include <asm/setup.h>
> > > @@ -114,7 +115,7 @@ static int __init early_parse_mem(char *p)
> > >  }
> > >  early_param("mem", early_parse_mem);
> > > =20
> > > -void __init check_for_initrd(void)
> > > +static void __init check_for_initrd(void)
> > >  {
> > >  #ifdef CONFIG_BLK_DEV_INITRD
> > >  	unsigned long start, end;
> > > @@ -172,6 +173,42 @@ void __init check_for_initrd(void)
> > >  #endif
> > >  }
> > Making check_for_initrd() static seems like an unrelated change to me o=
r am
> > I missing something? If yes, it should go into a separate patch.
> ack.
> > > +static void __init early_reserve_mem(void)
> > > +{
> > > +	unsigned long start_pfn;
> > > +	u32 zero_base =3D (u32)__MEMORY_START + (u32)PHYSICAL_OFFSET;
> > > +	u32 start =3D zero_base + (u32)CONFIG_ZERO_PAGE_OFFSET;
> > > +
> > > +	/*
> > > +	 * Partially used pages are not usable - thus
> > > +	 * we are rounding upwards:
> > > +	 */
> > > +	start_pfn =3D PFN_UP(__pa(_end));
> > > +
> > > +	/*
> > > +	 * Reserve the kernel text and Reserve the bootmem bitmap. We do
> > > +	 * this in two steps (first step was init_bootmem()), because
> > > +	 * this catches the (definitely buggy) case of us accidentally
> > > +	 * initializing the bootmem allocator with an invalid RAM area.
> > > +	 */
> > > +	memblock_reserve(start, (PFN_PHYS(start_pfn) + PAGE_SIZE - 1) - sta=
rt);
> > > +
> > > +	/*
> > > +	 * Reserve physical pages below CONFIG_ZERO_PAGE_OFFSET.
> > > +	 */
> > > +	if (CONFIG_ZERO_PAGE_OFFSET !=3D 0)
> > > +		memblock_reserve(zero_base, CONFIG_ZERO_PAGE_OFFSET);
> > > +
> > > +	/*
> > > +	 * Handle additional early reservations
> > > +	 */
> > > +	check_for_initrd();
> > > +	reserve_crashkernel();
> > > +
> > > +	if (sh_mv.mv_mem_reserve)
> > > +		sh_mv.mv_mem_reserve();
> > > +}
> > > +
> > >  #ifndef CONFIG_GENERIC_CALIBRATE_DELAY
> > >  void calibrate_delay(void)
> > >  {
> > I'm not really happy with moving early_reserve_mem() from mm/init.c to
> > kernel/setup.c. Can't we just leave it where it is while still keeping
> > the changes to paging_init()?
> ack.
> >=20
> > > @@ -319,9 +356,14 @@ void __init setup_arch(char **cmdline_p)
> > > =20
> > >  	sh_mv_setup();
> > > =20
> > > +	sh_mv.mv_mem_init();
> > > +
> > >  	/* Let earlyprintk output early console messages */
> > >  	sh_early_platform_driver_probe("earlyprintk", 1, 1);
> > > =20
> > > +	/* set aside reserved memory regions */
> > > +	early_reserve_mem();
> > > +
> > >  #ifdef CONFIG_OF_EARLY_FLATTREE
> > >  #ifdef CONFIG_USE_BUILTIN_DTB
> > >  	unflatten_and_copy_device_tree();
>=20
> I'll make adjustments based on your comments and
> resend another version.

Okay, I will wait with my pull request to Linus a few more days then.

Thanks so much for being super patient with me. It took me way too long
to test and review your patch, but I hope in the end we'll get the best
possible version merged.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
