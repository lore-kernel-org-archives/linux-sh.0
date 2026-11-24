Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795527695;
	b=MlzBCn7Q4qr1i6WJzeqMvlGAL8qo1mnn6pAZVdXJTgRiFs4uaBPy26SMqbP7TTKO9QQL
	 tlViZ1AYN2TeIpRtSJ4pUKD8+VeK2OUdhGuCSc+etfLNJGQIhHmgulT/M23ZCiHfrI8jY
	 eD5hSa6TyykjqtMWOMC4hvhjh3dUgkjUoab9GA7RoyAQsrwQYGOfV+HWZg5ctLq6K88A8
	 Zc+1wm06uiB3uwYSXWvYgcHC5qK8f/u95fA2QAnpLmGnlj/VMETrTvevhhIr48SqtguUy
	 kHeS8Mqu9mqgn1rKmVMmPrsIF2ysWsfPUpTHUT0+SX97QIaQuToZnSoQJI+wZEFWkjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795527695;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=MYQSSMXpf43N4GjSBt3kWRte/PY5hANqQLDIFSaJ1Eg=;
	b=49IC8YWI5xD1xLmaMq6DjRvcIrlmCs/QDk6f9VVBTOBjPN3lNCv2KNlBAdfMJSCyJ6on
	 SLOI7ohsXgLy4JgdKWHKl5wzC9sR3lmVv1qfTtC60hPVRFRdhEUkEOVZOPrIrvtOs4UfN
	 ydLE8wDua0ZAQaCU/+iqsErwDfyNZZKzLi7sa+iVZrfzZRSfVyD+WQNpLHE2Szx8iz2Q8
	 fOd/snWtkbYkKQBqZSm6RYcMYsWuvIA2ak8U6atebHgW1ExkIaQDVJsZxTMxfyfq5n83L
	 khyn1s8aQSMTGSvIyXCpwJPi/UIc14Sw7xHQu/FJJwYBTgok0Hlb2BqB02OaB1Grp8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=bCdzYNJh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2liMAWO8;
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356C0606A32E
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 13:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 356C0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=bCdzYNJh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=2liMAWO8
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3EF55140012C
	for <linux-sh@vger.kernel.org>; Tue, 24 Nov 2026 08:41:34 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 24 Nov 2026 08:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795527688;
	 x=1795614088; bh=MYQSSMXpf43N4GjSBt3kWRte/PY5hANqQLDIFSaJ1Eg=; b=
	bCdzYNJhd45eTuhYvQZ+/2L4mKjymmS0Xx1CV1VGBBhogmbm7t6YNC7RcG5mUabV
	pg08AlynPIdCOSfHv4JUt24OY7uzI6xxNGDPRa962Al1vhODBi4+lnNJlbhlJZuL
	+i++nKhtzBTxQv4fVrAfdqhiQ1V+BGOyVJRvM0FWCdWviqMaMsgoybtfzStio+zf
	qOG2z3nYWiwvkwAqKrl4LLvWYWS0K5xkxupoUp/BNTGkEux4NMxw5DZHkzkQfiqB
	ekxIjDFzCGkh9V6k89EUikgUN+1h4iQtlVUWjJ+/PCrEOZdd1qlNqWldQRQoVzhc
	lqTKAP6dj6/Yy7cvXzes5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795527688; x=
	1795614088; bh=MYQSSMXpf43N4GjSBt3kWRte/PY5hANqQLDIFSaJ1Eg=; b=2
	liMAWO8e1J9B/1m5SVeE789rMOYhdHLRUkzyJukmVu0Jeg4x+GkSzQt2Iks9j3AS
	0yr/PhWzM0Y90nHVRa74Q41A/W039/keKwktz2lcbYw2eCXKkmQ41Ih3NzYl6wkU
	ppQo/mNgOU8wDF9JJIQwlT5MgS+hznopRSeLk2jp3tQ8YYa+aC+kO71D+68WVud7
	JxVttExHkuI5uCugOf5PM//StRusCtG4QcOWe/ptR5J/YPUViwGxg0wBn8ZJ460R
	QjQ451bMNFbvBRYrem5SAzGbtddq1J22LHRLoUryf8slZG3/Dw3JkB2u+ThJBmAx
	aPsz4bIJ/yXcm3BtunrSA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795527688; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZz4=;
	s=fm2:rsa-sha256:PnrKwaC0WOoQ8XKjX0u7iXF5xK5i2/lcBFw2veCbwR1ydAK
	q19gIjvLlKhSGAGNmRwbSD0lw5Z4JTU37AL7gqHwTLMf9CeH33HHW6hJzYlzsLFz
	eZ+LOi5ZYt/BPC5PtHbymkEeig7eQeDmTpPPdunSGaFGyoxnFsSgAWEv50GTXw4O
	F34AZ1gTWHuAKfqbVTP+MB4j9BkEf8BXwy3PlzfVSnW1CCa2Tx9BRwmlbjVxM1XG
	UGvG2KQBLZwUqbjF/8i2vlC41Az/EW0WtVAkxcgzyVgogYhurZUmWUEsVL5kU+cP
	CmKhwCwjAjK+neZ9CC1dpNF56wwNQRFBZ+RV1qQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Rg+l0whB90Vy76Qms2D5dXFhxayudKTo24eXoC4O1Y4=:gJ9gHlBGvHKKl7manrr7WsUalocySKl8lm7VWHrs2OA=;
X-ME-Sender: <xms:BJQFa63oh8a7lhyM_uApDDZRs_yd4sRctwemvWJjs-4DNxKs_rHZzA>
    <xme:BJQFa35T9ANKCarwzJ7zl71S8vVsdEfzlZUgmvSRYvO7OsfO6j9M1xr8cls6BgW3s
    kcch_qnCH7P6N3M4XtGWU6kpzILFsisx-VUdP1nQ-uaG2vGGjlMCHE>
X-ME-Proxy-Cause: dmFkZTF5KWicfu9f3PEW5ht5TCyVa5vyCikQXtMqlDERgcApuayq4QVZa76BwCqwiYPxRC
    j6RfP3MEgi11aDhGJC+FtnNWjbAHRnkxlCsXIDKUVCGMoMq8ISZ4Pz9y/s9eZLHPlNZXIQ
    6xROBcKDVsu8bXhJmRn6krrf8QlhDPCYd/auTUP9QxYgJv/HJMVD2hVD/WIXmUxpyUtY/R
    JC0G26K1KNyPDbCZ8DtfwDEbGMncW6Q+WBVi6odvhE9w3Uq+9KCr6kX4T5UrH9iNrQ58/u
    xQAOnJsQX0ZiooSkXsU6KtD0CNQMLDOrsiZYvM1hXYyBO6bn5UeCeddIG/3PSj2UsebbFJ
    PGPluWC4GO6sdURLcS4SsHqioB7QHCl5yhP9JKd0imuBhSGo4tDsOu5yDJ18YfOEzNAoik
    EzaEDEEcHAgOmA8R/b1Wido/OCxdvG01jr5i50bcoPZx2fc80AiXjvAs8n1rvHo9UsaFHH
    HTcKzC30yM6gb2i1zuNedHbAbCSvIro7c0l58N0xlTnFZPnI3yEJCERsm1pzr/ennbeW3L
    Tjh6vurgIvG3LzsM25h+ZD2J1QSwL+Hurn9OfhVRuTxAT+fVwJhEI538llI+Pkg/ZO1qDX
    sBsla/EgyXQ/6LOKl96Lr7KQwDz2JOttVchKEqRtpHFMG5Qw3zhOO+x06Jiw
X-ME-Proxy: <xmx:BpQFa6nEnchkNx14sqR9YDMzoFdgjD6ndMFJqqweMEpQDRor3WHDQg>
    <xmx:BpQFa8Om3Ypxv81L6blcyxvwda0qi7If-P3a1rcG51NLBy7xXrDgmw>
    <xmx:BpQFa-zSvcYQTmcPyYXUuFdRolmdIVrNiywSi7BXg1n_V9rNL0coKQ>
    <xmx:BpQFa5v6SV-iSfSjfOIr66nt87oufPgwjQQ_fgCF3NJMS9ASVIFeKg>
    <xmx:CJQFazAk2_E-Y8nsHl64wj-Kg_cNeB_DaixxdrVh5ahvDEbZU4Gu6IWj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 1FE4A32A00A1; Tue, 24 Nov 2026 08:41:24 -0500 (EST)
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
X-ThreadId: AS3EG-ulzzHR
Date: Tue, 24 Nov 2026 14:41:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Bartosz Golaszewski" <brgl@kernel.org>
Cc: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Arnd Bergmann" <arnd@kernel.org>, "Linus Walleij" <linusw@kernel.org>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Kent Gibson" <warthog618@gmail.com>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-sh@vger.kernel.org,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 linux-wireless@vger.kernel.org
Message-Id: <7abe46c2-436d-4c19-8c2f-22a55a41f722@app.fastmail.com>
In-Reply-To: 
 <jdqf7rwmhri4b2hzuq3wbd54xitqsmw7coyx34cqhjepj4njf2@vad7brzfzj5n>
References: <20261123085723.156933-1-arnd@kernel.org>
 <tdc6h325jthjgyik2ne4oistkm563maoc2cpnffqu7hh34tpl7@oscripzv4dwq>
 <qvmy7iaxc7cjy2gkajqkr5ma6b4lwxz5ff64a5zsqrgewkxodr@odbjlv5x3hix>
 <8296a5c2-0aa2-4fc7-b65b-9d336bc4dff6@app.fastmail.com>
 <7dpg3x3gkypkznzhuetjsqmk5fhqwuwkc6kupbs52zqh5mibgx@fjow6eodw4pf>
 <2f25009cbd67a8ee7b417f12b35374b1@gmail.com>
 <7e04f3d1-df93-459c-85c5-9e57dc1c3cde@app.fastmail.com>
 <jdqf7rwmhri4b2hzuq3wbd54xitqsmw7coyx34cqhjepj4njf2@vad7brzfzj5n>
Subject: Re: [PATCH 0/2 v8] gpiolib: finish the legacy cleanup
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Nov 24, 2026, at 13:44, Bartosz Golaszewski wrote:
> On Tue, Nov 24, 2026 at 11:53:40AM +0100, Arnd Bergmann wrote:
>> On Tue, Nov 24, 2026, at 02:10, Dmitry Torokhov wrote:
>> > Hi Bartosz,
>> >
>> > On Mon, Nov 23, 2026 at 04:41:32PM +0100, Bartosz Golaszewski wrote:
>> >> Can I apply v7 and provide it to the SH maintainers on an immutable
>> >> branch?
>> >
>> > BTW, I have the soc_button_array rework (converting it to software nodes
>> > and dropping "select GPIOLIB_LEGACY") on an immutable branch based on
>> > v7.4-rc2:
>> >
>> > 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git 
>> > ib/7.4-rc2-soc-button-array
>> 
>> Nice to see that this is ready.
>> 
>> > I recommend pulling it into the gpio tree before applying Arnd's work so
>> > that x86 builds with INPUT_SOC_BUTTON_ARRAY enabled no longer pull in
>> > CONFIG_GPIOLIB_LEGACY either.
>> 
>> I don't think the order matters, my patch 1/2 just won't have an
>> effect on configurations that enable INPUT_SOC_BUTTON_ARRAY until your
>> patch is merged.
>>
>
> I'm not following something, the conflict is with the SH tree, isn't it?

I think we were talking about two different issues:

a) the sh/rsk7203 conflict is about the header inclusion: to make it
   build with my patch 2/2, I need to change linux/gpio.h to
   linux/gpio/legacy.h, while Dmitry series tries to change it
   to linux/gpio/consumer.h instead of either. It's not a hard
   problem tbh, just a bit annoying.

b) The INPUT_SOC_BUTTON_ARRAY change has nothing to do with my
   patch 2/2, only with 1/2, as it addresses one of the remaining
   users of the legacy interface. I hadn't realized that Dmitry's
   comment was a reply to your question about a).

        Arnd
