Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739306;
	b=pEdjsa1JBiCYdPURFyY3p4i15NNhzwCx7zx3Tke7Eqe4c03gBdiu8qlHIbh2OB5n7oWw
	 zFTAjIRs0q0IXdg+1D+oRDtQ37SGzRv3l85BIlZoXTj9O9z19Nfn/OPUR5FdY4oW2kBs5
	 spGtEHMKMZ9AyRoxI4dnbgPUJL4ur1HACFZKJYr4O3iuBUX6IY0HWC94+2bmCLby+CV7f
	 bIR2iMwycOF0tg4C3tkV8A6O0uUqHySI0Ue7k3cH3oc+NCrrj+11hSoGvcfjE4ry2hcYm
	 h8Lfee3CZXq3UTX2DmGIr2s9oZ9ZY0qsxq76Ys7L5cqY3nV/HeIsC+yfVTwuZzrjuAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739306;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=82Wx7AX++5oKqGU7LtU3ThMwJm2RmYtBbwXGfMG0TKk=;
	b=olTuLIWG4WLc3scjtRXhmz21I2l/4UJCsWyPtsfZodu85a4s6nsMqxHuaSDB3dyG9m1y
	 oKh0gosE4iBPfvegbY1irW/mgEkyTjoT5WLF1xtT1LV4q7Z8LU+J003komnVDAnnOHstT
	 Snv1tp4cZ4aLc2UklfXgs/Kt2niGOcG5Ht/ZuONegCFVMxgXHk2l8hJCjvzJu1M7ecd2t
	 kwIJY7jcDumU5ZNroXd1SrnBGHK6Y2ER86YuZqd96rlDf5C0fLby3h7iEWPrOPG7foqoJ
	 jDmvSw5FiklckJ+HIZUFv9VjBxMe9rTpqFg+E9wUz5lOZfO7BLNacxmQbhchN8CKH+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=c19a0Zg+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IzH7f6Aq;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B8606A31E
	for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 07:08:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 727B8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=c19a0Zg+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IzH7f6Aq
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 951F814000CC
	for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 03:08:24 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 23 Oct 2026 03:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792739301;
	 x=1792825701; bh=82Wx7AX++5oKqGU7LtU3ThMwJm2RmYtBbwXGfMG0TKk=; b=
	c19a0Zg+QIb2Dbuwv6n4IvjO5KfIy/sxA4HSfKDAn6rECQ/Byrr1Pyh44Nq5MDdj
	iwqULif5RsC3BS1w6XFP9n4dRNgB5nenXQPKuSCfENHhGU5yczBCDpEEux/Aibi/
	LKZK/rO4uCLsFmy4lgP3eHsVI1Gz8eqE2TcqkHX3CUHkIP+3EUJBrv8+zyGuegjT
	c+esDiasbtWVd5/weCbuItM/wNT7dXinhoQ5X7vFuQs4uxfQTMZtqdADUHuiKp5Z
	TxvefglbYAfArQjtmM4Xt5cpjwnCuuMbiiQvQXoiW6o74rAcqKEaStGLXfBX7SiH
	AAd8YFBZO8jpbyLg8wu+Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792739301; x=
	1792825701; bh=82Wx7AX++5oKqGU7LtU3ThMwJm2RmYtBbwXGfMG0TKk=; b=I
	zH7f6AqSdBND90jz/5bLpcjnO1PPDBhuZE4OpkBx1vaAY8yD9rqtwIy6witS5U1+
	S1lS/ylH9mGtdgv6yKCiVD3A9yu+/648VkU5v2/eRdRA1cYdt7Bd3oiWhaSUNS4V
	3dzph5Gf4jboGvFknvocCLLJyNOSgBbFiI7Lw/ICNO0hdD4y0FCqzZ+n9bugYOr2
	YbWg58f08uQQ7wx3J5Qs9Hk7ec0zsGYY08CZ+9/TJmvkVMQ43yO6IUBRG3xUCU88
	ue8AGOS7aZULQkk6dOY41G/CJ20jl3T9OMz2vsr+f1Pv+xIomRY+R5VziZgbLoao
	LGyD35QsFLCjdl3VdmN5Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792739301; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:EkZN7U8Mtos/X+YnTTnamjwpCY9CNkGyDjxLUm28uu2zwoh
	vdlYObm5yXiQtgziNu8Es93QtZb+PxOohEgmD5ELt/ygC82p8SlIdQYdpajzKgOm
	5SxFPJgAWoYWztYbFgdBHPi3uxWki3FxCFjCMrnDNcoEvZDx40mhrHJ8fvNNCAFM
	euBk8xwQHkz6U1/l3U8ETg45QidoUqKnImwl/oCrsHrX9uNouECXfeu1W+3D9FTd
	jdxaDZYRC90vRQRFolFgRY6M7ej4SZeZs25uQOj1cqf9Pi0+HB311blbgOaxcqmb
	WU3g+LzbxwL0pawlA/P7rTKXEraLOr91U8shEGA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:eYicQZ4ZI09WKrUrzJ0vPIeuBu1/hfNmh/I/rUWrrPk=:+RJtS8dO2Obx2wQVHsui0+l0ARPaU3Cr9jdggohi87o=;
X-ME-Sender: <xms:4gfbahUuKH9ZFY5KUt2iBe70UwKsmprjmKsGsGtWhFiqTNTmKfXzFA>
    <xme:4gfbasZQbcpiHysVj_uISbnoD1UerQN-OyjtXXa8JuPI9yLF9GOtGPcATxF4jU_dm
    RpM_Qofbv1hR6juVWtsnGsLy1_Z0ce639xf8rmmFnKhqhdvsC8OiA>
X-ME-Proxy-Cause: dmFkZTFb9RAUOZ6dUYOBxlsQW6+NOLcFOtIqKejPOpG//e5EOnn73Jow7cHdL9QLax9Vl4
    mQIG9ImqNAGu2AOcI+PMHEYaRAKaoYQmJe7EicQwC+zm+CfjWQEUMSQSUEWutUtMV/K64S
    7NGqAup3qVnHlKkxv2vOySnM8AiEed5GpMq/CBjyvQJooi1Qgaq9igJ24H58IGGl/6Hs/X
    WgvclVdyQXrPhNOotNeI91YZMhViuWzGC/5ZUHXqafqBXL5kQvdcq+vWxIDXPCCcku5puJ
    vwcnY4JPjjCjK+LC+Ci6JJS53MwVvwlG9lMzBlC1C5tBgLW/vDMVLWcEaFnga+9aB+T1rE
    qzT7ZwfNA8B0lggFMqhnKL9a6YkWAWcJm9vZVLG3My/pNQdAlF8HouzD7upJANuVRRQSM8
    4AlFrD4Fg25fI2DHus1/Zlivl0PmZuWxwEQi/QGXvTONaD4nBliL2N+aGDOkYWu159YaaT
    h+PJ6CDMYG2RRGsMbZ8sFqKKDgbIO00ZMk+0od43T1O4KyfbZLAvLYAgKSwcgVNtuYFZLs
    sMSNBKzzTt1Q10tUs76oc7XsZGUWS4G9wAvdyBZiVNELcN8XtkNwU3JTwPyQVc32XtWG8i
    TdOnTnSllV+hE9ztqM9/bDp9vSEr3fdNUA+7F9nt1GFLvkV8o/DQpyKl5xsQ
X-ME-Proxy: <xmx:4wfbakJDruj2EROYUzs_RBReiWpgVVkuiJzjpAtbLo7gPFJBaFq2Dg>
    <xmx:4wfbahvLu8po85o_dUQyT7b2crNr5JO5cyZd34ojtGdBdaPzNuSpvw>
    <xmx:4wfbarIqA0DIFcQjRVUJPTBZcHhBFPD5Io3_fJmK4XF50_n1o5xklw>
    <xmx:4wfbai_ugRnzpQwGdUHdhovaYc2erGP5Ep-O0FQTW-PP_kqd_UkUrQ>
    <xmx:5Qfbas9Upsv89iheNnSmX3PtUNzbBvOtC4Wwfou4vhKTUr8ryP1Q41Li>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0684032A0093; Fri, 23 Oct 2026 03:08:18 -0400 (EDT)
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
X-ThreadId: AJ6RlB2RkjcF
Date: Fri, 23 Oct 2026 09:07:57 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Florian Fuchs" <fuchsfl@gmail.com>, linux-sh@vger.kernel.org,
 "Yoshinori Sato" <yoshinori.sato@nifty.com>, "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org
Message-Id: <04cfcbc2-0021-4ba2-b3bf-0da3cc82d046@app.fastmail.com>
In-Reply-To: <20261022233410.2959823-1-fuchsfl@gmail.com>
References: <20261022233410.2959823-1-fuchsfl@gmail.com>
Subject: Re: [PATCH] sh: traps: Fix kernel unaligned access fixup in branch delay slots
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 23, 2026, at 01:34, Florian Fuchs wrote:
> Commit 75d4d29549e5 ("sh: remove CONFIG_SET_FS support") converted the
> callers' set_fs(KERNEL_DS) sections, but missed copy_from_user() in
> handle_delayslot() which relied on the caller's address limit. This also
> broke delay slot instruction fetching through handle_trapped_io().
>
> Since the removal of set_fs(), access_ok() rejects kernel addresses, so
> the fetch always fails for kernel code and the kernel dies with:
>
>   delay-slot-insn faulting in handle_unaligned_delayslot: 0000 [#1]
>
> The initial instruction fetch in do_address_error() already uses
> copy_from_kernel_nofault() for kernel mode. So choose the matching
> instruction-fetch accessor from user_mode(regs) and fetch the
> instruction.
>
> Fixes: 75d4d29549e5 ("sh: remove CONFIG_SET_FS support")
> Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>

Hi Florian,

The patch looks correct to me, but I find it a little confusing:

> @@ -287,8 +287,10 @@ static inline int handle_delayslot(struct pt_regs *regs,
>  	insn_size_t instruction;
>  	void __user *addr = (void __user *)(regs->pc +
>  		instruction_size(old_instruction));
> +	struct mem_access *insn_ma = user_mode(regs) ?
> +		&user_mem_access : &kernel_mem_access;
> 
> -	if (copy_from_user(&instruction, addr, sizeof(instruction))) {
> +	if (insn_ma->from(&instruction, addr, sizeof(instruction))) {
>  		/* the instruction-fetch faulted */
>  		if (user_mode(regs))
>  			return -EFAULT;

The "insn_ma" pointer is always the same as the 'ma' argument
you already pass, as both are set based on 'user_mode(regs)'.
Why not just use the pointer you already have?

       Arnd
