Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982B63368AB
	for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777303651; cv=pass; b=PtX7IZo0bdm+tlTMeOJDv8uejkLm2TgAEvT+inQVCHYuYBPPD/UbKgN4b0jPrHktHSRTMHAyd493WCNJr24bMx7wr7haBsITYIvc81qyOMtuBtlwyp6gTy/zL1ifC+MwUXtgXjrVirWzytGB9Vg02gwSDsnML5rbo3inLa5PVf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777303651; c=relaxed/simple;
	bh=CyWq8lzVTQnbyNyLsnJBEWEqt1LuimpGX7rKZ850W8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSxVO9POkH3PI2yhnCArIgl4ZQhj3mZ8Xf/XEbEGOFweFkWKoFy7Zkkzbc9DFXva9Lwg0JB9jVsxeCZh5IxNaUVG0U5l0NVx63pUYozxMcbbPCuNbI82Yy7hVDNUYu+5h/f86kW3gNToXF/J0JEDPEgA9CHOUT52xvHudv9q+P8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW8N4eGm; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW8N4eGm"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43eb05b1875so6093034f8f.3
        for <linux-sh@vger.kernel.org>; Mon, 27 Apr 2026 08:27:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777303648; cv=none;
        d=google.com; s=arc-20240605;
        b=Z4Lu36o8dfP3ZuP9LVuzJfiJfHRyqHXwHBxmrCJyEv1vbN8m/hHW3AyZTVAyJg9k8D
         ILayxm181UioVvo1dhx8mDPt7MartJ3OnWLk+op9fx7t6SSZo4Bo1zRvA0cluyaQH2S+
         XvDWlW9bgtEWUfyMkxl5emt/T6wbOCi9shdtT7c0SvAML3spemwDHTcpLID4SFEMXCbc
         YQWnz0illipe3W1yDaaJMpmD0PdAcvkpt09KVPl+Ie+ZhCaf5dhzArR+rgEN7ZyUZpAw
         EiV/mTLwBpHjzQeN9ZbO7UsCK8I/s7xTLJJ9bg1zmTfIgqpbikenVrTVJ8pmYAWF0Zf5
         Btsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2FRyQ/RyoABp4v/5IEB82Be0LFi6IsNcT/3z4X4HozI=;
        fh=ZMvNhfn79wtdqVXklq20pwzKQCLqN6UMPweEWBamcHM=;
        b=FKMnl/XJ2WygLtbELhc7MZinEtezY+akyWBAIjLFpfqYadJvJkGScenWqKOha0lyjf
         cDDo2jbGHiWvL/zne2dpo0/CZE9FosQ5TOiL1crfc716uqULxwQobRMU0PqCYjQUMsHk
         gd9NmpAxLX6jYz7LGH15GI0e9aR36OZ2UXbBcXJkwrS0mKcS9NHn85KGWIJ43kCt8DCP
         /fHEAitEPvuk+LF41cKJM577GGVzCvVRp9n+PLs7UockyDMa3QhLGpe0T4+dEW5sKnNV
         dsgcrUwwEj/oZuUizmwUVfJ7qlX+5xJSMt3t7K9qK8K2peAtcJ6288e+RGIsvKJoSt5R
         bepA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777303648; x=1777908448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FRyQ/RyoABp4v/5IEB82Be0LFi6IsNcT/3z4X4HozI=;
        b=MW8N4eGmjmCpOE8QqvDhbI22HJhv1FNfSFIQP7p9wnoyiUJDgVtBruv33T8tE+mOh8
         CGDrrGfr4LsFcF3mPTxO2M5GRbTz+8iv4dI7H/FIKoky+msSI78owBcufxSlb3vjLicS
         BHfmMzK4WlF9Gy6QWbEkgufPXANWY2nzAYfB2z0IJsv+onq4Z3iTYptPviDtqhT3HFXw
         GMKlkF3z6u1qPVEGkhHHh5sGUC2gsnQSQiM/D9gZCoRZX7T5al/IYcIaxMFBvZHDcRcA
         JMboiCAio/XRYyJ4IqXGfIqK6pXqEp4vaHFNcWYaCDllWX1JuusKIcH6I1GAUWTTOxqG
         gCaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777303648; x=1777908448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2FRyQ/RyoABp4v/5IEB82Be0LFi6IsNcT/3z4X4HozI=;
        b=SCqQW+oRiTgRDRUb6t14UcHDGNYv+/s+UfcCXh6MJ99eloV82l/+H9xRF9o7YT/Lbv
         GRoMbH5CC3qupw3qagerlxEqyBDyMqEfgfSQPisnOHVV/F5mq5UX3SADu2IgxiaRw/XZ
         MQkVaRjVEjm5kBl56hJ5Km7WqCQWyuWNT11hAVOBp7ah7uoRUJt20362y3/byQ9Ohqwo
         gK42238NFH2b3fkGSVDHVNhKjspbSsTHYjHUyxRterA4KP2pcD+e6N+HZS8/agHsLzHB
         15ntaP1NcFF0Q9fnhl46K2xV2vzVRXzT3hIlsr2byXjIqPvpa5AnNXhaiuUrZlCCnPj3
         MZWA==
X-Forwarded-Encrypted: i=1; AFNElJ8SV8aLzM80XIaOr8Tmx6xUDIwdM/c3IclrkEddG3rvUQ99CtEPpt4X3zZBvSLi8j4wgs7j39Rhwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ2TOffw+74jOzHfeVNWR+/ML//KYl0jqv2qiNCaSjHBVsOVZY
	AQfMpNZ+5QByuaZd0bcppEALdU421BAbx7RAtlQ0u7RnkM7jebs9PKiXIq7r358qBmXkZ6D5Dn0
	5rHtVTiIFT7sIG6dP95sr5fmpcfGNaY8=
X-Gm-Gg: AeBDiesmtBa/Oe1pns/V2YiHgFtPGEX2TP5d6T8XN8nGJCvxFGU9nWFYoaczmQw5r+D
	5OQSt6wuWzfCn+2aj3mSJfwsvlyYB3JHAfLU/fsRJ6JxJzMmZn+YsG0COUaj07uIy/g7BpiKYzI
	9zF6N9FDFY467B2NP0LXbNX48vND0F0lj/jGLNYQb8m4SxDdwLuOZyT413MksJnqbqBqSxbmU45
	9Q9kyPXGkE0O/ebL14yfiVFu5HbgFbLYQPiCA0yqaCN1k6wTGW9LKxdhMAfQwgLdABjiLDCasxl
	lGPYWCZrp2ihLSs9tASM+lWXbFAGZjFFUW7hGa+ygeDN5DNNYGxZlxdVTpxfPE3H9CSsYrFc4pJ
	2OUU=
X-Received: by 2002:a05:6000:4210:b0:43f:e808:4ee2 with SMTP id
 ffacd0b85a97d-43fe8084f09mr59050768f8f.8.1777303647931; Mon, 27 Apr 2026
 08:27:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org> <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
 <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com> <20260427081547.4cdbb9a5cade734f143902f0@linux-foundation.org>
In-Reply-To: <20260427081547.4cdbb9a5cade734f143902f0@linux-foundation.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 27 Apr 2026 16:27:17 +0100
X-Gm-Features: AVHnY4LB0ND1Dxh4uexvvpYN_DjpDVF5ij1OjppIGQ47kx58EMkgeVIQzdtUyxE
Message-ID: <CAADnVQKN_6fCMnv2OC3at4X1v=vuah+_LrwW2PQUYkVXqqVGVQ@mail.gmail.com>
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

On Mon, Apr 27, 2026 at 4:15=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 27 Apr 2026 16:00:59 +0100 Alexei Starovoitov <alexei.starovoitov=
@gmail.com> wrote:
>
> > > >
> > > > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > > > ---
> > > >  kernel/bpf/arena.c | 2 +-
> > >
> > > BPF maintainers will probably want to carry this in the BPF tree.
> > > That's fine - please go ahead and add it.  I'll carry a duplicate in
> > > mm.git so it compiles.
> >
> > We cannot carry the same patch in 2 trees.
>
> Git is fine with that.
>
> > Sooner or later it will create problems for linux-next
> > and issues during merge window if more changes
> > are done in the same area.
> > The only way to share a patch between trees is to
> > create a stable branch and pull it into 2 trees
> > then sha will be the same,
>
> For a single one-line patch?

Number of changed lines is irrelevant.
If there will be a commit on top that moves this line
or lines within the hunk, git will be confused depending
on order of pulls.
We learned this lesson the hard way.
