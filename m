Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD251A127
	for <linux-sh@vger.kernel.org>; Thu, 17 Sep 2026 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663591; cv=none; b=KbJONadNBmcKtFdljWLtpGaRkQDBy97esfkqVTDJBVc96iNqb6RcP/wpaw58tw1BaZO8BW+46g8b8BndZKwLr/37XV3Jta1PwgdOjoardKiL8rRZjQ8S++yQsHahgxxn0GMZYSWh36JnOWZBLk5rDw4bmiRjKD6AycrNHwmCIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663591; c=relaxed/simple;
	bh=eYYWM3K0Z9Uro9HwA9hQ8je2naly/JqA+zNhzp9DrpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoNOsVogbNQPihbceXNBCUoYQYm6sgwH94CKT2+QUb6LR9ZM2IsLYvJMM5GgCw7sOQDI5mooFssXfP8CGW1Gm8XSPZL33YFWe44qodbQlh2u4BEuaAWX3LR/fsykqPiJuPqaH2SLSE0TBd3o6l2oLbkjRUU37kZlaPHBNOS/kfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTTX6g4m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTTX6g4m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
	b=ZTTX6g4mYj0vlRM1lqShOllZvQyzIx2owUz//QT3uX3LDPwvQ13gLfFul3EjOEEnhQRL8+
	IgQ/7XdL20/z2P4kFnyzkp7ERWfZuLKKKkUCSaqJIXTrE/hkbCg/FbDPz+nqS3uMZjRKFl
	rRIN2A0cBVjwRsvMvG/YvP3IE3QaPqs=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-Oi1ZNR80O-mQm8oqa5gbgg-1; Thu, 17 Sep 2026 12:46:26 -0400
X-MC-Unique: Oi1ZNR80O-mQm8oqa5gbgg-1
X-Mimecast-MFC-AGG-ID: Oi1ZNR80O-mQm8oqa5gbgg_1789663585
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c2945f5e851so95782766b.1
        for <linux-sh@vger.kernel.org>; Thu, 17 Sep 2026 09:46:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663585; x=1790268385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wJkyJ4XReVojvgclcE9i/BeATq3QWWN8a1a2t1DdhcM=;
        b=dpemoWcil1dVPFaIGDnLaOATiGXs+AR7oJRCh82lmm1FVVJHjXsWo29V/rLWIn9wqC
         mBqHSHNtU/q9DLD7ULBz1pm5epCyJQxknbp/Vyo0X2burpwYgTVmRyt+Zo8GTZKHAxI1
         886MPPsx09NMK7Llj7M/pFuoAtA9LS8BS9gRCmBhckc8sBvD9J1v7uA5xEvRf6ibW8vk
         RVShxIS4TpMaRNZ9GFO1RSCHZmznMAh8Gtl6n/G8rVMlXM3Zszpyd797od9jFbPp9zNk
         fQVMR+1SbCFIHZrwYHTLreNgud2hMi3rDmq6Ph7LYlSLB+teq8b5C8JgViqmChV6V+Dm
         qGag==
X-Forwarded-Encrypted: i=1; AKwUvBydyjdAJbig35voRGl46DxT7X3flLBzka4slLokqkFW5pzVjOs5TXvMk7PSv2r0chBXuwCYq1Ykkw==@vger.kernel.org
X-Gm-Message-State: AFuF++lz8wQwHqPzMO/sozs+RibrSlIE/STDckSgqntplSI7vTIxCIvq
	gZHj9yHQ2VFgSobnU0NG+5UiJGxbAk5px3xvdQ0jHoqw8S++YooX6pdhWXF4fG8aDkmInXwiwQF
	4aZx5LcpYAtD4oakPGKwv2Cq4+NEUYzY4etrSoMRLb0aPxo11MJ6UeTzvHsMhyyM1+0p6ULU3dj
	xQDznwr4x1aNaI/VacMrzzwYQdCzYIcMS2syE=
X-Gm-Gg: AYBFou3MzQwFwlw6YIXhX/MIo0/8wmO6lXcecm9Yp7ohTKKspaq4+YUpxncJncDcxgb
	fkLuUJuY90obMFtDPQ8KXl/xB8gqBAdstdNLc7HSSC0gnT9I9EO8XvpTxhN36IBRmqeIq7FfnuQ
	2Rpz4S/uCtRoNZIxB8faFeQyQFv6XRNr9h4y/OSb14eCUuJ1nvCqni7mvybgbD2tkEHhEJAbIN5
	T0ucEfXtmLb6V5yxXPMiJ1tJzcwWOFdYbG5vj15XFKtyMofr+ypVMzMRJYdTxpQTZwht6WrNu5s
	pDA=
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id a640c23a62f3a-c29e53184f0mr504526466b.42.1789663585473;
        Thu, 17 Sep 2026 09:46:25 -0700 (PDT)
X-Received: by 2002:a17:906:4fc5:b0:c26:19de:9ad2 with SMTP id
 a640c23a62f3a-c29e53184f0mr504523266b.42.1789663585091; Thu, 17 Sep 2026
 09:46:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <b4ab47d2551d090520b4fa81a884b5988b9655c7.1788351089.git.rrobaina@redhat.com>
 <apkuNj1paR_GO3x9@willie-the-truck>
In-Reply-To: <apkuNj1paR_GO3x9@willie-the-truck>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:46:11 -0300
X-Gm-Features: AcwNN1UTQywdGW9xqj12KwNHAYLGfDNNso402GZvP3WcYYwXGdDJ7Oiz7qML_cg
Message-ID: <CAABTaaCoNztwDUA-HPp4LaikxL4dxk-1bvCCpoZEGD4rnds1oA@mail.gmail.com>
Subject: Re: [PATCH v2 04/13] arm64: pass pt_regs to audit_syscall_entry()
To: Will Deacon <will@kernel.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	linux@armlinux.org.uk, catalin.marinas@arm.com, guoren@kernel.org, 
	monstr@monstr.eu, tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gYgOQM04cizaWC3pcu-_9guhA9Yc-h5QtylbYyl30Ro_1789663585
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 5:22=E2=80=AFAM Will Deacon <will@kernel.org> wrote:
>
> On Wed, Sep 02, 2026 at 11:43:37AM -0300, Ricardo Robaina wrote:
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/arm64/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> > index f743cbec1c3a..65532b2a8cd4 100644
> > --- a/arch/arm64/kernel/ptrace.c
> > +++ b/arch/arm64/kernel/ptrace.c
> > @@ -2476,8 +2476,7 @@ int syscall_trace_enter(struct pt_regs *regs)
> >       if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
> >               trace_sys_enter(regs, regs->syscallno);
> >
> > -     audit_syscall_entry(regs->syscallno, regs->orig_x0, regs->regs[1]=
,
> > -                         regs->regs[2], regs->regs[3]);
> > +     audit_syscall_entry(regs->syscallno, regs);
>
> Acked-by: Will Deacon <will@kernel.org>
>
> Thanks for doing this.
>
> Will
>

Thanks, Will!

-Ricardo

