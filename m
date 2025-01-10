Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DD20B817
	for <linux-sh@vger.kernel.org>; Fri, 10 Jan 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736502298; cv=none; b=IxvmP2qNhW109/2YwkajawcwvXhTkV4bJdt3WzMz5OWw8Sf6FFMTAkLOHcgB527pVLFZS2vN0pNXzkW5r3j8fRRMygDKsLrcI+4Akgu6tcCcL0UACxcsSE8Od9WXSopvzuGRo1jIyjk1Mkjn0r1UZMOwh5lPWKvxkVTGqa4J7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736502298; c=relaxed/simple;
	bh=ENLLV/0PrVWHZJnSd10hwquS1U8BMVZB3K1bFjotxyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dbc3K9x17QOYIboQeH2MJamKyC/iFdujtqw5AptREU+nDR+Q/9oEoRSCoiMXrmDD8Lb5qG20vHW6tfbc2j52yBJKiMc7T36FhZgy6VS+sM90hf1SbY3h9iLQXe15FVRuN8e2jNapQTZjgQSQN+9hK2BLikXZdhUB0lYHjhK304w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UIFsE3fM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UIFsE3fM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736502295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
	b=UIFsE3fM8ZpT28RgTD/VWrQgEAnTkGjPT7UbRMlcM0A3WZUp3DhNJ0v0QFBh450AL2dUF2
	1rk+agWGcGiZ9i74yLeJbYlEoWeR6NzBDaiJjp4lAMBOkt46WyA1BMrDxOCmGN/VpP3McP
	TQbg59XT+08yYB3kLiyn5GjAlHUungM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-YYE_X5DwMLyLJU-BWmzRog-1; Fri, 10 Jan 2025 04:44:54 -0500
X-MC-Unique: YYE_X5DwMLyLJU-BWmzRog-1
X-Mimecast-MFC-AGG-ID: YYE_X5DwMLyLJU-BWmzRog
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e03f54d0so781389f8f.3
        for <linux-sh@vger.kernel.org>; Fri, 10 Jan 2025 01:44:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736502293; x=1737107093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A4Kw1qoNYerqhNjh25Dgp7jdmE++mW9Fl3ZiJ8T3co8=;
        b=JG1dzbyfIHX7hboMhCqanTqLpC75GdOmh4uYDUWDa2WJ3LuP5RivtSb8jp58vnrr6C
         z9lB8WAeZY+VAfFDW/t07XFTxR80XHIh//2bTu5RRVkvmOoe5GjTJRBPncY5OJ2KIae9
         E+tZgImeGcuBqEqsoHbZEs5T9ja9nHOb8q3fbGEtersMFX4Au6CTJ4kSovhGaDl/2r23
         h1jkYwerpN7J52T4l7hKxS4Cyd065jIvL1Ax9f6LCG06UUJ/FqDbZXaK4Q9wzeNduuBK
         QI5ZK77PuPBswE4nIzLbG1mxjn2j4fujJY/AiCJ5lUkMtXZxLHVLu1EXOF7Gar/PvBD4
         tCQg==
X-Forwarded-Encrypted: i=1; AJvYcCWtNOaQsHN7Ry1tS9XoR8hCQqshVO7ZD+l9XnphD170EkG9QLcE2nB7beSvMkAl39u5hxz4A8kwrw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlXxF7yjk/Dytp/grOHDUGLOsmr/z9mPBf8S1PlscitIi1T8p
	2QSR+4mcX64LhshdD5gjFiXl9ejLPtwv/NEWgu+TnC3QIBB9GxDMgk/R/+I62H6rTxw6J8S0czj
	CeNyz0Yv+ioXESLaPre93PJFQSCYjrGehH1gC+biMSpaDRfLkdDTYonc=
X-Gm-Gg: ASbGnctYE9yz2fS84AogdTrlFknKRYw4EhuQxma0OJnFmJrYNLdys5mOmE0WiyU1AJC
	cx2qoOEoquE0e8xLcIJFAF+8BEuKjvWTbh0qAVumsVlKdNrCvm4BUM9Nuz1fTWV6222LyhTYC7w
	VFcl99lmUYPj1jcbi7YHOeE/RkIhqOIGy8Svmcy1UjqHh0Kd2jpPiXsqLZpMFq6zKHOyMKbNw1a
	Tg8EA+Lk7keH3keAWc3bk3sXSuIgHcoSC98DGJ11HX4zw9gdSfsAzHijanWYS3nVFQBeq8H77Rz
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910103f8f.45.1736502293464;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWMxVaNXeUTe+wjdV2pCbQXCctILb5vVg9f3+psJOjGS23Sr767uuQBsbyCemBlGukLyZjgw==
X-Received: by 2002:a05:6000:709:b0:386:3803:bbd5 with SMTP id ffacd0b85a97d-38a8733a1f9mr9910059f8f.45.1736502293124;
        Fri, 10 Jan 2025 01:44:53 -0800 (PST)
Received: from thinky (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e383965sm4140444f8f.31.2025.01.10.01.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:44:52 -0800 (PST)
Date: Fri, 10 Jan 2025 10:44:51 +0100
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Michal Simek <monstr@monstr.eu>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	chris@zankel.net, Max Filippov <jcmvbkbc@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] fs: introduce getfsxattrat and setfsxattrat syscalls
Message-ID: <4ad35w4mrxb4likkqijkivrkom5rpfdja6klb5uoufdjdyjioq@ksxubq4xb7ei>
References: <20250109174540.893098-1-aalbersh@kernel.org>
 <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <e7deabf6-8bba-45d7-a0f4-395bc8e5aabe@app.fastmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l1JsHs6BRV-Pa2MxrpTfI44HDFgOBUDX7fgvFgAjL9o_1736502293
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 2025-01-09 20:59:45, Arnd Bergmann wrote:
> On Thu, Jan 9, 2025, at 18:45, Andrey Albershteyn wrote:
> >
> >  arch/alpha/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/m68k/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/microblaze/kernel/syscalls/syscall.tbl |   2 +
> >  arch/parisc/kernel/syscalls/syscall.tbl     |   2 +
> >  arch/powerpc/kernel/syscalls/syscall.tbl    |   2 +
> >  arch/s390/kernel/syscalls/syscall.tbl       |   2 +
> >  arch/sh/kernel/syscalls/syscall.tbl         |   2 +
> >  arch/sparc/kernel/syscalls/syscall.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_32.tbl      |   2 +
> >  arch/x86/entry/syscalls/syscall_64.tbl      |   2 +
> >  arch/xtensa/kernel/syscalls/syscall.tbl     |   2 +
> 
> You seem to be missing a couple of files here: 
> 
> arch/arm/tools/syscall.tbl
> arch/arm64/tools/syscall_32.tbl
> arch/mips/kernel/syscalls/syscall_n32.tbl
> arch/mips/kernel/syscalls/syscall_n64.tbl
> arch/mips/kernel/syscalls/syscall_o32.tbl
> 
>        Arnd
> 

Thanks! Added

-- 
- Andrey

