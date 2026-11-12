Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466241;
	b=IDxf+NxtpVWbpl/FhBn7i5irJEwWdZx61C1RAvZ85j26g1YtFBe4mXSHKFJ8Xe026SZl
	 lZ6BOTk2r6znOJRjW1xZmPOc2UgwZrwaUQ+EHRFf9yLZkLlS9xff3KcftFjKKIrgeLYKI
	 OqGh4schcx1qVBt2RwPUrvWVpP7jePa5Cc+2XX/06zvELd0c0FrL/M5AWXpyuNTbhbrag
	 r/Bk6YoxcUc4odLgkOww+SdkvirxqjjrVVdggqmtI63PYBG++/KXowDdtk08KXvitfknC
	 nM2dWQoaL4BcQ8mJU377Ed2pxBPYpZNF+vew4XC9eQi8kiOeXTBqVxzeVyz6RdS5MGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UQ104XrltwOzDQ8IcCi3Ok5RkLXXXhJmwNsMcy2ddH8=;
	b=BmkgrCFQK4I5sdGFEZG9XI3JnhHOoGhJbruKT6p8K222RReWfN7hXSuY+hzSan7qR1KU
	 g6HTWiLxKF66blIt9rAXBHfmaj5MJdHp0hJOVxGyK6FYXR8DRYafBC6CiA5WN2Ujj/MMU
	 9LN+8a5gWvDsAcFb3rftuMSN6Z4Ef4xWBLo9KJVOGudrDZAz3Y7gLRBAjyxHM3xiC2j6M
	 cQXKwCI//xC643rG03HmaHiKIkkPuzGu/CYlFaJoFoozTWGy6NdQ6JJLABeemvhg9E229
	 vMMbjFq7Mcu27XpNaGe2J7oxFwVbkTvaPiUkm1WYg4JZs4nwx2gE7SdJggtsGEhLCwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+kJtLGF;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498DB606AE5F
	for <linux-sh@vger.kernel.org>; Thu, 12 Nov 2026 06:50:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 498DB606AE5F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N+kJtLGF
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ede7cb02daso3936345ad.1
        for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 22:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466241; x=1795071041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQ104XrltwOzDQ8IcCi3Ok5RkLXXXhJmwNsMcy2ddH8=;
        b=N+kJtLGFASRGuahSux7Ypn94XBqaQfBt7x3p0iF0GNp3TDjNDeTJ8prQVSu9U8gFcP
         hlYxSbRXx68RnRcWwVG62mYXATTWyEhA25gQiWCIdjKvya7iLVH7GMPwISFXw/RwMRLg
         fh07Q9IhoovKjhk3QfbcovvP55djwpBIo7Mfn/cLYeKeGi0Pr7N8Ot3VEAv9Y2mk6zPq
         SX39mUH53To5ACHKMAXINsCDWFFxWCDb5zz78Stq/veL24gHJr5sBammaFm6wMPQfdTi
         mnM4s+sH+zw2UhavXX24lv6W+QR8G7zjJVVEyyNYEtD9mB6elnGo191616otDMecOWua
         XHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466241; x=1795071041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQ104XrltwOzDQ8IcCi3Ok5RkLXXXhJmwNsMcy2ddH8=;
        b=kJNLhdFSXlcvlAPl3BI6/THi9Ht4DIfzygyy/O9DTfvrMKnK5SPYEPHxIFlKo1U2ph
         MBilzPb7xQxVIAQts1iHC3n5AuGlda4HLDKswLZ2f3+hIW/AaRNVno0ZbDtRRpjnoZ+r
         1L3RQXURYNtwoY2uJBJg03Po8ZY55wM407mQ6jKpGp42Y2QTXKEegFNwpLSTbDxC6X+c
         8ptCSdhAH5+WO7Iu5hMsRiOwV9qco6MQ4LMrn6AiweQO50wyBAtnzfWd6i3A7eW07eu5
         IQ/9h5vVHrFn6QvAnj4z2ZK3iJzVXX8FFrApoMF7G7WX74rNK4licBQKcqxIUkVjso42
         lcKA==
X-Forwarded-Encrypted: i=1; AL+hErEfAkPlG9U9pkMyVhrIjf22lq81egixFOTf2DVsco4PbEUAkTJKxyAMpVvL6YThgSbDqTOiuOdHaA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HgFYElCC5OmYY9I5V36cEZlyKJUSKmNzvLZFFKFfYmNGHOrjK
	T534/qJ5mR1ZAia0Wus6QRcjQMzMAPh0A5gmkaGFas9/ZlZLxz1HDzYgKiMpODN7
X-Gm-Gg: AYBFou3fOXn/waR+B/BeSb0M9Bg+StfKwRiYY4fXFlxgtw6obCkuoOFaNMRNNpDLhTk
	/RIFAclJj7bRSpEnsF6PIgklT65O++PF/sobp7EtohZzi8FTBGV4mGUYkSl2dOaRqlty1rQ1Kv0
	qAZNtvlDjRRbRl7IDO3cwZigtDZ72KFRpAYwKFUJV/Ak+lI4Try7iJTU4a4LB3QiO/3drpNhep5
	PwYPFABXG7vwJTGnRYrcyMG1ruCUCQEHM9oW4UNXavOwWikvquMIeQnQutw6EGrsk3kqrefKdtR
	gDV5pIxKnsphHEk+2iz0RAPbA5rV19cbbwp3Uw1afd8X+uEDLNi28Q/D2iaKiCakVFcLlDXnX8y
	d6LsilQXC0c76AgWb2RwRnpDEHHfEF1iDh9lwWzY8j2KRZI3TJIEv86o1SqNRQTjVCpg2rOaZBT
	wz+2GZEndANqUH1qEz4P6n6JI8sETEIOlMeK2vH9yBrChk8/RMA9Hd/HOfVB1bcI7udVQjCkh9B
	TtDYTKsG3jgkxM3gcwU8t8IfKqkFZMbddUgm4w53zr4ORnal3CjYxGkZnFultBnvn8YSQh2eWgR
	Z+avupqzDA6+H2xgbnEN0Xc3+GcA6CaJN6tlJgUslX7aJGlU3yq1WA6GLbkn89eVffTJdfxauXT
	krd7y5CY0uO9LCoNYHzSBWvlFxwKZyCOn3rF0sA==
X-Received: by 2002:a17:90b:4b84:b0:3ae:3b3d:c617 with SMTP id 98e67ed59e1d1-3b197cca4b8mr1069474a91.29.1794466240511;
        Wed, 11 Nov 2026 22:50:40 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:39 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-input@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Input: tsc2007 - drop platform data support and cleanups
Date: Wed, 11 Nov 2026 22:50:32 -0800
Message-ID: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
have been converted to generic device properties, this series drops
legacy platform data support and its header file, removes redundant
memory barriers, fixes minor coding style issues, skips registering a
non-functional input device when no interrupt is wired (when the chip is
used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting the
threaded interrupt.

Thanks.

Dmitry Torokhov (5):
  Input: tsc2007 - drop platform data support
  Input: tsc2007 - remove unneeded memory barriers
  Input: tsc2007 - fix minor coding style issues
  Input: tsc2007 - do not register input device without IRQ
  Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt

 arch/sh/boards/mach-ecovec24/setup.c     |   1 -
 drivers/input/touchscreen/tsc2007.h      |   5 +-
 drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++---------------
 include/linux/platform_data/tsc2007.h    |  23 ---
 4 files changed, 60 insertions(+), 152 deletions(-)
 delete mode 100644 include/linux/platform_data/tsc2007.h

-- 
2.56.0.567.gdb80ae8cd5-goog

