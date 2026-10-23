Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792740357;
	b=ODYgODkrjdfhqURU7jO8U1/Odykbvr2RVmVLpdlSHJaWPTp8GGevQGScEp8pybCXgWL3
	 vJXlvm3srfXy/r0zyHgAO46h9JmrepXs5feNHSSndb9czloOpKMNBlagN9pR/53BZEb7d
	 gNZ0KVplf3cIY/rYP0Uqf9hoa9jg00BDmdzCI11nz2VbaGA83eMSEfE7NcnGWQLR0lcYv
	 fHMg0snZ3A8Y/SfHNi/X5RarXNfF4LTxHnMtM3rbCuu3uKXOiSx5YliESfL180NWiZQZO
	 jsibFS+2t0PxCcmYQrymHMuo9sCaq69pqRcDZ54LiUzi0XoSQXMONOqNSzEJ7BeiO6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792740357;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=UR29Az9rweKwmG/FHwYSy4Zxlp5HN7tLC+xHHDEP7Vg=;
	b=1CtkiDEpWIq7g39tHKia9Ac6A0yzyprP3+wqOsmdeauo10c9lQmE9DINKDEF9K7R2o5L
	 32cjdI9BPpcNa/DBqMXMsIXQOVF4e6f1+B/btupDw77usArfYNSZhBshwbhaH80gYuLuW
	 wNZqpbu7hE5fi22Z7Ci9CCxVxjDsCPZ6tcZoIEyghBiOhxLx6bNQ/k9LYL5dOb1gM3H5Q
	 GtA9/tq2Fterauwh01pHblqI06mspfMaEVu8g0ph161QHJwKn/60OvD0ljKz6OV5QCpbQ
	 tV2J9LS5bWVN5Pk1LyViQVVjyCyvjdOwmFk95E26BgPeqBU7AukWbwfrYM1FBbZNQBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=LwpEKnlS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="t/LKUazE";
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE820606A31A
	for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 07:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE820606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=LwpEKnlS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=t/LKUazE
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 12AD5140014C
	for <linux-sh@vger.kernel.org>; Fri, 23 Oct 2026 03:25:55 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Fri, 23 Oct 2026 03:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792740352;
	 x=1792826752; bh=UR29Az9rweKwmG/FHwYSy4Zxlp5HN7tLC+xHHDEP7Vg=; b=
	LwpEKnlSruz2MkkO0AO0feSXby0q+0LF8B4+llgF3RfHJ72WmzqCQVCjA6mzuuG/
	MPv4LS2F7ghNnZMQvwYSFGFJKf+Ql+SeAz4nkw6mMyvLjqnLv6Nioy7D6UH7x+cQ
	vm/mXDRwkQZvR9tAkvUYcfaH0JYT+U5Jmt6rJzfUhGO04ZW1FFqtKvwU1RETGyiZ
	8Cfo/qAnEUfP2NKVoQutGfksZSWk2gXR+aDksWjgl8XSY0tgFXSaBcxOxnkosaz1
	lsSrjjDXoQBboPjz+zE7CdSPzt91N2yXNfbOtROG++Ezz45cH55jA53B0bbIe46T
	/Z7qGyegNb7f72cgXuaGcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792740352; x=
	1792826752; bh=UR29Az9rweKwmG/FHwYSy4Zxlp5HN7tLC+xHHDEP7Vg=; b=t
	/LKUazEjpptsgOTVVGLOyUx67iN+H8jM5UNTBHv0GnUTgnl92Qqkc6AqONAmKqeI
	P+GSGnmAqJVfEWOZ7OXCq58W6Sxp1hZ8a6fnsoxkHQ0dvwMblii7qZVRXyjmvVSW
	K68hHt9H7pXD2Q3gpmNsMkEmKOhugojqAfzsDpAaczpMpwV/jYatn9WDrwbpAeVG
	KMrRbSABOB+OdVFAXFjcBMX+uwVITmzi3nX8fFrPUCBBpwpRw/oXG770IwBCMXuR
	7NzWvmJgTj/zI3qxVHkRsxSaPlCIiSC4TMY9ceCNE2q49ekyccaBYXLOeovzFBeD
	YS55+5UYsA6J4xuY/WZMw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792740352; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:RYV+Ym1ph3mC/dVRdFjnhs2/iRMTP6v3fBZEuTfBYjEMt1X
	q/R08CsIBr19pHCZc+lWI8MPyghcvbrBVfOkvtDlsh/X+bjUG0yLktXO4MaCjRx9
	oNSJC8x/sI4ZwQF0tOnbK3Pmvaeh4QE0G1+ojC3tyNjsEMpVEIGwEyirju4Ak78t
	/j/FykAeef3ZwinxPA5gzngxk/HiwV7Ix2Su91dyHHEOnyeglwTHhbcqoqmHhvYi
	3IQuOjWqnMj1HC4choLIFSDSI2W/hmg6dltt2Als5f08TgFd6rHBcAQpycjeCaZ+
	SekpG/DC8ArgsaxKoDp8jgJzuJDZ96U+CSxq1kg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rBYetkeAQu5d2/2n/Dkw5SRbZ2B0w1gShixvi2Bd/eg=:fXbW+yRh06QgiD0PdkLZAhmarNBawaN1PDA3bbeZgtY=;
X-ME-Sender: <xms:_Qvbask7R9CnJrP0lAGqETxJNwdHuBrx_tbtChhIr_sMaLIM0itV2g>
    <xme:_Qvbamre5fSZEUD2x1Ck_UmGeHU3ag-f41K37dx_QQwa5202upcpp9Fku36kd25fl
    liID1czpUGXhSWcSn79eE0gZAh2Wh-xv4nlHSskj2_v0dRJEbMPNB0_>
X-ME-Proxy-Cause: dmFkZTEClNIKfcap71svuJThdRRvPmrDVzRwWli1kOKd9dtkFjsrm2DeczGsYu0PK0Oq/w
    oNm8TKtM23P2axpZSE88RCI7olbpXcY+BFOfmz3d1WfydV2xbT3F7QFlD3MUjspzsekhuP
    Vq4/75LNAwwut8CLiaDxX/lXUm6XqpiKQZYfp33GwiP/YR/gnp4jBMh6/0yu98ygSAP/b4
    mlc6AiENjR+nwADIKOhDZTgAg34uf4zmhAgJp4JY2SJmtMi54FflTA2PfP568tME9Z5nlS
    LFFQZds89J84jcG+PbKE4eCmLK1+/1tYw/FBXq76EkF0tUpetJ1jutwNpHHCVK0TE2SPfO
    6ydcSLEHkTh05dk6rAeOYf/92xWHXZlpacNRwQjMaF7vKkSgS8HvfPA2TSSiXsJE/pP2rS
    0kDQlQFFUk8KTgIpK489qn6p4Ar5fyC1yETfbyLreYrPoxQJoRCdaoo5bV1/KjovT/eVx3
    ePVrHjaqc1mbYfIxgRWM53N53hxgtN9W55TapB1UekXSkyk46N9CGlgIYIeV2aotCmhjJ/
    DiHaQc7Md35SKb65SlkgI7gWgnlznldTromcJtual+vIxgtCOjCtNOTDvE28wV+L/fnDvO
    ubiBFrF3kjVuxthsTeb2WTWYRAL/4RtuGtAZVE42nDsM2GoTD9wVWSvHDXQw
X-ME-Proxy: <xmx:_gvbalK__mc47poPj6y8xYq24v7gWxlHDLsgd_57d1K8YPHjzAMqUw>
    <xmx:_gvbagMdXDEDlBe2OOdRyNXRl3EfRcNnmvDgJFkwiczIdyQBgN7Nmg>
    <xmx:_gvbaj7KmbInEWQzqXOQauuJHC0HCga5_h0Jc1PS5VJEBWBjirt_4g>
    <xmx:_gvbai7uP-FmSMMatn2lkpswoCy2xHPjou55t3bLzI5hixq_ZFM-Zg>
    <xmx:AAzbaihJYtEtcBpc7FCafLIb-JL6JE0qXzZ6bxN62lFuiMHKlqCNd2XR>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 623A432A0093; Fri, 23 Oct 2026 03:25:49 -0400 (EDT)
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
Date: Fri, 23 Oct 2026 09:25:29 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Florian Fuchs" <fuchsfl@gmail.com>, linux-sh@vger.kernel.org,
 "Yoshinori Sato" <yoshinori.sato@nifty.com>, "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Message-Id: <4eccd2fe-9749-4220-832b-b34308ccc0a8@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdVOA2bo2NTz7L=+W_h_eTmXJY7JeuFdKbh-uB3n-23SDQ@mail.gmail.com>
References: <20261022233410.2959823-1-fuchsfl@gmail.com>
 <04cfcbc2-0021-4ba2-b3bf-0da3cc82d046@app.fastmail.com>
 <CAMuHMdVOA2bo2NTz7L=+W_h_eTmXJY7JeuFdKbh-uB3n-23SDQ@mail.gmail.com>
Subject: Re: [PATCH] sh: traps: Fix kernel unaligned access fixup in branch delay slots
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Oct 23, 2026, at 09:15, Geert Uytterhoeven wrote:
> On Fri, 23 Oct 2026 at 09:09, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Fri, Oct 23, 2026, at 01:34, Florian Fuchs wrote:
>> > @@ -287,8 +287,10 @@ static inline int handle_delayslot(struct pt_regs *regs,
>> >       insn_size_t instruction;
>> >       void __user *addr = (void __user *)(regs->pc +
>> >               instruction_size(old_instruction));
>> > +     struct mem_access *insn_ma = user_mode(regs) ?
>> > +             &user_mem_access : &kernel_mem_access;
>> >
>> > -     if (copy_from_user(&instruction, addr, sizeof(instruction))) {
>> > +     if (insn_ma->from(&instruction, addr, sizeof(instruction))) {
>> >               /* the instruction-fetch faulted */
>> >               if (user_mode(regs))
>> >                       return -EFAULT;
>>
>> The "insn_ma" pointer is always the same as the 'ma' argument
>> you already pass, as both are set based on 'user_mode(regs)'.
>> Why not just use the pointer you already have?
>
> That would also handle handle_trapped_io(), which passes
> &trapped_io_access, right?

Indeed, that would be bad. The patch looks fine then.

Acked-by: Arnd Bergmann <arnd@arndb.de>
