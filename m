Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138A29ACD8
	for <linux-sh@vger.kernel.org>; Mon, 24 Nov 2025 07:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763969470; cv=none; b=KG3gNE5PghVEvth2Lg+1ILjZfTTvcsWD3fIhsLaHlrJwIveoxK5zb7E0ykgJX6yMZpTsuLjNeBOkMKwTkjOEngEYlWn8VDjg086JcHuJJn6CLlGJd8UOAMFizINobfgOWlL7sOSOLYpX1ofTj+fpst90Uh88PVvW7s5y4l0pvuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763969470; c=relaxed/simple;
	bh=Klh6JDo5bGAgOW2h8WJL+XQcwidJOXTkk5c3OXJr/pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuH7VjYICMi9ywPCNranzpncXVb3dFdIGM5/J7yDMV9sUQtbDvkrUrBFgmc4TZ07bC3cMA/4rBNGSLuSABhOIFnhzxiwfjh4+r8yDyQ3JfdIkT/cdPtdY4Q8U4Sjn1hnFOIWTgSY/wUfStB7SFC2hqcYDyC7U6+41++A6SJc1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HMeNL5UW; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HMeNL5UW"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso38048605e9.0
        for <linux-sh@vger.kernel.org>; Sun, 23 Nov 2025 23:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763969466; x=1764574266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nx/9XKXx0vttGVqTiw4W+ppRW1gPYEutkG1zxZiVplA=;
        b=HMeNL5UWdC6NGWBe2E4gImi5cxGsjTsBr7O3WyuOQkrAH6xAJah4noG0KeSYw6fqW/
         ki5I3pJ9vasLyUPNsYVQ1nYiZCK/2GpW0UYjBh4EFh1lfHOcruq4uDC3daaPJUOlPkhi
         qZQc4A/7M4xMSgWyXwuYR+c814V9HebhbVCA/GUVaxrYc6Lowu6WtrduXSNDC0FzsWwQ
         4LswcCBByg4bj1pflIYJkqSrfubQnyOEsaXw4dQH4EsTzsvzhvB8XV68QLnL736OupPJ
         I1acjdYGMe9ihmXAuG+p8glP32+cS6RcbfFn6d5YX4jxZwN3KusPbu0LP9+gjq+3Dd5y
         WnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763969466; x=1764574266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nx/9XKXx0vttGVqTiw4W+ppRW1gPYEutkG1zxZiVplA=;
        b=ZYoOW+VLct/iISZS8ZKZBD8NFEugPAWvtjBcrEWlyltrTfZcxPQiNhfJHbNTijKzFF
         zk1kUGCsZOK1QYrHil+6jySiJuhJj3EKQmk1wzINChNk3QlTQxogURJ+Cz2RK3QS89Cx
         dOrVF+nth9UNOU6xghfl1DH5Nyg2ERq+9SWgiGFPkT54Sfb3kJJ60KdmjoIWS9PAJ8mj
         idvCzTJv+UV8iAVC5csHu1fqJ7vWBn0RBDmeFzomE7dq79sAg9fW3fO5+IF8qaowJPJd
         frGhgiIM2qSTeP4s1ixLXcyu13iGjNpGCKZGn4kh7x8aC0Pv7ikqS2zWpis3kmUnN7o2
         r1AA==
X-Forwarded-Encrypted: i=1; AJvYcCXpzxOvaYv/NqTKZnZpewkj/gLtauY5Gc6jjCrSU0VFpLKf6BzGd3p9smAIomJKxjEXqPccnAdX4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFqjDmTVs0i5KgP0uKP5ChuSATzrEKa6AAnyun48cy4yDjiGD
	s44uk9KbQ1t6orXLZbznH1phCaAYnzmWVvXqrE0r2QLWhvi3RKDaItZamfJdkqQ2JlA=
X-Gm-Gg: ASbGnctyxIVVP4LRx6QBUxylq4aTo3qOsYCM9wAKBuj6YIgsnwI48ASezGqVLkPVXPV
	F5OH1XPixSmhgK8zaO82U7Q1hcCwcnUVGUET0InoqzLHGD3aIsofTBSAJKBDkYO4qFDeytCUx9/
	UZ98V7KYoR5bX9ynlio0WLEtAnMmiaMLT+wTofGLYY2UIO5rPdE70ggtsdSFLeF0sIt6rji/QAn
	VOIbaJcEBG8GroDexnf2c6nQHrRzTuphdSh2SbdVc09vOPSFap1wTLJklXfLXI02cfF87xAdOhn
	U7DwUJrGlHBaIZpTWH16dcbsdur8/kWripEQ5fl2VxpZFRctAaBWHEU2R2JKQOW1rQ6YaazQa5w
	3cB7gRXocNSrnsttmii6d0+19/pPYnnzh/9CtQS1mJzveaRjGu9eJE5BzQS0fawKLWu4NULTUsJ
	dqvQXfBkovJ7+2yW1Wy9bbSJ765K6NlzPQeMfS3kduj5KTL6BNseJhOA==
X-Google-Smtp-Source: AGHT+IGobOErczOKLWR/BHEjDIojdrhHS5GnwoLh6XejaBhaphGalWUlTTHXiIJHFeG6CD0ZI8tmdg==
X-Received: by 2002:a05:600c:4e88:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-477c01d4af2mr108288705e9.18.1763969465715;
        Sun, 23 Nov 2025 23:31:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net. [88.187.86.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf1f3e63sm183519735e9.7.2025.11.23.23.31.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Nov 2025 23:31:05 -0800 (PST)
Message-ID: <b42433a7-e102-43f7-a7fa-1c9417a21146@linaro.org>
Date: Mon, 24 Nov 2025 08:31:03 +0100
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: 64mb limitation of qemu-system-sh4 board
Content-Language: en-US
To: Rob Landley <rob@landley.net>, Thorsten Glaser <tg@debian.org>,
 Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Cc: security@debian.org,
 Debian QEMU Team <pkg-qemu-devel@lists.alioth.debian.org>,
 debian-ports@lists.debian.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org
References: <aKi6IWVX2uIlGKnw@seger.debian.org>
 <Pine.BSM.4.64L.2508230023030.21591@herc.mirbsd.org>
 <6abe2750-5e2c-43a1-be57-1dc2ccabdd91@tls.msk.ru>
 <119d5858-52f4-ce1b-9ee7-9615ce2054b9@debian.org>
 <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <79f14fef-123f-4938-b069-10f07e7d0405@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24/8/25 20:07, Rob Landley wrote:
> On 8/23/25 09:19, Thorsten Glaser wrote:
>>> There are no alternatives - qemu is unique in this regard.  And
>>> it has never been designed for this usage.  What we had for 15+
>>> years, unnoticed, is like `chmod u+s /bin/sh`, which is never
>>> supposed to be used like this.
>>
>> Perhaps, but there’s shades in between.
> 
> I find qemu system emulation a LOT less problematic.
> 
> For sh4 I boot qemu-system-sh4 and then use a network block device to 
> provide swap (so the 64mb limitation of the board isn't a limiting 
> factor).

The R2D+ board uses a SH7751 SoC, which memory controller can access
7 external banks. This board has its boot flash on CS#0, a FPGA on CS#1,
64MB of SDRAM on CS#3, a SM501 display on CS#4 and some ISA bus on CS#5;
leaving CS#2, and CS#6 available. CS#2 can have SDRAM, while CS#6 only
SRAM (not really a difference in emulation).

 From QEMU side, we could fill these empty slots with 2*64MB of RAM, so
the machine could use up to 192MB. But then it is up to the guest to
use it.

Looking at Linux i.e. it seems to hardcode the RAM base/size in
arch/sh/include/asm/page.h, so we'd need changes there to use more
memory, which seems unlikely to get for a such old board...

> The sh4 build in toybox's mkroot works fine for this (binaries 
> at https://landley.net/bin/mkroot if you'd like to try). It also works 
> with -hda but I think can only provide _one_ of those so you have to 
> partition it, which I generally don't bother.
> 
> qemu-system-sh4: -hdb hdb.img: machine type does not support 
> if=ide,bus=0,unit=1
> qemu-system-sh4: -hdc hdc.img: machine type does not support 
> if=ide,bus=1,unit=0
> qemu-system-sh4: -hdd hdd.img: machine type does not support 
> if=ide,bus=1,unit=1
> 
> (You'd think it could at least do -hdb since that's just master/slave on 
> the same controller but the qemu guys never bothered to wire it up. 
> Anyway, I stick a 4gb ext3 image in /dev/sda so I have lots of scratch 
> space for builds because building on network filesystems tends to have 
> strange permission hiccups for me, or rm -rf fails because nfs didn't 
> _really_ delete a file that's still open but just renamed it, or...)
> 
> Anyway, this works fine on little endian, but the qemu-system-sh4eb 
> build has something hinky in the ethernet, I haven't tackled it myself 
> because I don't know whether the device emulation or the driver is 
> what's missing an endian swap. (I don't want to fix it the "wrong way", 
> and don't have big endian physical hardware lying around to try it on. I 
> moved _again_ at the start of the month, just unpacked the storage space 
> with those boxes into my sister's garage last weekend, but haven't 
> sorted very far yet.)
> 
> In theory I could use a swap _file_ instead of swap partition, and thus 
> a single /dev/hda would be plenty without partitioning it, but I haven't 
> tried? (When the network doesn't work I can't upload the results of the 
> build in an automated fashion anyway, so...)
> 
> You can speed this build process up further by hooking up distcc to call 
> out to the cross compiler, which lets you keep about -j3 busy before the 
> preprocessing, data transmission, and linking become the bottleneck. (I 
> mean ./configure is _always_ the bottleneck but that's because autoconf 
> is really stupid and largely pointless.) I had that distcc setup working 
> (and even automated) back in https://landley.net/aboriginal/about.html 
> and can help anyone interested fish the relevant bits out of those old 
> build scripts.
> 
>>> If you rely on suid/sgid *foreign* binaries, that's where the
>>> problem lies.
>>
>> Yes. People expect to be able to run foreign-arch chroots.
>> Entire buildd setups partly rely on this, too…
> 
> A qemu-system vm doesn't require any weird translation. As far as the 
> kernel running in the emulator is concerned, everything is entirely 
> native. :)
> 
> Rob
> 

