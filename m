Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCC84B44AE
	for <linux-sh@vger.kernel.org>; Thu, 17 Sep 2026 16:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663663; cv=none; b=DhZtr/hKxJ422KTDoPwV+1B5ZAVaAawq4l4Ro8XtZpw+Smp0mG6xZ/E+A+NQY5didH8d6mCrMv/94S1lERYIbMOk/wH0Z/0gZGyFCTZp/MJmpPhf3CPqVJE0jNdmoGC3x9UoFTJBTkS1xu2msFep/xVuzIQTaJFzqYG3L2TeOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663663; c=relaxed/simple;
	bh=OXoyJpegabl0ocESy43SWOAVnutZsDrl9ix8aJurgKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HtiqroDrBSTKrKYFGqedt+OPZG8Y/7UwXupygj1yY0ty3WNByww/egswuaGCY74AQSCbipqZmc5V/0bxja8fzAXx+1xWO35C2pAn78d5FYT2YDLGpRWUPNkST5dYtMV+AoyebeA7AbwpLQIdzz0AOGqDG2MPKlDLAK8hvjbP3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h/C9mgWL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/C9mgWL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789663660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
	b=h/C9mgWLVKUE3XGeurN8VBjS/UsjoM5ZJ9tPSlsW3dzKSEAFnd4gOI4xE4ErfI2eOvIN4S
	1xiJOWqAUg3ahtdZBoIQpTeKpK7kQL5ctrbOz1AE33GVCC/fChAbPFI/5ecAUhXRVRV1+g
	akJs722ULOhvBfgMe2Kgrdhy6k8idRY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-l0XINPw5Ome1SK4mtHkcIQ-1; Thu, 17 Sep 2026 12:47:39 -0400
X-MC-Unique: l0XINPw5Ome1SK4mtHkcIQ-1
X-Mimecast-MFC-AGG-ID: l0XINPw5Ome1SK4mtHkcIQ_1789663658
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6a9b5240fb3so1397881a12.1
        for <linux-sh@vger.kernel.org>; Thu, 17 Sep 2026 09:47:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789663658; x=1790268458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ghsNMjszr/YVVrzwI9L3VChkEhVa9VAV3CWSeRoOujg=;
        b=e0sKiHm6vh7DzyY8Hhyli9P89Y/uTQ8mXH9gBVOEJQfDVjm8cNM1NiOSqrXjTpDrzr
         V36zxCdcwi0uQI6aFMYgJkpx2hupnoAmIaYDp5fG5VpjxrRbX5j2pfy4XsY00HeCZLnD
         8sMF9DYO+bl8H/ggsh4A3lvqS4NzKC0NI2tWTV7BbntS6RNICFzQnbLBjShtJzAuhS2h
         3I+yCTab2YZt5UqcmYPV4dw3Q45RGQn4VQeoq1x7+N3m/iH90KQNBZwr/jXu4g9S4DEI
         IrPuQTQmPpqSD115mTH/Mp/MYssjmyPhL0I3TXG06NFwwWgV/iDNDuNOsmd2RuBI7Hx8
         V56A==
X-Forwarded-Encrypted: i=1; AKwUvBzc53wVPX2dW4+pQurFVC95aAjGCUonWcpXuPmxBtrUHWpg+Z33fGCbn6tJk/cofPfipnwaTC1EqA==@vger.kernel.org
X-Gm-Message-State: AFuF++msVyeQXj/oC1reVUvi3CXcuDedaRrNZIrDsT3wCrNNmG0XUPpJ
	J0z3OAGNTeNR+RzatUZUeIks2oVUf+H1s2WXpqjXMsptZvpSytwx/aX2/UlgL0nYM+tAJqxT9OH
	xhooha6JT36bvMZfexkFPCdQxAKaG33unngSiDlFGOIqnJaESQuEHt92hduqsPwWGf1IQNNbBt2
	AwwA+qf0YXVssESnJzwOUOZ+7mQGInE1JpnwE=
X-Gm-Gg: AYBFou2d2Mejouo9Zr6g9X5kBWd9d7OaB3HYvtb3LNNPlTpz31pNzmRqRgiwFqkqK70
	ytVqAnwR8+mEIGMaEWjqsGQg84tw5t8MHw+GXLHyeYN3tN3pJ/I/ATd92Fc79cnZpPwvkUVGG28
	t2HLc2XxnigHiwi/Y3zq1mAvA/6Oon40L/a6BKxgtfZpE/PudUZdieZ7Z1PpXgWYn6DT6gbMTFR
	b04gOMblvLt98XcQk15DNW6PQsggNbOYHFUhQKbr0YFAqw3qn8jitbIG/op+V8I/b437mI752gt
	9m0=
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id a640c23a62f3a-c29e5244c19mr627701266b.10.1789663657717;
        Thu, 17 Sep 2026 09:47:37 -0700 (PDT)
X-Received: by 2002:a17:907:1c29:b0:c25:fdbc:52df with SMTP id
 a640c23a62f3a-c29e5244c19mr627698766b.10.1789663657315; Thu, 17 Sep 2026
 09:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
 <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
In-Reply-To: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Thu, 17 Sep 2026 13:47:26 -0300
X-Gm-Features: AcwNN1UQ-9H3EW5aAPKYI2mYiHxV9kMvBFdM8jP3WAhZbefwH7qcxYHE69PGYDs
Message-ID: <CAABTaaAUBzp1uaLve2piMhEB1R5po5n5+Sy+U0mbbe70Ak-SUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Magnus Lindholm <linmag7@gmail.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, paul@paul-moore.com, 
	eparis@redhat.com, sgrubb@redhat.com, oleg@redhat.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oTTw16rAL3WcTrh_SuAJZbGEOSOX-3vXSO0nkAXXIOM_1789663658
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 2:21=E2=80=AFPM Magnus Lindholm <linmag7@gmail.com> =
wrote:
>
> Hi Ricardo,
>
> On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
> >
> > audit_syscall_entry() now takes a pointer to pt_regs and extracts
> > the syscall arguments itself via syscall_get_arguments(). Drop the
> > individual argument registers from the call and pass regs instead.
> >
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  arch/alpha/kernel/ptrace.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> > index fc8f6cedbb28..8a39c0473297 100644
> > --- a/arch/alpha/kernel/ptrace.c
> > +++ b/arch/alpha/kernel/ptrace.c
> > @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
> >         }
> >
> >  #ifdef CONFIG_AUDITSYSCALL
> > -       audit_syscall_entry(syscall_get_nr(current, regs),
> > -               regs->r16, regs->r17, regs->r18, regs->r19);
> > +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
> >  #endif
> >         return syscall_get_nr(current, regs);
> >  }
> > --
> > 2.55.0
> >
> This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series
>
> https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail=
.com/T/#t
>
> That series moves alpha's syscall entry onto the generic entry
> framework and removes syscall_trace_enter() and its direct
> audit_syscall_entry() call entirely - verified with git am against
> GENERIC_ENTRY applied, it fails at exactly this hunk.
> You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
> lands, alpha's syscall entry goes through
> syscall_enter_from_user_mode_randomize_stack(), which already calls
> syscall_enter_audit() as part of the shared entry helpers
> (include/linux/entry-common.h). I applied patch 1/13 alone on top of
> GENERIC_ENTRY and confirmed alpha's entry path already routes through
> the updated __audit_syscall_entry() - no alpha-specific code needed.
> So for alpha, you can drop this patch in the next revision rather
> than rebase it.
>
> Regards
> Magnus
>

Hi Magnus,

Thanks for reviewing this patch! Ok, I'll drop this patch from the series.

Thanks!
-Ricardo

