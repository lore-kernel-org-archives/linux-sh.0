Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CD6158DCA
	for <linux-sh@vger.kernel.org>; Thu, 11 Jul 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720693254; cv=none; b=P3HsFa7//sLjf4ePejVbWerdpLD9xwHIp2SEuto1dzhOf/Jwxh1laCmgNT054u0DOgB8LIh6qjKZZHm9wVEkuNDVqEH9QCqwTGFPYmsbS7gdZRyGri1a1hLao6KvVy2fTFTtx583CE0TF1G+exQVonfZnRwhVPrMGFgdOPVYQgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720693254; c=relaxed/simple;
	bh=nq1Hr0IGYvDifQu3HyTNdsMiNWtNq9cGyb9xXbxGbSI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQeuYgkjjEcb4DIm7DNQCdzkd5n0SoDl04wF+SMzqNEquQRDClLE0SVWEqeUOQod4Z1BqgwMF78Thm4359OfUHmgrc2YeBX2l9wON/XobWpoljh3VaG7RYzObGnuBQfDsjtRq1dTE5+EMAxHzpE8whu7/ZUSaPhuP5go+DjQnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=MGNYrNrk; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="MGNYrNrk"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zndkpwTvCpxAt7PaI8wM50qoEpm2D27jMQDANjDxMJs=; t=1720693251; x=1721298051; 
	b=MGNYrNrkPO6K+5yxG4mSJZgh0r7dHEvBM2wrmzEyPEQhAveRlpHWi0JjIzhJarsCSPN6UvFD/DH
	6poT9GyrMNd7x0PFAdhExdajvdE1YeRo+/WdFOzVBHH8kOinahwjNAfmrYMehaK4FMsQ056hqjPYw
	8u++ffcL8oA4l58rrpZFYZIfr5/fG3Af/gmNu2G24aj5bTBkphG4LLSHxR40vQ/Rz5j0rpKVw/oq0
	SoF+y9JtejWyFi4IjlkCa27d1/31AfCfK6Q7SiuhSnecDiiTuufVEujbJEn0ULlG69zlTFy4RPzAQ
	fe0+qx1h32A6ZCHJBzeP1b3sxvyXtmbQiR7g==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1sRquv-00000002HTe-0JQH; Thu, 11 Jul 2024 12:20:49 +0200
Received: from p5b13a475.dip0.t-ipconnect.de ([91.19.164.117] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1sRquu-00000000zMw-3dYf; Thu, 11 Jul 2024 12:20:49 +0200
Message-ID: <0de2dd928a7137314b517218779e1504ad0df656.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] arch/sh: Drop support for memory-hotplug and
 memory-hotremove
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oscar Salvador <osalvador@suse.de>, linux-sh@vger.kernel.org
Cc: linux-mm@kvack.org, David Hildenbrand <david@redhat.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 11 Jul 2024 12:20:48 +0200
In-Reply-To: <20240518115808.8888-3-osalvador@suse.de>
References: <20240518115808.8888-1-osalvador@suse.de>
	 <20240518115808.8888-3-osalvador@suse.de>
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
> Remove all CONFIG options related to memory-hotplug and memory-hotremove.
>=20
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> ---
>  arch/sh/Kconfig                     | 2 --
>  arch/sh/configs/apsh4ad0a_defconfig | 2 --
>  arch/sh/configs/sdk7786_defconfig   | 2 --
>  arch/sh/configs/shx3_defconfig      | 2 --
>  arch/sh/mm/Kconfig                  | 4 ----
>  5 files changed, 12 deletions(-)
>=20
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index 6bc60f964f96..c5c093c73aa1 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -3,8 +3,6 @@ config SUPERH
>  	def_bool y
>  	select ARCH_32BIT_OFF_T
>  	select ARCH_HAS_CPU_CACHE_ALIASING
> -	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM && MMU
> -	select ARCH_ENABLE_MEMORY_HOTREMOVE if SPARSEMEM && MMU
>  	select ARCH_HAVE_NMI_SAFE_CMPXCHG if (GUSA_RB || CPU_SH4A)
>  	select ARCH_HAS_BINFMT_FLAT if !MMU
>  	select ARCH_HAS_CPU_FINALIZE_INIT
> diff --git a/arch/sh/configs/apsh4ad0a_defconfig b/arch/sh/configs/apsh4a=
d0a_defconfig
> index 64558bf60e10..19ed0601a36f 100644
> --- a/arch/sh/configs/apsh4ad0a_defconfig
> +++ b/arch/sh/configs/apsh4ad0a_defconfig
> @@ -24,8 +24,6 @@ CONFIG_BFQ_GROUP_IOSCHED=3Dy
>  CONFIG_CPU_SUBTYPE_SH7786=3Dy
>  CONFIG_MEMORY_SIZE=3D0x10000000
>  CONFIG_HUGETLB_PAGE_SIZE_1MB=3Dy
> -CONFIG_MEMORY_HOTPLUG=3Dy
> -CONFIG_MEMORY_HOTREMOVE=3Dy
>  CONFIG_KSM=3Dy
>  CONFIG_SH_STORE_QUEUES=3Dy
>  CONFIG_SH_APSH4AD0A=3Dy
> diff --git a/arch/sh/configs/sdk7786_defconfig b/arch/sh/configs/sdk7786_=
defconfig
> index 7b427c17fbfe..07894f13441e 100644
> --- a/arch/sh/configs/sdk7786_defconfig
> +++ b/arch/sh/configs/sdk7786_defconfig
> @@ -43,8 +43,6 @@ CONFIG_MEMORY_SIZE=3D0x20000000
>  CONFIG_PMB=3Dy
>  CONFIG_NUMA=3Dy
>  CONFIG_HUGETLB_PAGE_SIZE_64MB=3Dy
> -CONFIG_MEMORY_HOTPLUG=3Dy
> -CONFIG_MEMORY_HOTREMOVE=3Dy
>  CONFIG_KSM=3Dy
>  CONFIG_SH_STORE_QUEUES=3Dy
>  CONFIG_SPECULATIVE_EXECUTION=3Dy
> diff --git a/arch/sh/configs/shx3_defconfig b/arch/sh/configs/shx3_defcon=
fig
> index aa353dff7f19..9a0df5ea3866 100644
> --- a/arch/sh/configs/shx3_defconfig
> +++ b/arch/sh/configs/shx3_defconfig
> @@ -31,8 +31,6 @@ CONFIG_CPU_SUBTYPE_SHX3=3Dy
>  CONFIG_MEMORY_START=3D0x0c000000
>  CONFIG_NUMA=3Dy
>  CONFIG_PAGE_SIZE_64KB=3Dy
> -CONFIG_MEMORY_HOTPLUG=3Dy
> -CONFIG_MEMORY_HOTREMOVE=3Dy
>  CONFIG_SH_STORE_QUEUES=3Dy
>  CONFIG_SH_X3PROTO=3Dy
>  CONFIG_NO_HZ=3Dy
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index f32a1963ff0c..1862411665ab 100644
> --- a/arch/sh/mm/Kconfig
> +++ b/arch/sh/mm/Kconfig
> @@ -144,10 +144,6 @@ config ARCH_SPARSEMEM_DEFAULT
>  config ARCH_SELECT_MEMORY_MODEL
>  	def_bool y
> =20
> -config ARCH_MEMORY_PROBE
> -	def_bool y
> -	depends on MEMORY_HOTPLUG
> -
>  config IOREMAP_FIXED
>         def_bool y
>         depends on X2TLB

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Will pick this up later today.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
