Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C198527465C
	for <linux-sh@vger.kernel.org>; Sun, 14 Sep 2025 04:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757823574; cv=none; b=IYrsMTM+69tfmuyb6Fj+9jhI/SKu74yFNHdLcjY9wv+W+GoMip7su4sccN5416Rfj5BeVFJSHYlHOqpZaO3a+TlvSwwZmh5rq5m/bbp9cZYBODlGv79iEUtmivAlxSu9QsR/JyXVsM/qrFYN4ZxcSenat2SaFyNNMkSxNgRv98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757823574; c=relaxed/simple;
	bh=nKH8BykbZ/NG2ohjRy0QYNVXxhFKK6pBLbFy0ufJ1Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yye13rJ+Lauev+x0p2CagzGG4lN3SqdiW+rwATz1VIAVNoU7l87EmAGp/WOx4nIEh7LRGZWiJLnokAl2cTkaiv5EPMhzGUnIhVKC/l29ChItGAlDSgEr3m3M2UNOPZPiznbqwqQ4QcT3Jt3QQfjFaAiqcEBCDhKpcq8ddc0F998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJqW6gFT; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJqW6gFT"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso549147366b.2
        for <linux-sh@vger.kernel.org>; Sat, 13 Sep 2025 21:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757823569; x=1758428369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=OJqW6gFTmxCLo302hPNut8BO+ryXGy8PIMl/uEHO+E+z8i2EI7bfQdJIzRtBRfvXw+
         kcWbRtogH1JQpYSKNv6/zC4/cphZqfgFpRGzi+biQSqIyclF5+D85pOtnPCF+2OqkZz3
         CDy5gGsVM4vK7s4rQQw8rm4UeVohzh6niXAU3IEb2SuGNO2EeuKPfgMpVtnZIsHoZjbx
         vpDwdZIfOKoR5NhKuV5Cx0QkZBDdn8VSiqtXNhrSCK1lfZzEVpu8tq07tpGEuWiSX78h
         yx8FmO3uN2ENwCxH/6hjHHYqFM9jtWMEntVkZB7EYZ3E0XE1sdusU+KrGJTN7b5oFKbe
         8fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757823569; x=1758428369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LXtvCmrZRR9OgP0sG11mqG9m/nOQIjqm8VdJ9uLACjc=;
        b=Ys9SiDfHZ9054C8yJNy4S6V1yVjtUFeSELhXRm052pfIGw9Eya0rs1bz2MPBXDU5xe
         gZSLzBVcrUDF4/2bMN4kfugLU9SGsADymay9Ji4neydrqmrlkWyzNQ8qUMPK4HEqsWf+
         CuBFWljVkXUfBlNUfbZxpxUB6u5rjcvH8mFh+G93UZeklV9JhLhPvR2alZZF8vsQcz0X
         9I8kU7vMVxkciDmO5p2w832KEWbJY2BZdsR0NSlaRAxcbjAf3d3C1SrkL5cZPVSqyv4W
         jiBX82zb9ejSlBCIRBiyJYS+pftQmagTtn7CW6roFOcCPi+3/MeB5QJ5hsLqYOAwbeAy
         o1lA==
X-Forwarded-Encrypted: i=1; AJvYcCUz0ER3v707qNaS0dEgBvMEG1nHrM0o8KMcCJu+rOdwn4LEBJt5KXmhF6qYh4zZQ0K3uSETAH6U7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Z1yahdbVp7lcrvWvYIEy+4+V5yeu/UdEIvJ28CboJ5xPHKci
	wrwAW+Ymvuy3Opkez7625w7hClwpdtQFX9ZLvHLvU/s5fib+M2xV2sZ/
X-Gm-Gg: ASbGnctUGVvctT+hhYx3aFbaBFag7I/7np8V9UYlHCL6Q5XSYAC2xtNnsW+khMpConi
	M29XR4bmRMl4ePIVUrVtUKj4L70Jfb4xL1zAJKFvAtmNYgde/6iFMfjj/Y2MLAEKXhVZsJ5PEdD
	rDstMSFZOVgcT9Ut14jMYbxWXJQd3DmGsUkww/WMxD5AqX7uYJiyFmAaK23XDse6u+dxLNFsgA9
	v6S3I+Fl8bqRiGgVH631UVwj3w/9cwHmxm1iXRvn58+j9dO9ayXKYerUJY6TbCHErNdBT7shZdo
	YartLJgNswVrKqTdHM4F4tGeQqc+E7iicjvVB0NHk6gVtxW+vi8sPvl15+cuKRGq6Bob1JAApq/
	BdCENBOXE3QxyXcB4gTI9Epro501P9A==
X-Google-Smtp-Source: AGHT+IF6mujdx9qWAhF6oXDc9ZfcQYBKEdRbKR8jum+cm7upWvg9UYWarRjAWufJtq6SFHzRS8+jpA==
X-Received: by 2002:a17:907:9809:b0:b04:25e6:2ddc with SMTP id a640c23a62f3a-b07c353a723mr763099266b.8.1757823568595;
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07c28f190fsm504796666b.39.2025.09.13.21.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:19:28 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: safinaskar@gmail.com
Cc: akpm@linux-foundation.org,
	andy.shevchenko@gmail.com,
	axboe@kernel.dk,
	brauner@kernel.org,
	cyphar@cyphar.com,
	devicetree@vger.kernel.org,
	ecurtin@redhat.com,
	email2tema@gmail.com,
	graf@amazon.com,
	gregkh@linuxfoundation.org,
	hca@linux.ibm.com,
	hch@lst.de,
	hsiangkao@linux.alibaba.com,
	initramfs@vger.kernel.org,
	jack@suse.cz,
	julian.stecklina@cyberus-technology.de,
	kees@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	mcgrof@kernel.org,
	mingo@redhat.com,
	monstr@monstr.eu,
	mzxreary@0pointer.de,
	patches@lists.linux.dev,
	rob@landley.net,
	sparclinux@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	thorsten.blum@linux.dev,
	torvalds@linux-foundation.org,
	tytso@mit.edu,
	viro@zeniv.linux.org.uk,
	x86@kernel.org
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
Date: Sun, 14 Sep 2025 07:19:23 +0300
Message-ID: <20250914041923.4119219-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gmail banned me after first bunch of letters.
Just now I sent remaining letters.
So now the patchset is ready for review

-- 
Askar Safin
