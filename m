Received: from barb.cherry.relay.mailchannels.net (barb.cherry.relay.mailchannels.net [23.83.223.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5C1635;
	Sat,  1 Mar 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740817955; cv=pass; b=av4bKeAHmfXzdMh56AgUGq9NE4GXBby+nI6tZcUic4Zyxo7ngZ9dKsU0BgYFAe8pKo6RlHpZjdLuVoPipy+LQncVevVpt/BCTeHH1HpUhe+/5hyaU5v4JOOCJ3TtOd0sJSYYQWv6jyLYpGWidswfxWTrix2sB4GeosINGNrDFhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740817955; c=relaxed/simple;
	bh=ioB2nISzPeluWv9jfPb9Yvprv8YRjalG8AoqtA+W8BE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aQDxaLrz79IbygJAco+2x5Y2ys5Bm/uTshRu8mhR35DceqRJ7eHflxJTZtocT0k/JDi/IlV9Oh+RCmWAz2D6vjcCpzYsnGd3fvs4zaflGRIHXLuL3MjUab05vu7uatxtN4g0EKiqJFNXaJy0Ui+YRBmQUA/KNMJ9zLqgN8ERroM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=rVP6adPk; arc=pass smtp.client-ip=23.83.223.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="rVP6adPk"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 392058A31D8;
	Sat,  1 Mar 2025 03:20:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (trex-1.trex.outbound.svc.cluster.local [100.105.230.78])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id C03448A3FB2;
	Sat,  1 Mar 2025 03:20:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1740799254; a=rsa-sha256;
	cv=none;
	b=6nsRzhaV2KMNAkc9mJSpdW3hlDHspqknwS+MDxThIBKjmlR7E+jY+g45qE8xBiQSf1VzX9
	vYrExQ1Lqj/qxiyc/VasvCSHMzidF5Nt5voyFx+zl3IXd+BZ3TInrfxJ5bBIp1lADwUwMx
	FbSSQv1Pm5YBb8ZFF9Di6Mv0d2j3qRxMQ322fZ5t9DFYhk7csKw4734u1kzrv+kK8hnufq
	cCmc6EywpL2aOGmK9innin1NYgp9T8SLPEst3Oab/VsZq2rTMVDFGVB1KmXKzgIxC2nshW
	APsXRmVFE8Gy/q2k97Ssy6QRJ2alT9W12S2+YmPVHBJZQ7+ZwgW947Ga9ucCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1740799254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=TOF8EoDBPkgQOuWlYGr996yYxGzhWlzyrqszfM/Cblc=;
	b=s1TY/0+FwG9eKaD/85WmkgDz9F+rlirgxhbqJ1IfxjKQk23lu+/UakfjFE3Sj1epewupp/
	IuuUxvpL2NxF/+MotFXlR92AaQL/b2HdJp41r93HTY5QPIIxOTS3cEfBiZE9pWb0r9qZy/
	VkHPEtCIMVJivp8evUokg7NStxuq6OJEVfMZ7fWnf3Tee2PyC+jeMr4TaFUUSP/GEAcGJo
	PFpnM/Q+dVjKqW0mWvkWxthRDIftwnfKd1TQ36E0KVPraEPBwf6MD9RobXxs8kHHa0D3I4
	cjIvuHLoJ641KTciV5TRgxLK9HqNyM0WlKo3hGNsdQ0MYfqZeImPlnI5Q2MGtg==
ARC-Authentication-Results: i=1;
	rspamd-7878b47b55-ndwfl;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Bad
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Power: 6c5d186c60f78e9d_1740799255062_535815330
X-MC-Loop-Signature: 1740799255062:2179686445
X-MC-Ingress-Time: 1740799255062
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.105.230.78 (trex/7.0.2);
	Sat, 01 Mar 2025 03:20:55 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Z4Vhj4038zM9;
	Fri, 28 Feb 2025 19:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1740799254;
	bh=TOF8EoDBPkgQOuWlYGr996yYxGzhWlzyrqszfM/Cblc=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=rVP6adPkMEcSvt6gI3S03II0l/k9WOLXifmOks/DkimE1I1Lfl/NIcKyFCI8yyZDA
	 oCGf7C4NlOYl9QyUjXeq81Vm5AC9l1I4x8SjBDm762oV5Tq+cXQ0cTXS2mIDQECnl5
	 mIBUQKfAv+6FYHQ9JWAncNVeBPLgB8vf7NRttktw55wVAHmdj/6x9uye1GZChB+xmS
	 +x/qy3t+zpKaDAC//eC2MZfU6+pwqKvEyqvow+kZD4c6VCHE9YIfdIwnTH8ECBsO3I
	 Yg+3bblfHwwbuDghtfvV3NHMPHAkTcoOwmgB2XJLRtH7MErKZJry8+mPQxbevf4k4x
	 3BsI8juBJDueg==
Message-ID: <2f96dcff-421b-4ff2-a24e-ab67d81ef698@landley.net>
Date: Fri, 28 Feb 2025 21:20:52 -0600
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
 <9cf43bbe-898f-4b29-bd85-04f5320bce77@landley.net>
 <a917c1183f85bad8af1312994d330f141c57db04.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <a917c1183f85bad8af1312994d330f141c57db04.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/28/25 16:34, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Fri, 2025-02-28 at 16:19 -0600, Rob Landley wrote:
>> The march 2024 rebuild was in response to that Feb 2024 bugfix, so it
>> _should_ have the fix? (I'm waiting for another musl release to rebuild
>> them again...)
>>
>> I just downloaded the toolchain currently at that URL and built mkroot
>> and it worked for me:
>>
>> Run /init as init process
>> sntp: time.google.com:123: Try again
>> Type exit when done.
>> $ cat /proc/version
>> Linux version 6.14.0-rc3 (landley@driftwood) (sh2eb-linux-muslfdpic-cc
>> (GCC) 11.2.0, GNU ld (GNU Binutils) 2.33.1) #1 SMP Fri Feb 28 15:47:36
>> CST 2025
> 
> Is that on Toybox git HEAD?

Yes. Commit b4fd71d18f84.

>> And the failure _without_ the fix was deterministic rather than
>> intermittent, so...
>>
>> Keep in mind the init script has a 3 second timeout trying to call sntp
>> to set the clock, which will fail if the ethernet isn't connected (or no
>> driver, or no internet...)
> 
> I'll try again this weekend. Also, I will review and pick up the fix.

Ok. (I'm available Saturday if you need to poke me, but traveling sunday.)

>> P.S. Speaking of intermittent, I hit that hang after "clocksource:
>> Switched to clocksource jcore_pit_cs" on one attempt just now. I should
>> sit down with the engineers next time I'm in japan and try to root cause
>> it. The scheduler fires reliably, so it's _probably_ not a hardware
>> issue? We've had Linux uptime of over a year, not just idle but running
>> an energy monitoring app, so it's pretty stable in our systems...
> 
> I thought it was a software issue?

I agree. That's why I said it's probably not a hardware issue. (The 
config has NO_HZ_IDLE so if the PIT didn't fire reliably when 
reprogrammed the scheduler would flake, and it's not, so...)

> Adrian

Rob
