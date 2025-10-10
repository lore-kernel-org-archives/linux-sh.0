Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A323E229
	for <linux-sh@vger.kernel.org>; Fri, 10 Oct 2025 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760072280; cv=none; b=o5kVXhfl6vm1TudHBmGT5EL8FynYSFwj9GHMTXuArzqtEKsduAVw84UO47kJG4ozqDlSoW1A0evlOWh/5hfXKqTjQdTC6mGbLNbXVu7mDVTo0+OSJi1luGX/yQnjE8ffX3Z0C833PWw3tc5D48XxKajmPWrEPM/PDMW+VOreOno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760072280; c=relaxed/simple;
	bh=20zVq/I1A85ImSdUuzZ7bh9Qs7dqD4eEIEsQzzw5Ci4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dASfD4snY/FZma+cle4eYTnasQZQx1BL3mbV+4LAmmXdte4r1t9QBBVjTWx0JxwfMBEpFq1Bd+8jquHLO0wy4XezLZCcLLMmkc4j9Y8DtT3785VmPBnXp9rktLD5GZRKm0FJL0O99X0zLQsuqUqAXDigZCPtyOxWRr3mEKo93FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrdiTzbT; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrdiTzbT"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63b960a0a2bso2025007d50.1
        for <linux-sh@vger.kernel.org>; Thu, 09 Oct 2025 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760072278; x=1760677078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=GrdiTzbTpmXrgj0/PjkohCZ6LgFNbxV45gb5L/ZVbzaWKAHJgA12/mfFqFdtOpY72m
         bZZCyt4k8jRvQo4unsWw4ZeaFcU/eOYR2U/wcLgsvZR/RYdUoV9fmyuViF8Of5PYj/l4
         634Gm0JHXypxB9ycdlhLckuOP80mjqw4wIO9HLiTQ6purdE8gu3SXgXaNMsYndjRbf75
         1dPvVv1bpLUsn7UsoLTsiGPIZ2KQmnwtMFB4nrm8RHlzLeSFwrO7OIHtu7G4t0f6Q3Az
         maevl8wn3jZRwLsUqzTevJOM0Q45hnxhlAkendZd7mXKlZsyaRmG6ugJRYjmZ1sxfyiy
         qCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760072278; x=1760677078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7qS0AM3lX7OGhXSFEYS6mkC3EKNzPxshbg7hLZcah0=;
        b=dXZQExnve+v7G3gZoi+Wolvr8K/b8BGUcm1zDCPTDztTIrUnCtBteRoZan7fkidYlF
         ztD5ZNMK5tuh4lvJQZ5+lIS+vSEb26Yb2JIFEYSSdvgpRp0WXsebfZEknuEtgST37q8E
         1rD9WPzBvA7GTQoRsjTBTV/wLc8AD5IV79u9ifj1GOuk1QY7FfUr64WlYv0di8ghofy/
         8p4rjSdWWBxJF71lhPPOiMCekaI4xh/91eUZhpvGuRN6ipj0OCUUpS2UvGfN7LwhDVeK
         ZpZ+P595JYwovq0IgekHp3duQksNJY/JTfMtVLCcywbKLTKtmCe/90LSea67vS6IzZjb
         OFEg==
X-Forwarded-Encrypted: i=1; AJvYcCV8QfvY1sL5JZV9CeNpqiOqGHNoDBCOWA1QrZEdJ2awnFBTp8S3x5OYgij6mMoA3dZrEXuah/sljg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpYj0R3SZfj18hygC2Df5dbbhrlVra8g9lvD88ZW6NspnBUEqy
	oCswSIHp7rGPKYJdnzr2APLfGlZfNHu9ErLX3NLqZ+kRR9TGI2EIPocMyoGhEY803x3Vs43NPd0
	SlJc8eX7D5mcqj78Q5KYsfYVjlGsklPU=
X-Gm-Gg: ASbGncuJWXnsVTHCm3i8Rg1gJK79Xmsbbf9vS5bT5WZ390Toz5GVS6xCwdGyLlVQrHo
	pKAB+xR64lYfdOkMeI+cO+cQqXy44rSGZiBr9w+A7cYceB+pQXHfka6PauByHGTef2PDrJ+OUfe
	KFCVniP/q4vUJ7jQDRSwRplJtknwi7ogcTAgbwYGPNWr9k0VfAN1BK5jVA3K9gL07e5R5nWzR3H
	DOn2wFOTT43VoDMRogUJ+hcGA==
X-Google-Smtp-Source: AGHT+IHqDciv7GAPYfMGdKr9Fwuo5GT168N8GcrpsJ5KozP5HqYqg/LDALxuogvzJXgNCm6zrA+DoCqu7lr8uhQrVc0=
X-Received: by 2002:a53:5009:0:b0:636:2420:d3ce with SMTP id
 956f58d0204a3-63ccb93456dmr7466309d50.51.1760072277565; Thu, 09 Oct 2025
 21:57:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHNNwZC7gC7zaZGiSBhobSAb4m2O1BuoZ4r=SQBF-tCQyuAPvw@mail.gmail.com>
 <20250925131055.3933381-1-nschichan@freebox.fr>
In-Reply-To: <20250925131055.3933381-1-nschichan@freebox.fr>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:57:21 +0300
X-Gm-Features: AS18NWAQwCKadWHXCZjVUBNaD3TaKIilJiJAQzSbvGFaYuFuE8UDpW1_H3riB-k
Message-ID: <CAPnZJGBPyONjJoM6cskxysDnN4pxWuWJCK5A6TgikR2xHsrN5Q@mail.gmail.com>
Subject: Re: [PATCH-RFC] init: simplify initrd code (was Re: [PATCH RESEND
 00/62] initrd: remove classic initrd support).
To: nschichan@freebox.fr
Cc: akpm@linux-foundation.org, andy.shevchenko@gmail.com, axboe@kernel.dk, 
	brauner@kernel.org, cyphar@cyphar.com, devicetree@vger.kernel.org, 
	ecurtin@redhat.com, email2tema@gmail.com, graf@amazon.com, 
	gregkh@linuxfoundation.org, hca@linux.ibm.com, hch@lst.de, 
	hsiangkao@linux.alibaba.com, initramfs@vger.kernel.org, jack@suse.cz, 
	julian.stecklina@cyberus-technology.de, kees@kernel.org, 
	linux-acpi@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, mcgrof@kernel.org, 
	mingo@redhat.com, monstr@monstr.eu, mzxreary@0pointer.de, 
	patches@lists.linux.dev, rob@landley.net, sparclinux@vger.kernel.org, 
	thomas.weissschuh@linutronix.de, thorsten.blum@linux.dev, 
	torvalds@linux-foundation.org, tytso@mit.edu, viro@zeniv.linux.org.uk, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 4:12=E2=80=AFPM <nschichan@freebox.fr> wrote:
> - drop prompt_ramdisk and ramdisk_start kernel parameters
> - drop compression support
> - drop image autodetection, the whole /initrd.image content is now
>   copied into /dev/ram0
> - remove rd_load_disk() which doesn't seem to be used anywhere.

I welcome any initrd simplification!

> Hopefully my email config is now better and reaches gmail users
> correctly.

Yes, I got this email.

--
Askar Safin
