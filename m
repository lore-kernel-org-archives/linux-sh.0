Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3163101B0
	for <linux-sh@vger.kernel.org>; Tue, 14 Jul 2026 19:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057588; cv=none; b=LR9zGhZVPUNsFnR/Zu0LIdXUKIBEiIAKufIn/uTcsWuCGMOTNXT8mD/hlQ9z1eUujWrmpuVs/QLf9mr1GHtsETOqn7G3l2m+FIJN9XSKHaXLF4+ShIUUbAA9wd5Z3RyNV8R5QhftRpZ4WKlv0nIjjChLai6xFdE5Az18x2oIy/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057588; c=relaxed/simple;
	bh=rO3I1EUeGiAkqPV0trsEcnvx8GCSqMIqb+Pk754JRnY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUttFI3nFmZIg9r7UvCWP/XqG/agLNhVgZxQV8xiU1zGMidfk900JPGS0PTPeErW8NueXIGtla7Q2oRFAivL9ykZy6Tu7fAk9bLzR0Li0syqWk6fXhIvYVlRIH/8l41OUStM+nE0kIgdoaoJCxlNQw5mLajuKWCODNTIsADBAFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=PCWCTvWh; arc=none smtp.client-ip=23.83.209.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="PCWCTvWh"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 1B5A1941462;
	Tue, 14 Jul 2026 19:33:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (100-104-241-122.trex-nlb.outbound.svc.cluster.local [100.104.241.122])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B1CDD941421;
	Tue, 14 Jul 2026 19:32:57 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Spill-Whistle: 47cd77b50c36352a_1784057579975_202022998
X-MC-Loop-Signature: 1784057579975:704993602
X-MC-Ingress-Time: 1784057579974
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.241.122 (trex/8.0.2);
	Tue, 14 Jul 2026 19:32:59 +0000
Received: from [IPV6:2607:fb91:bef:8c2b:d490:67df:fdc5:d864] (unknown [172.56.10.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4h08bY1Nkyz104k;
	Tue, 14 Jul 2026 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1784057577;
	bh=Zb7VM6q2ffT8IIKkyO12mSRbNp64dh1jrlGf0BT3S7Y=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=PCWCTvWhyy4b81vybPgT/78/ar0GTSDvfQyt6tQL812+8jEGSJBra6q+9NDMJ7m6Y
	 nffWwBEP+hA9f+GVbL/ksxP4CQa93WyrjV7GsR3cSw3E2ZLC9ZOo7uZBYDGp8ExtEM
	 dsVcFZXvIiP/7jkpCNHQsF3oKIFN/iOpk21OiklcnGoInJqnN3Q1AAPnXwBa6S9iND
	 wUrRK7pEWcIqvvNDXIJ5TZgSVNt/7vKnTwApSyP075Stxj1htOJ5bjHXOMvrqCSpP9
	 xit1j6wxb9/i+fLeCRtS0LmgNC0vGkK38VSPNmaUpybF7lQpbRlogw74HwigNMk5vv
	 lvH0V+nKoG/VA==
Message-ID: <e67d3f91-aa6e-43b1-815c-4ddf35751ddd@landley.net>
Date: Tue, 14 Jul 2026 14:32:55 -0500
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Toybox make root no longer works as expected
To: Florian Fuchs <fuchsfl@gmail.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh <linux-sh@vger.kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
References: <359d107fd9fe92a55e77be84c26d9ac86112fe13.camel@physik.fu-berlin.de>
 <71c6a925c748fb3c9c2af30362387f0e562c0f6f.camel@physik.fu-berlin.de>
 <alXpoJOjg5HrSvhE@lithos>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <alXpoJOjg5HrSvhE@lithos>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/26 02:47, Florian Fuchs wrote:
> I also crafted a bit with gcc-17, and my first issue was a duplicate
> symbols (LPCS0) compiling libgcc like in
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=89012 I could only work
> around with explicitly using O1 instead of O2 in INTERNAL_CFLAGS of gcc.

My notes say GCC commit 551935d11817 introduced that failure. Dunno why, 
it's big. The two largest chunks of it are:

  gcc/gimple-harden-control-flow.cc       | 1488 ++++++++++
  libgcc/hardcfr.c                        |  300 ++

> And errors with libbacktrace, I worked around by --enable-languages=c

I hadn't even made it to that yet...

> I got gcc to not ICE, but it then fails with invalid assembler thats why
> I became suspicious about the asm in question.

Yes, I'd found that failing kernel file, ran it through gcc -E to get a 
standalone one, and then tried to compile it with the sh4eb compiler 
(rather than sh2eb) and got the same ICE. Jeff immediately suspected it 
was sh2 #ifdefs in arch/sh/include but unfortunately my usual attempts 
to strip down the test case failed because if you remove much the ICE 
failed to happen (since it's a jump-too-far thing). It's GOTTA be big.

The commit that introduced the behavior is, of course, adding tens of 
kilobytes of new code to the linux kernel in a syscall you can't 
configure out, because linux-kernel. (Play the katamari damacy theme.)

https://github.com/torvalds/linux/commit/76b6f5dfb3fd

> turns out, delcaring the
> adresses as offsetable, seems to "fix" the ICE and compile and work for
> fdpic, means it is maybe not necessarily only a GCC issue.

The gcc issue is terrible error reporting. The assembler swallows some 
assembly inline statements that don't work in context and barfs because 
"that jump can't make it to that label", then can't properly report the 
error back up the stack as anything other than "bad thing happened deep 
in the bowels of the gnu/hairball that RMS explicitly tied together 
because he didn't want people to use gcc's frontend to develop a new 
backend like llvm literally did anyway, ia ia gnu/Stallman ftaghn".

Seriously, the ICE even happened running "gcc -S" so I couldn't look at 
the assembly output it was telling me about. It complained about error 
on assembly line blah but DIDN'T FLUSH THAT ASSEMBLY TO THE OUTPUT 
BEFORE DYING. Grrr. Maybe a missing fflush(0) in the error exit path?

> diff --git a/arch/sh/include/asm/uaccess_32.h b/arch/sh/include/asm/uaccess_32.h
> index 5d7ddc092afd..cef40414bfb1 100644
> --- a/arch/sh/include/asm/uaccess_32.h
> +++ b/arch/sh/include/asm/uaccess_32.h
> @@ -92,7 +92,7 @@ __asm__ __volatile__( \
>   	".long	1b + 2, 3b\n\t" \
>   	".previous" \
>   	:"=&r" (err), "=&r" (x) \
> -	:"m" (__m(addr)), "i" (-EFAULT), "0" (err)); })
> +	:"o" (__m(addr)), "i" (-EFAULT), "0" (err)); })

These are probably actually the correct fix, not a workaround, and maybe 
should get pushed to Linus. (With a commit message referencing how linux 
commit 76b6f5dfb3fd added so much unconditional new code to a single 
translation unit (which could not be disabled by a config symbol) that 
the jump couldn't span it and had to be promoted to a larger type, and 
gcc gave a terrible error message that slowed us down fixing it.)

Rob

P.S. Jeff apologized over Signal: he's caught some sort of flu/covid and 
is offline for a few days.
