Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997D9429CEF
	for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 23:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.223.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784071270; cv=none; b=fnWHd5TPQGXgO/JVR5L8+DssbvyscMJSGK4ZGQdu7+DilssmRJ/qVQMEFzQ+PkUJjB+TuSvA7OGRhQjPOjlqFjhgMvkcZ1/xGk1BH6indKEzUS+CnMNxD/tHR3wKnDCByMgBaAB1usN000NuH1aZx3O0ve6Q5q+P8buPJ5vubBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784071270; c=relaxed/simple;
	bh=i9FH1uGeekjZPHgcD4PiNy2CEO+C0UhM1h9ZWVRzxp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJxX8f2d0ejxGozkfyHiWY56j+LQpn8zSH0x6jvifR6WOGDcoxLvmKjw/zBQpFYwHrX7nc8zq/R4V2xfH9xbjBAOcWomQX4EIcNH1n5IQBWlGh3ZHvzAljhfVRX/WtUjSnpG0ebwtoHisWInH0Zo7Y555kToZoJUwBEJU33/PsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=IoRCrNFi; arc=none smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="IoRCrNFi"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D2829401F8A;
	Tue, 14 Jul 2026 22:02:30 +0000 (UTC)
Received: from pdx1-sub0-mail-a237.dreamhost.com (100-103-89-63.trex-nlb.outbound.svc.cluster.local [100.103.89.63])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 6F8B04024DB;
	Tue, 14 Jul 2026 22:02:30 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Bitter-Inform: 0c245a9e1c11e889_1784066550719_1758271648
X-MC-Loop-Signature: 1784066550719:1432241806
X-MC-Ingress-Time: 1784066550718
Received: from pdx1-sub0-mail-a237.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.89.63 (trex/8.0.2);
	Tue, 14 Jul 2026 22:02:30 +0000
Received: from [192.168.88.7] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a237.dreamhost.com (Postfix) with ESMTPSA id 4h0Cw60Yx9zymf;
	Tue, 14 Jul 2026 15:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1784066550;
	bh=/geot2SBeldrASU11cPwoJGfY37oyFJvJ2xT+nfzq0c=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=IoRCrNFih7eAHZ2pohzIIiobDC/esE6UgP5b8wpXhaTKe8M0k7DWpM/9FQWgBDqm6
	 IO4ay/B2tihGLEkg1rfXa+M6aVaM7Huz4fZQkHhtuLOMQAmXn9JF+aKvZX/hPkh3/r
	 XD+BbGEFRcTGncbDReuAi/V2zEo3HsJVv8HTea2q1xY4PKv5Rt44eSSW8qBKgrYbzL
	 0kjm2iimPnqf/rMhVGKQZJsyrTtzcjmAWmzKdimjydP9mh9FllpRHUtxnQGLXxW6FE
	 Viuuu0dAcqREcjwnXsmzSQYxmw2kJLlqXuNFtEpQufEsRNAp1ei587sCKfgK7xDwGz
	 hGX3AGrreXvDQ==
Message-ID: <01f3150c-a267-4614-a558-a19767deedfb@landley.net>
Date: Tue, 14 Jul 2026 17:02:29 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
 <alXpoJOjg5HrSvhE@lithos>
 <3eeb0f60a3f133bfd3ab5467b35045c904b8a9e8.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <3eeb0f60a3f133bfd3ab5467b35045c904b8a9e8.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 03:14, John Paul Adrian Glaubitz wrote:
> Hi Florian,
> 
> On Tue, 2026-07-14 at 09:47 +0200, Florian Fuchs wrote:
>>> OK, for some reason it works now. Unfortunately, the toolchain doesn't like the current kernel:
>>>
>>>    CC      net/ipv4/inetpeer.o
>>> during RTL pass: final
>>> In file included from kernel/nstree.c:8:
>>> kernel/nstree.c: In function '__se_sys_listns':
>>> ./include/linux/syscalls.h:261:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
>>>    261 |         }                                                               \
>>>        |         ^
>>> ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
>>>    236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>>>        |         ^~~~~~~~~~~~~~~~~
>>> ./include/linux/syscalls.h:228:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>>>    228 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>>>        |                                    ^~~~~~~~~~~~~~~
>>> kernel/nstree.c:763:1: note: in expansion of macro 'SYSCALL_DEFINE4'
>>>    763 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
>>>        | ^~~~~~~~~~~~~~~
>>> Please submit a full bug report,
>>> with preprocessed source if appropriate.
>>> See <https://gcc.gnu.org/bugs/> for instructions.
>>> {standard input}: Assembler messages:
>>> {standard input}: Warning: end of file not at end of a line; newline inserted
>>> {standard input}:1592: Error: missing operand
>>> {standard input}:1592: Error: invalid operands for opcode
>>> {standard input}:976: Error: displacement to undefined symbol .L339 overflows 12-bit field
>>> {standard input}:1014: Error: displacement to undefined symbol .L459 overflows 12-bit field
>>> {standard input}:1028: Error: displacement to undefined symbol .L340 overflows 12-bit field
>>> {standard input}:1040: Error: displacement to undefined symbol .L461 overflows 12-bit field
>>> {standard input}:1060: Error: displacement to undefined symbol .L462 overflows 12-bit field
>>> {standard input}:1082: Error: displacement to undefined symbol .L463 overflows 12-bit field
>>> {standard input}:1100: Error: displacement to undefined symbol .L252 overflows 12-bit field
>>> {standard input}:1201: Error: displacement to undefined symbol .L286 overflows 12-bit field
>>> {standard input}:1211: Error: displacement to undefined symbol .L468 overflows 12-bit field
>>> {standard input}:1221: Error: displacement to undefined symbol .L298 overflows 12-bit field
>>> {standard input}:1234: Error: displacement to undefined symbol .L469 overflows 12-bit field
>>> {standard input}:1256: Error: displacement to undefined symbol .L349 overflows 12-bit field
>>> {standard input}:1341: Error: displacement to undefined symbol .L314 overflows 12-bit field
>>> {standard input}:1488: Error: displacement to undefined symbol .L454 overflows 8-bit field
>>> {standard input}:1498: Error: displacement to undefined symbol .L471 overflows 8-bit field
>>> make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
>>> make[3]: *** Waiting for unfinished jobs....
>>>
>>> Adrian
>>
>> I also crafted a bit with gcc-17, and my first issue was a duplicate
>> symbols (LPCS0) compiling libgcc like in
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89012 I could only work
>> around with explicitly using O1 instead of O2 in INTERNAL_CFLAGS of gcc.
>>
>> And errors with libbacktrace, I worked around by --enable-languages=c
>>
>> I got gcc to not ICE, but it then fails with invalid assembler thats why
>> I became suspicious about the asm in question. turns out, delcaring the
>> adresses as offsetable, seems to "fix" the ICE and compile and work for
>> fdpic, means it is maybe not necessarily only a GCC issue.
>>
>> diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
>> index 5d7ddc092afd..cef40414bfb1 100644
>> --- a/arch/sh/include/asm/uaccess_32.h
>> +++ b/arch/sh/include/asm/uaccess_32.h
>> @@ -92,7 +92,7 @@ __asm__ __volatile__( \
>>   	".long	1b + 2, 3b\n\t" \
>>   	".previous" \
>>   	:"=&r" (err), "=&r" (x) \
>> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>> +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>>   #else
>>   #define __get_user_u64(x, addr, err) \
>>   ({ \
>> @@ -116,7 +116,7 @@ __asm__ __volatile__( \
>>   	".long	1b + 2, 3b\n\t" \
>>   	".previous" \
>>   	:"=&r" (err), "=&r" (x) \
>> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>> +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })
>>   #endif
>>   
>>   #define __put_user_size(x,ptr,size,retval)		\
>> @@ -196,7 +196,7 @@ __asm__ __volatile__( \
>>   	".long	1b, 3b\n\t" \
>>   	".previous" \
>>   	: "=r" (retval) \
>> -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>> +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>>           : "memory"); })
>>   #else
>>   #define __put_user_u64(val,addr,retval) \
>> @@ -218,7 +218,7 @@ __asm__ __volatile__( \
>>   	".long	1b, 3b\n\t" \
>>   	".previous" \
>>   	: "=r" (retval) \
>> -	: "r" (val), "m" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>> +	: "r" (val), "o" (__m(addr)), "i" (-EFAULT), "0" (retval) \
>>           : "memory"); })
>>   #endif
>>   
> 
> Thanks a lot for looking into this, I appreciate the help!
> 
> Did you manage to build a J2 toolchain using GCC 17? I have not looked
> into it myself yet due to time constraints, but I would like to switch
> to a newer compiler to build test kernels for my J2.

In theory you can just build an sh2eb-unknown-muslfdpic toolchain 
_without_ specifying --with-cpu=mj2 since j2 is backwards compatible 
with sh2 and the j2 patches mostly just add things like the more 
efficient sh3 shift instruction.

In practice, the first j2 kernel patch we submitted didn't use the 
assembly mnemonic for the cmpxchg instruction (the cas.l stuff in 
arch/sh/include/asm) but instead hardwired in the machine code bytes to 
emit it so the existing gcc/binutils could build it. Alas the kernel 
guys didn't like that, so we started using the cas.l mnemonic the 
vanilla toolchains still doesn't understand, meaning you'll need at 
least the HARD_CAS parts of the patches. Plus I believe there are other 
fdpic bugs that the arm guys introduced, so here's Rich Felker's patch 
stack for gcc-15.1 and binutils-2.44:

https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.44/0001-j2.diff
https://github.com/richfelker/musl-cross-make/blob/master/patches/binutils-2.44/0002-sh-fdpic-pr31619.diff

https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-15.1.0/0003-j2.diff
https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-15.1.0/0007-fdpic-unwind.diff
https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-15.1.0/0008-fdpic-crtstuff-pr114158.diff
https://github.com/richfelker/musl-cross-make/blob/master/patches/gcc-15.1.0/0009-sh-fdpic-pr114641.diff

Rob
