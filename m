Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E01E322E;
	Fri, 28 Feb 2025 03:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740711833; cv=pass; b=Iqp09wivY3bD1tKrax19fTSVE044nxKZmF5a4uLa1WS1bXQTXKn6D1PPm2w/FAvPsjndG+gUT+Ms2zDIfctwKpFwEfYKpxiaTXXi4UavdBfb0pRVW3W0YYEhWHhc5Za9+X768oe7JiNgO6teiwkaQPKfzmaz5xTLE8/RCCBuS3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740711833; c=relaxed/simple;
	bh=OUq4isnhzdB1iaFzesSlcbQnccaph3ySIlDqZNqIPhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Igh3kj9k0CuiX2LV9VAa2wQCVllORq25JCzqdrHg6fX3WTAhevfcpLyJIPG6w/ucC1bztxt2DLargMmNtGPZPtVGjmMPJKWVpzEcUU/ojTMh4mk5tEXIrYQ/+loEYvIV3SThwv0ouR8jh4Xsjx6y7bUcjOIHsO3osrF0rB9qfR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=Aa4PTkjQ; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="Aa4PTkjQ"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 6E4128A2E47;
	Fri, 28 Feb 2025 03:03:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a308.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.104.238.197])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id E81728A2C57;
	Fri, 28 Feb 2025 03:03:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740711824; a=rsa-sha256;
	cv=none;
	b=KNxS8g80kiVclkCGw0923aNTCZRWDzOtx9WCQGIl9HhsLtm8NOsJSMdabuwByuEfX0JHrO
	BoDnCh0RCBabrDoCMsDR/0YOqJhS04CpbpNfzbkvSppSOon9g0tbg2ZUVqEkw1E4GjqGvY
	vNLB5CLvQwezukXvkgyViN37ajD6Eya/augKSqRVCyPTNeJFepyRK/Ij32UWPiuULOufFx
	sWhme1IC3jsiEbqhyMKn1a21tGqDtSBtXd4lBgWsznF0HOVTL7ox8jOV9TlUZYF5Sox3ri
	uubPWSMStX0cedWjm7JWKS034kPEnP9Qj7conhjAgfhC3AgV8t35tZSRJF+4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740711824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=58q7B9UYi5rBr+jFOxB/6XDvPshHNqZ9oAADqYHuEzE=;
	b=2PSUPkNnK62WgXZceyPOCAnQjHQTJ484nMZtqy5NM9r3CpU4rJTJVp52p+O1pKKrOqpLJk
	+0q3oyZTYYRwwla1+gLSN7z/Dy1YndUUYTQTpyYkJTYwcdYLFxM2gYVgVl8V/oKzERaY8i
	haMWk4z/zNtTJoxRWl2P2B3ZzMv+nz7z6TDTe0ZoazG8cBORWk5kzmkP9mzzMX4z/UixFN
	sz4CTbX3T4Cje9GfeOIIXxtDLQUHM9o/ObVPveOxQ9yNUJ8YzUojJ26U4mBzBMC+kldLmA
	y6fJjKBfvz68GR8EkB/Ux3FgfRzDHR6XjoPaXVXlLAFsGLNoN8YR+xpUuF1cQw==
ARC-Authentication-Results: i=1;
	rspamd-7878b47b55-zlsz4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Spill-Left: 37c1f7183c977c25_1740711824240_184581356
X-MC-Loop-Signature: 1740711824240:1002261756
X-MC-Ingress-Time: 1740711824240
Received: from pdx1-sub0-mail-a308.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.104.238.197 (trex/7.0.2);
	Fri, 28 Feb 2025 03:03:44 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a308.dreamhost.com (Postfix) with ESMTPSA id 4Z3tML60gXz47;
	Thu, 27 Feb 2025 19:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1740711823;
	bh=58q7B9UYi5rBr+jFOxB/6XDvPshHNqZ9oAADqYHuEzE=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=Aa4PTkjQIZx4mmH66vgq4thq+Vpz1BYLjgwxyPzoOTG0vU7/vPGk2ZtMHREFr5kWY
	 ZtTDOYM/dyGzBpgHuxCSxrHRu9s5hbmquxuPH1HSHIYQAFbvR07fq1HPlcSgpDNrRc
	 zbXRj1+qc4KVo031Z47Gq+h5bV5rODY0Onau9HW0ZF9C++ocqP142XtPMDph549oG9
	 Ym1fv+Alvs0s3jNRAsfFryY/wAENABDUFVuV/ljSTWHqI+iARbNCYq1ckg8gv2vn/a
	 kQFYpmjHzSTDNNncpIewoHTKoe7IoVJg38z8C9A5bBI2gqMV0bhrISCXrpsHApgjnp
	 WzViX+wNcfbwg==
Message-ID: <1551804b-fc78-4a3f-add8-af693f340a01@landley.net>
Date: Thu, 27 Feb 2025 21:03:42 -0600
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
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <f574808500e2c5fb733c1e5d9b4d17c2884d1b9f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/25 01:52, John Paul Adrian Glaubitz wrote:
> Hi Artur,
> 
> On Sun, 2025-02-16 at 18:55 +0100, Artur Rojek wrote:
>> this series fixes boot issues and allows J2 Turtle Board to boot
>> upstream Linux again.
>>
>> Patch [1/2] enforces 8-byte alignment for the dtb offset.
>>
>> Patch [2/2] resolves a problem with PIT interrupts failing to register.
> 
> I can confirm that this series makes my J2 Turtle Board boot again!
> 
>> Even with the above fixes, Turtle Board is prone to occasional freezes
>> related to clock source transition from periodic to hrtimers. I however
>> decided to send those two patches ahead and debug the third issue at a
>> later time.
> 
> Yep, it just got stuck for me right after these messages at my first boot attempt:
> 
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
> futex hash table entries: 512 (order: 1, 8192 bytes, linear)
> NET: Registered PF_NETLINK/PF_ROUTE protocol family
> clocksource: Switched to clocksource jcore_pit_cs
> 
> It boots past these messages on second attempt, although it's now stuck trying to start
> /init. However, it's still echoing <RETURN> strokes, so it might be an issue with Toybox.

Which was fixed a year ago, which is why I told you to use the new 
toolchain with a current musl-libc:

http://lists.landley.net/pipermail/toybox-landley.net/2024-February/030040.html

Unless you're hitting the OTHER issue I fixed last year...

https://github.com/landley/toybox/commit/0b2d5c2bb3f1

Rob
