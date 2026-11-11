Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359238;
	b=HFyfT0T0Yu26pnVSpnyWl4PpiynLkn3GRLJ4Q8HiJsi2kDNV8/tpXpxeVSZj18yoXUDh
	 I9wllxYttj6KsPRuzfh2aIP493K711UGAzSDhxSLClk1d41vjDIhw0h5aPr/LxXalaa+n
	 ugmZVT+ixakuDIKi+iOgrsP3Owu94J+2E3JDNzz2HTFrTkh7572AfvGqmDRRUgo+i6tDm
	 /nU4rOyyLkzK+7eiMGrlE4WDU2Ag8TdHXtQiUwOMgGj3twkjaKz/OGQtKc0IZo/dAv2D6
	 sa6+1gFXbIfbg4VJeErZpSy9OISOwRXT71QHuDA3QwDLlSdMATPYxCUPThs9hVnpsyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6LbzmDz7qPraA+XTAGiVYeN9C//rOWw8KeOnHh6tdK8=;
	b=IelSFlexfXf15fpWTeZgt4l1lm4WO9Q/IFBg6h6zFhgXQXSeosMhb5tez/LOcdCGiJ9c
	 2W7g6OE9oTE83T3z5TuhX8ycdV+kW8hbKI9DNi8sweI1GCU4839JO5sh/nCc8drun5pug
	 hE1nIwsMYmkTjks4RxRzH+1XOJxdr3YLINO8j43pej1v0GiI4EnH2g0cA5ibGWu/HO0XL
	 pesmuNk3xaHM/jU/tZmF8PakDMjSyRyZgIposaYp7BEt/t3eBLb8ZpU7HSzl6tNdF0YFi
	 31P6WEmEpoh1iMdRfU0qwoqn56Ggb0Ma8a3hdOkQ/8kH4KI7oaFLMuWqiP+4Ftut2qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eJebg/TK";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118A8606A320
	for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 01:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 118A8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eJebg/TK
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1568989a91.2
        for <linux-sh@vger.kernel.org>; Tue, 10 Nov 2026 17:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359237; x=1794964037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6LbzmDz7qPraA+XTAGiVYeN9C//rOWw8KeOnHh6tdK8=;
        b=eJebg/TKvg9sXmzHFGcMsw8BxRGn+Xpnifgl0BcLeTAg6afBoa4phoLi1zBN2ow7nv
         Cigr/AilJUn6A7n2WHJ6UavUzaO5qxvQjaqdAWMh9w8PEIlyYmB4tZfP2nLYAGzatesR
         pH+H624g64fCOouYMmsDJEP0K3lC/i8hDHvtj1UbMPMK7kgkSg7A18THNcrqOQrpbVAJ
         rEyLPx+1oUygIwtTkZrbG2m4NiYGAGtz0e758vrdjLHOk88N7PpsNtJzQQF82E0Sm3kS
         fiNAfsUEhF9L9X5GaerDWwVsvhbmxdyAKjygd2mogGPq/KKkUJdPer1vTwiMCZWuXgJQ
         jGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359237; x=1794964037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6LbzmDz7qPraA+XTAGiVYeN9C//rOWw8KeOnHh6tdK8=;
        b=dXNo6lOcmVB4DRZa11P/KWnoHz/p/VM6uwL2wv15UmRTamDikVacv8Zkz0DBET+RfC
         OURWiO9EeFsI60zV2yUorIuvMJNldtW3c69XSbo3gG/oNyUlJsNyVe5p0LTNXJydSokl
         Wu3/bLASrJHnadhA4Q1kNs6/HGNfoGQR8u6EaTkSGdlZubtuy3j+J4ZAQQN4g78ypFLT
         dRcUFvscdAvcupy5fISOlI8ScBTiB7d8umSf5iGQKWjr10+T4F0vtuFVGCrkY1i/wTLx
         RzNM5wYP15B6lPX7gQpWBqgtT5sS3OxiywSZVwYvLhQ27nZ6YYdpV6QFVUJqdq1lyz6x
         FA8w==
X-Gm-Message-State: APuU4Z/0IuKG+8Nu4s0otZUVBcHh0pnxjJemvhbcLhD3Y1ZVNgInywWP
	iNNDPaw2okF81S12bjlBcNB5/RJ4R1kk7G3guqyGrRMQioIfU5Y92Y/n
X-Gm-Gg: AYBFou1SwzdWhU3VuOG/s4YKSwBIh7nBL6zUqRHVLwQ3TYKavM5KPZrwXLXAastxHcB
	GFnoEc14XFmubpWTmE4mKZcuQZD7Nq5dsev3kL6bZghtRl1H+jNvdQAq+438I+ErBsobsdXabSI
	8JlvJKGHoHQrCKKTUzgZ04tc4ju4Rq1RnNz2Stv+R6WkjztH3FGMRm+EkHNa5cxQROCfXY6TgT+
	E2X9CbvKUaPgLjrw9OPabYBBGn5vmsXhPTHw2530XQF0hklMMPY+53nKGcVLmydiETF3WpqPd6I
	unFefaMBpv4B4/lMRpVAM2lzuGbpLldUTe+F9fnEGQO6DF+OWKDdHWZhQf9iOf0uOlKsuc6FUO3
	M3W4X0GpuY4TGXlFtbk58UHzYGdxBKiboXMYCimVVJATq3k7XTnMntm2aUzy65AbHgUCTzMrhub
	voYMlSZqnsnhwX73FK6h7Z/dvF2j/7B53Rlo0pPWojOubwCrQohnyQR6sN73ltHTPG3xcfPbuCR
	DQyiNSLXRku9QujAX+ez8iI57sfK9U36KDs2wIShbhROrn3SyAwGmpiXEqKKIgEhehUdFrtmHMi
	tTA75KGVVyZjEVIqFKigciUG8iaxygswpi/NNuGTHMWjWkkAd1gC9hQARzlxUc6r
X-Received: by 2002:a17:90b:4f42:b0:3ab:b39f:41b9 with SMTP id 98e67ed59e1d1-3b182f1f60dmr736828a91.61.1794359237411;
        Tue, 10 Nov 2026 17:07:17 -0800 (PST)
Received: from fedora.lan (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181f8fd59sm701711a91.1.2026.11.10.17.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:07:16 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	geert+renesas@glider.be
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 0/2] sh: sh7305: add TMU0 clock support
Date: Tue, 10 Nov 2026 19:07:12 -0600
Message-ID: <20261111010714.227429-1-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Post: <mailto:linux-sh@vger.kernel.org>
List-Help: <mailto:linux-sh+help@vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-sh+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds Common Clock Framework support for the SH7305.

The existing SH7305 clock implementation is converted to CCF,
including the master clock, CPU, bus and peripheral divider clocks,
and the TMU0 module clock gate.
The legacy CPG clock framework is then excluded for SH7305
to avoid enabling both clock implementations.

The series consists of:

sh: sh7305: add TMU0 clock support
Convert the SH7305 clock implementation to CCF and
provide the TMU0 functional clock through clkdev.

sh: sh7305: exclude from legacy CPG clock framework
Exclude SH7305 from SH_CLK_CPG_LEGACY.

Changes since v3:
 - Split the legacy CPG exclusion into a separate second patch.
 - Keep the SH7305 CCF clock implementation and TMU0 gate
   together in the first patch.

Artem Novak (2):
  sh: sh7305: add TMU0 clock support
  sh: sh7305: exclude from legacy CPG clock framework

 arch/sh/Kconfig                        |   2 +-
 arch/sh/include/asm/clock-sh7305.h     |  11 ++
 arch/sh/kernel/cpu/sh4a/clock-sh7305.c | 262 +++++++++++++++++--------
 3 files changed, 196 insertions(+), 79 deletions(-)
 create mode 100644 arch/sh/include/asm/clock-sh7305.h

-- 
2.56.0

