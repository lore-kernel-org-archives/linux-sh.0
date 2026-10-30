Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368087;
	b=DZYSkvZwgbJCm5lTqPErCL5APKfxKa6lhIGVeE1sxB21y679E10I0aX4yZMSt3jrbFQm
	 8svQ2HO/baiRAnvR+6yhAtxEpwNBuSp3SC3zv2OSF2qy35F9ew918HvVStjdYEpydC3oq
	 HPq1sAd/4+sNwT4pWEtu+iCZ9yoWfr1yEaBnCRvPvgfk+/nhz4X0rtdc7Z95fj529x3jt
	 vXFV7Rv/Ak9Mt9eDxx+M6NuDodqyzyO5QgFkNLnH1fP5rpBtuDMYEfOhRW9pXL4xaJtJX
	 qsZDfPvKiAgRi4URAJzyYQHdT30CvtlVXCfLafU28vTk5R40nR27PrVa/KlRq2owpRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
	b=EDs9HaO3t76IpuUB5XZcytzpAohizwcMdayXEEQaOgh8x6yOstq4mgPWJl9rp/lBi+YJ
	 2E0K7JUOfygv4JEcoY7LdyrVQ+rN1XOucCf/x6R+3Hoivnc+x/4PQ4m2yI65c1PGCB6Pa
	 EePkZtdVaJt9ReOgT57MKJZYpoX0/B61nDDFymw4Kz5AJb2ZaNEMtVYxpMRwPaBQn9F+2
	 xQJe2BlBNqQ3xBRKftCHCSvlFE62prlwJJZDJnbZhh7Agip2sYzEpGJgLM7Y6IYmWIrT+
	 lpNNF6fo2hUXh0lgoJ0CF9X08fxPFQIlkDRDdnddFh32hxLdKReNe1mDxzMKcugdE9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F353C606A31A
	for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F353C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so5783695e9.3
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368085; x=1793972885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=P0o7zm7KEPIXltx3NlgMQzHQT99NsbdanhX5hUYiA8mqcXpAtEl9r+/7vE4Ggfb6xQ
         AjDmKEsJCN3A9nhHSHYQq86Tx9QzgKkEoL+MNKiu90Y6d/c6qq8wEeWDbGqZ4zOp73t2
         V+jiEVsBNp3JryoT0gq/L7+LKDEBausQ7tqgfI+sigyrm1PvM7UpDQc9g0naBiUQsKsm
         txn6SCcpysT3ZLStg89zxyyBWbPd9BONg/H56ElBDxvktEsTFh0x/DFDQ8EoFwz5gpkM
         +r9npc2iAjvhv6WuZ+vHLzVgZO3yPFE7oA+XMRoLdTuvTODgouxb21kNS1YSNNzhhvRI
         MLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368085; x=1793972885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=uWryFm/Xkw9Azg9Ntv3Pf7pq974IQZDcABvSJQOyJDOPSm7XEYvhzevC/Fuxy5M6Uj
         GsR3fWOf40YNnFR0wceQ5KWO6VYOVlVGlPyOhn+92rBTIzrWX0Fspns2dU3KN5pvDBRf
         JSMagwB9c1/vToBDncUDIStOwgcOcOG9dLmWUCSTIckttqICBYTW5tQBpW1uKQ7SFRat
         WRRIR3A0gcwebDuAuJ2NDl5JXhXTj/s+77QebOR4B3xWU4ui2LzyaBd+ZWq9LlPLaYc5
         SSdWTwblYCdqEUdxAUcuDdxTYnPwx+5leTf7w+Uvtvxwz67XRgegPvJ4VJGNBW697jUn
         nBhw==
X-Forwarded-Encrypted: i=1; AKwUvBxDmq7Ax779qVrhFlrB99O4RlEvWK3XKNuz2ijiwtNqBcHSvtDO93+t9HCSpCM+YAGsLjkw1rSr2w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJkGv3jKZozLheLEm0nl4wvfbUUofxDiUWlTuX0Gm2itVfjWTpG
	rGKYnBxmGK3/nDNayhzPtnictlbYMeg0hcsyJgmgCfP0ftp7qkE036yG
X-Gm-Gg: AYBFou3HFfPC02yKyk0N0j6QnBVupaUoSGv4AGkgnRNspzjmzErNwfD0GkF2mdpfoPq
	aVcbUlTladjzTBSumSVqDFMwdFC4TnuEkutrMIs4c8JG7/FWlDBOrNKls0R0Hc0sgObCP3+uhog
	4HU1tlq1bTdW1g2jupfYvIkJyIJbwlRchEcbc9zEnPgFkVcIqUI3DzcypkJ3zNaTWfgvKbZrsVV
	Oku5Bg21+XfjO7WYSHKOsokN+I/6tuvpnksfhgiiXXFQUeF1fYC4IkC/uCRaJpqI1yV/VJ62wro
	uDV3gybGu9NrNAPgiXq1gPfn6nuLGPrADW/3pMSURMoZ8EKvGru3Sm+wfR88yhjeykNHTHUcWVl
	06eW+UiNAVjgsofD5nKU9aMxb1LfLx1+BuFTh3b5J3P1SgHy8yR9hy6xX0IJbMnITMYlFiH96cG
	I7VV12dipsh1zOI7fT1ql6JIdK8hHniPDn+duR3qb+1AvubQZQx1vnLmNZMiSqLaYpyHzwR+1aQ
	owExKt6mxs8SDmjPTnecAVOaL0HUHJEkjmQ5kx7HpHnObxLR166+dGzmnyi0QIxQdQVECaebUz8
	mIimMGZvfFgQSPYmB+Q2oAKoTh/SjflRruL4a4zrGQ1LqmUu13wTPz25/oOKqLY1IRnIqSu21+X
	E7A54+7o+JASyqg==
X-Received: by 2002:a05:600c:34d1:b0:4a2:526b:d3fd with SMTP id 5b1f17b1804b1-4ac1793fb5emr50752935e9.15.1793368085145;
        Fri, 30 Oct 2026 06:48:05 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([130.43.154.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm172048905e9.15.2026.10.30.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:48:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:48:02 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Message-ID: <auSgElFWW4n3sJLb@C422HJQPQG-Fractile>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>

On Fri, Oct 30, 2026 at 04:37:58PM +0800, Muchun Song wrote:
> This is a follow-up cleanup to the page-table teardown fixes [1].
> 
> pagetable_free() now invokes pagetable_dtor() for constructed page tables.
> This makes pagetable_dtor_free() redundant and leaves explicit destructor
> calls immediately before pagetable_free() duplicating lifecycle handling.
> 
> Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
> then remove the remaining redundant pagetable_dtor() calls. This keeps the
> destructor decision in the common free path. No functional change is
> intended.
> 
> [1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com
> 
> Muchun Song (2):
>   mm: remove pagetable_dtor_free()
>   mm: remove redundant pagetable_dtor() calls

For the series:

Acked-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
