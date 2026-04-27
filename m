Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5D31F996
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777302074; cv=pass; b=tBe1dAdfhyquJXia8cQtx+gDVvT5kRN/Da9hdec5r4sNvXyrW3yfkWX99g1Vkp71EBw7kCAiCRSuTpCxt/khcA79Fw61QR142vNFCirFQoJ42n8yYdDYk5w9VW3HFBTHJNRPit0asvwloxJoLmBHegXLLH2jpgdFjLHzQyg8IIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777302074; c=relaxed/simple;
	bh=rcQT7/KShC9VR0GIxi4YEYDYfvyBuPQTsb2a6WjuRoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdzXCp11sGXO7moRh8KC5YVynsyqoI0NrCSKrlDsGZLoevr+kyPen6z5iG5abVlZy4DtLRpSLqOUn46Ua7IC0+NmMWrsQJam7o9AH9lGM+8n4XzpThpr3+w50ai3fP2ij2gmiAO+HhGMbeOHocTwLmNIRPmYdjctdtfdrX6fzNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDsBbXrT; arc=pass smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDsBbXrT"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso96131135e9.3
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 08:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777302071; cv=none;
        d=google.com; s=arc-20240605;
        b=g6OSt02hj3hSHpZRG6SwLNK8nR+2M17eAdocVL+QzxfzsKTDxl/JA/e/hcMenrjob5
         vhVYRQL4yiugE6wrZytnOQFVAGdt0wIr9bJJbpsbGFJ/GXcmbYoVYdDkgHCUq/8Nmu5g
         ni33y9suF2FavNuqxG7OzDXCm+Cu9YpvRSg9dHbW5Gd9GthlF9iM94PBov7ZR/FNAt9R
         BbbcSz48mzvjqySKdQdUAi1vJD7yHAavBFXkW5JAo+osLLZTmZ5PI0/7bXsrGsfgefz1
         mCr/VtipouI2sBQ/MuoQu/mXXRV6r0RSbq3m5m31jb/Cy84o5pmKPE+eI9VA1shHTsgg
         7/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IsMoDiMZP2yl8KNjLXtX/OQcgCLqcJjLZJHfEPoEHys=;
        fh=yk3Bian3VmKkfLyuHW9o8smeBucJDHP5XN92awoMzlo=;
        b=gwR9+h4eU40R5SCMxi4WfN/tpSWly89uJPMCYR82T5DrHWo/A0xrBqaYeJP2Y0bmEg
         ZUuhF+BikK2oTrxEbct/21A1T80ahO3svOI1Y4oCLFZrEjOiazUl48n0DwK+iWc/kZS9
         otmZTY3443cvo7Irhipd/EqmzMf7SfQMCluqfp90trKSUUXI+HsZxez5hp+dGtmrBozw
         eZ9BACyr3G1SYQkR84hAM+hxHadywwyZcnJUmOKlRvuxVgU5EuN6fpNf7f7Pjt9lr0sZ
         ivoxRhgcQZ0NrVMlNUoNon22HDqwuKcB9qD/Gzli0IwVH+DxtElnP90DENZfpEylyPKr
         AHmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777302071; x=1777906871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsMoDiMZP2yl8KNjLXtX/OQcgCLqcJjLZJHfEPoEHys=;
        b=KDsBbXrTU/sDYCclNKcvEKSRAoNylE4DU1o9lAz3dubZe9XdYhHeep4cMGOjyZL6nA
         jIhwYMHVEOZ6AWjk1C41nyaM/rBW19UqlYGnjVY2a7T+kkE7sTW2YbdxgplcmohIAkWz
         +nd3IGJGraEWRAmQIFE/aa4LFZP4M2nK2CBrEfaTjcKOGEj4BXv4oB6GeAVwGG+6e/4L
         sJiGX7bWpEWo+pECMw1s3Vu+dHmwFJLNsMUQblMNvO99SI2zDHzwbbaDSgzZmVc9OPyF
         5RH3zy+UDodOf3O0+LhM9/q+FO/2EfQSkgxhBvSMVEQMeG4qMys3xtj2O5dLUI7ICvcq
         zeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777302071; x=1777906871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IsMoDiMZP2yl8KNjLXtX/OQcgCLqcJjLZJHfEPoEHys=;
        b=ZKLySepyPr9d26qYHvYAn/iCA7o3z6qHgCTPHpqNu3cPskSqVKSeq2XRalY1CeLomI
         FePbBFCDFaWiTdkmy3+JVewJYa0GiecElNU+rz9sngdVGdQkmdMoFGQHVixzYW89e8HB
         hw5P+lPN7FO77seCYChoF5oOWkJq57JszDEd/W1tg2fIpQ/UwXw87g85zdLK/kB6B+MD
         Ebq09oyE/85XIY2/PEii+8+/Ix+6xSINUapvdArK3zWwJFkIW0/miCdnUHe5esfO3GrG
         BiZkM/ywOZBKIbUIHTucrNIyRyjOsJ5ilwwIJHqhvMIVswpTSasBtqZjUiJY+v3SrcTg
         MCaA==
X-Forwarded-Encrypted: i=1; AFNElJ9o/iRrfSpBSGdE9Dv3Cudcl9X0KwJddNCRmCW1OcHlQ6qBDFDNNXr3STMcf/ia/cNy6yfaDwMQKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLLlndKFrtqmU7BCNsm7Nyc/lD8ADR1i0Thh+t6YRtxB8BkaQb
	YobnD3saGq+7de3ndK5B26oCSxw1z3bO8/hndWHOhPlZJkzjEtHtjGTwlCdE9zVLx1HDdAEyd3t
	ZNLWg5JJ15L7Wy63bb2m8/CiQVFwVKN8=
X-Gm-Gg: AeBDieuUCfvMwAM4tTy5lu7D/77pmPfnEEedvJGMW15loNvdOv8OStcjFr3N4Fb+eU5
	jymqPL7CEnJnoRNFbQ47wH+uDS7Ueb8DhTzGe9JrOSFxM+zdjkzOkpj6NbboSlzbD8antPbIujE
	BMElVKoUqnTK5yl4JglwJ5cg4f0MA52DfRzdws3T6x6qP86fnNEQcqjVWNcaMOQgFc3iS8DcRZ9
	eLJrpvxJygKJ+DSkMbT2Y7LLY2ar0Bqdh/1TydfNQPc7z4RQJra6tSn+1UY9Evdkp7b5llSV2MQ
	G2ALDZDLbDSqNBjlFeGtD0umyDMG0jgAy5OAJy0tTZ/d53a31wS/JCwUNzO9DFqlc0mmVEtdt+k
	Vs2k=
X-Received: by 2002:a05:600c:4e4c:b0:48a:58ae:9938 with SMTP id
 5b1f17b1804b1-48a58ae9f69mr423287055e9.19.1777302070487; Mon, 27 Apr 2026
 08:01:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org> <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
In-Reply-To: <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 16:00:59 +0100
X-Gm-Features: AVHnY4IasoXaoqIWZAdmFU7XS_Idge0ITPUKZpISd1rL0jATf9af3D4zNm_fFNY
Message-ID: <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 1:18=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 27 Apr 2026 13:43:15 +0200 "David Hildenbrand (Arm)" <david@kerne=
l.org> wrote:
>
> > Pages that BPF arena code maps are allocated through
> > bpf_map_alloc_pages(), which does not allocate folios but pages.
> >
> > In the future, pages will not have a mapcount, only folios will.
> > Converting the code to use folios and rely on folio_mapped() sounds lik=
e
> > the wrong approach.
> >
> > Should BPF arena code allocate folios and use folio_mapped() here?

no

> But
> > likely we would not want to use folios here longterm, as we don't reall=
y
> > need folio information.

exactly

> > Hard to tell. But in the meantime, we can simply use the page refcount
> > instead, as a heuristic whether the page might be mapped to user space
> > and we would want to try zapping it, so we can get rid of page_mapped()=
.
> >
> > Page allocation will give us a page with a refcount of 1. Any user spac=
e
> > mapping adds a page reference. While there can be references from other
> > subsystems (e.g., GUP), in the common case for this test here relying o=
n
> > the page count is good enough.

makes sense to me.

> >
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
> >  kernel/bpf/arena.c | 2 +-
>
> BPF maintainers will probably want to carry this in the BPF tree.
> That's fine - please go ahead and add it.  I'll carry a duplicate in
> mm.git so it compiles.

We cannot carry the same patch in 2 trees.
Sooner or later it will create problems for linux-next
and issues during merge window if more changes
are done in the same area.
The only way to share a patch between trees is to
create a stable branch and pull it into 2 trees
then sha will be the same,
but mm tree has its own way of doing things,
so this patch needs to stay in mm only and if no one
should be touching adjacent lines :(
