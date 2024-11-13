Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548A1AD24
	for <linux-sh@vger.kernel.org>; Wed, 13 Nov 2024 01:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459859; cv=none; b=DxNBoMGI7Y+tfA5q1boTIdVOg2yUg+BNK09OX1ESIwrDQ6SfDou8uXq/wRh5eEUHaSM8AC1tFsZm1rtJCFykpDi4bEpBwQ+Kh3qDZ3Gkrtyb/A2ar58bMPVf+HgGKuZRjOhSpLiy1bS+Dv6a+JCYc/nXrQPDozDa1nGs3N0NEp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459859; c=relaxed/simple;
	bh=vR/6viA1402z4QjFv93lWG4YGFKZYWT8l5MX9Rc2Twg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gBLL7qSEmxkLbmQ4663cyV6jRyUYyM7Z3JA9vBZ5pLo8Bc5G+3cVun/x01zjxQzEnMiQyyGtJ/sBJ4fu0Se81Qe17mRlr6pGulpm9/swyVbQ8mYri4yA22rYfZeVkdamPHHb0J0LaS1nCyiqVLRS6/2irxR9Pqos1Zmj6Smnpio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W/3QJif3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/3QJif3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731459856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71kRV9QsWZSXh3DeItT/ZQQntIgYvFwGt1Icivu2FQU=;
	b=W/3QJif3EzC+DqiNuiM1JinKwu0JDI1aqlA7EFdt9r2cZdW2hzrTc80fprK2Abefdv4Ojn
	YCjGXef8m28K2Ij3/xln1C7t4R6/eK7f1jG0zsaZYFNnUz8UtrVUyvZ04wHQJUvfVYmTos
	4I73a7Czz4KZR1wAAYLQHEav1a7uozw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-302-11EtgfivOCK3-BmbgwnKPQ-1; Tue,
 12 Nov 2024 20:04:12 -0500
X-MC-Unique: 11EtgfivOCK3-BmbgwnKPQ-1
X-Mimecast-MFC-AGG-ID: 11EtgfivOCK3-BmbgwnKPQ
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2220919541A1;
	Wed, 13 Nov 2024 01:04:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.83])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 61B4830000DF;
	Wed, 13 Nov 2024 01:04:07 +0000 (UTC)
Date: Wed, 13 Nov 2024 09:04:03 +0800
From: Baoquan He <bhe@redhat.com>
To: akpm@linux-foundation.org, Dave Vasilevsky <dave@vasilevsky.ca>
Cc: glaubitz@physik.fu-berlin.de, linuxppc-dev@lists.ozlabs.org,
	linux-sh@vger.kernel.org, mpe@ellerman.id.au,
	kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	ebiederm@xmission.com,
	Reimar =?iso-8859-1?Q?D=F6ffinger?= <Reimar.Doeffinger@gmx.de>
Subject: Re: [PATCH v2] crash, powerpc: Default to CRASH_DUMP=n on
 PPC_BOOK3S_32
Message-ID: <ZzP7AzziB8a2jJGP@MiWiFi-R3L-srv>
References: <20240917163720.1644584-1-dave@vasilevsky.ca>
 <ZuvnhSvVMIGgAVNj@fedora>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuvnhSvVMIGgAVNj@fedora>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Andrew,

On 09/19/24 at 10:57am, Baoquan He wrote:
> On 09/17/24 at 12:37pm, Dave Vasilevsky wrote:
> > Fixes boot failures on 6.9 on PPC_BOOK3S_32 machines using
> > Open Firmware. On these machines, the kernel refuses to boot
> > from non-zero PHYSICAL_START, which occurs when CRASH_DUMP is on.
> > 
> > Since most PPC_BOOK3S_32 machines boot via Open Firmware, it should
> > default to off for them. Users booting via some other mechanism
> > can still turn it on explicitly.
> > 
> > Does not change the default on any other architectures for the
> > time being.
> > 
> > Signed-off-by: Dave Vasilevsky <dave@vasilevsky.ca>
> > Reported-by: Reimar Döffinger <Reimar.Doeffinger@gmx.de>
> > Closes: https://lists.debian.org/debian-powerpc/2024/07/msg00001.html
> > Fixes: 75bc255a7444 ("crash: clean up kdump related config items")
> > ---
> >  arch/arm/Kconfig       | 3 +++
> >  arch/arm64/Kconfig     | 3 +++
> >  arch/loongarch/Kconfig | 3 +++
> >  arch/mips/Kconfig      | 3 +++
> >  arch/powerpc/Kconfig   | 4 ++++
> >  arch/riscv/Kconfig     | 3 +++
> >  arch/s390/Kconfig      | 3 +++
> >  arch/sh/Kconfig        | 3 +++
> >  arch/x86/Kconfig       | 3 +++
> >  kernel/Kconfig.kexec   | 2 +-
> >  10 files changed, 29 insertions(+), 1 deletion(-)
> 
> Thanks for the effort.
> 
> Acked-by: Baoquan He <bhe@redhat.com>

Could you help pick this one?

Thanks
Baoquan

