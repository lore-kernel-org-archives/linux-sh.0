Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD5D39DBD4
	for <linux-sh@vger.kernel.org>; Fri,  4 Sep 2026 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542484; cv=pass; b=Bs8ep1fgRIoWqFdiQS2Xezs/J3I3VhU7rSMQSuH2xLIUVlrXAvLKT8H2ptRi//wr9pPQZCJRu8J4rJlz+tMMZDMfuG98oz/vlkBKiLoCKRdnx7T+1MNZ+FCwZsf3455SKrCh4pqa1/DxadVuG3ifWFfP4FRsKfVZzli1xeBtrTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542484; c=relaxed/simple;
	bh=AFNBiWCRpUcEoXNChHss1VconiHm4hB8qaeZxdrK+Dg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBnlLlVq5UIWW3TjjKYHW9Qv46moBCMxk+tsm5LpbI5Wl8pETh+BxMyBOdUJl+jR6jutsQ8p50Z4UAukXHyS9cy9A5V2zo46V1JtgFeXIiHAiBezVPvVVpg5t2jjRDARxiQzMhCQmDecBXh9oohg+13nJ0pjUeaz2FghHOwTB/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+5ZMHHh; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+5ZMHHh"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a5ebf75d62so1912105a12.1
        for <linux-sh@vger.kernel.org>; Fri, 04 Sep 2026 10:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788542480; cv=none;
        d=google.com; s=arc-20260327;
        b=bT2JMJ9MbET/XBAdAL/66mHHaIz1cdazIQlls8o6tmrs/JC+8afiBTqUFa1IwpPXgw
         vPeZhqYst7wrKMhsVe/Dc5sqcEi2pEamQwIEWFyObubQ4DCVaqQQMA62DDXgPnejwX6J
         0qV1PboQvVqo92N6vdapToaENDGZzsLUpuE0wrJEi1yVeIWpo2vAbiEoa66SnHxMGb3e
         PGeGupnBmsHLY7iLw2BlO2DWzDWNdnfgWNE2AKEG0mtbYP9/RF7V9RxMnkSpOMK1RlYh
         AYzPdhetyYzIt29nbhlbddjaP5ZGZl1xBTLd7ajaRErynjpVN7p1iuzSANxBAiV/CIqL
         3Tfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        fh=+AZjWGmqgE+wHeF5gZ17ttEvOW28psa9DuzA/5oite4=;
        b=LdRDAX392yTmtfsSWPJ/K303M1JXWmi5qQMvD4eTNe9zD+zZwLjLbZ854IisZcGjxT
         t9jezmnevd2/Vl8TH9bs8WdlRFUF6q+AX+wAMqNT3bCH9u9PfDHFZgu/QKHglYaiONLk
         s/C7IrmjBJ6BmzyzrJJrRMjag4ZsPM59MgSETrsb0kaHcmRlz/yLdfJqCg6hkgNydGlA
         w74ijmlzcdxe/lrgXkjMc1l7+I4cVkh4/2clOxbExAHDaSj6eyZDOeghRC/3am9Q47uV
         dSarH27NvBBXp4Fo7eR/NHYL5AejyrlvaNuf+w4XRvH6W0ED3/E5clBy+nS9FveejPkK
         zSJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788542480; x=1789147280; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        b=S+5ZMHHhfGjA+IdWmeugDDHgBwHG5bBYSPYfCEow+5chkn8MQle82UmWyVbxLiEN7d
         ijcv6053WNTu2RqyJ6VR+Q1MSk4Vxz4n7ZKFRrjYrPqEbaWeUeae4OgCiLykWRLNUDRA
         ZH/X93kZSKA1/wbKpcmxavHteq0Ow+JKUXYEkMsejbWI7AKmmLzp7rDEpD05dDMzdu05
         qx2RS3AgstzLvoN8v5AUqAPOvMKc+nz/J8n2Lte3Wf5wq5bPQVeGs2cRbGv15hnp0TgY
         EW5NlkkUE9iLPQcY1GiopKTuEm/IxQzvNCCThYHaycwvH5N4Y2kyLdCZ7Tyzs3tF5f6h
         EH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788542480; x=1789147280;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbP84TB5YSyUcPTlSRXVzwOJ5KiLCluO2L3qZFE4rqU=;
        b=f8uCIlVn9XpIkG2F5SuYtxyNobGhYZfr0Rqs49q5fXTT65TTHkII9h1yKASBnW5FvT
         fW3ir72BFLJLDvEYSgV+8oKTZDXTo3TaDZKW1bj5esiwPs0N9NNVQHfh9jS+EhMfjwB6
         mPE0qLTV9CSU4V9h65dZkBg1sMjKiH+KWkLL/x1lmovFwdKttx3wL1qatARWRzMi/peX
         IuzW6BsDcA7Z45o/Vk6iP40ai5hdJGuyhG02x9BELOVjKV8mUK49bjCjmAC+mKrmP4cO
         iSsOOBqQbBdA3Upqkqj6m9RhclxaIjgfMx5LJ3JBsBXUemo3wBtHch44CboR3KmqBjlD
         dXnQ==
X-Forwarded-Encrypted: i=1; AKwUvBxysPGDUECtADyM89amGAUnxhWng4Jmzw02c9iet66gTRL8H6E1INXBIOUUd97318gszECXaWMTzA==@vger.kernel.org
X-Gm-Message-State: AFuF++mVmYGNn552YN0zq8mNSWku1I2zizKGHTIszLYm/Dg+stSt9sx4
	AMLOgPIA0E8KVjaQr6zOpdYYu2+yXIBMRjGpd6WVHTZaExmK5eQkQQ08ABeEIK7SQdi3CdZzvX3
	Sb9D4/1GhG9FDOlst37ex0BErb41dW4E=
X-Gm-Gg: AYBFou0oE/16JHY5a/8bz4b4qASN3L7vPwM8IcMvvDQmdsVHCqlC8/a67nHqotyD7z9
	DPoG6KY72MH+BupCKjCJOJBLmTgVg/EWidQ15ZSD/GOVs/ANi1nbeB3WPA3PlFlX0aPatpe5Tyl
	PZyacH4OfDc/ZCJPkVPi7LHENZBOJO9Hda63nOOZQG3Cffy2uOIrhV985Tb+fz9EsMuVsaKC2GZ
	NFQpIvU04Ebf/UszmSb9qI4jxL+mzf36GaPJEdF0pmO3QkgmQ8GdORX6OAvlciOG3mhUheWvFyX
	QbwheBNs8X0j/xAG/qjztvr9wqIpKl22CNI/woZCHFLHiwdAV+pcNLxdGV3tcbJ8xPW+7NJbtef
	DLP2rLtZFReDgjEMfSHKviqZmd9pKZx0=
X-Received: by 2002:a05:6402:a252:20b0:6a6:9368:73a0 with SMTP id
 4fb4d7f45d1cf-6a696a73aa1mr4363499a12.6.1788542479338; Fri, 04 Sep 2026
 10:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788351089.git.rrobaina@redhat.com> <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
In-Reply-To: <4ada9fcbb93af8d5c1c9bfe2c83d94fc10bfe327.1788351089.git.rrobaina@redhat.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 4 Sep 2026 19:21:07 +0200
X-Gm-Features: AcwNN1WpEQ0Y6eKbtA6wNzDHeYOBs1Tconhq7C15XjRhFKDXvjk4jMYrR9OFExk
Message-ID: <CA+=Fv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4BLWOvDTt92t5Eg@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] alpha: pass pt_regs to audit_syscall_entry()
To: Ricardo Robaina <rrobaina@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ricardo,

On Wed, Sep 2, 2026 at 4:44=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
>
> audit_syscall_entry() now takes a pointer to pt_regs and extracts
> the syscall arguments itself via syscall_get_arguments(). Drop the
> individual argument registers from the call and pass regs instead.
>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  arch/alpha/kernel/ptrace.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
> index fc8f6cedbb28..8a39c0473297 100644
> --- a/arch/alpha/kernel/ptrace.c
> +++ b/arch/alpha/kernel/ptrace.c
> @@ -496,8 +496,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
>         }
>
>  #ifdef CONFIG_AUDITSYSCALL
> -       audit_syscall_entry(syscall_get_nr(current, regs),
> -               regs->r16, regs->r17, regs->r18, regs->r19);
> +       audit_syscall_entry(syscall_get_nr(current, regs), regs);
>  #endif
>         return syscall_get_nr(current, regs);
>  }
> --
> 2.55.0
>
This doesn't apply on top of my "alpha: enable GENERIC_ENTRY" series

https://lore.kernel.org/linux-alpha/20260902184058.198679-1-linmag7@gmail.c=
om/T/#t

That series moves alpha's syscall entry onto the generic entry
framework and removes syscall_trace_enter() and its direct
audit_syscall_entry() call entirely - verified with git am against
GENERIC_ENTRY applied, it fails at exactly this hunk.
You don't need a replacement alpha patch, though. Once GENERIC_ENTRY
lands, alpha's syscall entry goes through
syscall_enter_from_user_mode_randomize_stack(), which already calls
syscall_enter_audit() as part of the shared entry helpers
(include/linux/entry-common.h). I applied patch 1/13 alone on top of
GENERIC_ENTRY and confirmed alpha's entry path already routes through
the updated __audit_syscall_entry() - no alpha-specific code needed.
So for alpha, you can drop this patch in the next revision rather
than rebase it.

Regards
Magnus
