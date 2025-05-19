Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E72459C7;
	Mon, 19 May 2025 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644517; cv=none; b=O25y/Qg3qpRWvygHJLWVQkxgNxWjMPxS7TQIcEjIghXcfHMp6RWT1N1FyWsDRl9j+912iAF7J3IuRRtShSsKzloqpUinxkwlPDKa5U1bO7WTh6RObAkeoIGidAp9oss2hbIluaRZzfCeWADG06ssN5LtYZ6qM1HM1vCh1icMutg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644517; c=relaxed/simple;
	bh=Ih+8f3zUfjU505gQBNGKBoShCWVN0Yfmu67KdEg42mU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAHOQKHVAYVqRMy2D2sBFTzXrRgHJLydUYFgVPZo5qAcotPdeOdwmXZOwlsg48FZjJ0c9uzFlZS38Xkv/VnFv88IybGXaoxKzEukGnDS3PNupNCbSsDk6QMq46ZYiRqFRm+zhp8dc+FuxYMaQOXPHor+qEBpm+lDNJljQpkDZuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-52eea8111easo131042e0c.2;
        Mon, 19 May 2025 01:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747644512; x=1748249312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UUoGNODM3B5cNA6VCA3Yq2EkxGAcmEIZXesnTmnumTo=;
        b=NtiFi+qERQn3YsxiHKRFGIxhVeaYCBSHH2ReGAdp7XYd/pWntF3GtbDf6wYNd3xfgt
         xOSkBNRgUQkBfDIB7BnFSxFjwrJmuyXhpjWo3xYtAVGAR9LPbOe7fZYectIkbmIaP/oK
         lm4y2xIMnS8mx4xoMCFtPO2g/8eac62VVK93B5pLWWA3wBykTfKha7FaFZ1dwHF4cdMH
         TBP9E5C+/77EOlRw7f8EUTQlf408Hr1uGNd1BTICly/aZ5VC0iddy1pv3xjRW7FoZr5h
         qgTsjUAdjtcBtEWg4kxbxjpKjMk/k73jf7xC8xfsIQyjbk4Xyw1H2eC0a9WPAXqt8zCP
         aBNA==
X-Forwarded-Encrypted: i=1; AJvYcCUumJ+9MNgCHlPFPo8uLFvKwh5ToQ6K+XaL1FaD7GQEsXvXswhC+Sf4WxbSb+Kz05wOKzGK/g9r7Ko=@vger.kernel.org, AJvYcCVtznrOKKjXLu9KXkS2VigOCdanuIraI8zffekeQvjuWjHcC5mumv9uB2eWRQkkzLWBNJESm64UMVkLFRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGAu1j7OYNxAtXqWrVSOryUYErYqZcUau5KQNz548Svt2aNzN
	RtdigoGaqe9CvJEZadsqCiRtoeRhIoYJeDdgcUPIofr7qa2yfL/pK6hB3+9HjvG3
X-Gm-Gg: ASbGncscIloULUd89iqM4bhfiv80YKTb2tJWfe0nwu8xsvAlqqTt+BwZB+7DlBXqmj0
	sJBO7u5/H4sdbcLeqN/rWmRETRhTF4HO5xOaEAuiENQ/xkdp5YqXe0JQUTYFMKFpTKeH0mWtXYu
	Hwe4pwBIOubhNXUaRdAfNqVqNstiHmtjPYIvCdFSYcXZtD946cq8QDrgQVK+9F6sZo7GYA3rOkT
	AII0bOHuUwXm+8ABx0sv7most3oACElsQRgf0Yd/+Zx5/wKXiKSJVOq5h26KebVdmFY3sHb+Ln4
	vIvfbcX3i32xlSV4nUirBa5WFbqbISvO21L82owC3xo6g4/aKEM/ATdtTQa69Uw/lB6G+jHRMrR
	DqUoZRnzT8LY5Iw==
X-Google-Smtp-Source: AGHT+IEHyltb1G0iJZhl3YfYVMe2vWgZlb7JXH2b0bwWqcQLNkl99jj0E8Oy5vP0M2oZkGu6dnpDkw==
X-Received: by 2002:a05:6122:792:b0:525:9ddc:381a with SMTP id 71dfb90a1353d-52dbcda03a8mr9604714e0c.6.1747644512555;
        Mon, 19 May 2025 01:48:32 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec1220b5sm5437499241.11.2025.05.19.01.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 01:48:32 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-877c48657f9so828701241.1;
        Mon, 19 May 2025 01:48:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwYJ9MeL6yZVQ3SiI9Ko7Fujsvic+6t1CUsWEEc2qsKg0qwY+sdMWvsNbDsUchbQTiSsvSObut3sNc3f0=@vger.kernel.org, AJvYcCV2WKQ9+WO9X6TlE9TLOz0XX9WLjO5IWXMerkK5zwNik+j2OBmvVAjbzgZPj9wa4gSSzYtDkBrMgyg=@vger.kernel.org
X-Received: by 2002:a05:6102:330b:b0:4e2:9b58:ed70 with SMTP id
 ada2fe7eead31-4e29b58ef93mr397855137.9.1747644511992; Mon, 19 May 2025
 01:48:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517093048.1149919-1-rppt@kernel.org>
In-Reply-To: <20250517093048.1149919-1-rppt@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 May 2025 10:48:20 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURQWHY2hAe+_sA8cVh1ERD4EfvJqg=NZDA0iXW-sBX+A@mail.gmail.com>
X-Gm-Features: AX0GCFtfNAumQMNNQi8KkHvE6Pqueqrc9COgImCZWxMhdTTFYMGbyiZ2UCS92FA
Message-ID: <CAMuHMdURQWHY2hAe+_sA8cVh1ERD4EfvJqg=NZDA0iXW-sBX+A@mail.gmail.com>
Subject: Re: [PATCH] sh: kprobes: remove unused variables in kprobe_exceptions_notify()
To: Mike Rapoport <rppt@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Mike Rapoport <rppt@gmail.com>, 
	Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

On Sat, 17 May 2025 at 11:30, Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> kbuild reports the following warning:
>
>    arch/sh/kernel/kprobes.c: In function 'kprobe_exceptions_notify':
> >> arch/sh/kernel/kprobes.c:412:24: warning: variable 'p' set but not used [-Wunused-but-set-variable]
>      412 |         struct kprobe *p = NULL;
>          |                        ^
>
> The variable 'p' is indeed unused since the commit fa5a24b16f94
> ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
>
> Remove that variable along with 'kprobe_opcode_t *addr' which also
> becomes unused after 'p' is removed.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202505151341.EuRFR22l-lkp@intel.com/
> Fixes: fa5a24b16f94 ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Thanks for your patch!

"p" and "addr" are definitely unused (besides side-effects?), so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/sh/kernel/kprobes.c
> +++ b/arch/sh/kernel/kprobes.c
> @@ -404,13 +404,10 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
>  int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>                                        unsigned long val, void *data)
>  {
> -       struct kprobe *p = NULL;
>         struct die_args *args = (struct die_args *)data;
>         int ret = NOTIFY_DONE;
> -       kprobe_opcode_t *addr = NULL;
>         struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
>
> -       addr = (kprobe_opcode_t *) (args->regs->pc);
>         if (val == DIE_TRAP &&
>             args->trapnr == (BREAKPOINT_INSTRUCTION & 0xff)) {
>                 if (!kprobe_running()) {
> @@ -421,7 +418,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
>                                 ret = NOTIFY_DONE;
>                         }
>                 } else {
> -                       p = get_kprobe(addr);
>                         if ((kcb->kprobe_status == KPROBE_HIT_SS) ||
>                             (kcb->kprobe_status == KPROBE_REENTER)) {
>                                 if (post_kprobe_handler(args->regs))

I have no idea what this code is supposed to do, and if it actually
works.  Red flags are that the assigned "p" was never used at all
since the inception of this function.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
