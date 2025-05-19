Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809D326A1B8;
	Mon, 19 May 2025 10:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747648923; cv=none; b=UDTt10CGpeMLl/dmr+xkGdmGriM7cyHAoRLjXoY7MyM+oN3a7L8g1fvjPu8NTm4y19/61Y0fPk7qOrfQ+hlxgeZCza6bwUWEABBLAXmTNh29iZ2XICkxFk/UpAA777mHLPeSEGEo4w3EQEhVy0m5Nya8vQGAaOsI20p+RwaXPUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747648923; c=relaxed/simple;
	bh=nfGjAmRusdnHy0utbcl82JupWWBu05y/buhmdLs3ic4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKjN1Y4/0BOemwLIWshG4Z5TnB+9/vbe3d4rb+LV0NgkB7muOd3GaXMZz5nivh8nBZi6QOSDlBJdx7XkyHKcSwx3OZjKtijOeWmZeWozj/TWAGdzvxpVXpBw4j6v9P/pCgH9oxlhI69C7vfKc7Y/UkI1izGp4FHJWOSnri0RuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNzz+hwe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNzz+hwe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C73C4CEE4;
	Mon, 19 May 2025 10:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747648922;
	bh=nfGjAmRusdnHy0utbcl82JupWWBu05y/buhmdLs3ic4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNzz+hweTHX+k6aokJkJd/pWyRJ65OXEmVIES3IqDdme72h8vSATCts0gihA98ibW
	 zzXXKxkzdC0xWDNOzE/1PMTztoN+WD85XfY79fLXtiZ/MLJjr9fKjBxol8QOB00P88
	 2pm/1Ls9OuU5E4UClzAGhS3fkfSiwNcvuCPqqkGA3UgX4qgX89utWpRWwpqQZIvlQX
	 2SgWSEcuXCYA6T2e9RANQMQFfg/Q4kFAbRNzhHg+858gn2q4yJUD1tyyy3KRUo0JYM
	 jwiXeYGG9ADy0g5hgkchAsRiiFIvBm7htxLxNtFytxRDuP3ghDQLWcG4Aq/LX+qLjY
	 KVeLj3SufeB+g==
Date: Mon, 19 May 2025 13:01:55 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mike Rapoport <rppt@gmail.com>, Rich Felker <dalias@libc.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] sh: kprobes: remove unused variables in
 kprobe_exceptions_notify()
Message-ID: <aCsBk6OUnkKGSJm3@kernel.org>
References: <20250517093048.1149919-1-rppt@kernel.org>
 <CAMuHMdURQWHY2hAe+_sA8cVh1ERD4EfvJqg=NZDA0iXW-sBX+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdURQWHY2hAe+_sA8cVh1ERD4EfvJqg=NZDA0iXW-sBX+A@mail.gmail.com>

On Mon, May 19, 2025 at 10:48:20AM +0200, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Sat, 17 May 2025 at 11:30, Mike Rapoport <rppt@kernel.org> wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> >
> > kbuild reports the following warning:
> >
> >    arch/sh/kernel/kprobes.c: In function 'kprobe_exceptions_notify':
> > >> arch/sh/kernel/kprobes.c:412:24: warning: variable 'p' set but not used [-Wunused-but-set-variable]
> >      412 |         struct kprobe *p = NULL;
> >          |                        ^
> >
> > The variable 'p' is indeed unused since the commit fa5a24b16f94
> > ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
> >
> > Remove that variable along with 'kprobe_opcode_t *addr' which also
> > becomes unused after 'p' is removed.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202505151341.EuRFR22l-lkp@intel.com/
> > Fixes: fa5a24b16f94 ("sh/kprobes: Don't call the ->break_handler() in SH kprobes code")
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> Thanks for your patch!
> 
> "p" and "addr" are definitely unused (besides side-effects?), so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/sh/kernel/kprobes.c
> > +++ b/arch/sh/kernel/kprobes.c
> > @@ -404,13 +404,10 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
> >  int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> >                                        unsigned long val, void *data)
> >  {
> > -       struct kprobe *p = NULL;
> >         struct die_args *args = (struct die_args *)data;
> >         int ret = NOTIFY_DONE;
> > -       kprobe_opcode_t *addr = NULL;
> >         struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> >
> > -       addr = (kprobe_opcode_t *) (args->regs->pc);
> >         if (val == DIE_TRAP &&
> >             args->trapnr == (BREAKPOINT_INSTRUCTION & 0xff)) {
> >                 if (!kprobe_running()) {
> > @@ -421,7 +418,6 @@ int __kprobes kprobe_exceptions_notify(struct notifier_block *self,
> >                                 ret = NOTIFY_DONE;
> >                         }
> >                 } else {
> > -                       p = get_kprobe(addr);
> >                         if ((kcb->kprobe_status == KPROBE_HIT_SS) ||
> >                             (kcb->kprobe_status == KPROBE_REENTER)) {
> >                                 if (post_kprobe_handler(args->regs))
> 
> I have no idea what this code is supposed to do, and if it actually
> works.  Red flags are that the assigned "p" was never used at all
> since the inception of this function.

"p" was used before fa5a24b16f94 ("sh/kprobes: Don't call the
->break_handler() in SH kprobes code"), but I can't say I understand that
code either :)

CC'ing Masami, he probably knows what this code does.
 
> Gr{oetje,eeting}s,
> 
>                         Geert

-- 
Sincerely yours,
Mike.
