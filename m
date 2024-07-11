Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64015ADB3
	for <linux-sh@vger.kernel.org>; Thu, 11 Jul 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693284; cv=none; b=OmLmQIBgJY9tc2M4yQ9ZUbipeoEjIoWEQ9NnFEIgkid1OfJgOJLKroqWe2X8fVe49EDGRLTFGr9PSEYa9spNZlvBv1BGgjfda9Q2qR/m6Ol2BHMP4CVj7xI0+beF5EKDsXvb7Y0w+OVsjzhhia1uEdSKZZQqpDASsbJ8Id+8TRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693284; c=relaxed/simple;
	bh=PntBoiE2yhkOnqH4L2uEutOUkugNrdk+LQVSLxwMQxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZOAqzRkqvn4Veu6bmZ84E3PXzdgUX1xNe3l/rcrQop23YvnlcTODhnBkWiN5j5xY+koBbHAYJc/faluWAYJ42CUMn1ySFSsudoP+Yqq65RMBzkYEEJ+/vjWB083zH53i2I49k6kklwTREM3sJ4PBnpsR+PqY1TGsSuibtwHzHbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=XJiVSLkN; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="XJiVSLkN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VusCKtflooo5piJ9a0SJFPaccOcKM3PeICzYGrcI0Yg=; t=1720693282; x=1721298082; 
	b=XJiVSLkN6PHH2iwPqam5F3rBVGeFkzzqW1F6RToqmEu+lG7/0gJ2c5EAqt0rfaiCMPru+sKQH18
	NQBcWL1eXYGA+6fwtTwuyteUZZfOxcgceRS5qg07s/86Rkq9FurGzY5a/jKYFPUAnQ7G4WZmYhm5p
	qph9u9oln+r0CuWzwhL6rEcEB3vcKpcHGCrNmCJNTKqenj+W2BDQgUTqxHR13it67EIZSD1T6uFxg
	G82iDtmd2khYPESMSU007ofE76UmsY5LCZoBY6r01I0GYKLIoY8aa9mvUB4dU8x0TUDPZKyVVFChg
	wK2u96jqgxnmbVhVOeHDmglcRDVQEoISsTAQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sRquE-00000002HC1-1wfa; Thu, 11 Jul 2024 12:20:06 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sRquE-00000000zJz-13jO; Thu, 11 Jul 2024 12:20:06 +0200
Message-ID: <9d5ea8fc23eab6fa6c1c444a5052cd8c5d4b513f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] arch/sh: Remove code that handles memory-hotplug
 and memory-hotremove
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oscar Salvador <osalvador@suse.de>, linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 11 Jul 2024 12:20:05 +0200
In-Reply-To: <20240518115808.8888-2-osalvador@suse.de>
References: <20240518115808.8888-1-osalvador@suse.de>
	 <20240518115808.8888-2-osalvador@suse.de>
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

On Sat, 2024-05-18 at 13:58 +0200, Oscar Salvador wrote:
> Since commit 7ec58a2b941ed889("mm/memory_hotplug: restrict
> CONFIG_MEMORY_HOTPLUG to 64 bit"), we only support memory-hotplug on
> 64bits platforms, but currently superH can only run on 32bit, so
> remove the code that handles memory-hotplug and memory-hotremove as
> that cannot work.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/sh/mm/init.c | 28 ----------------------------
>  1 file changed, 28 deletions(-)
>=20
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index bf1b54055316..d1fe90b2f5ff 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -395,31 +395,3 @@ void __init mem_init(void)
> =20
>  	mem_init_done =3D 1;
>  }
> -
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -int arch_add_memory(int nid, u64 start, u64 size,
> -		    struct mhp_params *params)
> -{
> -	unsigned long start_pfn =3D PFN_DOWN(start);
> -	unsigned long nr_pages =3D size >> PAGE_SHIFT;
> -	int ret;
> -
> -	if (WARN_ON_ONCE(params->pgprot.pgprot !=3D PAGE_KERNEL.pgprot))
> -		return -EINVAL;
> -
> -	/* We only have ZONE_NORMAL, so this is easy.. */
> -	ret =3D __add_pages(nid, start_pfn, nr_pages, params);
> -	if (unlikely(ret))
> -		printk("%s: Failed, __add_pages() =3D=3D %d\n", __func__, ret);
> -
> -	return ret;
> -}
> -
> -void arch_remove_memory(u64 start, u64 size, struct vmem_altmap *altmap)
> -{
> -	unsigned long start_pfn =3D PFN_DOWN(start);
> -	unsigned long nr_pages =3D size >> PAGE_SHIFT;
> -
> -	__remove_pages(start_pfn, nr_pages, altmap);
> -}
> -#endif /* CONFIG_MEMORY_HOTPLUG */

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Will pick this up later today.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
