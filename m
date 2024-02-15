Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6F766B25
	for <linux-sh@vger.kernel.org>; Thu, 15 Feb 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992599; cv=none; b=dChVZ/WtFB55GTEl7Y7BZZ2kzAuwZki0HFPtUd2XA79pjvIhs+h8lcbTDEM0GoT8cVc9TcmTvoNvNN8ygP0ldNXpOZO0pY3N9qUPSVsbjcZW58KhWunWBiEIHKBjbfj64vqcG65Ncj4r+/BPgbsBo08WMMXBUGy0MOOUdLAstDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992599; c=relaxed/simple;
	bh=wk9zWkkQLaJJBNHvfn8eQiLi4D0WXt4EMamd4s7URG4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=k9ovafmEVoamjdmVtDrTEBZ+6taTXQfVHd4fGHXGH0XzkVsrULOF6iIWQJHFSqhgELcswYP04MT0o9SyQ44Rbzo0dZcRp799PK2xL3X46B5Rejb+rsLh7WVncWejuoIB6gEgekevU6ERelaqX6/TrV4v41Ho5n2IlSERnuyHKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=quTNG7uX; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="quTNG7uX"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e2e452c852so302666a34.3
        for <linux-sh@vger.kernel.org>; Thu, 15 Feb 2024 02:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1707992596; x=1708597396; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK9BzjI4EuWJ5oP8jb5JKbLdn6UVkMpasNFQq6RGWkg=;
        b=quTNG7uXfmirGHLX5SatLCwYQMChNhWlk1W5Hf6ZFyLiTFTIYVyrBbNlhemT6tspBz
         EAwT7SG1+PuxfAWLv3sAajbQfWFvZ2Oc2P2cRgGAy0MyuyUbeBhEkMrLVJZcQUVvqY+T
         rwRb7Wq+KXTbgOXymu50t7vL2C74Ici1DfdayUz4Mp+YXry2XQAkpStU3egabHQdTLvd
         Kgl6c5JL6PwPad249/3Y76fyt9R1L5wSLCa6zhQzTFndo5exItblQBub6LUyhisySRrT
         OTgrrA+eHmxLjQsLXpqNH0mJdLlcT3+4jp45MRO6H4lcA3e8SpN1f0ZFBoVgzLVVcIPO
         T31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707992596; x=1708597396;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yK9BzjI4EuWJ5oP8jb5JKbLdn6UVkMpasNFQq6RGWkg=;
        b=UmhczXzxq34VVIYCykJ+5UgGazHsZVVeuX2eOzieIPMbIH4sKJVCUmh1giNAMByfki
         D+zI0LoaSePk9ZNfR1zMQnyGTzUU0hraOzYWHXEvwnOgWU6NAoZa2J3tzewE0O6CGOYV
         am9r/oFng53+fsAXMVoVUdxNHNYvniPBgVmpIx1Q2jgTzM4ymKK1U/izBkkvggHYquc7
         nm1akBRWwdlo/U2WO0KpfMrtcK8Vkgd6jDFHO8N0I2gpNqAQ5EvsyUlrcLQusvwl9GOn
         Hjs1fGYjQu5Zpwjjjpmx9XVFLEB28IAAJX3/nFw34KOCle3BmZEze0GNwNKXDci/ylzC
         FFPA==
X-Gm-Message-State: AOJu0YwwUmIlLO4iE4dujjRBiVRMJhnxeIQ/DLRZVOw5WzqcwZU1AXWw
	5ZD3E9wQ6PIrp7uGbvw8Rl4ljxfBKCZCOMmLPSejudoM7whWsPdhbxp3O5hHtu48lzdK/kCvxf5
	S
X-Google-Smtp-Source: AGHT+IFD7LwiLb6QhpY0M1rggPrmocnFFg4PMfAFuALLj0tyUXGpFcrXfy9O0w+Fd3aiWNvCstQBoA==
X-Received: by 2002:a05:6830:18d0:b0:6e2:ed2e:3a9 with SMTP id v16-20020a05683018d000b006e2ed2e03a9mr1078470ote.37.1707992595987;
        Thu, 15 Feb 2024 02:23:15 -0800 (PST)
Received: from ?IPV6:2607:fb90:f24a:189:fc59:4dff:fe4d:3a5c? ([2607:fb90:f24a:189:fc59:4dff:fe4d:3a5c])
        by smtp.gmail.com with ESMTPSA id w2-20020a4a6d42000000b0059a530f54c6sm168860oof.10.2024.02.15.02.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 02:23:15 -0800 (PST)
Message-ID: <2d8878fa-c990-e187-9040-934cce908e7c@landley.net>
Date: Thu, 15 Feb 2024 04:31:00 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Linux-sh list <linux-sh@vger.kernel.org>, musl <musl@lists.openwall.com>
From: Rob Landley <rob@landley.net>
Subject: FDPIC on sh4?
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Is there any easy way to build FDPIC support for sh4 with-mmu? In theory ARM can
do it, so I tried editing the kconfig BINFMT_ELF_FDPIC dependencies in
fs/Kconfig.binfmt to move "SUPERH" out of the !MMU list and put it next to ARM,
switched on the FDPIC loader, and the build broke with:

fs/binfmt_elf_fdpic.o: in function `load_elf_fdpic_binary':
binfmt_elf_fdpic.c:(.text+0x1b44): undefined reference to
`elf_fdpic_arch_lay_out_mm'

Backstory: I want to test nommu under qemu, and my existing tests are all using
qemu-system-$TARGET builds with musl-libc toolchains built by musl-cross-make.

I have a nommu test environment on real (FPGA) hardware, using an sh2 fdpic
toolchain built from musl-cross-make using gcc 9.4.0, but that's not part of my
normal "cursor up and hit enter" fully automated regression testing that builds
and launches qemu instances with a prepared filesystem that launches tests from
the init script and does "expect" style processing on the serial console
connected to qemu's stdin/stdout.

Testing on the FPGA board requires repeatedly removing and inserting sd cards,
so I don't do it nearly as often, and right now that's my ONLY nommu test
environment.

I want to get a qemu-system-something running nommu. Since musl-libc only
supports fdpic, this limits my choices to the intersection of Linux's FDPIC support:

$ grep FDPIC -m1 -A3 fs/Kconfig.binfmt
config BINFMT_ELF_FDPIC
	bool "Kernel support for FDPIC ELF binaries"
	default y if !BINFMT_ELF
	depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !MMU)

And gcc's FDPIC support:

$ dirname $(grep -irl fdpic gcc/config) | sort -u
gcc/config/arm
gcc/config/bfin
gcc/config/frv
gcc/config/sh

Ever since linux threw blackfin and frv overboard to lighten the load, this
means gcc can produce fdpic output for exactly two targets that Linux supports:
arm and superh. (No, riscv is not joining them. I emailed about
https://groups.google.com/a/groups.riscv.org/g/sw-dev/c/ZjYUJswknQ4/m/QnTEfur4BwAJ
yesterday and was told "Sadly that project didn't go beyond the ABI design
phase." so riscv-fdpic is _not_ currently in development.)

In theory arm can use the FDPIC loader on a with-mmu kernel, but the arm
configure doesn't have a way to combine "musl" with the magic
"uclinuxfdpiceabidoodahdoodah" blob because their matches keep looking like:
"arm*-*-uclinuxfdpiceabi" and "*-linux-musl*" which aren't compatible. (If that
first one didn't have the extra dash...) Alas arm-unknown-musl-uclinuxfdpiceabi
makes binutils go "checking target system type... Invalid configuration
`armv7m-linux-musl-uclinuxfdpiceabi': machine `armv7m-linux-musl' not recognized".

So I was thinking "maybe I can build an sh4 kernel with an sh4 compiler, and
build a userspace with the sh2eb compiler" (this is unlikely to work because
every sh4 system I've ever used is little endian and the j-core guys
inexplicably chose big endian, but I can burn that bridge when I come to it...)
But that's how I hit the "enabling FDPIC on with-mmu only works with arm,
nothing else" issue above. And that's incompatible with selecting musl support.

Rob

PS. the sh2 fdpic toolchain in musl-cross-make doesn't reproduce with the newest
"supported" gcc (11.2.0) because:

In file included from libstdc++-v3/libsupc++/eh_call.cc:32:
libstdc++-v3/../libgcc/unwind-pe.h: In function 'const unsigned char*
read_encoded_value_with_base(unsigned char, _Unwind_Ptr, const unsigned char*,
_Unwind_Ptr*)':
libstdc++-v3/../libgcc/unwind-pe.h:270:25: error: '_Unwind_gnu_Find_got' was not
declared in this scope
  270 |               result += _Unwind_gnu_Find_got ((_Unwind_Ptr) u);

Which has been broken ever since musl-cross-make's newest last commit almost 2
years ago.
