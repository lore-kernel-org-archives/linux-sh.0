Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764093;
	b=Wt8IePflIRx4VstibvUIsO0Q+ARPoRqDFcDf7uCPgUlKQZFoiMAb9tpNUnnRvfCFipIj
	 hYqp1q3b0UryIyqJIRj3OTa2reWpWm3HVFcF0jx8hKLMMNagwkJExHDdIH2d5N69Fx4rk
	 NVUuucJwkwLbXHqgdaPpsSrZPzDWYY98swbDAHD8gjC3GfrYNwPoQBtswhOZN1U3CLG8J
	 UE+TtAfwpc7NYnNDY8xc6WrQ4CkgPHl+9yKXfxMy3rSPz6JHvY71oMn3CDTD17DFHGHY4
	 mIpPv837R0oOWnkuLePYqRbkNL7ikW/1Fd3FFN6LlOmz4w9DwL6qLzORaLovLGP6d6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764093;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=qj74dmosnD7KLgk+vBYietoQ5PUnLeXDgyrsTv3MXtE=;
	b=tBW8Quqg/LeNFCT1iNkepIyXN2EahkugxGF1dMt74XwncklU5uNgGgnEq5rSWEZO88gr
	 TXEZmXJBXy/Jh3ffqMZDYSBeteJUbGtzBO/5o/3IozJwjwMNZoHX+M+rRKQxYtMyvpGK0
	 dozwxbr+KrcnhPVmgVawb8EhmZ42H9g07p9q4k9Lk8QePra+X2r+qerG4MPXLrxWVCoGR
	 xb8aqcMUqhHyVbtyejfa5BUG8cq7rQJfQGD3+1MuYwjWCDQHqyoAVkDAwvxPNP2GQ5A0U
	 fbIt6YT3c/gyobNhNvKL6sicuyQHoyiMWfaETz5n8HRVkhswHpPkBN3pOtcpEIWZ2hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=glider.be;
	spf=pass smtp.mailfrom=glider.be;
	dkim=pass header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=UynUuWkT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Uit9dfeq;
	arc=none smtp.remote-ip=202.12.124.136
Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4055606A31E
	for <linux-sh@vger.kernel.org>; Fri, 27 Nov 2026 07:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4055606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glider.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=glider.be header.i=@glider.be header.a=rsa-sha256 header.s=fm1 header.b=UynUuWkT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Uit9dfeq
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailflow.stl.internal (Postfix) with ESMTP id 489D71302BEC
	for <linux-sh@vger.kernel.org>; Fri, 27 Nov 2026 02:21:32 -0500 (EST)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 27 Nov 2026 02:21:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=glider.be; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1795764088;
	 x=1795767688; bh=qj74dmosnD7KLgk+vBYietoQ5PUnLeXDgyrsTv3MXtE=; b=
	UynUuWkTmuRhjqfxsS8jO+U4z6gpfwWf1mvJlgEUTXBFJJoLFUtwqrbdTQq8ny3z
	Zatku3g4ZrPd03FsOcyo3OX/6gsYGRYNDb4zrIg+yDS0qNIpnfp7Iyk8Gyw/ldlF
	fOpDXsZIwcunAMIORF0wInemKgqGImKFzsK1dDAm/yKJW150oVmKDhKfESeSy/yf
	k6CgLpWBkjrD+peDB7BnV5lNaRonJAwL5thIuA4pWgh5N5aeygwWdx4qPgrdFw3n
	Q2pa89d0/GaaVrjc4CsNdMH7Bz+sZVzj9ubvp21pBV7tNe6a8LMVHW5BxtpVTSlE
	WMufbYCI5uVGed8Exk0fAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795764088; x=
	1795767688; bh=qj74dmosnD7KLgk+vBYietoQ5PUnLeXDgyrsTv3MXtE=; b=U
	it9dfeqaXL+wIx2FbaPBWkqa7ug6aZ8QezkMneEhjZwnPvWtLykA+YEI0W36BHCe
	OSo1xbDZLK/+ZvhcKyj16om8FdsfMCMRx79Lsxpvx/THJIaz2+agiY4+Ed1CdBxi
	NyPRCYEp5BAmt3VnwUVAdQNZaod0weoIvj2T7+Rsb/Yq11muI6iNODK/W1y4drrv
	Ppfy7vih4hTJU+lhSaDGPsKswWPRF6lwDyAvv46AiO2PYlvpVkSCJ+3MUq1NIKkg
	5I1iLAzOQOqbC9wJBYzBKQ/dsQs+6oDZzIlwKg4AkM6HQNRRnvRl975JjujY/guk
	mUxIvz3hu0+H+rW7LCFdA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=glider.be a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795764088; d=glider.be;
	mf=PGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlPg==;
	rt=PGxpbnV4LXNoQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:ZN7bRaer89eTiEDmwMPzrd/vlYV14iuZy7t30sYZSASj8Zm
	X5chIRvexCPq8Jj1ut35QE5nYYnJiW56P5AlC14b7HxMXcDg6/BaUwuTzVVwD9gj
	lgz9D+U5t09TH6m9n9V+xdZCjeRglYHX/JolKDgu43jJddO+Ybnxwfg/DzNo8tdF
	BWoWaZ8SvsK9W5+5xMVFXU30kDfhPSyVMFiW7ea/PplGCwSCc0XAZ1TQsjT7QapL
	fkLPh4ClYaI74jr/ercEU3pivw9sUGJ8c+IMclbBJRVGOy4lWN2VHQcNstywo9EE
	hKQ8C7vBWilPDMdFULOxYTuqL5/gdVzAlkN93ow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sWfitte4NbF5y9SEgyIY7Cmd9xUqSwkFGei94mhERu4=:m8G0uIcQ+kwcg+eYa1cvBJ310J/wRfCiNftI6/Er/u4=;
X-ME-Sender: <xms:dC8Ja3bJ9jIPCyeUU5idnbVR8KKtueNTa2UhpVOml2UV_OLhD9ss9Q>
    <xme:dC8JaxOfalSugQreMYr51gXDv3iQOKfj6gxzHueFfxuL72rlcp64-DxsBsigXpc_X
    a-fYcL-1NZM2C-SNDyW9bZthx3HZAMaXj_ywdCvOhdblG0ATCpuvfE>
X-ME-Proxy-Cause: dmFkZTGSAX+FCnnGNPBt/0/o63UsBChFS4yTH8xTA1iaEs2NutNNBPmwAF2NN/WxJxn/MK
    n/dbCCPPLror4SP6RuGogWOxuBpQD9+/33WvLOGJG5mWKA2l2xkFLLbmB4A/6fme0SJXGZ
    nHJ/9s2rST6YFXtW91eEepsQ1lAs58epA0eDSN9w6Oz7dsXj4kHPfRQdkPN/aSNC/rei3l
    p8C1afHaqbvtseKxVIY95BKniacWaLuq9HJQC3pEs2JQMNmtYKfp3CX8pwT1HvBXTyE3nH
    xbBgfulcEgxb4JUWOaNOtviEUqEZM6dqFrl9udYBhnXUjBm3xs4BReGV8CMEtkKcrvvab+
    6ZKkD+SLWUfwjms+2rE1F0DJEbdvvRE9BMH6h+vorrhAx3KEIh/5PV0fsZBc9bmlLOPTjw
    3Y2T9GTeGOWukUFvF+ilNXxs1B/5wQv4xRTi68mSE5xm77e5VS0K4jrs2Jo7ZHGQTKhgwy
    bPnV8oEMsfBoSy9D6jeTDDcaNDtQQ4dD0k8sMs9mm7nBhpy/MDlBbjNNqeU1P7R96ndv1z
    GxP9BVjSqOB48dUaR9IK+EgUywjJdKKFL2vSfHfG9cRww831KY2Ga9XmXqoAcB4v2l/pUO
    DzQ2oFZI++QjtSFENkfRtbnE1HDEtHGYucIspLJxDZDlbFgLii0qTcP0rftQ
X-ME-Proxy: <xmx:di8JaxQ2Iz6eSyQhbqTDujPvIxtCs3JOji6cQu-RzwMNqNV53ZIfTQ>
    <xmx:di8Ja7dss9jwIiFJNe_hHur1gI8DADtv_pqOG4axFBXdL773s1XtNg>
    <xmx:di8Ja1CIeqqvs5H8KbG_KPOYcIvA95bhbG1O_ZR4Mf85cmUxyO8Usw>
    <xmx:di8Ja9lJsQjgT3FrIuseaIOzlH_wpCh6TyRAYwolAP3YWH8jJGo49g>
    <xmx:dy8Ja-zWN_DJ_j3cSJgXisSHnVO1IWGvO3Xn7M4P1fctX43iqUh3ZHnB>
Feedback-ID: ia0f84a9e:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C12F2F8009C; Fri, 27 Nov 2026 02:21:24 -0500 (EST)
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
X-ThreadId: AEA1nZ_JirSs
Date: Fri, 27 Nov 2026 08:21:04 +0100
From: "Geert Uytterhoeven" <geert+renesas@glider.be>
To: "Artem Novak" <artem122novak@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Yoshinori Sato" <ysato@users.sourceforge.jp>,
 "Rich Felker" <dalias@libc.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>
Message-Id: <7a3f9766-6c66-4990-9adc-54386b4e7fa5@app.fastmail.com>
In-Reply-To: <20261126234343.74235-1-artem122novak@gmail.com>
References: <20261126234343.74235-1-artem122novak@gmail.com>
Subject: Re: [PATCH] sh: Kconfig: remove trailing whitespace
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Nov 27, 2026, at 00:43, Artem Novak wrote:
> Remove trailing whitespace from Kconfig entries and help text
> in the SuperH configuration files.
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
