Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F336F4749DA
	for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789513362; cv=none; b=XLJR5bSSvh/QsGfkyNREUJCvswR7thNJ92PpLnE5xngTu9GFmnuF3K8sEhscSxnyItqRU+Xp7iBWLLNtGlgN6Y2R3qqN0KtOJ3J3IHUU2CB6BwnciB7JMroV67CZiVzCJoBADJeu/kA5UB4JpLxYIOn2dGVBHiCOciwLz7++kH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789513362; c=relaxed/simple;
	bh=ITz7hBythv5OWTbmQ9c4e1mzRPysX2+YTMbCrseTj6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggRGnhQ+gFQZwqQIbNxAxibR9Xii88b6mGWkK/pGuHGvFEybJ6/XhxOz45+kNp0iiFjYn2tfvcJUXlU98QKcQQgNJyFL5kLaP3ZoNPuOKSClQVk0g5D9plGSdOJhUUrLy0rC/D++pSqzKNcDdXu03NrooaZukSDvi2HRQ/iVdfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QDhDLxGp; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QDhDLxGp"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17450so282102e87.0
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 16:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1789513359; x=1790118159; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=QDhDLxGpXZg/OalxmhOxVAkdYAi224ppv8KznHDt+HyTPmcsqnv5zISRHYoDLYuQtt
         Qic1uhTAOMvAjA848GsokvMUAVqYwN0gvRzO67tlubDBgnllvTv4JGpeSDpoJE9b2L71
         oRWlpDw+tMg2f18V/7X1xH2GL6jfM2YmDnpyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789513359; x=1790118159;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7NEEN5klK6sYQ7k8fj+V0z2WeSFVNwjy5fJJIdfiMPQ=;
        b=pzGhT6lFHsKBdMNlC2dNFJtdbxHaSt5+fpGMdzexNh0d2xoJ8ZXDqiZX0gIloEha5p
         j6MwBAiPFWPB7CPJtBzB2oaYf9aT34nTgZdh4o94i9qv3Ly3gNhE1HXyM4Sk7eut7P8B
         CUMBzdjokWrLC4tDPs9thvBu0e3agHG49VuaBqWI8rhlL7crvM93mmKrnXTVLTu9qSad
         j5ZD321beEEgdxy4qBTo706COsibPPgsk+KtUU/kTNIpVTn1EZIdm/WOKLgDUJf74S/b
         vNPjaodI2Joh1EvEzzHIawPC5V/07qvTgSPCmds2vgf9Grf3Xa2XO91XunRGGCx3/qRq
         aAIg==
X-Forwarded-Encrypted: i=1; AKwUvByGTn5YYiYoNApC6iPXFoQuNE7Fwz0l4L20hg47FfsxQG/hr+oc0sLoLYnWpia0Hb9kao1smBq1tw==@vger.kernel.org
X-Gm-Message-State: AFuF++nXZol0S9vrvKAxuOgna7pBmXlPm6leXzazsL+zn0vuhSbTE3At
	E3eYE55G9ctqazQgjFlt/63JLU8VwdFcz+nqDD5crVVAdILC2JKy7+v44LTnUWAfVUZHuDguacs
	cAvZ+cf1m/A==
X-Gm-Gg: AYBFou2C1MG7LHFaL6nMGaKq2BIYXGoRuvz/CzzH0j0QG0wrbLTXC7EKXW1b2tMN5p+
	24poEaSL3iVsto00TAnoh5iVuEqPFV0bYBo7JatqaNTynXkJb/L5WCdslw06OsiSqmmQ8ZJ10J4
	InXfl3m1S8aZpwGMwP8jQ4ws6R8TMm7T1Kg+I++5NcBoGRG9feFndOX4dt53JKsfbQTeMsrrv/Z
	467LO3h5ABFZO8S47SXbnjeBCcQqlWLKJyeYVK2xopEHwaRvIr5i6icDzDay/iRlXT2EZfZ306H
	tXmQsxGTpNzeBngXVc8Rn558Uxgp0CnFkl1QkOcjC0NPbyO4UbLcI7zN1s7GYrs/yu29udZGmyw
	y3/cRoqNU7fuKLfvmqi1nDQnJ15Fy4qK00iibcvEyjMT8bctkHv3SKqds8y3IlhLHl50EZl7JD6
	9yBg4t+GsHejp0lxs2L8YD7OvqzpLm1Y8oNBjBe+ptxh6yFMM/k4+ufMvVjh8W98v+/JtLQLSZw
	mU9P1+kFKM5EvhWm46uCRDMnYtEgm0c+x8llZLH0p+SjODwzw==
X-Received: by 2002:a05:6512:1319:b0:5b8:9fa1:9c3b with SMTP id 2adb3069b0e04-5b8b6643f92mr39484e87.32.1789513358808;
        Tue, 15 Sep 2026 16:02:38 -0700 (PDT)
Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com. [74.125.229.204])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8b57e7e57sm291759e87.77.2026.09.15.16.02.38
        for <linux-sh@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 16:02:38 -0700 (PDT)
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f17450so282096e87.0
        for <linux-sh@vger.kernel.org>; Tue, 15 Sep 2026 16:02:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwYrOmjLcuVcAUWmWks4CIm8k8+AJeJffObAEpJTkWWFt6gSd4YBx7fSGZBEi9lDvIHKwxT9OOAUw==@vger.kernel.org
X-Received: by 2002:a05:6402:5d1:b0:6a9:a6c0:e5ef with SMTP id
 4fb4d7f45d1cf-6aa2244ef06mr218172a12.37.1789512913950; Tue, 15 Sep 2026
 15:55:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915-work-fd-reserve-unify-folded-v1-0-4d5217d6b246@kernel.org>
 <CAHk-=wjeamU=_RYT9cR3dZJ2N-Teo-N1+aYh7jwhrB=iWXD0cg@mail.gmail.com> <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
In-Reply-To: <CACSVV028AdnTYa6OKDeoJYCau58uTkKMgEdqTn7crNSV8QZxOA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 15 Sep 2026 15:54:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
X-Gm-Features: AcwNN1Wx2MaYDtFtmeOlL6MnzYY7doY_FEPpziKatTBWbLOeKsjmritQ5JuAL3M
Message-ID: <CAHk-=wjhJF91TCO0Zqeuf+caG2tQZ4AzbLr2qFmRmnMM4dbh4g@mail.gmail.com>
Subject: Re: [PATCH RFC POC 00/50] file: handle files on syscall exit
To: rob.clark@oss.qualcomm.com
Cc: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, linux-fsdevel@vger.kernel.org, 
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

On Tue, 15 Sept 2026 at 15:21, Rob Clark <rob.clark@oss.qualcomm.com> wrote:
>
> With fd's it is more than just about error rollback.. exposing an fd
> to userspace mid-way thru an ioctl is an easy security bug to write..

That isn't very common code. It's something that is done by a few
strange cases, and yes, those cases should just do it right.

But "those few cases should do it right" does not mean "make a whole
new subsystem for this thing that makes a simple "open" actually be
slower and stranger".

             Linus
