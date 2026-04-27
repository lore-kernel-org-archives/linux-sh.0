Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4AD36F41C
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325912; cv=pass; b=EoLkUv6RyNb8Yi9IZS+HpvIhK9Lcx86FYRp9GNHWd9FIqbys3Ib0IS1qzIFkqvN2Eqc++NksRmWaHFM9VWl8/qv+M6EAxj7JKa4fnTN9I4hIUVgtImaIi1J473oHBNZdKKpXddI0IKp8lU79ILOR9d3HmBaTZLpXW2XMsWYP310=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325912; c=relaxed/simple;
	bh=YGFUuabLhboE2TpWlFjYOpLZxbVhUV9ZG2G0W6iTEeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0XhhmKlZNObfC+rZeBJxE22GNPDfJ47tYInKp3ZhHKg/gx6OCFFfTQHjMEk//NiTZfbj8jGGL0f4kxUeMCnfuNyF0x8CPKA5CpzLOWuXJFfmsnpT4xR0BHYHxD9QrHYtDMlLNFtgoerFIw9tf+XrkdK3+5g09uRR2k2i2VQdYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZLAvI1O; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZLAvI1O"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488d2079582so126728825e9.2
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 14:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777325909; cv=none;
        d=google.com; s=arc-20240605;
        b=AzMFhbMNO7BASBeW6INPoms7XtXWWid5eoIX7eJO5xBEZiEhAaA6LsAKbHTeFM+yXm
         GDQDX7SaKH5vZ0WAZwTx3mvxZtt6gSSx0PMNoOi8aL1qpH8VkAwvt2ZmzSFcuUSI/AaE
         ZMD7Jl0sqgtDvRntg40eJxmyq6Aswg+qRn2gHRnGftiU5f7s2gOIBOkn44aqwXM66+Sb
         w5IbObTzQt5yvTJPNZt9IN4xvy42YuzxpLq4Hn5prudWYUS3UppzxM1dbppIyAQ3iyRx
         JlkdwyubSPXuM+yUcpoewiaAfBOZ3pFtWmdeUr84sF33dzrEwZYe1y+RuSMzvvjv4dg7
         FjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/TVU4nsu4bcRfWhQiDtREc5LpuHyEjGWAmgNF/qgKo0=;
        fh=QZi2GUV2ZrtURReXYNd9g0tiAt6Sk9ci6SdPjEIGisg=;
        b=fVQ2gY+hY+rKEIN64V9kBZSIVgzQOE20KSHWC/OhOjT3wWZDeNawzzgTfsXCnEMGUg
         K0af//9LfrTFty86ZNiMRAN9NkNakEpLeP37FtHk0ERU9OE3Op58/2+GVXBSsgFzU0Ww
         amGEf1aBZMBb9PR35M/6QtxuCUBrl+gA2T93M5Pjr43XnKiaHsYfHH9jAgBlZYEKZ2Ro
         AtUopEsYo6OXWcYgTLanoTZnovv1NQ73iK0xUXuYX5EpHxGebmgIk2mlsO+h0o+0YJmC
         FtQ0EruIkfPiPtxECODdxILkiqcmrP1VhVa0cxryPrFPrLWNquIrSgUFYPM5iSvot/MO
         yMbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777325909; x=1777930709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TVU4nsu4bcRfWhQiDtREc5LpuHyEjGWAmgNF/qgKo0=;
        b=eZLAvI1Oq8CW2yG0+ocwCvLVIdwPDKW9ZY0JuD1AY86CkRPdPjbphpKp4UwgFM82+D
         6cIWiv4zm4pueOyj/HMuMpJmZIqAAaR0HA1R05NCNIyKVNRPmsL3SEaeP4ZK/1mtDIyk
         gRs+W8RXHm2/azXRk61wDBuNGjlm6rcT9DbM7CI29Dxtubc5ntjI+UxGv9gjKMXvIqI7
         2tf2wyikZLTlrIDFY8ykAmWoymwwSdmZksTWonzJf9oWK2luSr5cLx3IiyL+VScrLWl+
         CCi+I4VByR7rr8i8PQ1c19a7yz2HcNO+MeSpY0Dt767hR4PCJp4C7mhu8jH742T3ghKH
         4fsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325909; x=1777930709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/TVU4nsu4bcRfWhQiDtREc5LpuHyEjGWAmgNF/qgKo0=;
        b=OjMzznJr/rKg0mxkSeMP4qFSCLpK0DNJfSQsGPy2+ME2V9/pPZhQLOiKRMGi9MuZbM
         WcOLDYpUZPXT0tdSJMt9WvCn1o1Atdj9CsQWLZsyF0E93gqB2W5gROJEsOz793OCIyaf
         krggY0/xHpTcnORCG0f61ptCZnNkxjvoiJODRk4dnfdot48nNZB19/DYjZ0Fk239TjPx
         6GLTtFoeLFGoIQliPnjjTYXKr0+6ZHF9p2CuWFebHh15LcYXW3/xilAJ504BM1HX2Xhk
         qHf24arMghK9DwZ3uG0o+/GbJ6qVwavWCoGcPkiT9z/T95vnkTtdtstAkLBzFijT0y1t
         pzUQ==
X-Forwarded-Encrypted: i=1; AFNElJ95ng23e6AT+wj4ITAt+liBZYvEQSyK7xgNgCfzXB1Zlty/8+LAcUA/XTIvVQwz/IYpS9YEFI1ikw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfDh2WNtOO4rGb1uXfVGV8Rwebjg0K6ZvaIhyAgftAI/kcQKWD
	O2aM9dyYEp3q3iIpk0AcbefPa/d1UvenqtxPf93Y5F0tXHZfZ41Y+mCsprOijzUFx7HYpxRGSBl
	eKgQBdEA6SLKc5kSvEw4LHuX8upokpBE=
X-Gm-Gg: AeBDiethdL+3zhIiuRumLkN5cnmZxleWuztQDu3IPbfLY8l7iTsByCYMuQbr1nqSqtl
	51IC6vqiw6N/3zBbcvx0ir5bAvDjMusjC6pKelcIK8L4TaoNqIwZTHAGUes/uTI5bxqSNbK2DIT
	HuGakqee3UCl+EsBmYkA3he0NA8XVyajP71+Cl3rsPKx7phFTGgzShBPbxU1dQxupIZm4ZNTdut
	+Rfaj/rtT2ARRYKUUWeKUv89MwFk8fG1cOckx0f8xG58hM3ABgRYV4dEfu7ImolgntG3X1jvMXW
	YjP29zufmXtxIrpoatFEFVFnzyC9bGBOEmVuRDYMka2Tycuq4mZoWoyssf/reVA+StVmg4kZk/G
	XQKo=
X-Received: by 2002:a05:600c:34c6:b0:488:8840:e5ae with SMTP id
 5b1f17b1804b1-48a77b25335mr5030135e9.24.1777325909037; Mon, 27 Apr 2026
 14:38:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org> <97192ac3-643d-4393-87ef-53a9f3ddaf95@kernel.org>
In-Reply-To: <97192ac3-643d-4393-87ef-53a9f3ddaf95@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 22:38:17 +0100
X-Gm-Features: AVHnY4II_oIb8C3aVippcvmoyZheListN6_PokHgWDygL-8vIswX205VDGz9ilg
Message-ID: <CAADnVQ+t549-aWEXq=ZUN79H-M=std3-Q8w3fU+dyNhF7mNjyA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm: remove page_mapped()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 9:59=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 4/27/26 13:43, David Hildenbrand (Arm) wrote:
> > While preparing my slides for an LSF/MM talk, I realized that I did not
> > yet remove page_mapped().
> >
> > So let's do that. In the BPF arena code it's unclear which memdesc we
> > would want to allocate in the future: certainly something with a
> > refcount, but likely none with a mapcount. So let's just rely on
> > the page refcount instead to decide whether we want to try zapping the
> > page from user page tables.
> >
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
>
> I scanned AI review and I think it founds something that is not related t=
o this
> patch.
>
> We use the page_mapped()->page_ref_count() check as an optimization to av=
oid
> calling zap_vma_range(). We must be able to call it even without that opt=
imization.
>
> Just like the bulk zap call earlier
>
>         if (page_cnt > 1)
>                 /* bulk zap if multiple pages being freed */
>                 zap_pages(arena, full_uaddr, page_cnt);
>
> It talks about concurrent "munmap(), unmap_region() executes unmap_vmas()=
"
> racing with our zap_vma_range().
>
> Looking into the details, arena_map_mmap() calls remember_vma(). We rejec=
t
> mremap and VMA split. arena_vm_close() removes the VMA from the list. The
> arena->lock protects our VMA list.
>
> So in zap_pages, the VMA cannot go away. If we find a VMA, ->close could =
not
> have been called yet.
>
> In vma.c, we call remove_vma() after vms_clear_pte(). So after unmapping =
the
> pages and freeing the page tables.
>
> So munmap() can indeed race with zap_vma_range(), and the page_mapped() c=
heck
> would not have changed anything about that really.
>
>
> @BPF folks: does BPF take anywhere the mmap lock in read mode before call=
ing
> zap_vma_range()? It should do that.

Yes, but do NOT. As I explained to Andrew.
It's a git mess. I don't want any more changes that cross trees.
