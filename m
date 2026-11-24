Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537060;
	b=xE8DdKZGg9rpkNRqJOB47vCuUqTNU0zKwwxnc+GFjoEWiO+ojLogBaNogW5EMaa3+L/b
	 3oT7ghxbqg5EjBojE15vKacqUYkGBrbAEks2z/x0dUI9lq7rFPqbMqHvqLu9Y6Xns/6Vs
	 xNpejLcr9G5ap4SW3mxshrC9pQKpDa96+rOeEn99EN1uRMFhPkb8EGA9nk4fneArbPp6u
	 XL7oXfANdzXMlsQN4Vz/eoknLy4Jc9lP2qfYhH2W7QVLn4XbZ23z5YoNtUa7XDxkDPdS9
	 viMg8ZhCLlxGCXKHDPTQPAa5BrM6c+2bLHRiCKGka0YVW5lIBB5gM0rjJexfONjWp0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537060;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=9SYGUw/UwXoOeXSO30qXJcWlcpamee2nnDhzME2fbKA=;
	b=LIPxrykTFwBSFYHY0Gx9Au6/nAwjLGwt6+p1ommQ7FYesHejV1NM3Q7cFxXM1FYuyyxl
	 /SHwfOg0Dk2Po1N562vulhEKlTKqB7Ex14MpRGN/LQXxwl7BsJfcu7DJ75ulIjN5IJ6q5
	 1ApNafkOm3S/GGOaxQSkIL/KxmHDyHJTnEpUHN8xr8CVx/27quY1B+RzuRgItTJH9iuAH
	 Z5USDe/rwxtPe757xjo/aQ12A0zVo5M91k098azIk4XnwXR0aJ0MgiAm+AX+0KHjMKvay
	 1rQiOwy1PJM/9bUxVDieRg5gh/7EBPzNkH7Epgw9xxej7bhztYXcJqQhLJ3KIVOKW4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=U8gIMfux;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="BK/dJqb2";
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69317606A329
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 16:17:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69317606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=U8gIMfux;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BK/dJqb2
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3F13F14002AA
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 11:17:38 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 11:17:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795537053;
	 x=1795623453; bh=9SYGUw/UwXoOeXSO30qXJcWlcpamee2nnDhzME2fbKA=; b=
	U8gIMfuxSw9dfpwESi1egCaKywFA1sLG5RRcuvIBwq8GO7Hv1Tn4Qh6jEJAP+3+M
	a4/WyEMvauxlg+xouwaVKJpNpwaZ4580XIkUwih+kRDYEGBU7of0CkC3YSaHGFu+
	kW0vxcGGlzb4NBH181PK0Dj6Mr64WfzIJLCNIko0o7JAFn54ofCZ5986KCDSxkcI
	Irq1BjuC2rNjDHbeSoAwS40/pNa41uevXwXcYunAx6Js3IQuRcggYc8+Bh0yk4rM
	8XrrTK4pOXx8wvSENDXlWa7mw72GVa+a1R8xSiKK2tuTJiJ2J2FknU8ilfleySVM
	zHrw4sBhCWx3TlT+E8UYbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795537053; x=
	1795623453; bh=9SYGUw/UwXoOeXSO30qXJcWlcpamee2nnDhzME2fbKA=; b=B
	K/dJqb26JaZuSKzXG5EjiwhPkO2HiRQyF2mV4IbWrIhKTN4KYC2IJmiKsX7r+m53
	RfPV8XKmei5HtIjbdqkeLzwPsDPNTfq68z9PJX3jf6eiwhdhcDeN0tRq0Yuj/HOM
	o2SjJ5jWiai7Ib1d/jITDLoRHtvnc34QBjg2Zmd0N4NQek/6MFEUtGEUwxUxMgWM
	t2SFkuxjh3eT4u3pIkGk0eN11/4A3UdoIUNSDEIF9JDPpcoe95o8fibegtecSL2B
	PxfHDGySIiXboa2WZsfZjAAvXECRgmQ6boPMX2nU3lgPVJQEcSM+G74Zgz7aulIR
	OrXr9UHl9oaRy8hPiEPqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795537053; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:Rzqw1xdspYGe2uEdYknwYrHmbv1jQouXLa5BNL/f/apfMQc
	LnWyDzU0wuMRHzoM5xYrwgCayy1StUZc++cU1HyblmRgcGOTw1O/FSeWKboaBAF4
	+xGZ7uUailQ0FCbJDsh1Mtx87ma/6bjEKcN1LQqwfVEUJVsJkuch8TFIMgp+B5x/
	p28spHrJ2KrRTzsewmJynKD5Z0mbWvGEIbqWTw4pc/O5IT92gv5WdYSrNv3XF5qT
	ei5Cseq0uo5jJnEofCKfwUZ2FER8BcoZvlsyGUwb7wdNCtGXjmhVwLd9QMfilWF6
	55tdZ78R8PDMJbdvK2n4hFlCvFR+2omjKJYiMYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Xh9LEKDObrQG/Qit5Q5DBAccQN9lEAj3CJBvdQNVeEk=:U0b6dSKxRqyMIA/Ww8r4lUlJvBN1bYdoWtjFI/W0JeU=;
X-ME-Sender: <xms:mbgFa7Q3dbCZV6IkbM3R3nrJQ81NJaNgYlN3GN5Y9atG0FOeIqBrqA>
    <xme:mbgFa3lDc7-5KK-Uraq5DUi_txTPhUZKTpN46V6UTFtTIqux-OdoWNtIxKFqNHJ0A
    0tLwNuTSsI1TR1rZhHtuN6fwsLYFLuTEa3j-1Kc-IQZft5J8cs2Emg>
X-ME-Proxy-Cause: dmFkZTGZg2lMQXSu91TsszNlu93A6AqSWK/psnerHEl49lKAqSYeMTv45eNVYA5rVW0h+w
    IQp1Nq021j281pvDW5iSiXdUhUdKWn+BlXverFwL6jGkI4/aBMCrMktn+GFbWGfFVi4e5f
    A0OqUhBXJsKqxqcfI1ZoFU+mVW8nzYKNXfMbYUfYiSpfQTxHuib5jp0Oj+gzyI3yEsNUPC
    kpC1wP4wdi86gBjq/5nv8dWkc3pqUcKGzZPnnItUGQQ49q7PEgXsBs8xe6Zr7PQOIYpX6p
    zjEk2YITgHCaLnRBfacQOJLT7s0UORgy5/a6CP+0YKvzZpqxgr6ab7tGfhAwmxD01VwVUQ
    q60hVE1FszmmelrLxK9AvmS+4hIC/a0h+HI0nBrJ8UR5UApFrOXu70oub9n2DhfGXdqeHw
    12VjSVTKk904Q4GHBcJNkL3eztowYicyjgIAMctLF4gmVBi+a7nFRxqqPEKn88lE+/k4O2
    cnTQyu1sq0ev3rHVtsw1hnDn/iFVcuTh18kGtIMTZcPRUCQ9dw5rs83VXtLYJDCLabiWRz
    ngZ9u6lJ3XnDvCE2xNyqwetzB+F3DI3F7fPUBfQhcHpV8BEDEuzBDYWgyTXumLtH2+7PFY
    imq3dBKt2ecpSh8V99iw0lC5FcL2sl+YZ+1oshJegOvjjM4ZtLK/F00L669A
X-ME-Proxy: <xmx:m7gFa2wvTMTy7SmTBxaI3lokaxULdOZpAVIg70dTavPQIF3gaCPg4Q>
    <xmx:m7gFa1U6EJcM5VLnEBLa9u5VZeX5sI0bxniy5Nw4hMSBa4rhKrb7lA>
    <xmx:m7gFay8My76HupTiXn1nBaLpbHlGjulPCAnEaue7T7l7w0LxVwRepw>
    <xmx:m7gFa4vhvH9rxfGm0nzR260q6WIKaXZ4Zbll7merHZnemPwSfrWefQ>
    <xmx:nbgFa35dkSZA7fCOesXaoxgXdr9ys1K-S22e1pkV984qOcmVTxkFa-cu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 41D1A32A0099; Tue, 24 Nov 2026 11:17:29 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ADTbQhylYhic
Date: Tue, 24 Nov 2026 17:17:08 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Arnd Bergmann" <arnd@kernel.org>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>
Cc: "Bartosz Golaszewski" <brgl@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Linus Walleij" <linusw@kernel.org>,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 linux-sh@vger.kernel.org
Message-Id: <15001a2a-54f6-49b5-baa6-877d66e33068@app.fastmail.com>
In-Reply-To: 
 <48f0cd1c224b0cfa2ccc39afc75512d5d7a1bd7a.camel@physik.fu-berlin.de>
References: <20261124143333.3197625-1-arnd@kernel.org>
 <48f0cd1c224b0cfa2ccc39afc75512d5d7a1bd7a.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sh: rsk: stop including linux/gpio.h
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 24, 2026, at 15:35, John Paul Adrian Glaubitz wrote:
> On Tue, 2026-11-24 at 15:33 +0100, Arnd Bergmann wrote:
>> Ideally this should just get folded into one of the patches
>> in Dmitry's series if that makes it into 7.5, otherwise
>> please apply just this one.
>
> I will get either of these landed for v7.5.

Ok, thanks!

     Arnd
