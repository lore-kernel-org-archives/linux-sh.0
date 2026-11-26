Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685237;
	b=AxlCWirtmPCBaAtwUoAal1/vrepW7a4680GIcvA61WVhVEiYtWjAKNsko7SF5rxkFcav
	 B5MC2z/g7Jun0aEVmuncagCDZfGcXDCoB2B6B9BOHXuuZpNJEF/co+1VZTDedq0nntYDQ
	 AOvC8mNXvkLgBtO9lLt2xksdXtL0BspozIj0PCAQoyV6DEOjTFXCSuMJeRkqhyrc8/767
	 eV6OTM2V+2zgz+C0HrRCtlzAHLU/6I014TZWCprtVdx38/6LTEpATDgB30S9nqL5UhOjV
	 sBmiU4AsE5SLD95QO0CqWHLq24lmgNzWvWJmGkV1/MnYNYPR3LlKYSHh5H9bmBHnB2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685237;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=bxYElGn/aLvZfT+U5MZHcaE7MPkeEJF658OGwFehSzg=;
	b=u1WUDDRobHmRX9t9IGbgRr8Qken7SqR7oLVsnz7HKmp6DTfud3C1622cboszNCL6QEWq
	 8kllYBh1vS8sUCJD8r27bTJ6lL/OAbFMkqUUL8bYXodgbTMwfrH+GmDPvWRdoNSiXTPQP
	 N2DBn2zVcSerwFOcsD+XCeXcBdjcpbx8Ojpfc3o5vSlYumz48QIl4XaoP+BDZ94nwCFWC
	 sIXhRW1ScDDkcV0IKfdyeDb523BPwrNQh0gj97HLeB0yFOOfTrnzYHQy0kvvDhhJrj8tc
	 3ISvWfaI7DY4zjIVnbPogRzepsnIMlRYCoewinTj3MdS0/8meoGjpsMM1A9m+Ebqqlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=coAfiJdA;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CctYnAhs;
	arc=none smtp.remote-ip=103.168.172.139
Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D516606A321
	for <linux-sh@vger.kernel.org>; Thu, 26 Nov 2026 09:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D516606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=coAfiJdA;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=CctYnAhs
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.phl.internal (Postfix) with ESMTP id 8AD381380588
	for <linux-sh@vger.kernel.org>; Thu, 26 Nov 2026 04:27:16 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Thu, 26 Nov 2026 04:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795685233;
	 x=1795688833; bh=bxYElGn/aLvZfT+U5MZHcaE7MPkeEJF658OGwFehSzg=; b=
	coAfiJdAUufyTbqPfQpwi7OEP7xbcxPLLAgbBjRY9YbnUEfvsY3ueUaigVjbH6p/
	5vX5AxeAvEMRMqa67YwjTCghA4S3Bg34xDc/k+WrVMrqEdYEG8Heo9Jo+ZNmaEvk
	j+0vm6NhGP5yBv0I6i3kwPrJuOfALwGcyvynNejG9LVeYSpgIm2T3VQbwQp/ZRQg
	r8aRvHtmXfCAa3K/aaABj0LLjXuIdUhmTAwcQ16WxpV8dzJB3lCUfN498MywRgvA
	hT/THeq+y0XMB+Rhnwes9MsZreM1vGUTNJsDjdPXUyqMFZS8w8I/O9Z7CVml6tTe
	nm39BbIpyyAG/DhV4vQRxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795685233; x=
	1795688833; bh=bxYElGn/aLvZfT+U5MZHcaE7MPkeEJF658OGwFehSzg=; b=C
	ctYnAhsKNFvhXxlAiqkqQ+SXWdOKEKxq08KVIoJ3BdfCMCPix7P4/qf0alggV57q
	4GUxBl3fgIlvTTSwDiqE3Nc27N2uvzCsAzqUp5HOOvskzykzB+ERqaUyDZ0HbpXV
	Ks2P7dD/iAjdJ/1qALr9F896s/DlupooPjxptn7YtbXxPAbAsWZfc6z3w4sKuJYM
	e386+3puGcPS+Ixc20a6M9zUPNfRu170mU0ctfnHGnGnxG4W7/1vLj21n99+Bd6D
	GQqNuWb90WMN69wK5U4PXq1bndxG+QoEPw9YZMhmgiS2O/H2yXOHy2uivSXQuMuF
	pquFJocnyphjvxAyNanog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795685233; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:pAbNLtSaASBvNZti1bEBVDorbB+5Y31KRiD7YnlSuLZF6sW
	ZmK39cnxH/9ViPLBNWMtsZkv8cO9JyvIK3SMqK7QpzQ2YfX24YTkoDoqo2WkwlzD
	/AbE7lJb1T95UUPgNeHYZlgyHGdzXEi9EJnLPMMoWiU1Ny90pOGQ3x07aB9lKwTL
	vdBbMZv/sGqw6mlQRQUGkJD899W2W2L+4SChKSaHRc1JfI6keLd8Ikt3c231lF9t
	DITeXfQsydMjqCVevEMX6QwtfQJoV//x+MeKi7RLYIkCq2nf10NuqQ07FXcTWfaO
	6ZUgfM7FVri/oF8jwwN+8QrU+68abYuyOw9CGVw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:OJzQSZi05U2jsSYUm9Mtry4szIsb+dVDA1k2gGV6Rkk=:zRFaQYpnjorMqgGXbvt2aJ2vsItFvc/qKaJokKrwKEw=;
X-ME-Sender: <xms:bvsHa_ej7NSPLgAezOlAqK1gkP8Sfs7u4AVc2eSeL28JXeHpUSdZrA>
    <xme:bvsHawCOVHnSSiKb5Fj-H7bBySMCDCuFj43ivQ9-e6A7u4oNX6-anSU9lwAL-7F-X
    z0EeJ6OZ8hMgIDkMo1BOvh3ceOA7ROfSrIQT2JjGUUgM9yTfqYXfg_V>
X-ME-Proxy-Cause: dmFkZTFrMeaPHKMi5eIe8O+0XWrSeBawJiniLv0Fq5SQOl4oBuAWk/pmKy84PqeVHp/MBE
    i5UVZH2xboKr+rKVrpGkW22B5dZeVi1M4VDNg/Wu5AyCV+4E3icjYJHrswtHN1BoiPJNvX
    SZ7dgKjLCSXrRHX/BiSmei7FS6QWOyAUYjyyyiYHfauzX0PP3zzjWocIJKMh8SMDkFoGyk
    AebLX7P/32fxVPT12NqYsoZOGBY/EDjVkFu7WiDKPToAWuQfkv7mQ97ui2sgtFXO0likYL
    Sn/YGgYO20sLMqzLQxMm09Xfz+FyPaIhjKggVZg8Xt5TfEo0Go9OmUXFUIlmboOYl/9xkI
    wWY/H6Y1+Sr4Pj1xLTs2oREKtsQuSXW6eGEdHUojvoaIPadpRw4/zL1gHYxP5vZQqpf/rA
    HOIdXGNDmxIcqqvKA8lJ6FV0UtIoE105UCXbNmgBkZevc6tGMmxYYKOgsyNp+gaQI2QFwz
    DiG377e62oETjm/pNyhKujXA22Fofa/+jmnZgR4k9JP3n9cVVh2Fmc+I0GDIBfnK+/FYLA
    J0jymXWyAPwHe7hAj7NKtdNqNivhvPajdB9grO+PqW9b393awY72J1xbUjBIFAI3RSUCCm
    bnr0CEbi6hvl8oCW8AP0hydcHSBuxXC0YuzKdlzkOAPR7SkkyXJQqjFs9N9w
X-ME-Proxy: <xmx:b_sHay0b21012Zfk_CaTFXpAk_ZVSDCKGeXWh09TE-rk8a-j5dUqug>
    <xmx:cPsHa1xu4HJyHYtPZCxcZPsgH2ieDno_F7ei-n03jyDw1f2oS7GFVg>
    <xmx:cPsHa5F5Olk8Qu5Cm5Qr2w9BH-66JMR5BirjNAIBJyHcjnJwSzfNAQ>
    <xmx:cPsHa4ZoF6nOYzqYUN4pye8x-SHqJdFBJbDF8nl4zmRTNWXyAWV66g>
    <xmx:cfsHa0W1HkhKI1Qs5dkg7rj8A5NJ8KxBQeaCBWJU0aZGQ1eA_aUF_23e>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 39D30F800A1; Thu, 26 Nov 2026 04:27:10 -0500 (EST)
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
X-ThreadId: AZ0y0-oFllyJ
Date: Thu, 26 Nov 2026 10:26:49 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Artem Novak" <artem122novak@gmail.com>, ysato@users.sourceforge.jp,
 dalias@libc.org, glaubitz@physik.fu-berlin.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <f1f5d30e-cef6-44b6-bf60-cc296a9f95ad@app.fastmail.com>
In-Reply-To: <20261126053626.18680-1-artem122novak@gmail.com>
References: <20261126053626.18680-1-artem122novak@gmail.com>
Subject: Re: [PATCH] sh: mach-se: clean up IRQ table whitespace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Nov 26, 2026, at 06:36, Artem Novak wrote:
> Remove trailing whitespace and fix comma spacing in the SH770x IRQ table.
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
