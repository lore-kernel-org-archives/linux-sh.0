Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8511719258E
	for <linux-sh@vger.kernel.org>; Sat,  3 Jan 2026 05:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767418595; cv=none; b=LRKDLmRRCRvoOdU2kBZKCb1T8wI71sDuFKNZoSZIJEBX+ZhD+6w4cYXYyLvyL03Dyo5S8+Bv1sF4Q4EZnQgs88yefPyWOiNR61ncLZXp+zRElZLd51xoKQtMvZ6iIPDO+j7GscAtWfYLTY3cXw5o2oFzhq6x4ZQbtjbsICCJ7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767418595; c=relaxed/simple;
	bh=ATXYUvNs1r7k2R+QkRXiglU8qywdgmSoPgsNlVWS4pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8YM9s12/UV14/g/HAfNI++DOr/vSPuXHATKi4SASSnC+5tHafLL/QEVr8NusffTdyPZsigWbcdMAHZJH3c9M3F3xPMmWI8Qe1428r7ng8rywA6uggYohyduWms/pit9pjQTi4YpJ8g4IjWM8qL4WzIrZXwXX8iW+234Qrg8u84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDXMiTxx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDXMiTxx"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb5810d39so8128689f8f.2
        for <linux-sh@vger.kernel.org>; Fri, 02 Jan 2026 21:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767418591; x=1768023391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=10gk4kIzv5viXrYP6wsblohOaaYzL8Wh9uCfOfLAyTE=;
        b=gDXMiTxxJbSjZSyFQUB6T5kBrvh2LsNE97UOkAmZYirAEl0yRraTfieWvOhBoqRUqm
         FIHLEGPxujyCQ7b66gUmIrAfOBp7ZQQM3oo59+R2v2NQ6TSeJYwC1+sItTOs92L+mPC0
         YOyKfOGX7SpTHcnTlGt7O7cRpP7+e1ku6+iHq6X7qBAfXhq/5C14HOJ86NOU1aIrYiYH
         eCgLhdjtCLh/ZPCiL4WZX3EZAkiX1RxBgsaDDWflHrVLWdoHDOG4GK6ARhzE6uUQrbGT
         SxBpM24mo+zNzRAf3+4C+lNZlydg1P+21uuT1rhnmXBZLBRxqG5dbSIdSV7mOFxyqUk6
         b+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767418591; x=1768023391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10gk4kIzv5viXrYP6wsblohOaaYzL8Wh9uCfOfLAyTE=;
        b=uGfsBjrOaF5j7T2XQyrLUoRmdX/5ZdA8yV8FIyK+HTuY69ZPXmh7GCsjCd4mx8kfH6
         3E9vWxO2OSxslTCcZzOovSmDzd+2/XMF/dUU8oOWpi46HFqOoch3SIX1Bt4PrjCeE3ro
         o22npeAkJT6BshlutSqjZVhPksO2nbQQBSIeTVEjSBA/Me10uCHVbKGQ2jtqHolJUHH+
         l+uixXfdSCce/0+yVBVJFfQKkNlksvB+j6qx3CaL9iAyjzKMFxRcu9RzdB/zc/nZIrGS
         WDUmSg4DWe4f8xhvdsMpb7xXzUGv84LPWPqFchmwzJR0G0yG0Ftb7ln5ndSLCpRj8UMq
         k/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWk/IhyIVqESOW/TJ5LQOfOqft7bzJ9lBJzQRu7AXU/c1wQqKCwyp5xElDs4SNEw5lPgIsZcgXw/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCbpovg9+QSxDq8hYseZaaAOwFZ0stmsCnA53cZ49o/vzeeFcy
	dIErwFCJ6klRzkF/EgDZSh021ZLD/wGI8tB+j6prGJXNnmr46MnX9uRH
X-Gm-Gg: AY/fxX6RWOAXFqMuatp8zrZk77ZfSoI2i4Y1BkLismaLM/Tf+2B2JTAZiUVIDpEuUBg
	lEltbLUvl3ZGfoGVkEr2/Oi8lDlgtieNSUi5mP5ORFQWurKLfFOJFMFqUOdHL9vakyR/u3ytXlJ
	iXqRUPFI7JDr3DeqX1EGd9QkKocOeG9Dt8QxieQpLcpim0FEuK9HHWOgP++kI/PswHciBdHW2zH
	TULwh43NMu2s+yVxEENZpT56j2sYfWmbrUErOTbQTfc1iz3kTSEdwct2z2YYJRyLNcVt0Wv4KI2
	X9WaNrf497DWWVVYQQ2TLF25FdIh9R7sYWVAOj1Mtg5KtO39HLpnHLWtbUXSp01RosigfAltz45
	TSzAaN5uZLGQL2fvWdjI8/+yRsBSrEyiLNk/clKlUdcJGOz7DEjOmNigOf92EsVQN+K1QRl3RQ4
	mEGWxIUeM5I/EOQMpUWC5qtFO5E85R2jVe2LcaeYqgyP32DL4P8lnJN/MODDKCJRYa
X-Google-Smtp-Source: AGHT+IGVfFhDmvRzquITceR9a5MtoKyW2aPxvUx0HbCgVxiLGpVVcSZGOqzt3JsoKLBzXfIUaXLywg==
X-Received: by 2002:a05:6000:178f:b0:430:fd84:317a with SMTP id ffacd0b85a97d-4324e4fb825mr53362620f8f.38.1767418590643;
        Fri, 02 Jan 2026 21:36:30 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa4749sm89007161f8f.37.2026.01.02.21.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 21:36:28 -0800 (PST)
Date: Sat, 3 Jan 2026 05:36:26 +0000
From: Stafford Horne <shorne@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 12/28] openrisc: introduce arch_zone_limits_init()
Message-ID: <aViq2vsMk5tltK0f@antec>
References: <20260102070005.65328-1-rppt@kernel.org>
 <20260102070005.65328-13-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102070005.65328-13-rppt@kernel.org>

On Fri, Jan 02, 2026 at 08:59:48AM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
> 
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/openrisc/mm/init.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
> index 9382d9a0ec78..67de93e7a685 100644
> --- a/arch/openrisc/mm/init.c
> +++ b/arch/openrisc/mm/init.c
> @@ -39,15 +39,19 @@
>  
>  int mem_init_done;
>  
> -static void __init zone_sizes_init(void)
> +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
>  {
> -	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
> -
>  	/*
>  	 * We use only ZONE_NORMAL
>  	 */
> -	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
> +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> +}
> +
> +static void __init zone_sizes_init(void)
> +{
> +	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
>  
> +	arch_zone_limits_init(max_zone_pfn);
>  	free_area_init(max_zone_pfn);
>  }

Thanks, this looks like a good cleanup.


Acked-by: Stafford Horne <shorne@gmail.com>
