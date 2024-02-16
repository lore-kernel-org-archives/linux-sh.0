Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755B130E5E
	for <linux-sh@vger.kernel.org>; Fri, 16 Feb 2024 18:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107887; cv=none; b=SJpz/upSlD/HLdYm8XAhGYLbAX0qRyLbDkJLplg1th082N92HJHlowE6EBf64XwbZ5cjRamgyji20mwT5sdxx7y6xEpbDYnzdamEgM5OnGueaVPXNAjKtGN3XzNSzpKQnPs1eoMYsgTtb1U8M1Zdr6WB7LExMl0u8dW4Nex4d9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107887; c=relaxed/simple;
	bh=WPAV/t8XAn69X3K0JVZV+xXIcMTy4I7vVN4Upk6UlgU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:Cc:
	 References:In-Reply-To; b=W+QFGCZovj+iFzWKWu+cM6BgzoMvSy/GOWI8Op+flDdgdmG13w6b/ovwuES6vn+BufCLlMQgOTiIGsUElXGZnj88ioH5gVx97Z5qTgDlh6CPG0hBvlajk6mYe+Jaq8hREKHxmL3slY9sFGbfavlwQ3c23XwMl4975lh2mpU5Ppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=tQrV1UuE; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="tQrV1UuE"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-21432e87455so784380fac.1
        for <linux-sh@vger.kernel.org>; Fri, 16 Feb 2024 10:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1708107885; x=1708712685; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3Y4sMCkAEN1dJ3u6Rl2m7bGoJBzE6Wp/k1NISd1rsM=;
        b=tQrV1UuE0jFEQPZnd8g+0S7HSX8KIs1lZ+z3gmgmFKQFUGx5qATd/wWqd8h++mxBr4
         ftiEheeGhycijiEnI0r+GNM7IsTnwsRXbZuAxw4dLFBrlDIezi6Oa9UPj6yCVzNtiIId
         +1Es9c0hT726+A4O2FnXhpakIyGiRlNM0f08XAy7iUqb8GIDtx83nCnp66ONzdkGoisn
         27TA6AyGY499I4hkFWBn5K416lX7/o3LBNh+WCpbEuoFQbNG9Ul6NgntiYCRbod+zRSn
         zty/BSMJkFzqJG/df98BBoLHMuF9wu5ZOgvaIT7Jpe422MyivzkReukDb2nUxAhJQIzB
         RmRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708107885; x=1708712685;
        h=in-reply-to:references:cc:to:from:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u3Y4sMCkAEN1dJ3u6Rl2m7bGoJBzE6Wp/k1NISd1rsM=;
        b=QoYIQ4RYr49aeYTJ+YSpdMqUVJHRbQg2e64BG75K+9OhAvYh3fkvQyiZTKriHur3fl
         VRx9nj5GkW22gYMTXrgenr1OBl5KOg4uXVeg/lW9XmIOaOf7RrwIX3Y50a3ABBmVRc26
         4lzu5Dd8NrLUW4zZEgmhgQrnDol7i43/oFfVyqPql9Gb0w61uj3L4R769LQ+klI8ucas
         NtdEScIiAv+zg4ghoWTPcrdDrt08Uxc657RZbMz/EhvEZ0SKS/JksJgSw6+9gQFVZQbU
         4vuZDMoZhQQwMG5WKLhuWNiGsHJL8glmW32uUHhX/VZKnLf3/T5k4I/MjOBuJAkbPxvB
         paRw==
X-Gm-Message-State: AOJu0YwEzGuee9GvO0kKDLFBZYX7CpzEUw+5PU6yhxcipQOtPXTtX+ZM
	6CtoOtFT4c00CfDpH9yXAytirQljoIDpj2gLH+Oh/PdG2nq51/6wxo1oFBosjEtc5YrdQ8xsXDa
	3AXM=
X-Google-Smtp-Source: AGHT+IHpdTodcv8FhKKnU32oTFi+XCtlV8SoOzpn2BtppB9a53IjR1FmjSjwZyAE0XAXzuGF/Zn4Pg==
X-Received: by 2002:a05:6870:158c:b0:21e:389a:214 with SMTP id j12-20020a056870158c00b0021e389a0214mr5236026oab.49.1708107884746;
        Fri, 16 Feb 2024 10:24:44 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id g6-20020a9d6206000000b006e2df00aaa8sm69725otj.70.2024.02.16.10.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 10:24:44 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------JZv2Oucc0fxnFsYn08RsO01N"
Message-ID: <efc5208d-f954-9b67-caa1-c604a217bdf3@landley.net>
Date: Fri, 16 Feb 2024 12:32:31 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [musl] FDPIC on sh4?
Content-Language: en-US
From: Rob Landley <rob@landley.net>
To: Rich Felker <dalias@libc.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, musl <musl@lists.openwall.com>
References: <2d8878fa-c990-e187-9040-934cce908e7c@landley.net>
 <20240215134941.GE4163@brightrain.aerifal.cx>
 <CAMuHMdVczQMiyDkhgAd4G6Zrmw7-pBYMnDvVn18vxd-3CSsSaA@mail.gmail.com>
 <20240215164723.GG4163@brightrain.aerifal.cx>
 <08431a7c-322e-596c-ff46-6b7e0578646d@landley.net>
In-Reply-To: <08431a7c-322e-596c-ff46-6b7e0578646d@landley.net>

This is a multi-part message in MIME format.
--------------JZv2Oucc0fxnFsYn08RsO01N
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/16/24 06:25, Rob Landley wrote:
> On 2/15/24 10:47, Rich Felker wrote:
>> On Thu, Feb 15, 2024 at 03:53:53PM +0100, Geert Uytterhoeven wrote:
>>> Hi Rich,
>>> 
>>> On Thu, Feb 15, 2024 at 2:49 PM Rich Felker <dalias@libc.org> wrote:
>>> > On Thu, Feb 15, 2024 at 04:31:00AM -0600, Rob Landley wrote:
>>> > > Is there any easy way to build FDPIC support for sh4 with-mmu? In theory ARM can
>>> >
>>> > On the userspace toolchain and musl side, yes, I see no reason you
>>> > shouldn't be able to build musl for sh4 with fdpic ABI or build a
>>> > toolchain for sh4 that defaults to fdpic and has fdpic target-libs. I
>>> > just tested passing -mfdpic to sh4-linux-musl-gcc and it seems to
>>> > produce correct fdpic code.
>>> >
>>> > On the kernel side, I'm not sure, but the normal ELF loader should be
>>> > able to load fdpic binaries on a system with mmu. It will not float
>>> > the data segment separately from text, but doesn't need to because it
>>> > has an mmu. If this is no longer working it's a kernel regression;
>>> > that's how I always tested sh2eb fdpic binaries on qemu-system-sh4eb.
>>> >
>>> > > do it, so I tried editing the kconfig BINFMT_ELF_FDPIC dependencies in
>>> > > fs/Kconfig.binfmt to move "SUPERH" out of the !MMU list and put it next to ARM,
>>> > > switched on the FDPIC loader, and the build broke with:
>>> > >
>>> > > fs/binfmt_elf_fdpic.o: in function `load_elf_fdpic_binary':
>>> > > binfmt_elf_fdpic.c:(.text+0x1b44): undefined reference to
>>> > > `elf_fdpic_arch_lay_out_mm'
>>> >
>>> > It looks like there's an arch-provided function that's conditional on
>>> > !MMU in arch/sh but that, now that fdpic loader is intended to be
>>> > supported on mmu-ful systems, should be changed to be conditional on
>>> > fdpic support (or maybe even unconditional if fdpic can be loaded as a
>>> > module). Just look for where it's defined in arch/sh. If it's in a
>>> > nommu-specific file it might need to be moved somewhere more
>>> > appropriate, or an mmu-ful variant may need to be written and placed
>>> > somewhere more appropriate.
>>> 
>>> ARM is the sole architecture that provides elf_fdpic_arch_lay_out_mm().
>> 
>> Ah, I missed that this was a new mmu-ful only function. So I guess
>> something like the ARM one is needed. I'm not clear why this is
>> expected to be arch-specific, so it would probably be nice for the
>> kernel to provide a generic version that archs can use unless they
>> need specific behaviors here, or just make it conditional whether it's
>> called at all (only if the arch declares its presence) and use
>> defaults otherwise.
> 
> It's in arch/arm/kernel/elf.c, and pretty short. Doesn't LOOK
> architecture-specific, although I'm not an expert. (Why SZ_16M instead of
> RLIM_STACK? No idea...)

arch/sh/kernel/elf.c doesn't exist so I cut and pasted the function into setup.c
just to see what would happen...

(Question about that file while I'm there: why are calibrate_delay(),
generic_mode_pins(), and test_mode_pin() not marked __init? And is marking
sh_fdt_init() as __ref equivalent to marking it __init?)

The build broke, I fixed it up to at least compile, and my sh2eb fdpic
filesystem didn't boot because...

Starting init: /bin/sh exists but couldn't execute it (error -8)

Exec format error, but I _think_ that's me trying to run a bit endian executable
on a little endian kernel build. :)

Anyway, to keep you posted, here's the "wrong fix" so far.  (Attached because
thunderbird "upgraded" itself and broke my wordrap disable plugin.)

Rob
--------------JZv2Oucc0fxnFsYn08RsO01N
Content-Type: text/x-patch; charset=UTF-8; name="sh-fdpic-mmu.patch"
Content-Disposition: attachment; filename="sh-fdpic-mmu.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gvc2gva2VybmVsL3NldHVwLmMgYi9hcmNoL3NoL2tlcm5lbC9z
ZXR1cC5jCmluZGV4IGQzMTc1ZjA5YjNhYS4uZWZmZGE4YjIxMzcwIDEwMDY0NAotLS0gYS9h
cmNoL3NoL2tlcm5lbC9zZXR1cC5jCisrKyBiL2FyY2gvc2gva2VybmVsL3NldHVwLmMKQEAg
LTQwNCwzICs0MDQsMjggQEAgdm9pZCBfX2luaXQgYXJjaF9jcHVfZmluYWxpemVfaW5pdCh2
b2lkKQogI2VuZGlmCiAJKnAgPSAnXDAnOwogfQorCisjaWYgZGVmaW5lZChDT05GSUdfTU1V
KSAmJiBkZWZpbmVkKENPTkZJR19CSU5GTVRfRUxGX0ZEUElDKQorCisjaW5jbHVkZSA8bGlu
dXgvcGVyc29uYWxpdHkuaD4KKyNpbmNsdWRlIDxsaW51eC9lbGYtZmRwaWMuaD4KKwordm9p
ZCBlbGZfZmRwaWNfYXJjaF9sYXlfb3V0X21tKHN0cnVjdCBlbGZfZmRwaWNfcGFyYW1zICpl
eGVjX3BhcmFtcywKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgZWxm
X2ZkcGljX3BhcmFtcyAqaW50ZXJwX3BhcmFtcywKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1bnNpZ25lZCBsb25nICpzdGFydF9zdGFjaywKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBsb25nICpzdGFydF9icmspCit7CisJc2V0X3BlcnNv
bmFsaXR5KChjdXJyZW50LT5wZXJzb25hbGl0eSAmIH5QRVJfTUFTSykgfCBQRVJfTElOVVgp
OworCisgICAgICAgIGV4ZWNfcGFyYW1zLT5sb2FkX2FkZHIgPSAweDgwMDA7CisgICAgICAg
IGludGVycF9wYXJhbXMtPmxvYWRfYWRkciA9IEVMRl9FVF9EWU5fQkFTRTsKKyAgICAgICAg
KnN0YXJ0X3N0YWNrID0gVEFTS19TSVpFIC0gU1pfMTZNOworCisgICAgICAgIGlmICgoZXhl
Y19wYXJhbXMtPmZsYWdzICYgRUxGX0ZEUElDX0ZMQUdfQVJSQU5HRU1FTlQpID09IEVMRl9G
RFBJQ19GTEFHX0lOREVQRU5ERU5UKSB7CisgICAgICAgICAgICAgICAgZXhlY19wYXJhbXMt
PmZsYWdzICY9IH5FTEZfRkRQSUNfRkxBR19BUlJBTkdFTUVOVDsKKyAgICAgICAgICAgICAg
ICBleGVjX3BhcmFtcy0+ZmxhZ3MgfD0gRUxGX0ZEUElDX0ZMQUdfQ09OU1RESVNQOworICAg
ICAgICB9Cit9CisKKyNlbmRpZgorCg==

--------------JZv2Oucc0fxnFsYn08RsO01N--
