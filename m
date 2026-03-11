Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BEE31E85D
	for <linux-sh@vger.kernel.org>; Wed, 11 Mar 2026 14:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773238290; cv=none; b=gLNXQCAlKyp7TdH8iBEXHkFhkfq6MwLGMxPp47N2ooe0BqCwY79c58OX7piuKAbyhGxUv/DO3Nhg2yINC4q8j7KEmwPzy0CkybhWSn8nNYXxvyzLALvTNnn0627UpPzbcV/Kb3jgZTy9G5ZB4jE/gtfkBTeoKjkEiKJYV82CEoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773238290; c=relaxed/simple;
	bh=POUJjzeRhBIXfPGojdZfC417KH92loTKx1KmDpRcfoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JLxK5/tRw/jHjWZIbR6SzjTBgcvYZL5bXQe33IJoKfWYAjZsFJeCJm2suth3VE8msKl8qPhqKqxJZ1b5SRxu4zrspc7SfsLUZwKilqsKPa7GJULyG1rz2S03yVlJDIILLSxTlJ6on0gOeUvN3z63km8BE+xWuW6zN/lFkiM18gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b942b36de08so190265866b.1
        for <linux-sh@vger.kernel.org>; Wed, 11 Mar 2026 07:11:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773238287; x=1773843087;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIz9Fr5w5J45ZN4rxwvT/0kjXMGfLP1VpB2aKPOax7k=;
        b=HQEE2rJEib5F1asIDLVDjUF6YtyJpycjh6hrEpnm9PQSRaAFJQODLzffiP8Up3dhht
         l1UegCsSYkAeTfyBcUksY9l3gIK1LvGmlSb3tOwtN+OY8q0PKgNEc/B1Oe5FvJ1pCxhu
         4PfXLwID3H47NU28wTMwGZMX89BaxXsBVs+kZwrS7d7UCv/N+dJ5sWC4UKHh7mqFFi1Y
         D58aFExisDTTmxf84++s/K9iR4QszDLQLaFDxBPOkgqO9cE8yHmsguxyL9J4Io0d8zDS
         bnJtwmHsMI5PCVR6VOfQXdCYc5FUaEkrSdahvjveV6FJMylxaZpXakCEegrMVn5Uvj2u
         hSjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfrhp8tq+b7t7EIXkj5uso94ZQFkfwBVgHj2wpWE6Ke36yvoHOZrpZhKf8W3jH+JbYDEIOtpliWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRbIp2ziOAJzdjaGqkIq3+2Mztu1pn5EWt57racuqHYI2LZXm
	9IgbWMoRRVqOjPut5Nb0hDicGeRd1p58uUgLPd00SA9eNAGoQY3ubHwAayX6O+2E+Tsjpw==
X-Gm-Gg: ATEYQzzGxpPO4DuuPoT8hztRIVEMXf3tIyy6xl0t6KoCmqVmdPlSYtUqGtGF1vNkRQu
	C49AhcA0NP+8kuCCYAmdFrNc6Nv6Ru3icixkCmwiP49AJXvzTiJZjAKPYUIyzJ/QOGrHBE5Nc4P
	s6IBUH9+SMf5x7fCSfIPFvUe9qe9BmT86pDQU3eI6A+z7lpmQ08nQQenKtUqNKPhen6theR3O0x
	/kJLxX/vtl9xEEJ/EbrM9Jeg3+3PS4lSCZbOxdMccjc1KvtK3zBAdbEBvbLnzq1Fh2uplFZIqZm
	jpDjlgVzVJ/HW8qNfhF/blTXkR/Jr7XPxAi1P/HHLxPyv3/ZhD7/tbGDodSa/yISEqOySz6jgdD
	TQyBbumiagFwDC9Px9ipyFUp0IaYBYbVgElMU/zJsrXyFw0b9HuaOpGVEnkeBpzcZOaG8o6ALvY
	Kb/VEwl9X17rNu4V0erYnaRklqK6xHXAEKerMc0mlj6YuTwiqhb+XYsK16yRd8
X-Received: by 2002:a17:906:c106:b0:b87:6bb4:9eaa with SMTP id a640c23a62f3a-b97118af658mr467649966b.8.1773238287189;
        Wed, 11 Mar 2026 07:11:27 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b972e185284sm55818566b.51.2026.03.11.07.11.26
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 07:11:26 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-66174cf4549so2110902a12.0
        for <linux-sh@vger.kernel.org>; Wed, 11 Mar 2026 07:11:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWo/DoWTCHE1IiXls8xIDnc/33CvCxf5AyV+kFX5NzymBmdhOTmaBasqrnFoiSCE3DmUvmugh5Q5A==@vger.kernel.org
X-Received: by 2002:a17:907:6d16:b0:b88:4f25:81da with SMTP id
 a640c23a62f3a-b97113ff0b9mr462021166b.0.1773237981235; Wed, 11 Mar 2026
 07:06:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-15-bd63b656022d@avm.de> <20260310100750.303af303@gandalf.local.home>
 <20260311141332.b611237d36b61b2409e66cb3@kernel.org> <20260311100332.6a2ce4b1@gandalf.local.home>
In-Reply-To: <20260311100332.6a2ce4b1@gandalf.local.home>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 15:06:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
X-Gm-Features: AaiRm53WEGMMLW4z34e7P-lM1qFvsCJGZ_o4JNL5NPWbhJPKmcqz6k9bJcyL--8
Message-ID: <CAMuHMdX4kRGLaKMzPuhS1Pmxh609eiqQW-cAS_jWBBbt-vE6SA@mail.gmail.com>
Subject: Re: [PATCH 15/61] trace: Prefer IS_ERR_OR_NULL over manual NULL check
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org, 
	apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org, 
	cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
	target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	v9fs@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset="UTF-8"

Hi Steven,

On Wed, 11 Mar 2026 at 15:03, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 11 Mar 2026 14:13:32 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
> > Hmm, now IS_ERR_OR_NULL() is an inline function, so it is safe.
> > But if you want to use IS_ERR_OR_NULL() here, it will be better something like
> >
> > node = rhashtable_walk_next(&iter);
> > while (!IS_ERR_OR_NULL(node)) {
> >       fprobe_remove_node_in_module(mod, node, &alist);
> >       node = rhashtable_walk_next(&iter);
> > }
>
> But now you need to have a duplicate code in order to acquire "node"
>
> I think the patch just makes the code worse.

Obviously we need a new for_each_*() helper hiding all the gory internals?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
