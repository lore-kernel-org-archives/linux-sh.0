Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1874C92;
	Mon, 19 May 2025 10:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747651170; cv=none; b=fXSJnI1PVDNTAZIUmiWBDPgyLqZPz1wspKvKvyx+Lh0WCjo3kMpjN3sFkncEgAnus+U5WCtDGc8321kQoixGYvJ+cioplI/S+6NogrlO1niD6RkqH7vn7Y/6Ox1V6mBVcasEOb+AAH1QclGy4XFspQ4XPhulPRcl2vI8vFCPBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747651170; c=relaxed/simple;
	bh=2M0MlmTnRgcrRCoz5Y9ZGHAKugv49nF7Ios6u1T54y0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3RUWGwb6tugTGVAQeywyhMUSfqh1BoxGF+WmZOyCSRKu+dH4DQgY8UpgGsWMbDKpnx0nO5Di+r5iUyaZsFqlPjjE58APxpabsfzHTF9l7aQ0LXdEpStgwXpaaddB0G8InrPdCaVX8xptZJpAXg6FCMYetQaBrH71xOyr+r0T28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52dd77335a3so183398e0c.1;
        Mon, 19 May 2025 03:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747651167; x=1748255967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIUIMLg8OyOkQVobLgePv9WbYlvjAsV4vX7+Q8pM40Y=;
        b=QcluPGOegOOjHtDHn9x7UyORsDqV09V8LjfzNseToi0TEi52lxknIzvhxNZkahBdpp
         pN5N5anuhpsPG27F5RRnVi5Le6ecnhr1CBRSm3znOeosiCpBkh4JodKm13T7mHxu1FPZ
         Tb7eoYG1K+xSoqt2WTlAVvIHVjMO7BPHxdGmqrHSMk0E90GSgEvM/YD85SjSStLyBgM6
         nVRD/hv74G9NN/LKi4J/zeDDf2kTn+qYaRbPs3LiR/gaPtQlO+HINgozwiUpOfkKgEFu
         d5Rd1wy+BeVDzcLWjl0s3klDiqGwUINqLbzNYOHbG21uysE/eEC0DA4EK14RuBIaNKLn
         Jo8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQKXKilzZJ8OIfvz/VqjJ48ZJyGi4IVY08qgVnbha8JGgS7e4wmkbHReAvagEhKZ++48BvST+radjxufw=@vger.kernel.org, AJvYcCXu9EpOA81DjzaHKw9fckKw2GbgSkCBPaPA/Z5Zgfp3zCttZYXgbWIxfimd36/Pj50sAyEcE6Ahg68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYO6pmsBvi2O5OlHR3xDniANyh4jkE7aSAsEnJe0hG3NRYA6EA
	o6KFaP2ed71PKiAinty5Ps50Kmo+R59SCumI1TngehPmFw3FZruwu3qan2HejJo/
X-Gm-Gg: ASbGnctx3yUYm4bdEEBNqQqP6OaZWOwoPLFSu9dA9KTKZjJGraS29mY5dNhs3BFZZ+S
	rbo4hXuC/AHrtzfCskUW+sc09xTrAKDSRHYjE8ZitgfC+OAPplVJRCDptvAXPJHEeHABe2M/Jx3
	iBIaw8zWtBK2MqoEL+SxtWPgvhO/APmcN2e7HrBxQt3LnJwxNZUMV3C/Eu9/wSL9SRz49/DZbzp
	rXoOINkzd684FChdi7t/N9XbfzjW+ZGrPZxdp8ADIlaMLYD3bHne3nUqpggGqKoSTlWbjh4fAZr
	QYEcLXX8fnaR0UQlSzxisNE+dhdcpsi68/LDjmjIaKRZHplvzViBFbUdKl3NvF90uN/Pm/S5PeD
	w2ycn2Or5TnnxCg==
X-Google-Smtp-Source: AGHT+IHvnvavGrrNkov3HdTyXLIqWoxVJ3dxooTIshVbXqa+mNK5uOM6jQOKtVV+f6JUE5TjUI7BgQ==
X-Received: by 2002:a05:6122:2049:b0:52d:bbab:2055 with SMTP id 71dfb90a1353d-52dbbab9460mr7036760e0c.10.1747651167142;
        Mon, 19 May 2025 03:39:27 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-52dba910d55sm6388874e0c.5.2025.05.19.03.39.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 03:39:26 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-87bfe95866fso459637241.1;
        Mon, 19 May 2025 03:39:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWOywm+xpZBqZqrp6DvAqNT7Zo/g1OJGbi7cJMs9y0bf8rOjDJB405bLhF2Es7hl2qx6lt+wCoTp6I=@vger.kernel.org, AJvYcCX76l6ITzyqrvrNtSj+GMkrzlI0Mp9vOY6PYgLxoW1GkQO79e9Y+VIw1g7IPD3euCPRLCMmQ9scyiD9oFk=@vger.kernel.org
X-Received: by 2002:a05:6102:2089:b0:4e2:83d1:5422 with SMTP id
 ada2fe7eead31-4e283d15566mr2038705137.12.1747651166595; Mon, 19 May 2025
 03:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250517093048.1149919-1-rppt@kernel.org> <CAMuHMdURQWHY2hAe+_sA8cVh1ERD4EfvJqg=NZDA0iXW-sBX+A@mail.gmail.com>
 <aCsBk6OUnkKGSJm3@kernel.org>
In-Reply-To: <aCsBk6OUnkKGSJm3@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 May 2025 12:39:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU-JhAU-n7sPgHG7aOHW8qhLS-MDtiyiotdAcJ0d0ZFFg@mail.gmail.com>
X-Gm-Features: AX0GCFsUK_wt65xWyOW_y2Who7rMlINwtXttrNMHKLDDnhlKTMZHkgvVC9YNLUA
Message-ID: <CAMuHMdU-JhAU-n7sPgHG7aOHW8qhLS-MDtiyiotdAcJ0d0ZFFg@mail.gmail.com>
Subject: Re: [PATCH] sh: kprobes: remove unused variables in kprobe_exceptions_notify()
To: Mike Rapoport <rppt@kernel.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Mike Rapoport <rppt@gmail.com>, 
	Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Mike,

On Mon, 19 May 2025 at 12:02, Mike Rapoport <rppt@kernel.org> wrote:
> On Mon, May 19, 2025 at 10:48:20AM +0200, Geert Uytterhoeven wrote:
> > On Sat, 17 May 2025 at 11:30, Mike Rapoport <rppt@kernel.org> wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > >
> > > kbuild reports the following warning:
> > >
> > >    arch/sh/kernel/kprobes.c: In function 'kprobe_exceptions_notify':
> > > >> arch/sh/kernel/kprobes.c:412:24: warning: variable 'p' set but not used [-Wunused-but-set-variable]
> > >      412 |         struct kprobe *p = NULL;
> > >          |                        ^
> > >
> > > The variable 'p' is indeed unused since the commit fa5a24b16f94
> > > ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
> > >
> > > Remove that variable along with 'kprobe_opcode_t *addr' which also
> > > becomes unused after 'p' is removed.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes: https://lore.kernel.org/oe-kbuild-all/202505151341.EuRFR22l-lkp@intel.com/
> > > Fixes: fa5a24b16f94 ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >
> > Thanks for your patch!
> >
> > "p" and "addr" are definitely unused (besides side-effects?), so
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/arch/sh/kernel/kprobes.c
> > > +++ b/arch/sh/kernel/kprobes.c
> > > @@ -404,13 +404,10 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> > >  int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> > >                                        unsigned long val, void *data)
> > >  {
> > > -       struct kprobe *p = NULL;
> > >         struct die_args *args = (struct die_args *)data;
> > >         int ret = NOTIFY_DONE;
> > > -       kprobe_opcode_t *addr = NULL;
> > >         struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> > >
> > > -       addr = (kprobe_opcode_t *) (args->regs->pc);
> > >         if (val == DIE_TRAP &&
> > >             args->trapnr == (BREAKPOINT_INSTRUCTION & 0xff)) {
> > >                 if (!kprobe_running()) {
> > > @@ -421,7 +418,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> > >                                 ret = NOTIFY_DONE;
> > >                         }
> > >                 } else {
> > > -                       p = get_kprobe(addr);
> > >                         if ((kcb->kprobe_status == KPROBE_HIT_SS) ||
> > >                             (kcb->kprobe_status == KPROBE_REENTER)) {
> > >                                 if (post_kprobe_handler(args->regs))
> >
> > I have no idea what this code is supposed to do, and if it actually
> > works.  Red flags are that the assigned "p" was never used at all
> > since the inception of this function.
>
> "p" was used before fa5a24b16f94 ("sh/kprobes: Don't call the
> ->break_handler() in SH kprobes code"), but I can't say I understand that
> code either :)

Yes, the _variable_ "p" was used before, but not before assigning a
different value to it first.

I guess this is where Rust would be helpful? Although C can and does
give a warning here, too...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
