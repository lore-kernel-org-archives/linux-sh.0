Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764119;
	b=R1BqhN4rymsPZB444qam3H9+MrYBrR/8cKhSm/ubyAIapCDi9LVJ9w7bTXerTnYqMn5P
	 OLUeQAotwiLbvvgv/0NLiLiELzNhwgDb/XgYQdV/q5h0XJ8m9Omu/ZvZ4DuuwawksbJfQ
	 s9Jj55w7A3gfMFulmgm8szLGjZH1Pw9THsG7t+c/4nfJje+KsSwfhX06MnabowDQwT7TO
	 Gyr4yH9xgfHTT/N7PSr9zb+1lARtoBAwHcM6mlRHukenOXTlc72iU24UBigzOyOzPhhe3
	 JUbBG7EiDBnF1gb/wVskvB2L392uhn8kVTycIBwE/RZldWikdzm3c9VgXJOv6d07KFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764119;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=xZNJyCxI46VRtERU6S5hKv3kxg+ly1dyzPdyXj7173o=;
	b=S/2KKW+kjABrmskeaNmViEtQKCsEH//lqMWlmRsFeiNoOnidYPMpvuK6EaXE3MsD/z/n
	 9ItwpQ+E/rrpdZhBtGIsckE24hRvkCVzhbDbwgn+h39AEkYmWXEdhmP4ev/Yt1cXCgkHF
	 99Q9s0jPsXkwfx8KcYRPHwPAPVZHjjY9w6f6Q6nTY4WIHBa9hTCgANQodeRXKRT0NDfwZ
	 8+Sty1m4NIkYrTVhXPQiykSfvtjKnAk4vrUuLThunMIFLeKDFcxJ3P2uR56h1jh2tfO7y
	 DSTVQfL0OIV6qx4NnJTQt7/Ymg0dT2Rth4mRRp4X8HLKT6rCEFHa6OVHTK5G8Hto94A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=Jt7+pYJK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KOLv07Bp;
	arc=none smtp.remote-ip=202.12.124.136
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4055E606A321
	for <linux-sh@vger.kernel.org>; Fri, 27 Nov 2026 07:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4055E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=Jt7+pYJK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KOLv07Bp
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 534FE1302B9D
	for <linux-sh@vger.kernel.org>; Fri, 27 Nov 2026 02:21:58 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 27 Nov 2026 02:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795764114;
	 x=1795767714; bh=xZNJyCxI46VRtERU6S5hKv3kxg+ly1dyzPdyXj7173o=; b=
	Jt7+pYJK1cliOmfmK3C3agMOxziUx+crZOb0xNqZkjluUx5vJIxYS7ZD13dqsh+d
	UDBac5Xt0Jz3EkY2fti+FzDCpokToFaZlgVFOJtlKw49Kq7atyMKgNiATNQu+Mm2
	+Ykyt5nLbHdhjJCYyEqlLUclK3M9TELjSqXryPA3EMw0Vw2TJIK0vEcK0TdwySbG
	pKFFquTEwsXADY9bGcAU8kz4NAOShJ1syFKQ/ZNIS84ZXn36IjtOpPNNS7dllYO7
	q3Bq34SlnVgzH33i4uli75rmEFrYEXKmw2R/EVjhms/aPe2XaltP9b8Fk4AW4Iqg
	QpROPckAxEvYcZqN5APorA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795764114; x=
	1795767714; bh=xZNJyCxI46VRtERU6S5hKv3kxg+ly1dyzPdyXj7173o=; b=K
	OLv07BplK3bd3fk/h1xixStDE3N8Ne6mWCMWO9Y+eTY0OMgm3URgECWRiGY1OEO3
	MH2DAGf7APvPxV7fWRo2VJvhbw3+aTVqxMMk4cR9k0FuNWJIm/LOPTqag0IFQZ6R
	HsqIr0tU3RJ/oVUNWeUfF8DUFIsL7rjscZhRvb+jrNN/2FT9gaaUZSy+5LiKvAHp
	Uk0+oYgc9U2Ip5JhNpVHWsmhrA9Z3OufdxpeUq/l/KOdTOAAFovmMsIuSx54vB72
	iMWUWZb/tJBRRmB9K8J4XdqniG3Qj/NVfzNvk0sc+OMHlosCA102lYeq8lwWSh9A
	YdI6WM2CLdtZ7qvFQGEfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795764114; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:opJKlYL0n2ez46OivU7YKnGdPjjmPcZsli4mvnHmooRBbC4
	sBuKVjSwyCfW89MQyxVzC8lacH5/rmlrkkcoQyLB8Y6wNgEjiOV/WWDUwuGMZoby
	GpLRCUNNriMmLhNuUtM64EBsfuWG3gD9VGBySg8beI9Lqchf3p6oaSNFl7/EZLpo
	Zo/GGSRaw4xm/a+9QIT+ZCQDTBNKgR4yNxMObJ9+m68uscUu5qoV8ZiVucDxAivk
	E7396eOCxP3ifG7+BImVm7cC75lO2LTIERFXzZAGtNuaalLwiy4GWndJ4kKHG75K
	Ysg5Db97LeJ1pFhxQhHfb1g1D7JQzWosl/rLNaw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gdGLtEHzAfo3e1G+v3ioZQqDyD5KGfngLBbkYjU4AEU=:LnoB4wT3pRxwUnj+lGUhLNqaA8I95v1E8b4G9zsLNdM=;
X-ME-Sender: <xms:jy8Ja4BsdYNPDtFg4Z7gz_nzyFWIXqgNnOR8iGR2rOmCdaqH0stzOw>
    <xme:jy8Ja1UGCVo3D7Vgo10UIdFqolrVnfsw26BQ4BFd6sOkdoQher8w4GMJ6nsi9vaDn
    KoLGmYDmU5iLwPT2D9-Gh22RDo0QNtMFwQE1MH9juKtHInbvnnx7W9F>
X-ME-Proxy-Cause: dmFkZTER6RdK6KJafy/wF66tx4RJUPRnUW6o76zZBTQgrnZR+7OzrTRaQUmN41dELf6X8K
    x1IMSsmpqJWCxNoOG+f4eWoMbvoPVQvlb+4JuaBSSMFiUMt8SbtTxFuZPGfEIijHMSFjJ2
    WjVNFBW5mZ7iclu1ORcCJ1/vGTcTwTcl07uCxApuWxxLfWGzm3q8VOA8xhBCHdCwzN7eYc
    5uXMmpF72nnLIZqh/fZS0kXdSA6bYl4APNq273AceEXE7Pz3SlG9mR3RnU8B5D0azSGiq+
    9IQxEg1X4FIclDSQd855nmp4PxpLx/PJGnhvhSS0NZV0aeQc90ZSdvFjT1jEW+EjMkneHn
    giVDDoLZO3OcJUmMK6n7Q5sm4ObBq/904amRvGqGB3+EvcIUwf5ok6e3plNQGkjx9t0Fmn
    H3KnIAo5vTxBHEvoc3hMti4aHZ4y7LBfSm92+hQvTNG/az5AiDTx3PLyFQlEqDvqAM3JKg
    xJ6X5D7Qlyv6DeSf+tp0zt4VJOkZakokalBfDNGSnMYv8w0Acib9toSV6gPqEko/3FySQr
    DQrl4KPOvw/kgGusSK+zWggBRxtbFkQQIEZBnw49bEuxZE2nQ438gut0Cq0sbMXVND3G9m
    BVA+V5+pWTIfM0U93uOdouQIhrV1LxBmO2c+X/ouf6nkR7TXrlE5ck99r5Ng
X-ME-Proxy: <xmx:kC8Jaw6zkYEhORhylYy-BFj8rgYx4Wwa0e4Y818U12giciAz7qz06Q>
    <xmx:kC8Jayk_f9WqHxXe8A_F6YYwrQTJw2FR61AUcsP1iu3tQkCBFrg4sA>
    <xmx:kC8Ja9qObUnJI21dzD1q-jH7rqyXcx-6iqFFADZJE-ynVfrqdhX_mA>
    <xmx:kC8Ja5sOQ8HKCylBTdC1hKBOv8A-d8Cb62dREYKbOt1zR7ATm8ka3g>
    <xmx:ki8Jazv6xy9hfT6xsmf1SmVBOpcnnm3biLgnfb6KDbuc6WrSKjnwZL3x>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 10724F8009E; Fri, 27 Nov 2026 02:21:51 -0500 (EST)
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
X-ThreadId: AcEvLIDCP-0Z
Date: Fri, 27 Nov 2026 08:21:30 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Artem Novak" <artem122novak@gmail.com>, "Rich Felker" <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>
Message-Id: <e353cc6f-f4e0-496d-a9d9-f9cba49fe42c@app.fastmail.com>
In-Reply-To: <20261126234349.74357-1-artem122novak@gmail.com>
References: <20261126234349.74357-1-artem122novak@gmail.com>
Subject: Re: [PATCH] dma: dmabrg: remove trailing whitespace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 27, 2026, at 00:43, Artem Novak wrote:
> Remove the tab-only line from dmabrg_request_irq().
>
> No functional changes.
>
> Signed-off-by: Artem Novak <artem122novak@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                                                Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                                            -- Linus Torvalds
