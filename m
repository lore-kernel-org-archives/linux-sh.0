Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E05265CD9
	for <linux-sh@vger.kernel.org>; Fri,  1 May 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777658679; cv=pass; b=scG8D8K2Img4wo45PGxZJ6EGEbvfGoody0FjmFdN1qx6R5sd6tX0tUBaLa993bdcnH7FiDPVLnFi2UJJv9QGzHzTOcwz1d74Ow4RgIeTbl5z9I7RZwP1q434I5Ze8ywrAJamv/nU+817aw2KeMRzt50KYId9LdwPqNiOtxRdRNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777658679; c=relaxed/simple;
	bh=3RTezStBBLZ9pzEwOM/vk1OzJreiLap8HLp4z4RKuQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DzBkSoBlo9gFHbDBu+R0G4aYYRBLWsctVwS/4NPjZ9ZLW8bFhFIpBcrJfCWfQlmZY2by060j8jY9RYTe2mscd8NZxXNdnaCyP4QuQ7VEIcdFilzEMTKULAfMoNpj4e2yuPsiS9hDJnASM4FBBAsm4DmMa4emTaR5BJfE1IZN3+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=PqH53+GR; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="PqH53+GR"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3E15472201F;
	Fri, 01 May 2026 18:04:31 +0000 (UTC)
Received: from pdx1-sub0-mail-a255.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.97.143.63])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id D10F9720177;
	Fri, 01 May 2026 18:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777658670;
	b=uqwfeiU63oCwRYkz636WFI+TESlE2X9MGSfmpHyoGh9C237xyNl8MEKlp18KwdhcHSKfyf
	Wr4t6YGU/EXbQkUdM2YA6U9j3gAgVNfZMd08y9Au/a3/8W9GFfGByZquj3v0lbIeKUuaUW
	9usipFj/GJfkM2/3VFXQ0ieiP8QVwuGKEJP5eA5EAz3239Kby0r7/OgO3KAfjL8WKBHoaq
	e/5Za0YMjzDYxFpT0/9ABdgkasfOpRucy0ZXoMU2npdo3/WHIKFC4+iKVH8QD/oQietAfn
	oVCfGRRSf1vEqlpIHWe27h4VnPYRM3tiwCumGQpdEkmQLl9DmOEJgsSs3VB4Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777658670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=WfCieV7m5E9IemRJw8xUqjZeq1rGCYd+mzQ2dkcE+z4=;
	b=DR7unHkcP1YeA8afCkWj7QeqyFHFYUZ1n1m66a2fTfNRQJm5pmXEc61LBNl5EBuTyBidJX
	TZuExN+R8ALAPyu7eM36P8FiH2wth4Rs58I3xsTEtRbObkHpNf9WTsh/JyLtx5F+YNntPv
	jymvqQMJo1bLvuZ2+dSsJgGdYV07MVDohWyJEwFQSkrXTPod23KD7/t7EYxYX8dul0ubJc
	3vRzVA9xOPRsiXl5GFpCT031ksULBJpKjhXDx4zXsZJP+TFI1MVqwoTsAkz1uek6zoXz23
	KAb71/zOBIelDeKYYRczgY1bi+0vpEydcFtXMJ1J7dIFLDxQCkc02uW3G8MsKg==
ARC-Authentication-Results: i=1;
	rspamd-859c89884f-zjqjg;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Ski-Snatch: 6e6aef7c670cd201_1777658671068_1404242813
X-MC-Loop-Signature: 1777658671068:829707760
X-MC-Ingress-Time: 1777658671067
Received: from pdx1-sub0-mail-a255.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.143.63 (trex/7.1.5);
	Fri, 01 May 2026 18:04:31 +0000
Received: from [192.168.14.157] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a255.dreamhost.com (Postfix) with ESMTPSA id 4g6f7f2yltz106w;
	Fri,  1 May 2026 11:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1777658670;
	bh=WfCieV7m5E9IemRJw8xUqjZeq1rGCYd+mzQ2dkcE+z4=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=PqH53+GRbuGFIXd/KB4nWrLuKCOc+kAsrT1KqawisRTApXDBV6vVQevphDcyULjXU
	 C4L+Zoyl6v+l4lee2sD/bsVpzWEjvVbAC6GGSAHISiTlKvE1a6tTkhpMSx2Fym8YT3
	 J5RCFWOYbNVWJhNEVe4PpXCvNWpCYPCBj2d0OZu9BEGEwkPJd7LZOlotf9GMkNzAqf
	 Etnxjdn8bT7nHRoaxQ2z/j3ejGDQ7hed3KAtbq89Lvbn1LvrlPEaA3ygILCxwrhwXw
	 a1WfN8j6YbMgrR3ZgGgdtYEcLTeyFvpdKAwX9TkEnzp3emSeRHsRmTeqWQ0jNp7FtS
	 gDAoSRr0ZDLrQ==
Message-ID: <406357ed-1984-41a3-9b29-5cd8bbae29be@landley.net>
Date: Fri, 1 May 2026 13:04:29 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/30/26 01:57, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Wed, 2026-04-29 at 09:46 +0200, John Paul Adrian Glaubitz wrote:
>> I'm trying to build a new root image after updating Toybox but that no longer works:
>>
>> glaubitz@node54:/data/home/glaubitz/toybox> make root CROSS=sh2eb-linux-muslfdpic- LINUX=/data/home/glaubitz/sh-linux
>> mkroot/mkroot.sh  -- LINUX=/data/home/glaubitz/sh-linux CROSS=sh2eb-linux-muslfdpic-
>> No ccc symlink to compiler directory.
>> make: *** [Makefile:108: root] Error 1
>> glaubitz@node54:/data/home/glaubitz/toybox>
>>
>> It asks me to create a "ccc" symlink but I have no clue where that link is supposed
>> to point to. The FAQ says the link is supposed to »pointing at a directory full of
>> cross compilers« but I don't have that and that's not my personal setup. I have the
>> cross compilers installed in my home directory and their bin directories added to
>> the PATH variable which has always worked in the past without any problems.
>>
>> Can you explain how that "ccc" symlink works?
> 
> OK, for some reason it works now. Unfortunately, the toolchain doesn't like the current kernel:

The last one I tested was 6.17. I keep meaning to poke at newer but if 
the OS age discrimination stuff takes effect without anybody but me 
fighting back, I'm out.

(Government permission required to reinstall your own devices, with 
$7500 fines per download if you dare post a noncompliant image, modeled 
on texas abortion bounties? That is not a "fun hobby" to participate in. 
China can supply us operating systems along with the hardware. But that 
is Gavin "spyware" Newsom's current law going into effect Jan 1, which I 
100% expect to get wired up to Palantir's Persona/Clear and UEFI Secure 
Boot as soon as this round gets appealed to and re-approved by the 
Roberts supreme court. Because people anonymously organizing against ICE 
via signal made the billionaires uncomfortable.)

>    CC      net/ipv4/inetpeer.o
> during RTL pass: final
> In file included from kernel/nstree.c:8:
> kernel/nstree.c: In function '__se_sys_listns':
> ./include/linux/syscalls.h:261:9: internal compiler error: in change_address_1, at emit-rtl.c:2275
>    261 |         }                                                               \
>        |         ^
> ./include/linux/syscalls.h:236:9: note: in expansion of macro '__SYSCALL_DEFINEx'
>    236 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>        |         ^~~~~~~~~~~~~~~~~
> ./include/linux/syscalls.h:228:36: note: in expansion of macro 'SYSCALL_DEFINEx'
>    228 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
>        |                                    ^~~~~~~~~~~~~~~
> kernel/nstree.c:763:1: note: in expansion of macro 'SYSCALL_DEFINE4'
>    763 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
>        | ^~~~~~~~~~~~~~~
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <https://gcc.gnu.org/bugs/> for instructions.
> {standard input}: Assembler messages:
> {standard input}: Warning: end of file not at end of a line; newline inserted
> {standard input}:1592: Error: missing operand
> {standard input}:1592: Error: invalid operands for opcode
> {standard input}:976: Error: displacement to undefined symbol .L339 overflows 12-bit field
> {standard input}:1014: Error: displacement to undefined symbol .L459 overflows 12-bit field
> {standard input}:1028: Error: displacement to undefined symbol .L340 overflows 12-bit field
> {standard input}:1040: Error: displacement to undefined symbol .L461 overflows 12-bit field
> {standard input}:1060: Error: displacement to undefined symbol .L462 overflows 12-bit field
> {standard input}:1082: Error: displacement to undefined symbol .L463 overflows 12-bit field
> {standard input}:1100: Error: displacement to undefined symbol .L252 overflows 12-bit field
> {standard input}:1201: Error: displacement to undefined symbol .L286 overflows 12-bit field
> {standard input}:1211: Error: displacement to undefined symbol .L468 overflows 12-bit field
> {standard input}:1221: Error: displacement to undefined symbol .L298 overflows 12-bit field
> {standard input}:1234: Error: displacement to undefined symbol .L469 overflows 12-bit field
> {standard input}:1256: Error: displacement to undefined symbol .L349 overflows 12-bit field
> {standard input}:1341: Error: displacement to undefined symbol .L314 overflows 12-bit field
> {standard input}:1488: Error: displacement to undefined symbol .L454 overflows 8-bit field
> {standard input}:1498: Error: displacement to undefined symbol .L471 overflows 8-bit field
> make[3]: *** [scripts/Makefile.build:289: kernel/nstree.o] Error 1
> make[3]: *** Waiting for unfinished jobs....

You can always bisect that sort of thing to a specific commit, which 
then doesn't always need a root cause or proper fix to avoid 
_triggering_ the problem that didn't used to trigger.

You don't even need mkroot to do it, on most targets the initramfs is 
external (qemu -initrd option) rather than static, and even when it's 
static you can build it ahead of time and feed it in from a fixed 
location. (And almost never need to because about the only thing that 
would change at compile time is offsets, and overflows are RELATIVE 
offsets with a translation unit not long jumps between units. Module 
that --whole-tree stuff which I didn't think the kernel was using 
because it would make module support a huge pain?)

I _think_ I built 7.0 when it came out and it at least compiled for sh4? 
So probably something since then. (Sigh, I should cut a toybox release 
before 
https://osselcna2026.sched.com/event/2JQxw/building-the-simplest-possible-linux-system-rob-landley-hobbyist?iframe=no 
just so I'm providing the simplest explanation, which means I should 
ship 7.0 binaries. Seems kinda pointless if I have to delete it all 
before new year's, but I committed to giving the talk...)

> Adrian

Rob
