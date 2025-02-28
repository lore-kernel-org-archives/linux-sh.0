Received: from chameleon.ash.relay.mailchannels.net (chameleon.ash.relay.mailchannels.net [23.83.222.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6692A101C8;
	Sat,  1 Mar 2025 01:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793660; cv=pass; b=XtXJSYxWRXdPXHgn71lZ/7cqJDU0S2c3pUGzVA+ekonYp4LwMqv1+wGp3KiZq9dtLR3uhmGfXR+9ptu78T5OKKL38Uscphpv0NXHrQQoath1EYxJPjX5DyIZ1YXGWhKDsqdSWcqirnnkGILkIwgER0hXWXlgemavR0BXgSn2H/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793660; c=relaxed/simple;
	bh=9fNC/TSXGeRCJeu4GxrTuGuZUj4kYPFMrLufRw4n5OY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pTnDEptkppgJKa7r8nyjkhcHBYiomX25fgrufrHJpv3qpfxWon8oIPn72VZkcFHzHNp9e4YE5mu5qfLrtaTZjXOKn2H4XZDYijkKiVnFEITklZ02bPOocAN1tB53HAfH1s8TiONDH4qcDkT0SC+jhDd/BMYR6HDX+GAD9NSYjTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=N5fsOeJH; arc=pass smtp.client-ip=23.83.222.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="N5fsOeJH"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 4A2D232135D;
	Fri, 28 Feb 2025 22:19:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a202.dreamhost.com (trex-5.trex.outbound.svc.cluster.local [100.104.191.118])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AD380321A3F;
	Fri, 28 Feb 2025 22:19:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740781154; a=rsa-sha256;
	cv=none;
	b=BCGEzvIWQPpjxslxQuy9oRccz33nICueK5+EfszIs+VM9KKknQjsTh5Wmz6boRyaUyFCD8
	4ZllSQi+THfh8nL2kRefnzHWjPJP0O4u2S/w79MEnLf4xcayDZUrdeUz5MCtBuDiTz/JeQ
	ymMU74PmL4jn9lN+QA9Mx03tw+qwJ8qMY16ikWGUQAOpi5A44VeC7UZSXyBIZH3ZNzjhXI
	4sj3HoFQWo2Kfx2f5jW1LwF0zb4gsUjCHaumjwCTyBrHkPF+7Q4ZoyFx16RY8MAzMUEFcn
	nXTGs+W9BEZ6myc5ulw7/k6vLV4dOUN7aTyIStY2XJ+08ioG4VIy3XSEBJQ/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740781154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PzlTgRr9Vo0BLTv0WNL2DnLn4rYUWOQKuKEVykzfUFI=;
	b=wUYoqJY3zAbyLLpB4SELmy219TE8Bk9d6FYwDBPYJhrJnspJ7o/KojsH4Xzj+iulhOmdZT
	6SfnIZcIktxIG0M8wgN5giKEEcs+hxTCsuIf+VHjCL1pBRYBQ918yyizsPo/QJIBxeLwRz
	4dJOdqV/bBltgQ0szBbSbwLIgA1K5cvdIlgVfrw12dEWrs97+WLbXGaLv5EoDJHbPG24dC
	+scTKRKtNtaG+PNQajhmn9cmMKI+NUksiiEXgfmjgU+JjqjL1tiZe0db3efVDFi+FXaKXW
	xJzSCER1BhAFHvBfhqmZKfYTXLKhw2GWewUHoSCAGUNiYK3a6k25NXVVfExxJg==
ARC-Authentication-Results: i=1;
	rspamd-58748c789d-cwdgv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Madly-Ski: 792fe26e66da1dbe_1740781154993_3018745810
X-MC-Loop-Signature: 1740781154993:1433236021
X-MC-Ingress-Time: 1740781154993
Received: from pdx1-sub0-mail-a202.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.191.118 (trex/7.0.2);
	Fri, 28 Feb 2025 22:19:14 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a202.dreamhost.com (Postfix) with ESMTPSA id 4Z4N0d4JR0zBQ;
	Fri, 28 Feb 2025 14:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1740781154;
	bh=PzlTgRr9Vo0BLTv0WNL2DnLn4rYUWOQKuKEVykzfUFI=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=N5fsOeJHftCZu+LfgdR2UNMcSwDEVh6d3Hf/OQgibSx22nfaaDJRSuYrt/xlIIz6w
	 uwNlubKZ0Nmj2Gqjj/+zhK8E0NKURR/tCPS1G4sDkw5RRLMzUhjNs05o7o2aMZIRdI
	 58+MDIU6G7SFDpKYog1163aZALQKlxDXQTaXR6UywjuyyIaGuSIo4yVLZFE5Zge8PI
	 kmjQEVuuV1DeGltROBzu49NOCdA9QvaFrSsV8RT2tUqLQB/ZDVht3ht8gaN5S4a0BK
	 964nJRt6JAEwtusN7eLkNykb4XJtm13XhXszd0SGsNwv61ymo1xDUAg57uBqLUlmAe
	 +0GnCjlVKfrTA==
Message-ID: <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
Date: Fri, 28 Feb 2025 16:19:12 -0600
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] J2 Turtle Board fixes
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Artur Rojek <contact@artur-rojek.eu>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Uros Bizjak <ubizjak@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 "D . Jeff Dionne" <jeff@coresemi.io>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250216175545.35079-1-contact@artur-rojek.eu>
 <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
 <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
 <48881e2d8efa9d7df8156f5f81cd662c2286e597.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <48881e2d8efa9d7df8156f5f81cd662c2286e597.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 02:34, John Paul Adrian Glaubitz wrote:
> Hi Rob,
> 
> On Thu, 2025-02-27 at 21:03 -0600, Rob Landley wrote:
>> On 2/27/25 01:52, John Paul Adrian Glaubitz wrote:
>>> Hi Artur,
>>>
>>> On Sun, 2025-02-16 at 18:55 +0100, Artur Rojek wrote:
>>>> this series fixes boot issues and allows J2 Turtle Board to boot
>>>> upstream Linux again.
>>>>
>>>> Patch [1/2] enforces 8-byte alignment for the dtb offset.
>>>>
>>>> Patch [2/2] resolves a problem with PIT interrupts failing to register.
>>>
>>> I can confirm that this series makes my J2 Turtle Board boot again!
>>>
>>>> Even with the above fixes, Turtle Board is prone to occasional freezes
>>>> related to clock source transition from periodic to hrtimers. I however
>>>> decided to send those two patches ahead and debug the third issue at a
>>>> later time.
>>>
>>> Yep, it just got stuck for me right after these messages at my first boot attempt:
>>>
>>> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
>>> futex hash table entries: 512 (order: 1, 8192 bytes, linear)
>>> NET: Registered PF_NETLINK/PF_ROUTE protocol family
>>> clocksource: Switched to clocksource jcore_pit_cs
>>>
>>> It boots past these messages on second attempt, although it's now stuck trying to start
>>> /init. However, it's still echoing <RETURN> strokes, so it might be an issue with Toybox.
>>
>> Which was fixed a year ago, which is why I told you to use the new
>> toolchain with a current musl-libc:
>>
>> http://lists.landley.net/pipermail/toybox-landley.net/2024-February/030040.html
>>
>> Unless you're hitting the OTHER issue I fixed last year...
>>
>> https://github.com/landley/toybox/commit/0b2d5c2bb3f1
> 
> I just downloaded the latest toolchain from:
> 
> https://landley.net/bin/toolchains/latest/sh2eb-linux-muslfdpic-cross.tar.xz
> 
> and the issue still persists.
> 
> Am I missing anything?

The march 2024 rebuild was in response to that Feb 2024 bugfix, so it 
_should_ have the fix? (I'm waiting for another musl release to rebuild 
them again...)

I just downloaded the toolchain currently at that URL and built mkroot 
and it worked for me:

Run /init as init process
sntp: time.google.com:123: Try again
Type exit when done.
$ cat /proc/version
Linux version 6.14.0-rc3 (landley@driftwood) (sh2eb-linux-muslfdpic-cc 
(GCC) 11.2.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Fri Feb 28 15:47:36 
CST 2025

And the failure _without_ the fix was deterministic rather than 
intermittent, so...

Keep in mind the init script has a 3 second timeout trying to call sntp 
to set the clock, which will fail if the ethernet isn't connected (or no 
driver, or no internet...)

Rob

P.S. Speaking of intermittent, I hit that hang after "clocksource: 
Switched to clocksource jcore_pit_cs" on one attempt just now. I should 
sit down with the engineers next time I'm in japan and try to root cause 
it. The scheduler fires reliably, so it's _probably_ not a hardware 
issue? We've had Linux uptime of over a year, not just idle but running 
an energy monitoring app, so it's pretty stable in our systems...
