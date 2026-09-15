Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8550C43BDA0
	for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494731; cv=pass; b=miTq7j6gBs9mkfzN9/i8OuvmUPdl5JgNpDAWfmyOCo+Ufwa88aHhH4uaaWw9/pAMGKfGy+YwuE/vMyxC52cqraHl0o2dHAZiqq2/YBOz0o86/YLSen8MIWmOVabfBbAwDeZ0LeBCIcSNfzdSKWfpovgTCZnZiJhCJBxP1djHGKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494731; c=relaxed/simple;
	bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fQjsuqpLuh89DLGq0UIMVPqGWaFF7rDlCTyx+a0nDGp7IqOWW2qfh3YyQ83QxS3k9IvJ3cTdARVbHTU8OOdLNI5Ybjk0JFhGNkFzKC6DSd2iVE/X5F3WLjqsGHnjR4PplrrS6HCXX8jNj9nNST/1Wo426slVDHB+ySEqGQIQXZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPgx9Wh6; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPgx9Wh6"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so12055ad.0
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 10:52:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494727; cv=none;
        d=google.com; s=arc-20260327;
        b=sCgbtKOgwTAt0uFJK65C6RYpOPSYI9ZnJPKf/TVSZZwBCoGKS21mKcusvnrw0hYLQd
         BzdtJcdVg9t7Sey5CRXgzZKYT8EjfA0BUPASxzhHe/4GEOmtAVIgP0u6dbMOdMaszhcn
         Um+HLcovAfDcXL8NTn5DdU19ivD5qUSDKTr9TSwWblgKujcHbifKdGX3bFP7LCoxJBwo
         LZDC+4AYZCeL1aqvfSDuQ9OyvHQlck9Lw7vlDScck8pbzIQII7Nf61ZBUZ8FyRDh5Sf7
         jSA5Ajw3GQ6D45TUuo+wMkfo3zWCFJORuN34Q2CG9NuAgcypYEtM+tBUbOnJ9jAXLTeR
         Z0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        fh=/SdfaVrea+lFj9Ith2YwnrknE1Pop7J42z5O35U1PCY=;
        b=HK/eMlvUNkSdzR2PUJEnE2rZhPie+n8lwouyGwEZJvqym3Twvf5KsoFaLi8IaCw7BR
         12AnfBfOCKGN+lfEH9zkgq0UsCBXCiRT4aWFcmLAbaDV6dkRWI4pv4NlNjzr+O54j4OT
         U8IEeFxe24nPTlADKhzCEVX7x3ZSMXpF+l2Rr6ajHc6EcsdBOGpifp3dN9P8GzwANoK9
         WasR0JTkTxFuPbVaSEGr5OQKmtEhrITiq+wcXnF5kiQfTX1cZsebMwKY1FcciSiUVb9G
         2/hZ3w55bbq+8aVAaTpbtbZaW5Pz6THF3Rj8pIC6OVGUm35nxY7xsT283+ZBEnolxUhR
         Hbkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494727; x=1790099527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=WPgx9Wh6g8ehXMOaZf8ZSNtevHb9fzr3lXk5INKsJirqC99dpiARLSwTsIwHA4pbMW
         JbWx8MvBxDUFu6opqA60njTwuSet+XjH0Wga4OKXeEmVhOXoy61UWc3rqiL6EU8/l428
         EjMY1UqvowxmFEZiD+cpXVE0I3gM0Ssco82ZH8FSIs0h6jzSdSLoGG2b/9Ga+W+7Aup7
         R3Y2jKX2VRyqaVjVjF8po02JGQLWYioBTM31SQGX//CGOHsZjgwuKy0KaaC3tSzQflwo
         ISJi8sLOMT0xayOGlmIx3TnuUJAs8/tTEps0xY78QDJPw7a+XDrg4k1OSruo0M4Rr9uE
         eRpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494727; x=1790099527;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4G5uXJmB7HF3o1L37WqbjganRxVa3Gn0saA7lTxNiM=;
        b=CvHxtz9t6B3qoI58tFWlfhylVz2BsNNT48e3wUMMOnZtF/vqvXPkhlGyFQ3FSgqFj/
         c3ivSYl7arY0rf9K9HxOrCpV6dKbQWooSej0JlD48CvVXmCLJ1WWMez42+VZmFiRzgoZ
         vqKHm9YLrSn+N8Q0uNSBZ7F1Fnj3VpfnjjiqlEymvfwsHfJAfwAt0PMDModvVJbiSUhc
         7IAbIfJnxN0VZVHBi8fmw0H/fZ+2CgzTUvaryupp1lXI1eydMG/O0EliVyLqzlD878Fq
         TQFUKJgA3Z0FMBkG7YNJbq0AKe2O9YSn/AX0IxFdBo8HZaaVZJnnbvK20jVY94wr3HPg
         Bogw==
X-Forwarded-Encrypted: i=1; AKwUvBwYgc6Av/oG4eiZR1dvNeGWm7zKAUfYx7ioJBQjEqpVzGISuf9u+Qqny4M9eQdw870W4WhTRGrewQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l3PpAfWUlilmykCbSz12D0m5T+kjHcR0Hh0nk0D7NBxNHQrVjU
	AmKV46Ml66lHBvILVSBu7vyReNqSXPu12HMTUTdsMcLige1qboeE/g7DMofWyj+E484BFfLJ2ON
	/Fv6gwq8XTYRqr0UFiuzqf16tOX+z97YlU0SG1nLp
X-Gm-Gg: AYBFou1+63oczu8Rz9RgVHHXwC2mgVGa3Z0gaYWb7HC4O/O3ziKZQSLh3VP56ZnCezt
	inCM2cA0dTD1RU0r/tkmOJLd0a8HXSFdhbTfrvKAc6P5nmMQ+rT51LCMmRr1002IWtV790F4Pvu
	p5PKjTF0Bm1r6UQNSL4fJ3Lpoa/TvrhfiXHiR7hRxEbz0QSklrNwUPyx8Bhf3owh+dYQESats0t
	e0Ktq3ZF76Jz2EmgyAfRpzusUsO3tS+/nl47F4Gj3lkL2xXL+bAo5rROmpaIuNgFFiQXRbl7EiX
	9WB56QbtMZ0Igs610NEVGeQ+/Jf+DCJUxuIui+ewemVJ72k/ncIxYXMBhjrMjpcdtqvm/LxlmNj
	eDH3oLSIdMqZ8UCXVeBdLOC+c4R8YJ4PhrFm5STl6QUMcsQM0EPE=
X-Received: by 2002:a17:902:f612:b0:2dd:5363:31ec with SMTP id
 d9443c01a7336-2dd89c0c38amr177395ad.14.1789494726332; Tue, 15 Sep 2026
 10:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
In-Reply-To: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:51:27 +0200
X-Gm-Features: AcwNN1Vhgv53PI2-XyXtJBbVzCNkGiiWjtvOE2b-8zHim7-UybJ3H2xniPj1VUE
Message-ID: <CAG48ez1RsdT=O=-0city3vjgWhDvY424KtTmrCJntWy5ds3HBQ@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Oleg Nesterov <oleg@redhat.com>, linux-alpha@vger.kernel.org, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 1:31=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> TL;DR, this lets arch code handle fd install and cleanup. fd_prepare()
> allocates a descriptor like get_unused_fd_flags() does and records it in
> a slot on the task. fd_stage() attaches the file to that slot and
> returns the number.

I'm not really a fan but I feel like if you want to do this, you
should be using task_work so you don't have to touch the entry/exit
paths directly? (And if task_work is too inefficient somehow, you
could tinker with the task_work implementation.)

> When the syscall returns success the exit path installs every staged
> file. When it returns an error it drops the descriptors and the files.

Is this mainly about stuff like "we installed a file descriptor and
then the following put_user() failed"? Because if so, I think a nicer
fix would be to have a policy of "if userspace provides unwritable
memory to a syscall, just keep going and pretend the access worked",
and maybe have a sysctl that kills the process when this happens to
emphasize that userspace should not be doing this.
