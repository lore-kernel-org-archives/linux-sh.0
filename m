Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4539A37BE91
	for <linux-sh@vger.kernel.org>; Wed, 13 May 2026 04:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648045; cv=pass; b=YYEEiHqrP9KWpVcL8D3BAEBRtm8a9kGRiRCGWjJqwDW3WmqdDyYbH1FrTx8ZJsY3jJpii8ChNFXv5D/OzmOKFKJolmulG8fPOD9cC+ed+whtBqJffHXDB080tXVDEFbNKBeCiDOZzoAmcs/DkhlueqID/w6rQRQFyjbERZL71CY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648045; c=relaxed/simple;
	bh=vDYXrWr5WuhgqeltFVhEaW/YEZfkgto7X0Tj6cby7QA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=SgiqZ3angwgySA776PNHJMrQYU6QPYQq6E7zVAMWEI/+Nx3wF7rrcO0j87kmEdDXoXGea6qPo1s3hu3zroURiILAt/EVc4uQ8h77M2PqWYr/tp7fjowSYOFqOlmmYDsT+YwKflXCdx/fPqE4OrmmCi/n4uReDV4um34wuvLWxhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=dviI4Qar; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="dviI4Qar"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 96004461F42;
	Wed, 13 May 2026 04:35:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (100-104-1-130.trex-nlb.outbound.svc.cluster.local [100.104.1.130])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 29E8E461F9D;
	Wed, 13 May 2026 04:35:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778646951;
	b=VVvjQBq9Xl2S5v4dVaSeDEcE1P9grPSJzIcuVXdIrifO2GBcjMfzN7+ZzUhJusSge2YgB/
	LJENJZuSAc59RVR6TYJBCcWGtuVgZDuZqhk1Obs+dtj2/TRJdBKEwyspSsIkSowX5JA+0I
	m77BWmUBvry5ic8G25VyNa7xFUAR/ZjCVEQQ/wFOu/rVyuw2Qok3OAOBwqPC0dXI2GTcp/
	RHYLQaMpHYJp6Jo4StzBjDwQ8qSErCjIM160JfsNbk5pf0f5CYZFg4usM+slUMpwBeuLeI
	/dX49DevF3xfRbWoIBvwfm/6x9EknoXvbQQOP2oX9tcu1OCZ8klxAbA5WvBlNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778646951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=jwPUGJ3ErJ9cY2VWffWajpHwT3a1fnxUTCoWa50s8pM=;
	b=LXrbpA6ErNUC5GaKCvf/d3YanmD5oyNQ1wmc1dKUuhQWGkZLmTPWKQ5MEHauDJrlpe8P+n
	HQ/9w0hH/1KeRf2n9hpQ2a/pLzWaMjbQFPNuWmbfAhDCRJAaymdCSgk3YckG0Q4hp+vNJy
	OFFviXHsv9/nUda8IVJMt1dXFBc0vlnvACpSJzC1x5EVIdpdtvbRk+9NuOoG2TC1eX62Ba
	A3nGFAO9qnOpvMwHjmPIWbJqkfNWVPErrmGjts0ZC/JkX6qbjOTHgyIwcQ1KSIzZN3LroI
	3/g6QZbdUvRdnAPu5Xp3wFEJ1nX6a6D4lvDxe/8J9lq4lo53ExSxpbgWXbkeSg==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-s757q;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Stretch: 2fd9873b2cd101d7_1778646951424_788268069
X-MC-Loop-Signature: 1778646951424:1194582918
X-MC-Ingress-Time: 1778646951422
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.1.130 (trex/7.1.5);
	Wed, 13 May 2026 04:35:51 +0000
Received: from [192.168.88.6] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4gFgd24zLNzT2;
	Tue, 12 May 2026 21:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1778646951;
	bh=jwPUGJ3ErJ9cY2VWffWajpHwT3a1fnxUTCoWa50s8pM=;
	h=Date:Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
	b=dviI4QarLmTpfOQUecGdIqa6VNy/aIdE/lpA8TC0B/WIhUJeInhG3LONwBMTHVc8R
	 VUbWx5MZu8Mh0+Mmzjsd7zSMhhMmprgLtEqGEINrbVaCdmkB3TQFYVDybW405pSPa/
	 qX5FSmf/S73gkVr5nkmHNBIjFEoAuqqZUA04RToJNNC9Jk7+m8olqOOw5hzAssCTey
	 0LE2/ug/c1ZPJhYIV4uzUWQUJf/OvDtZj/jexdveBkGdJV3iHMtlFW016setCWm4gL
	 Q6ff65IzhFxMdiBTnpXBMKRt4kiqhlyHxIWw+1o3YvS4auOm9Xcm5cUvHSYeCHj+Ki
	 X5yOoZ38TRhew==
Message-ID: <9dd69630-cdcc-4708-b53f-8cd7c8a8e330@landley.net>
Date: Tue, 12 May 2026 23:35:49 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
From: Rob Landley <rob@landley.net>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "D. Jeff Dionne" <djeffdionne@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 "D. Jeff Dionne" <jeff@coresemi.io>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
 <55D40750-934F-4F70-A19C-11DC5F97A389@gmail.com>
 <15ca13ffdfa494b4d774f75d3daaee2ac7a8c93f.camel@physik.fu-berlin.de>
 <acc36891-6148-429c-aa99-3cf7c6681d6f@landley.net>
 <84b1391eb542b5cd6bcbecdfbc63124187265402.camel@physik.fu-berlin.de>
 <003c0770-c6f7-4fcf-b11e-74f42bfc14b8@landley.net>
 <6bd93131318b8e78d49fdc5f3e5fecc053f9c046.camel@physik.fu-berlin.de>
 <ef22a5de-d945-4080-9f4a-f5a1ab9de1dc@landley.net>
Content-Language: en-US
In-Reply-To: <ef22a5de-d945-4080-9f4a-f5a1ab9de1dc@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/26 18:08, Rob Landley wrote:
> The end of line not at end of file, missing operand, and invalid 
> operands for opcode seem relevant, and the fact it's happening in the 
> middle of a nested macro expansion implies that the code being fed into 
> the actual compiler plumbing may be nuts here, but I'd have to cc -E and 
> then cc -S the result to see what actually happens.

The barfing compiler invocation is:

sh2eb-linux-muslfdpic-gcc -nostdinc \
   -I./arch/sh/include -I./arch/sh/include/generated -I./include 
-I./include -I./arch/sh/include/uapi -I./arch/sh/include/generated/uapi 
-I./include/uapi -I./include/generated/uapi -include 
./include/linux/compiler-version.h -include ./include/linux/kconfig.h 
-include ./include/linux/compiler_types.h -D__KERNEL__ -I 
./arch/sh/include/cpu-sh2 -I ./arch/sh/include/cpu-common -I 
./arch/sh/include/mach-common \
   -std=gnu11 -fshort-wchar -funsigned-char -fno-common -fno-PIE 
-fno-strict-aliasing -pipe -m2 -mj2 -mb -mno-fdpic -Wa,-isa=sh2-up 
-ffreestanding -fno-delete-null-pointer-checks -O2 
-fno-allow-store-data-races -fno-stack-protector -fomit-frame-pointer 
-fno-stack-clash-protection -fno-strict-overflow -fno-stack-check 
-fconserve-stack -fno-builtin-wcslen \
   -Wall -Wextra -Wundef -Werror=implicit-function-declaration 
-Werror=implicit-int -Werror=return-type -Werror=strict-prototypes 
-Wno-format-security -Wno-trigraphs -Wno-frame-address 
-Wno-address-of-packed-member -Wmissing-declarations 
-Wmissing-prototypes -Wframe-larger-than=1024 -Wno-main 
-Wvla-larger-than=1 -Wno-pointer-sign -Wcast-function-type 
-Wno-array-bounds -Wno-stringop-overflow -Wno-alloc-size-larger-than 
-Wimplicit-fallthrough=5 -Werror=date-time 
-Werror=incompatible-pointer-types -Werror=designated-init 
-Wenum-conversion -Wunused -Wno-unused-but-set-variable 
-Wno-unused-const-variable -Wno-packed-not-aligned -Wno-format-overflow 
-Wno-format-truncation -Wno-stringop-truncation -Wno-override-init 
-Wno-missing-field-initializers -Wno-type-limits 
-Wno-shift-negative-value -Wno-maybe-uninitialized -Wno-sign-compare 
-Wno-unused-parameter \
   -DKBUILD_MODFILE='"kernel/nstree"' -DKBUILD_BASENAME='"nstree"' 
-DKBUILD_MODNAME='"nstree"' -D__KBUILD_MODNAME=kmod_nstree \
   -c -o kernel/nstree.o kernel/nstree.c

I turned the -c into a -E to get a preprocessed file, and since -E ate 
all the -I and -D you compile THAT with just:

sh2eb-linux-muslfdpic-cc -std=gnu11 -fshort-wchar -funsigned-char 
-fno-common -fno-PIE -fno-strict-aliasing -pipe -m2 -mj2 -mb -mno-fdpic 
-Wa,-isa=sh2-up -ffreestanding -fno-delete-null-pointer-checks -O2 
-fno-allow-store-data-races -fno-stack-protector -fomit-frame-pointer 
-fno-stack-clash-protection -fno-strict-overflow -fno-stack-check 
-fconserve-stack -fno-builtin-wcslen -c nstree-pre.c nstree.o

And even though that says it's barfing on line 1640, which is the 
declaration of raw_atomic_sub_return_relaxed, if you delete all the 
functions after that in the file it doesn't fail. In fact, if I delete 
JUST the last function from the file, it succeeds.

Let's try ripping out some of the decorators:

sed -i -E 
's/__attribute__\(\(__(always_inline|unused|gnu_inline|no_instrument_function|always_inline|warn_unused_result)__\)\)//g' 
nstree-pre2.c

Still dies.

sed -i 's/static inline/static/g' nstree-pre2.c

Still dies.

Hmmm, still a 2.1 megabyte file, bit much to attach here. Let's see...

I switched to -S instead of -c and got

during RTL pass: final
kernel/nstree.c: In function '__se_sys_listns':
kernel/nstree.c:729:3236: internal compiler error: in change_address_1, 
at emit-rtl.c:2275
   729 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
       |

Which is because all those "# 123" lines in the -E output, lemme strip 
those and...

nstree-pre2.c:62345:8: warning: 'sys_listns' alias between functions of 
incompatible types 'long int(const struct ns_id_req *, u64 *, size_t, 
unsigned int)' {aka 'long int(const struct ns_id_req *, long long 
unsigned int *, unsigned int,  unsigned int)'} and 'long int(long int, 
long int,  long int,  long int)' [-Wattribute-alias=]

Huh? (I mean it's been doing a lot of warnings because I dropped the 
-Wno-gnu-stupid section, but now we're down to one and it seems 
potentially relevant? Anyway...

during RTL pass: final
nstree-pre2.c: In function '__se_sys_listns':
nstree-pre2.c:62345:3236: internal compiler error: in change_address_1, 
at emit-rtl.c:2275
62345 | d int) > sizeof(long)" " is true");})); do { } while (0); return 
ret; }
       |

3236 is the closing curly bracket on giant line. And again, if I delete 
everyting AFTER that line it works. Stick in a newline at each semicolon 
(and zap the silly #pragma gnu debug pop whatever that is) and... It 
complains that the last curly bracket of the file is the problem now.

I think maybe it's trying to inline __do_sys_listns() into sys_listns() 
but, sticking __attribute__((noinline)) on both the declaration and the 
definition changed nothing. :(

What does kernel/nstree.c do, anyway? It's a large lump of added code 
making the kernel bigger, but there's no config symbol I can switch off 
to remove it (kernel/Makefile has it in obj-y unconditionally). But 
that's modern Linux for you. Bigger and bigger...

Rob
