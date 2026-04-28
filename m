Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055A2877F4
	for <linux-sh@vger.kernel.org>; Tue, 28 Apr 2026 17:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396011; cv=pass; b=ragz+45weQ6V5tdPfy6obqjtsJ37G7Pfrl4KRaOE8u7tuLvZ5sDhBg2C8JIp4ljNlHEc1b8FbgouAEe9mxU2+cRBRnbNDykp8FCqpLlMZYyYE90Sr7Gtp6zL/OftBl8boSJ0Suby20P1QCD/d/lYWttjFkZI04DFYiGywG6ZtpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396011; c=relaxed/simple;
	bh=etazECzktFD5luO5FCpZbqDqLccDsjg+sso+8AqETyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/gfrpQTylr/J0QBL1yOajilap0kLUOc+QaiMO7HeFz4cjs5MH2m/DgVgYGif1abhcF2y+fvKaR+ErcQkpISLgjp4Lc0AgBk24tt2vX6F2w/E9Tm5HQfqAEd8NRJ8Os400G0gy9d3fWSIXQXf1j6kMR49eoG+1wcqq2XRWBja+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWpFy0Oc; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWpFy0Oc"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a2c9c5ff87so12151011e87.0
        for <linux-sh@vger.kernel.org>; Tue, 28 Apr 2026 10:06:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777396008; cv=none;
        d=google.com; s=arc-20240605;
        b=TG1zyws1KIzgVYI7w05CxmbOdPyHtg0oIkCMt8+vxV0RIwQcnS/O9lMGXLC62vaBkJ
         ugvE3OBgwqRzNXKVU+wX88Rwdxw1N2kQgevew5avDVuk46/AQJirEOHo+8Wd8a/hb2Kz
         ljG3jod1kKCP5TT6IAZE2EaSMJDKV/B0KKGWdhOK44Tnmh3ffYAJS9kaDoBU6mYcfRty
         eLT0mJAj+zVal4ziWHQPDDzjSbKPMdDpmPgWFaWlweVJ9yDJCEuu36RTcHFDUdQ0RcR+
         y9pdyG/mCcWX2t1N5HUtiCh0E/We6uGD0w3J4dLqmGW2v/oprhHwZz+Utf5sKeBZIod3
         HZXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VK5ahICXkL0MctIkCl6eavo2XIzw7vhC4fPYDrQjJ7M=;
        fh=1STlwzpj+FbkQuRWxX/6GAyOY52LCsdpEljce+5Jayc=;
        b=fSmBraWyvBmrl0T7pCVyNJVJEdhwkkzPggRK9Z4+qDPZNtZUdJxqI5IfgUngyKNb6H
         fsZF7UEALHHq/ibzPv3AtRtp07EqGhO8iIt6SDby2wFxc8pKCGiMKcz/18lfle23D9ZT
         Nrg3p7wA7uNLMMhpaU0CU5B9qYiWa7DpY8f39o8BbZMZOE8Y98ZZBCD5YCLbbq62ooZs
         627peGvvB6N1n6dqb78hdbW/eiLWjSLDVgiy+MD0Et4AVbxiVdahcRRA0Qdes2w2GzhI
         1IKnjJFLmE5RTiARgjO3PhMl/31CensT8Odn7aImz+VALX0rH1KvdlvTl6We5FVlgRZN
         P6kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396008; x=1778000808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK5ahICXkL0MctIkCl6eavo2XIzw7vhC4fPYDrQjJ7M=;
        b=CWpFy0OctxhLFQQv1UFd7bjLjWgAys3GujeGOY8gVBNKBK4PgcTqFMKxmpwyz3F+PQ
         ktgUwLpZRp5KgZ30lYf+sHOzzyiu+z1VmrASCFBCpK20G/JYDwFAEiVTVBQroee/3G7a
         HSg54MCx0fJu8oa6FQe3gJ0XTQzQdapKh1ToNx+vwDxvazSnpsrkD7UdQ4qrR6/LDxfx
         uDcDBX940YGg5avTprSctzkbVxr/sPzSEB/nLYy/Es2gkNCSQk52Ojm3p1f5mo/4zFA3
         viecmtxOZyd+p0PwK5VblGa6hG909udbRcCHskCWvu5iGm3x5FgtzE4y4JpeAe/ZDznH
         izSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396008; x=1778000808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VK5ahICXkL0MctIkCl6eavo2XIzw7vhC4fPYDrQjJ7M=;
        b=eo8Ydss+1c/s6jUh531m9vkA6o04Num49PQpF8H4O5rMVHTw7lV8w9mfGL8TucOWX/
         zn6wn6rb4ELXIz9ov6l4L2bwijto8DlfrqLOh/QGOnlf1OUBHzGq4r1EwbZrZ6eBjRzd
         F1Sf2PBcJIWNyLhWp6ZzYVlTGknRNsMe8Yc0+jYbA5uPbVAm3nCojksNG8t+OKddiDCD
         B+3yRb68ibl8SJqqm7TjTTvPWDtmri2c9VyULEtg8DUQhhgiijxbkqC3PnBC9gp+WXFY
         9U8G6a8kM0kp+rtHDDQ8snaXJfZIcRaoOiH5B/Py35OtXjSI6h7qcxAg3RpKLHnS8GDa
         t1uA==
X-Forwarded-Encrypted: i=1; AFNElJ9Oby0q3cuAf3BU1Jr5PFkloz/XURVdSqw5+g632JKAN1GvFxc3xq4IPLdGXfx6fEOrGTuR5aIZmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp9aZNVbeflrBUdsXUKeksOXEutG68EF01LR9LgTmiI2SlA7QK
	DxKxmpOBCFNllayNZJfD+rOb7Olu/CTl2B/1GosLW0tAfp+DLxsqquKFedHsPfStgkK8EBIDFyQ
	0WTDFGp80NDoA37GnspxTIYn5uhI+V/+jill3acPJDg==
X-Gm-Gg: AeBDieu12HjulP1e1MBVTguAFnSIiMB79VEFuBvPXcEEE2WAyndbwVtOQEBUHYi+/Ij
	OCZBC9kZ6TUmk7sDd+brBMTbz/jB2Le5mw5XJLCo6lbCxa9mflJrMmDlvBCPFFxElJ7rhhgYQal
	JTnv0kMXsc4nc2TTuuVoQnHukg4DRQG30uwQnYEz1I968F19/kfnBDsPYoZQBqUS55scOEYcbJS
	d0Grcs+opna7rjpWROZc5tM344C2BomHErveR1fqLNo8uBv8XE0BW28/HemfrS9Q94egDbF4HYz
	05PX6aNGSdqqpcvhYtxkcQVzOx9zj60jo7MCUnrB9wFTrAZaYjiA3Jx1kqOH/L18UjzttgLBJZd
	/aAmw7Ah3YvfGWP+sRN4=
X-Received: by 2002:a05:6000:40e0:b0:43d:7b23:bc99 with SMTP id
 ffacd0b85a97d-446489636b5mr6955778f8f.15.1777395553547; Tue, 28 Apr 2026
 09:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org> <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
 <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com> <2b2eecf0-72f9-4959-9663-c80e3cd0c517@kernel.org>
In-Reply-To: <2b2eecf0-72f9-4959-9663-c80e3cd0c517@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Apr 2026 17:58:59 +0100
X-Gm-Features: AVHnY4I0TqqC4RFs8UKqyAoce0ZbMMM6zkhJo0hxpAv6LX8MTNNEkUpX04aH9bk
Message-ID: <CAADnVQJp30BhhB6N3-GxtYmMpaMTaYvGcK9R5=8PxWD6qEXJhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
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

On Tue, Apr 28, 2026 at 9:16=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> >>>
> >>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >>> ---
> >>>  kernel/bpf/arena.c | 2 +-
> >>
> >> BPF maintainers will probably want to carry this in the BPF tree.
> >> That's fine - please go ahead and add it.  I'll carry a duplicate in
> >> mm.git so it compiles.
> >
> > We cannot carry the same patch in 2 trees.
> > Sooner or later it will create problems for linux-next
> > and issues during merge window if more changes
> > are done in the same area.
> > The only way to share a patch between trees is to
> > create a stable branch and pull it into 2 trees
> > then sha will be the same,
>
> As lack of stable trees was raised a couple of times in the past, once we=
're
> done with a transition to a fully git-based mm-next workflow [1], we shou=
ld be
> able to provide stable trees.
>
> [1]
> https://lore.kernel.org/r/20260421094216.8dfe14a8c62f2420fa5aace1@linux-f=
oundation.org

Ohh. Thanks for the link. Full git sounds great to me.
Reading the thread it sounds like you guys want to explore
your own way of managing the tree.
If there is interest we can share during lsfmm
how net and bpf trees are maintained from git pov.
