Received: from poodle.tulip.relay.mailchannels.net (poodle.tulip.relay.mailchannels.net [23.83.218.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F33603E8
	for <linux-sh@vger.kernel.org>; Mon, 11 May 2026 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.249
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778540925; cv=pass; b=lloKsp3a3LuMPoVEFguh32csVXN9z7hWpUTV5goVfT25S2xEoiuOSexKxbROsQNvINO0Vofhwq9b7HJc1WZXYcOzVa7tZdxBtwE6IQ7rJo9DvEpWnL3N88MsnngLG+g9QVnr1VPdG6EV/uUwG/AHmb4BH54O/g9eQKkjCCp0+Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778540925; c=relaxed/simple;
	bh=wQRZ9Hg4sgc4HOgEaxjiIJuoGmjm4aNmT6KXC3Bfhh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2FbNxEN4AxwMz/LkJ3XHKiokbhJubfgujfaF5VCa/OkqZ4YCMnyqkNkDQnG6p3zmMStnBhbrgExqLlthFhDsNSenUI33hEaxDa0uld5upRm5ldLMYayEKU2illDegyFfMkD9X4KdRsfP7tPiXz4Oicu5LwxRFIM6pTPyIm5JCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=Ly2hcNu1; arc=pass smtp.client-ip=23.83.218.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="Ly2hcNu1"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 88D67460C6F;
	Mon, 11 May 2026 23:08:37 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (100-102-214-146.trex-nlb.outbound.svc.cluster.local [100.102.214.146])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C2C7E4609D2;
	Mon, 11 May 2026 23:08:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1778540915;
	b=sbx85CNyy/SjgpAycEP0C/s/5O2jBGvT8zhNO950yqNSsqPuQ3y3Ld/lsdM7UTiUdMNhaY
	gO11mSgRwxNY8/ZQAJ9gOEP4Q4ggvQj7Qx/pqP3y91jyXJkAG46iCVsB9HPit3BqLsh6Ta
	tZv8TyMGUlJO4CmGrv0paCmD5b5u37wwcGnIINMBiqNjeUkNHxW9TuQ4PHaliHd/u6UNag
	CBsAPVpmK7HhzNFfIUHlJwqS/oJukd8qDB7xsPtP2ARw+6e0+TsH4/1uh3KOPUQ7qumlSS
	2V57jAUtVfX+YUr1AYyWlz/wlvxJXCa8q8a4i42dhQLmX/x3Ft/kAAZmuvW91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1778540915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Vzj58Io5dDEVZewLIHDcLGWYt8Uz13WjMunjokKNCw4=;
	b=6q9P9y5UIJ6Dti9LV8Ks981i1NkWOTLggo+6fy1AtsEW0FFxL29IMVxI/pgRKs/W3WNCDd
	0OWGLiiegRtdyGVord7CVO+edrxj++/Al1dXmULiPTFLLGxr+eyj4VPw1Z6ljqz7QclVWe
	rPXVfp4q4a5xG5Yhj+rs2nlKhtFsTogqJdH4EtqqKWBKYe5NIOgw+YB4MDZrO1r9ioFHvU
	mEH/5i0dU9OKV0HoWdv+fz2r1n/2tWXX6VMLEG3vyUK04vomDfkFJfYZfUSsgH21mvmZQg
	xX9P+2HQUyvF47/3exv87mujuJp95fckWlsNi6WjaSBb72bUfBybELy1c+IZ4w==
ARC-Authentication-Results: i=1;
	rspamd-79cfc4d687-wndn7;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Shade: 7df815885e6b932b_1778540917392_3000421594
X-MC-Loop-Signature: 1778540917392:3424631024
X-MC-Ingress-Time: 1778540917390
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.102.214.146 (trex/7.1.5);
	Mon, 11 May 2026 23:08:36 +0000
Received: from [192.168.14.157] (unknown [209.81.127.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4gDwPv1phzz106S;
	Mon, 11 May 2026 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1778540915;
	bh=Vzj58Io5dDEVZewLIHDcLGWYt8Uz13WjMunjokKNCw4=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=Ly2hcNu1nJqxcSiCkN4BpsSBRW1ddRb+Ocuer6fPQa8emA+4Ot8dqffDCrKPLeIqL
	 MFUVC+vnI/citUkM59Xj9B61bN4pJzQ5wuhXO91d145CCcJiodDiJL/8xZ+PzxOcVo
	 Cp3nHSzlbaoHHfCv784oOf93JjN6HExz/Bh7/g+wbW6WSkMkUNfsfVv1/Gsb63n8FP
	 bHpAV0Ixmv2dYFplD21h5cjTtB73AMmq6UIktaFsEW49rbamFujHYR0Ne04SBWVAKB
	 Y8M3jTLpyGXzUE0rX/geZKPkkFUiTW7UyMbSmHMmz73I2eyH/+d4eNzm5/bEAqMSlG
	 1O5N45jHorT6g==
Message-ID: <ef22a5de-d945-4080-9f4a-f5a1ab9de1dc@landley.net>
Date: Mon, 11 May 2026 18:08:34 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
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
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <6bd93131318b8e78d49fdc5f3e5fecc053f9c046.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/26 01:55, John Paul Adrian Glaubitz wrote:
> On Fri, 2026-05-01 at 16:27 -0500, Rob Landley wrote:
>>> What about the patches for J2 support? And can it work with a GCC git tree like [1]?
>>
>> They're in musl-cross-make.
...
> Hmm, sounds like a bit too much to be able to do that in a short time now
> in order to be able to test the kernel patch. I guess I will merge the patch
> now anyways and send it to Linus unless someone else has done that already
> anyway.

The first commit that broke the build was 76b6f5dfb3fd adding the listns 
syscall to kernel/nstree.c which then goes:

during RTL pass: final
In file included from kernel/nstree.c:8:
kernel/nstree.c: In function '__se_sys_listns':
./include/linux/syscalls.h:262:9: internal compiler error: in 
change_address_1, at emit-rtl.c:2275
   262 |         } 
         \
       |         ^
./include/linux/syscalls.h:237:9: note: in expansion of macro 
'__SYSCALL_DEFINEx'
   237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
       |         ^~~~~~~~~~~~~~~~~
./include/linux/syscalls.h:229:36: note: in expansion of macro 
'SYSCALL_DEFINEx'
   229 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, 
__VA_ARGS__)
       |                                    ^~~~~~~~~~~~~~~
kernel/nstree.c:729:1: note: in expansion of macro 'SYSCALL_DEFINE4'
   729 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,
       | ^~~~~~~~~~~~~~~
Please submit a full bug report,
with preprocessed source if appropriate.
See <https://gcc.gnu.org/bugs/> for instructions.
{standard input}: Assembler messages:
{standard input}: Warning: end of file not at end of a line; newline 
inserted
{standard input}:1640: Error: missing operand
{standard input}:1640: Error: invalid operands for opcode
{standard input}:1075: Error: displacement to undefined symbol .L375 
overflows 12-bit field
{standard input}:1113: Error: displacement to undefined symbol .L491 
overflows 12-bit field
{standard input}:1127: Error: displacement to undefined symbol .L376 
overflows 12-bit field
{standard input}:1139: Error: displacement to undefined symbol .L493 
overflows 12-bit field
{standard input}:1173: Error: displacement to undefined symbol .L494 
overflows 12-bit field
{standard input}:1186: Error: displacement to undefined symbol .L286 
overflows 12-bit field
{standard input}:1286: Error: displacement to undefined symbol .L320 
overflows 12-bit field
{standard input}:1300: Error: displacement to undefined symbol .L656 
overflows 12-bit field
{standard input}:1313: Error: displacement to undefined symbol .L499 
overflows 12-bit field
{standard input}:1334: Error: displacement to undefined symbol .L384 
overflows 12-bit field
{standard input}:1359: Error: displacement to undefined symbol .L365 
overflows 12-bit field
{standard input}:1391: Error: displacement to undefined symbol .L385 
overflows 12-bit field
{standard input}:1397: Error: displacement to undefined symbol .L500 
overflows 12-bit field
{standard input}:1409: Error: displacement to undefined symbol .L386 
overflows 12-bit field
{standard input}:1452: Error: displacement to undefined symbol .L346 
overflows 12-bit field
{standard input}:1609: Error: pcrel too far
{standard input}:1611: Error: pcrel too far
{standard input}:1619: Error: pcrel too far
{standard input}:1620: Error: pcrel too far
make[3]: *** [scripts/Makefile.build:287: kernel/nstree.o] Error 1

The end of line not at end of file, missing operand, and invalid 
operands for opcode seem relevant, and the fact it's happening in the 
middle of a nested macro expansion implies that the code being fed into 
the actual compiler plumbing may be nuts here, but I'd have to cc -E and 
then cc -S the result to see what actually happens.

I'm not yet convinced the compiler is WRONG, it may just be missing some 
error checking so it's responding to bad input with shrapnel instead of 
a coherent error message.

Rob
