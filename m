Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4DA619F116
	for <linux-sh@vger.kernel.org>; Wed, 29 Jan 2025 22:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738190799; cv=none; b=q3WcjBXnGumMYyRZwQ7brzu6WJVjauhkA45hKX3ynmbbMjHNppikRJ08PGdqDIdPSEmlE6pnIk9f0fheyzWsIwvYE5HK0PRpUxCYs6s1OtwWvG4f5eWDqdCJb5zP9z9lw9qAPWDujP6dRLVRE3pVY37icP4Y9QjlxtO3nwfutVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738190799; c=relaxed/simple;
	bh=9NEZbUKkxC9WZkbiAIu1fWTLB4qRr2YDtbirpcADGLM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AAR3GqgmAKQE/l/TnEOX+3oC+qhD/9c1i2wzWT3HjvpQ2NZyIGrZhEgTGZD+pXrvKgdwamZaVpa/w0Bmy5qhfKy6KGtk2HvDq6HaJC/YAIlYO6QSuJxOjxKDKjTddRQaEzD5OVQg14fo3lY3+dlJ+e+5qCoTlqB9wnzjriIJCkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME2wCF+g; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME2wCF+g"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43624b2d453so1067215e9.2
        for <linux-sh@vger.kernel.org>; Wed, 29 Jan 2025 14:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738190796; x=1738795596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bq5HSBH3IUQQ6t95U9MV+TMJF2wzLuKzSVhBRPVa0Vk=;
        b=ME2wCF+gDd8LdIynat9S3bda9P17TUQ0vziPxvygRTRyLEOFte5uwaZTJZ/5SBp9Su
         mjn/LL1433C6Ov0EhZCf1uVHMQmdLcX+AO958YqR4mszBpNgndg0r7wribXmqDmlCDZQ
         G8XdKSlYp4bY6h6fK67wnuIvhpiDkQynAmmwdi9czkAYh9IfNb2RkHDvoXi/00/HguqK
         2evKAFYsiSOyUzT4nCMOPog+2kt2tCpMPlpwnAG5X9YnLXGIrc32nBHBBXJt8022uOVv
         6maCYs2UTSlYyZGX/heMAtNIRfmQXx+/LiDYZkgCR8HpkGICu8sbtmyS5Am1JT0eTMTm
         oY1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738190796; x=1738795596;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bq5HSBH3IUQQ6t95U9MV+TMJF2wzLuKzSVhBRPVa0Vk=;
        b=PFjZnp27AKbbIBR8vBv4oWEvzZ/Ds4Ef/kMM6zzs0AY6KxVg50L2jfr48Vgp3zAGcf
         N46LnLR/dWFjfMDNe4LmbiZDAAwz0gdEYKJIOtkGInAp4l1JW4U4W0FzTQttvieVgTHl
         NVg+GhE4hcUbXXd4YVMHDQ2DdLCu0Cn67cLiOsDbf8Sp5Gpm1xKRUjMF9g3mttBpeuUE
         GKGMvR5iKdpAYjsbG7jGiWVZTkWdqK4YxVgNpdGSPCt/pcJXYJO17wYZlyJjShd4IYGR
         IAU05i23XeQUpIFIBf6/el8SD9ZvFuCTh9RPw2lPXXk78Q6os2bJ4QCYnH3Cpb7EksNS
         WJgQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoOZCpR/2b+F0pawRGPhcx2MVvqhnESFs+hBnD+VQtfLAo9PY4o4p8/+CmgBF5u0LGP9utTAvJ6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy747djzut3BKxrpzF2FCPrGiFbu0crTdFW50N4HGRUkLqT0x/5
	knw4+hlhekhKolu+UDOrmaPlJqivnznKSYDHvxI2KxzYWm4M4eYf
X-Gm-Gg: ASbGncumbZJT3oAtOhWnwTS3iIHpih9xFJnJiqVBupHEb/mRAQSiEyDQCFIflqxtXiu
	ZrwHd7oKD4qLzPlN69mQJUBEW+j5LDK3ETxc2MqEoJ/YFnzPZjoc5cUllf5PRBZLPw3kgvZZj1K
	lijhaaYaUrQCNi5PI1d5KMV43SIwqiFlqB88OWco7kzdnk1T6WKqhtGtPirnJC32zJmco97l+F+
	+OrFS77mi34cefF2loZmrPK1DFL1WjNjioFCltg/yXwIeuLyqilt9PhA/Lyu8y8TOwZaH1tKGaN
	Ri4wN47MUUlGrafcCxqc
X-Google-Smtp-Source: AGHT+IEMEXjwXlRQfN7vWeuXK/GlMDRdhd5em34babQOjlNDCktXzG2ivOzywizd/lCfyORLH3bH7A==
X-Received: by 2002:a5d:4f90:0:b0:385:ee3f:5cbf with SMTP id ffacd0b85a97d-38c519526edmr3798383f8f.20.1738190795618;
        Wed, 29 Jan 2025 14:46:35 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c125f0fsm120379f8f.57.2025.01.29.14.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 14:46:34 -0800 (PST)
Date: Wed, 29 Jan 2025 23:46:31 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: buildroot@buildroot.or
Cc: devel@uclibc-ng.org, linux-sh@vger.kernel.org, ltp@lists.linux.it
Subject: LTP test fstatat01.c FTBFS on Buildroot bootlin-sh4-uclibc toolchain
Message-ID: <20250129224631.GA452802@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi all,

LTP test fstatat01.c [1] FTBFS on Buildroot bootlin-sh4-uclibc toolchain
(uclibc: 1.0.50, kernel headers: 4.19.255). It looks to me that other bootlin
uclibc based toolchains are working, therefore it's probably sh4 problem.

Looking into include/sys/stat.h in uclibc-ng [2], extern int fstatat (int __fd,
...) definition is guarded only by: #  ifdef __REDIRECT_NTH.
But in glibc io/sys/stat.h [3] guardes it with #  ifdef __USE_TIME64_REDIRECTS
added glibc 2.40 a4ed0471d7 ("Always define __USE_TIME_BITS64 when 64 bit time_t is used")
which replaced previous __USE_TIME_BITS64 added in in glibc 2.34 47f24c21ee [4]
("y2038: Add support for 64-bit time on legacy ABIs") [5]. Should similar change
be added to uclibc-ng?

Kind regards,
Petr

$ cd ~/br-test-pkg/bootlin-sh4-uclibc/build/ltp-testsuite-728759506cbe08612183275b3543007d1c47f7f4/testcases/kernel/syscalls/fstatat
$ make V=1 fstatat01
br-test-pkg/bootlin-sh4-uclibc/host/bin/sh4-linux-gcc -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 -I../../../../include -I../../../../include -I../../../../include/old/ -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -O2 -g0  -Ibr-test-pkg/bootlin-sh4-uclibc/host/bin/../sh4-buildroot-linux-uclibc/sysroot/usr/include/tirpc -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -std=gnu99 -L../../../../lib fstatat01.c  -Lbr-test-pkg/bootlin-sh4-uclibc/host/bin/../sh4-buildroot-linux-uclibc/sysroot/usr/lib -ltirpc -lfts -lltp -o fstatat01
fstatat01.c:63:5: error: conflicting types for ‘fstatat’; have ‘int(int,  const char *, struct stat64 *, int)’
   63 | int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int flags)
      |     ^~~~~~~
In file included from br-test-pkg/bootlin-sh4-uclibc/host/sh4-buildroot-linux-uclibc/sysroot/usr/include/features.h:409,
                 from br-test-pkg/bootlin-sh4-uclibc/host/sh4-buildroot-linux-uclibc/sysroot/usr/include/sys/types.h:26,
                 from fstatat01.c:27:
br-test-pkg/bootlin-sh4-uclibc/host/sh4-buildroot-linux-uclibc/sysroot/usr/include/sys/stat.h:243:12: note: previous declaration of ‘fstatat’ with type ‘int(int,  const char * restrict,  struct stat * restrict,  int)’
  243 | extern int __REDIRECT_NTH (fstatat, (int __fd, const char *__restrict __file,
      |            ^~~~~~~~~~~~~~

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fstatat/fstatat01.c
[2] https://cgit.openadk.org/cgi/cgit/uclibc-ng.git/tree/include/sys/stat.h#n247
[3] https://sourceware.org/git/?p=glibc.git;a=blob;f=io/sys/stat.h;h=4bea9e9a7785f51af8eefd035874f475b92bb26d;hb=HEAD#l268
[4] https://sourceware.org/git/?p=glibc.git;a=commit;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9
[5] https://sourceware.org/git/?p=glibc.git;a=commit;h=47f24c21ee38701ae275aa9e451f70fa3e77478c
