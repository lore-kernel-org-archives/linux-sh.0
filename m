Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A04E3F7AAC
	for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 16:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488621; cv=none; b=FsGUD000nU6zyNoLBRSu6wKjvHudpDsq3KVNFEyXnE8Rv++v8sqtdtCTIXKcIT00Co6yK63Xh9Q+yIqm1wWtwaaZ/UKvFiyHjETlQQY/epxqBSC4gPcwBPKJG8T0dS7CyNJOYR+p/T+yyuGAoNLSNYbEcqwkeA9UlrmGOx07nRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488621; c=relaxed/simple;
	bh=TaD3IKHcoZf0PQ+wUUh3mHvOgYZf6uXYuUZRFHNcE+Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGcVeSoirJCteA6bE565d62sZmuAx7RpsXcbSstilvFWFj3x1NNLobodDDidqTcKOdV7sLIZ3DuhynZ+8Dn7XfTFJKV+RHo4HGepi+MBAg5qX+y3MfolScIYPDOL8Kt7gGR/QNEsNaAm9Xu/dWftx9Q3uTqD0BOWBsKeKZtN/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=SOqSMAPZ; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="SOqSMAPZ"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2953a01240so734566b.0
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 09:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789488618; x=1790093418; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=SOqSMAPZxZMKBZikTwKfw2WmrfM2Xy3giQ7yyOuRMABfG028BVeIuOq/EHC0oZxVZn
         3xXTUGBdqdsvFfL2B4tP1yw2ZJ9L2jhIC5AGv4N8imXmFAbjFFP/72gI5IoCa8j1o9RW
         oLIY/jBkYxyj3DUx76xfIAMrz51KLo+FX2iNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789488618; x=1790093418;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cj8iWYGkmy9fr6Sp+MjBMi0cvssqzarl8Tgut8FUMEc=;
        b=MdcMwelFqSJk1j54Sy7CDBJDizffs/XXnExfrm5tw/N8ASIkxMw23L+azw5Kv71Am+
         FaKJy5yk3zY3chBBlqyIdXlke2ah920lBaeOzZL6obV2RGsuMbbW150o8pUssNHuYO+V
         CahoYsq3OQqX6rhUBLgKcfW6d8Skd/SSStrkXIB84U61OuNyB6Xothil21P4lBuSqHxy
         wrr6GtdL9n9gqIGcVFYJeMFpKtP8gOpbfJ/DWXjHKhgOLc0o4bOY+OhN6ILpTUwAkzje
         PaQ5Rrf2cPJLqSAwbs1FqE7rMW+8y2PbmWM9XdZrFbdYbruqc7on7AMv3Rfave146oTB
         pXfg==
X-Forwarded-Encrypted: i=1; AKwUvByMy8THeK3PhuHzGRd3uNR2QtNp8ZKGoYBcB8s84fYNIybHHQDyNycZ32OaBp/zBimXhihsSGRQWQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kNb7fSV/CDR6LswwvQP4nIoj3NK/eN90J6FOfyIMkUknB54Tqg
	9UBrEJnTKe7C6+BEZhf1874MmRxVcMrDuxplxlIa+ES7BaOLxLZQLSdzgOYCW54wLX1+03CYp25
	/g9RX6Yo=
X-Gm-Gg: AYBFou0uEKUs/SwHXn97+/CzkkeKqRBHfEBRpd40mArtPT1/YrBmoMB4veQjdzn2lgC
	Mko6sV4xNxxCJeR9VMEtPa53j3peOG30QyroERuPJ89j+GbEF2J+irPS6XitVUIsZLzbGaDtuhf
	EAjyGYSR2295M8/ANM9WrwKpm4lRyuMQBljZ5PltNqYFkw1q9+RUrrUbplNrKkzvM/N+pa1/JHG
	QL08TUK+F5HKL65TJpz5ZpdmZ1BvKR1rXk1v4ehDaMDVN0eJlEZKS6RNoy+5rKo0E6GH+BdIdRH
	XwG0UFokvwU0a8L3h3KTfqWdARulo+u/EgNdgY7Eho0RuQABrraHPLbFSxVCuuSWFrWOmZSH4ug
	b/uEusozcTNykFIfRD+Is5tLcy3igD5wd3bTlejzaqgqF2Tgm4/0bNkJlmhuCEG3Vu1uTYH5/wl
	00hylFI8pHAFjULHvZ4MHicGspNfUsiLGoJCEQYu9VE+9KpPa4taI6xX05LXJOXygahDaAIlx+B
	fJcnuOEuyZZ7sIDUmdu4nrzRcRR1OYwmPwueMyvr0UEbsNb
X-Received: by 2002:a17:907:720d:b0:c24:6985:d7a1 with SMTP id a640c23a62f3a-c29b84ded7emr540711066b.7.1789488617363;
        Tue, 15 Sep 2026 09:10:17 -0700 (PDT)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com. [74.125.228.76])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29de6040b8sm774366b.48.2026.09.15.09.10.17
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 09:10:17 -0700 (PDT)
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a98604f6b4so5121474a12.2
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 09:10:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwnqFf4wdRdWLaUsZ/cjup2wmzzJi2TmZSrpmLgORnpN1eLQKVMm6uqJU2D4Yt4fQd5pwnRetMm5w==@vger.kernel.org
X-Received: by 2002:a17:907:cd0d:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c29b86141b9mr553591866b.16.1789488168046; Tue, 15 Sep 2026
 09:02:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 09:02:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
X-Gm-Features: AcwNN1WK06t9f9BcKFBIanysXcyUXK4eRICuH4x14s60AdlpF6ijCATIYaYAAvQ
Message-ID: <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org, 
	netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, 
	David Airlie <airlied@redhat.com>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	kexec@lists.infradead.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 15 Sept 2026 at 04:31, Christian Brauner <brauner@kernel.org> wrote:
>
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

Honestly, I am *not* a fan. At all.

I think this adds complexity rather than removing it.

The diffstat tells a story:

>  106 files changed, 962 insertions(+), 861 deletions(-)

in how this adds a hundred lines more than it deletes.

But to make things worse, it adds them in bad places: low-level
architecture assembly code.

Those extra lines are *not* making complicated code simpler. Quite the
reverse. They are taking fairly straightforward "just deal with errors
with normal cleanup in the place where it makes sense" and makes the
*straightforward* case simpler, while making the big picture more
complicated and subtle, and adding new code to places that are not
simple and just blindly do somethign that makes no sense in that
context.

IOW: it's more code, and it's more abstraction, and it DOES NOT HELP.

And yes, most of the well-maintained modern platforms (read: x86 and
arm64) use the generic infrastructure and they don't show that
low-level asm effect. So for those cases, it's mainly just  that added
conceptual complexity and a new odd rule - and makes a *successful*
system call go through that "extra work" and indirection phase that it
didn't use to go through.

So it just spreads out the work, and moves it to a less obvious place.

All for the very questionable advantage that you can now randomly add
a file descriptor without the few lines of fairly straightforward
rollback.

IOW, I do not see a single real upside to this, and I see immediate
downsides to it, and a more abstract complicated machinery.

I do *not* see why we woudl want to make this be a "every system call
exit" kind of thing. If there are places that think it's complicated
to do, they could have *their* local little stack of fd's pending. Why
force it onto the low-level system call entry for every system call
when there are only a small handful of actual real cases (the vfs
itself, and random ioctl's by odd driver subsystems).

              Linus
