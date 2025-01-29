Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE88DDCD
	for <linux-sh@vger.kernel.org>; Wed, 29 Jan 2025 23:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738193726; cv=none; b=brgbvKFY8V9eXHK7weqYrBlKe5d/+aGQB7zg6bP28q/LeisdN9ph4gYOt8RUNqOtESGguR097110SPQO+KK/ATBtaSqBn6lCXp59BYgwt+ASXuvtBTTMyo/fOGa6BXKgj4QaoAOw7FV4P4ZUhRZk5TfFQrMcd9Dxj6aOD6hE4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738193726; c=relaxed/simple;
	bh=Kvipo+YmRuHdQST4GxH1nqU68XUUhiVLXk9iqWdkGsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kbL779RamS2kRlGu6visP2SnzoBnN7U7wqEobWxiSL5ijMbgalFQ1VQv63a1BqyC6GQwSYvMEg31ckwV7kUU2EGZfWfqTK+/iW/YOeUzcm1C8PAXQ7KmqF6JrxnMygwTHQdmgagxYwc2j4Ry7xUs/YiOYviVins3s04lteqqKlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msacXZ2g; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msacXZ2g"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-385f06d0c8eso112059f8f.0
        for <linux-sh@vger.kernel.org>; Wed, 29 Jan 2025 15:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738193723; x=1738798523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ad4OWAvie9bFaeOk+7TOkUim/AHORb3zPHq5phrxsYQ=;
        b=msacXZ2g3BPwLvbpYcfKEL0Xd3Eyzr44ligYMtttVdYAFqdBOTrmyDk6HGTI6Ra7Cp
         jhYFMWzDBh/74b64+emBN5eFp8nY5vlOYQns7ycGfHE2ybMtHptWixQUHN6zUxyBTuGB
         l+ePkNLswh6T7upNyZ/I0hw7ba7rpUs76+b9wIid0qPzIekW6GbQD4U4WDHcnU2VzW5m
         L3XMo+uLRS+hTDJ4UMTWnjwiGshUYK1JMyQFAHidu9I6GQiPn1kxOgz1QiPybTtzDhLx
         e6Caq9ZMUOS76PUIgdJ43HLh0BF0GRq1+EAfFUSgEmTCNJMPndFCZCqnVSXw0ocYKvqD
         I4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738193723; x=1738798523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ad4OWAvie9bFaeOk+7TOkUim/AHORb3zPHq5phrxsYQ=;
        b=A4IsaxZXb94xfC7+AwxZE7KqC1wuZKAmkm9u8zD5WIZRPLhchg3Fah6D7buo3Pk5AW
         0RiIDzBiqogeLFnQvCmZ8/sPvVQuZ641pCFiAaasI34Xq2Y4ANROP3ygn7txBj5mq5uu
         ATH+3+vX69dqrYNmZf2I4PdaVHuWNWKxxM356f8+Yi8yw9Ulnz8VAC9MZFt6ctIQpP6F
         8uJuQDEhdy8nHpMS9KaNF4uHqd0X6vW5XkNPSlW97HBK8Wa8U/cH2Edrg+ADFUNqcFUi
         QautsCskOxrX2PTdvUT1Chf2oDoFuwFq4yHJOWr1hamARDJbM5KNvtPtkscQJCMRhwrN
         oZMg==
X-Forwarded-Encrypted: i=1; AJvYcCXRcEyJ29bWZa0sS1yAvn+1mctKyBnjAb5BVSVHyL29n0Pd1ySDNUvXNbFDZwqi6iGBWmjhyUNuQA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwT3qNapLNngVPD7cYPoXb3ana5OIHzX6D5QwtKOwPM14S/Yxfo
	yGziWqPzReBGNKpSOpCn4KJRbRgxw8TINw4+0Rzl1XJB+TWWFFR7
X-Gm-Gg: ASbGnct0noc/RaVxNoErp9265HXJDZCtgdwZwiOR8xaWfqnTBsj8TX5fo9xdvOLa0mi
	nwBuXYQel8aQLd30/XdtxR/SUSLKJyWG9ZoT2bNU/IELA88nabZiFNm1W62p/1JI5vlmt90ngDY
	VgmF/YbHKLXc/JfcAALtizMD5/PpnmrfnX9KmlW+xNwpSLBGb89WlftIaimcJDp4Nfo6uuHBVNR
	e6nceIJWmJcgTlmQLLVweZ+/NooSEAq5pD4+EbhgQ4p1+nai5j51RPs5zTjHrmX+ghleTQVMDOE
	BqTFPDs5IJjgPcI=
X-Google-Smtp-Source: AGHT+IEOlRIyw9nkUEKhHze05eDFF7ISQwE5h/yuUotX2U7dtDcjVrU1nVe8IqRMIJfxkree188UHQ==
X-Received: by 2002:a5d:694f:0:b0:386:5b2:a9d9 with SMTP id ffacd0b85a97d-38c520bfa02mr3661961f8f.53.1738193722922;
        Wed, 29 Jan 2025 15:35:22 -0800 (PST)
Received: from nadav-dell ([87.71.205.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c5c0ec315sm210513f8f.4.2025.01.29.15.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 15:35:22 -0800 (PST)
Date: Thu, 30 Jan 2025 01:35:19 +0200
From: Nadav Tasher <tashernadav@gmail.com>
To: Petr Vorel <petr.vorel@gmail.com>
Cc: buildroot@buildroot.or, devel@uclibc-ng.org, linux-sh@vger.kernel.org,
	ltp@lists.linux.it
Subject: Re: [uclibc-ng-devel] LTP test fstatat01.c FTBFS on Buildroot
 bootlin-sh4-uclibc toolchain
Message-ID: <Z5q7NwweeZ0iNlzc@nadav-dell>
References: <20250129224631.GA452802@pevik>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250129224631.GA452802@pevik>

On Wed, Jan 29, 2025 at 11:46:31PM +0100, Petr Vorel wrote:
> Hi all,
> 
> LTP test fstatat01.c [1] FTBFS on Buildroot bootlin-sh4-uclibc toolchain
> (uclibc: 1.0.50, kernel headers: 4.19.255). It looks to me that other bootlin
> uclibc based toolchains are working, therefore it's probably sh4 problem.
> 
> Looking into include/sys/stat.h in uclibc-ng [2], extern int fstatat (int __fd,
> ...) definition is guarded only by: #  ifdef __REDIRECT_NTH.
> But in glibc io/sys/stat.h [3] guardes it with #  ifdef __USE_TIME64_REDIRECTS
> added glibc 2.40 a4ed0471d7 ("Always define __USE_TIME_BITS64 when 64 bit time_t is used")
> which replaced previous __USE_TIME_BITS64 added in in glibc 2.34 47f24c21ee [4]
> ("y2038: Add support for 64-bit time on legacy ABIs") [5]. Should similar change
> be added to uclibc-ng?
> 
> Kind regards,
> Petr
> 
> $ cd ~/br-test-pkg/bootlin-sh4-uclibc/build/ltp-testsuite-728759506cbe08612183275b3543007d1c47f7f4/testcases/kernel/syscalls/fstatat
> $ make V=1 fstatat01
> br-test-pkg/bootlin-sh4-uclibc/host/bin/sh4-linux-gcc -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2 -I../../../../include -I../../../../include -I../../../../include/old/ -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -O2 -g0  -Ibr-test-pkg/bootlin-sh4-uclibc/host/bin/../sh4-buildroot-linux-uclibc/sysroot/usr/include/tirpc -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -std=gnu99 -L../../../../lib fstatat01.c  -Lbr-test-pkg/bootlin-sh4-uclibc/host/bin/../sh4-buildroot-linux-uclibc/sysroot/usr/lib -ltirpc -lfts -lltp -o fstatat01
> fstatat01.c:63:5: error: conflicting types for ‘fstatat’; have ‘int(int,  const char *, struct stat64 *, int)’
>    63 | int fstatat(int dirfd, const char *filename, struct stat64 *statbuf, int flags)
>       |     ^~~~~~~
> In file included from br-test-pkg/bootlin-sh4-uclibc/host/sh4-buildroot-linux-uclibc/sysroot/usr/include/features.h:409,
>                  from br-test-pkg/bootlin-sh4-uclibc/host/sh4-buildroot-linux-uclibc/sysroot/usr/include/sys/types.h:26,
>                  from fstatat01.c:27:
> br-test-pkg/bootlin-sh4-uclibc/host/sh4-buildroot-linux-uclibc/sysroot/usr/include/sys/stat.h:243:12: note: previous declaration of ‘fstatat’ with type ‘int(int,  const char * restrict,  struct stat * restrict,  int)’
>   243 | extern int __REDIRECT_NTH (fstatat, (int __fd, const char *__restrict __file,
>       |            ^~~~~~~~~~~~~~
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/fstatat/fstatat01.c
> [2] https://cgit.openadk.org/cgi/cgit/uclibc-ng.git/tree/include/sys/stat.h#n247
> [3] https://sourceware.org/git/?p=glibc.git;a=blob;f=io/sys/stat.h;h=4bea9e9a7785f51af8eefd035874f475b92bb26d;hb=HEAD#l268
> [4] https://sourceware.org/git/?p=glibc.git;a=commit;h=a4ed0471d71739928a0d0fa3258b3ff3b158e9b9
> [5] https://sourceware.org/git/?p=glibc.git;a=commit;h=47f24c21ee38701ae275aa9e451f70fa3e77478c
> _______________________________________________
> devel mailing list -- devel@uclibc-ng.org
> To unsubscribe send an email to devel-leave@uclibc-ng.org
My guess is that this is somehow caused by the fact that time64 on 32-bit targets is
not supported on Linux < 5.1.0.

Regards,
Nadav
