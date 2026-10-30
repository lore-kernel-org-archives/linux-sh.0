Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353541;
	b=fT1xP2My+lVTxqiIvgXqscrwmJKxqHPSznFnahfd5JA0EFol0f/JGlVjoOcYCmTDIfxU
	 71b9vHRMXHx5VFEjO3TIhUX8FYgxyn3PY+IfPlzSOfKzq/Z+GzqWg35JbUPzidQZTdFBk
	 bcF9EBLIo40EOmpLWB8RJgifOinfJMQf0VHPn1Md/VtvSiEoGSVHEt/Wr8RX//OVaqYS1
	 NVvF1TQFvpN9qEl3W3Tj2YwNxQ/M/d9MO2ke9M5MSSBIc1q56rmscnNVW/Rk0ls3LIhlC
	 /YHSqS60eD9WzIb/jTKkWWTLRLL6cInsnwz5G/qem+9dv5uOyuj0yc1rC/bkOy/kv9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353541;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
	b=C0KE+MyhjJ09O/9eNzKfyAVgACiFCkmFRVDAIWqmp5Q16mPRddL/JRsDlHvZatLiFZ+L
	 XnJdOCmTd1z59r0et5T745/rLMEZOVZiKIBhvfZVd7Drj+poA7oR7hGAxqJF/lQHyvG3Z
	 pdsmPDo4hlhLzkSp2isiaw0roLMDHn8SERc5FiNtDsapKZrhisbvOmxn8vdrF62oudg7u
	 bQqvSlRSFnBpbfURiDj4tZKQRZKOsj+Ky30BkW2L9J8VpFZq5ZLKFO5SOZSkeIun72Ky3
	 z4iKf1LfHzK18mK0NrG6EPdTr75nGBl443BGlQoWSUABhdfljmjK8ipJaNQ8YdpjD/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AEA606A31E
	for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 09:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1AEA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a89b4a59a1so1418736fac.1
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 02:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793353539; x=1793958339;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=q8Bp4lvQqYUsZT0k0dArzQOZC6e3m0dIfgAJwvcDsr4=;
        b=zzep2xzZo5JH8TqANzNy4UbqwgNdGA+H08FU5S/QrJPc9aqWwnz/1w3WXQhjbhDHR0
         3wvAZGl+aaQv6ATVXV+r6k8G+9SstqvJX8OMx62EWCD+kwKJ3dYs3YnWXI89Ks4B3N+F
         FRfYlkbLetbDNN+3x5AR7DJWyodvNS0+jynhptj3Dj61pZsihXx/1PA/z89aRM4jbj2w
         0o47MQjl7Xe2IgNlOgK8kgcwvhsa/KJ5sL5Emt56EKZ+fa0neFIxPoMJRG5yn74q8Y65
         MPJxD8dn9ji4s6UNcgbDy/TvbPcuoOYgr0lxnBtFwTizuDAIF6jAh63HrPgFBsF8A7XX
         BHhA==
X-Forwarded-Encrypted: i=1; AKwUvByX32YHg16lzY9/M6YKryE+gbdgpjBiqE7RvFpRiHhH1HSKcFY5hfYZffzCOOj7RL9GOPkIQVNPrw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL7Joqxjn8qiGtlHuKXO+WO6N4SM4IkDNHWwXkCvtqZqzL8udlB
	9F1xgQID6p/fvYreJ5gENlIfofgznRYmEfA5FTwPEuza0LwPc9/oZU96fk+QSM/d
X-Gm-Gg: AYBFou2EaL4XfdtMgoXFCGQcM8GiyC9vC7ikEUZR7bc/08NDewvqrsSIwOtASZ4DN0f
	JGMaxAl8VIN7wcs4XGb+OCO/P0v9GdJtuAr0zMermAUptbNxhRZ5qxWfkQIigrHXePgcaXoKF6O
	fv57BEXeR1pApDvpHn6AeG749hgG4JbfbOPPoOf5WjrfacS1Es4qAaNmt2VC7AvmryCaKmv/YNK
	udxx6ZuI/H5BprUKIxBXLjT00rg4pYLs+LX3Chnu4wkIRYZfFFhMDAqoXCnbGktRA1FnO8+HKaa
	VB6OIXrUGt8zH9C0syZZfybkNn5yR596wykMz9NwBYHQ4r5fd424b0QzyWaBJY+RzKbe2QPSDeG
	2wR303YrgUlIRB6KpUOoZJCPZOznPUzgU5G8wqT6PiX3thFDbhVGaGvYGpvCteHVwdL+agpyq+a
	GWhyJkl6gfxLsEM/SizCp3oLdCE5pbheFieCvSp6FBDtVuxN3L7o/6B5shl4OD2rb3FxyhyY7V1
	aJtH7oDpd7JhHyh1Am8DWQjSij6uBbTvR96P00eTvUyTnXpeaxU078VWfRgSz2KWGwjtTkHUtIf
	mj6fwxxoC/eOyJ1wfJb2+P+BGLKPwbBZ4VVOPKLqimWVo3AtUlQeoTJsu/7uXpZ8DOX7Y76oP5v
	2a0hWJKi4PVG3
X-Received: by 2002:a05:6808:2391:b0:4fb:c2dd:c7a5 with SMTP id 5614622812f47-5640e014f8cmr878834b6e.31.1793353539549;
        Fri, 30 Oct 2026 02:45:39 -0700 (PDT)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm1232638b6e.2.2026.10.30.02.45.39
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:45:39 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6df0b02fe91so1230629eaf.0
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 02:45:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwq88+xU2O7k+LVdGZhUXwZzAc8O4kc/w6Abl13i+P1O6gmxoN+mJhyquf6D/4sCo7VjAk2s96RXQ==@vger.kernel.org
X-Received: by 2002:a05:6102:605a:b0:7ca:8f2d:5c29 with SMTP id
 ada2fe7eead31-7d0542ccab3mr1591386137.27.1793353163338; Fri, 30 Oct 2026
 02:39:23 -0700 (PDT)
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083800.599152-1-songmuchun@bytedance.com> <20261030083800.599152-2-songmuchun@bytedance.com>
In-Reply-To: <20261030083800.599152-2-songmuchun@bytedance.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2026 10:39:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
X-Gm-Features: AclHuK-5feC2ixWlfC3xXKJ1XowEcUrdLUZ-UGAaez_2WzCy_48TVc-7hVrg-7U
Message-ID: <CAMuHMdVjr+-4GA=jBNpL3nig6QfQ0Fm8ob+c-OkLADPUJSaNqw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: remove pagetable_dtor_free()
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 30 Oct 2026 at 09:38, Muchun Song <songmuchun@bytedance.com> wrote:
> pagetable_free() now runs pagetable_dtor() for pages that have gone
> through a page-table constructor, so pagetable_dtor_free() no longer
> provides distinct behavior.
>
> Use pagetable_free() directly at the remaining call sites and remove
> the redundant helper. This keeps the decision to run the destructor in
> the common free path.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  arch/m68k/include/asm/mcf_pgalloc.h |  4 ++--
>  arch/m68k/mm/motorola.c             |  2 +-

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
