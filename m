Received: from brightrain.aerifal.cx (brightrain.aerifal.cx [104.156.224.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986F12EEE7B
	for <linux-sh@vger.kernel.org>; Fri, 21 Aug 2026 12:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.156.224.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315213; cv=none; b=o6U+cC0WD2+wTAGtdkHyJxDRsUKGL2wCyW3scuqTlJnNx2aG88hu4Zfc280P8IS9tzZ1kJMlUPi3cD3ca9QzovB5fzIIiM0Se1zj9Qu3DT8uJjK8AXRUQ0Jwpapx/75UhvzF8c14AsvIvnLB61wg3AF7wCUPfO33rSuJFnnY5Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315213; c=relaxed/simple;
	bh=Utzxh2pWuqvqvFDcklksUNutlFJ2fclQJ0/1Zb08fcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1wDZJWh+RTI5WxzTbPSvy12KML+zk9Z6eUpMulAvmYtf57A+Ax599c5hnbwe3zV+I81GVnwbk+l9PRZSESrwNtFfPY48CiRK9SbpF8qQYIcQu4MXmSphztB4LCJOqjg0mJpQ1hLlIJc/VlSuLZC6CRb5XaHek5bpp6PIb8GFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=libc.org; spf=pass smtp.mailfrom=aerifal.cx; arc=none smtp.client-ip=104.156.224.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=libc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aerifal.cx
Date: Fri, 21 Aug 2026 08:11:19 -0400
From: Rich Felker <dalias@libc.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Oleg Nesterov <oleg@redhat.com>, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: prevent ptrace from changing privileged SR bits
Message-ID: <20260821121119.GO25906@brightrain.aerifal.cx>
References: <20260821103335.3627506-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821103335.3627506-2-Jeremy.Jean@oss.cyber.gouv.fr>
User-Agent: Mutt/1.9.5 (2018-04-13)

On Fri, Aug 21, 2026 at 10:33:36AM +0000, Jérémy Jean wrote:
> PTRACE_POKEUSR writes every word in struct pt_regs, including SR, without
> filtering privileged bits. The general register regset setter exposes the
> same write through PTRACE_SETREGS and PTRACE_SETREGSET.
> 
> The exception return path restores the saved SR with rte after adjusting
> only the interrupt mask. An unprivileged same-UID tracer can set SR.MD and
> make its tracee resume at a user address in privileged mode.
> 
> Preserve the saved non-user SR bits in both write paths and accept only
> the bits in SR_USER_MASK. Recompose SR after user_regset_copyin() even on
> error because the copy may have updated a prefix of the register set.
> 
> Assisted-by: Codex:gpt-5

I'm only nominally a maintainer for the arch anymore, but about this:
could we please not?

> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  arch/sh/kernel/ptrace_32.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
> index 8794081483fb..bb69c35cb9a7 100644
> --- a/arch/sh/kernel/ptrace_32.c
> +++ b/arch/sh/kernel/ptrace_32.c
> @@ -146,6 +146,7 @@ static int genregs_set(struct task_struct *target,
>  		       const void *kbuf, const void __user *ubuf)
>  {
>  	struct pt_regs *regs = task_pt_regs(target);
> +	unsigned long sr = regs->sr & ~SR_USER_MASK;
>  	int ret;
>  
>  	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
> @@ -159,6 +160,7 @@ static int genregs_set(struct task_struct *target,
>  	if (!ret)
>  		user_regset_copyin_ignore(&pos, &count, &kbuf, &ubuf,
>  					  sizeof(struct pt_regs), -1);
> +	regs->sr = (regs->sr & SR_USER_MASK) | sr;
>  
>  	return ret;
>  }
> @@ -391,6 +393,11 @@ long arch_ptrace(struct task_struct *child, long request,
>  		    addr > sizeof(struct user) - 3)
>  			break;
>  
> +		if (addr == offsetof(struct pt_regs, sr)) {
> +			unsigned long sr = get_stack_long(child, addr);
> +
> +			data = (data & SR_USER_MASK) | (sr & ~SR_USER_MASK);
> +		}
>  		if (addr < sizeof(struct pt_regs))
>  			ret = put_stack_long(child, addr, data);
>  		else if (addr >= offsetof(struct user, fpu) &&
> -- 
> 2.47.3

While I'm not against having ptrace enforce this too, I think for
safety the return path from kernelspace to userspace should also
enforce it. Blindly restoring privileged mode bits from the task
context structure when returning to userspace is just *asking for*
this exact same vuln to arise again and again via other vectors.

It should be possible to enforce this in the same place the interrupt
mask is adjusted on return to user.

Rich
