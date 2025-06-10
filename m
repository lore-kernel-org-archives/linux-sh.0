Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CFA275846;
	Tue, 10 Jun 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749593466; cv=pass; b=RDmM5n5BLjn49lZnOBgXC1X980va07R2iy6xqMgBfCuMhtXj4YdQJnuGRCdC0Hgg6QYi071ezfo3HNUxv7OGNrYMHxYuCGEqhMW/tpT++LQ152tRpWCDpjWWMnW5YGSRdPVRLYLM13bbPuiU7sqdud96oPbc5MWxuCV41czj2eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749593466; c=relaxed/simple;
	bh=/n6BeKTA8IixklhoRtyjie7JUPMoUan7OziG2D+sRe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BODKHe+dlAw32CTVq0tsaAV31qnLscUfuyqC3Y/JXqDfBwiAhpeeFC0LQlq+AVdbXNjC25nTtC02tCk+X1BinGxAlexzM1Zg+lfLWR2ofVmAKPiEIH48tRET3B7M/L4qiG5QZfWv7TRt4EfhYE+aqZFVm/b6z72dPtleC+MSbx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=pass smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b=a5H0CQB8; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=landley.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley.net header.i=@landley.net header.b="a5H0CQB8"
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 790C8838D4;
	Tue, 10 Jun 2025 20:22:54 +0000 (UTC)
Received: from pdx1-sub0-mail-a311.dreamhost.com (trex-green-8.trex.outbound.svc.cluster.local [100.118.166.165])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 7B27383266;
	Tue, 10 Jun 2025 20:22:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1749586973; a=rsa-sha256;
	cv=none;
	b=2cryEfftBkxBqGPRPfGzOIua0UQwI7ga8zrxxhucZ/dOssJCeojUdP0Di37iXHYHywBzcx
	1N8Yk+k0Zu6OpdZHuJkU7UktGTjq7cwQ4zRK+UBT5Ai7GZqBrMWet9g4Wud6aCpLbnNZvq
	ON7uyv+hBzxyTggCU4lI0WINHznU8w6a9PlTpgJOFSZE/bPhRGYJtK+YV3z6uz0agst7VO
	JX87uCJ9blf9CHZlC3DHUQUuZ8UTNXOgo/ft1jb3bxVJJb+KBxAF8J5wfNKjKIZVUi3Ak1
	L5bbcfKNsXo6GUOKU9TRKSKK7wkLJ7iEnWq5PTeopKYgf9HTM6Qqasy9LjCpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1749586973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=GcmEzuAcrQcmeuvXZ7uM8B+AHDGDQPgvjsmIJEFZGL8=;
	b=uBkpkM66QBzkuX58qX1OZ3wkzeet67sJkZRHVT4zA5/m//KvmWF+60XNEDd57+hCJC3WoE
	t/dIgNOiODfyJyF0FNSLfcoh//47j9ncM+/+mYy17tFx6VYmqYf+ZVsSJyWa4yNeVoQyWV
	2RAFuhBaI/x9FNK7I5tCoF7f7ejslAUyQcYXD30VB7oBezYe3PR4lcJbz5I+iRjaCvFZ5T
	ykFSONnyAlXOwm3s9Dy7WeG9F9tskDZ89d8WxbwxQft9s1r80iuRkQ59pUlySmdY5HEXiR
	12p4jiISjv82jZth2zYIcLIDFmGji1DqMxvHKu1PCxRk3ulu9Opub8yH+qGEZw==
ARC-Authentication-Results: i=1;
	rspamd-5674bcf875-ffkck;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Tank-Inform: 3d4ab5fc13f60a6d_1749586973820_1909461595
X-MC-Loop-Signature: 1749586973820:2959690244
X-MC-Ingress-Time: 1749586973819
Received: from pdx1-sub0-mail-a311.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.118.166.165 (trex/7.0.3);
	Tue, 10 Jun 2025 20:22:53 +0000
Received: from [172.22.7.54] (unknown [198.232.126.195])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: rob@landley.net)
	by pdx1-sub0-mail-a311.dreamhost.com (Postfix) with ESMTPSA id 4bH0bJ0DyQz5h;
	Tue, 10 Jun 2025 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
	s=dreamhost; t=1749586973;
	bh=GcmEzuAcrQcmeuvXZ7uM8B+AHDGDQPgvjsmIJEFZGL8=;
	h=Date:Subject:To:Cc:From:Content-Type:Content-Transfer-Encoding;
	b=a5H0CQB85rjhkk2AJwqCJh1aT6rWvY695/Bp57oae4Xbc0ovbj3A08M3qkwc8kM1s
	 /9gBA17caRl9xbq9qe3j0K3bzGrY/y1+2UHWOCCWLYTAQBtfBz4MFsV8Vr31o59UL6
	 TbtHk4boihh4g2TZ6kI3IuY9LPgY1mijqbdCLYRNk0N5hWCDP/2LiuPFS/kjYQ2/FM
	 BsF78lnlLX5vrQfjIz9ru2yYoPoqko/Chjsh8WeP8tDGbIGLqq7xxmq3h9MxyBM1Y8
	 7ypBVOCe3+xDBuA7wLxtSTi8eYHJP0jud2Dh+UrcxsLNtia6gViAbG9yI8j3CHETXQ
	 pIJ8SUDQ0kiNw==
Message-ID: <c343a6f0-0362-4344-a5fb-5a23e12f69eb@landley.net>
Date: Tue, 10 Jun 2025 15:22:50 -0500
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
 <afec7233266c6c1fd1e70ac615ff129d9dc3f710.camel@physik.fu-berlin.de>
 <5656d614-c851-4600-a79c-92edebc9c55e@landley.net>
 <7f12f4e2ccdf1da4096e980923fd88203f0b1d49.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Rob Landley <rob@landley.net>
In-Reply-To: <7f12f4e2ccdf1da4096e980923fd88203f0b1d49.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 05:01, John Paul Adrian Glaubitz wrote:
> Hi Rob,
> 
> On Fri, 2025-04-11 at 06:25 -0500, Rob Landley wrote:
>>> I just gave it another try and it still hangs for me at:
>>>
>>> 	Run /init as init process
>>>
>>> with the latest toolchain, toybox and kernel (v6.15-rc-1).
>>
>> FYI I reproduced this but haven't tracked it down yet.
> 
> I have updated to the latest git revision now with the result that it
> fails executing /init now. Can you confirm this error?

6.15 works for me? How did I reproduce it last time... Ah right, I 
always build turtle with my patch stack applied:

https://landley.net/bin/mkroot/latest/linux-patches/

Sorry, fell off my todo list. I'll take another look. Thanks for the poke.

Rob
