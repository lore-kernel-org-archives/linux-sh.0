Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359240;
	b=i2g9EzkCCqeddgqyX21/6fEi5Lqmb7m7yMsrMdAXwobFon3CQ80IQkaJ/eI8lhniG2+T
	 8ICnTrvcFkCC6gLlqNyYeKST8+5eO1Be+l57qyysQzl2i9ms+28/rEDXGgiYhH9jL1EQ9
	 z53ewIHgp/DgyueFkOxzpBKU2O9GDBeIkmCdzUTx5yCp4FLnTTYiOU1+B0pQxdB7f99ns
	 nUoW1NzaMb9l1dp7DJ3h/YISqhZq+caodVYfnJntSYGcRbHwGaFc6KjSap1dVwTJi7qKV
	 1eBbAY6JjduKQ6K3LDkjISarS4LZFyHv7e0iL6qkCem3aYzZkMS09Yn2nPrn9A02ieQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359240;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=az9gLR2CIWHo3AVLRcdFpGDfb4bNdsqdJahroZfhtgk=;
	b=31I5JBacuoKFxLv/CWiXANRToWawmAedLi52fAoPo/bUg91qY09lScaCpJfsvz8mU6rb
	 JYxJFb6gd8b3phKgDluOm1zH5oaP5HTiq/EUixDVaU8cXmx7ZLC3RSu5rNjFUzuNo6COy
	 BXr7He7+qv/qLGAHZR5kLiP1t6VcXFDksohD/HFijS+zamIZBfDHlCUYViLofDDCjut0R
	 Fh31VlohrTPV1RdQnOR82g6HBMo3KV6F/Y4je6AoVv/w/OAzGkAxLl0cEYeh2mrZVsH2a
	 N8UzyWKzEKFArBttmpb/M2Wv4LYNZrCVXYQ3WvzjDXgvdQJsM/h0t4crCdfRun5EB1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTnOSLD9;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5F606A334
	for <linux-sh@vger.kernel.org>; Wed, 11 Nov 2026 01:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BD5F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mTnOSLD9
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cdab9e9761cso1350919a12.2
        for <linux-sh@vger.kernel.org>; Tue, 10 Nov 2026 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794359239; x=1794964039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=az9gLR2CIWHo3AVLRcdFpGDfb4bNdsqdJahroZfhtgk=;
        b=mTnOSLD9tLnLfdQ5QuiVTJeC/UYpdhTm9yNMlFEcLtz3lo1+qKFmyyDeRh8Qgvxh3Z
         s2hFnHYcGqAZP7zc2M2PuiRiMY5l4dAqoWwT958tfdlrLyPAyRor0czIwppkLGNl6x0h
         Tpkza+cnDD4fKhI9ku5XS2rXj3TUmSU2863iXthliMV5MIdYgtONEN3nWZIk1Voe+RL1
         CDKMAoIOtUG4mqEs3KmDrl4NVwSeOKL8XaJNZDiNE4lGkSaKdRE8+c/ZL7v6e8oK/uMd
         sGYNjTo0FOcPgHhYWUgLgEYpPeTg60b6cI/myYyoUn3VN5V+O5xwum1njvXKdMLw2Ndl
         0IXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794359239; x=1794964039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=az9gLR2CIWHo3AVLRcdFpGDfb4bNdsqdJahroZfhtgk=;
        b=h+C499PyZbR+ILywKQcS+VOJO+3vhPki9FvbixpbDOi1/VxUvMP3ZwAtlqh22LFl7l
         EXWsVi1P5OQFS1fbEfMjN+0XW5Fbf1gw1/NuxEGc3EcXkjY9dxEMqaPIKU/iakCl9AYM
         aDKWHbL83e9zfDDgikN+SmpxX8QitF9MVw8G+QeqVqrdNiKwKceXdq8tuQpjssJzUq1K
         znSVG1bOmCVf2DhDOjciQpbbD3ykEq1F+HMO/SsEP0VyOzOZ9t9N5GHj7rR7IPX/YYr3
         MY+0lpHdLqnEhr3ZMcQwaSfO7+M0gOp9FOLiDSL9JSVJchpBZxHxhkmnWxjQsmWpUd9H
         9qsw==
X-Gm-Message-State: APuU4Z8GGUAy+p61JVttnNB/x5lqQJEqU+LivKYeT+2eugEOAQqmJCLy
	EnOfLqpt/fqUWyzDodAhRVG+84ChyoDuM1nj07EAmaCsagasdmJMpwMx
X-Gm-Gg: AYBFou0/YLalK3oKo+H9VeyKC8xuYgkhRMZRj4enQFkIcbG8BHSDL90FvuUFZIkTUX2
	SnpFLHRI5R5ygsFMxcqavtJ9MCeikCAgc/Gbe8DFc0Fw6ei4KTpcWQVUefaga634RR4Wdl9RPAi
	LpaE+gEkjoqQA4sZVa+xM+RPG+BZnxaJMIukEGy034ZETvjJW6/tXVniipCeGPIMTdmRFD+MNH9
	XZiATP04rpbL+D0owbFWVFSJnjX0tjfPq32OnnYoYFY/OA6cH+SVEy4lYYRxM3M0DYq5JEkRqQS
	QJOOq+xOGM7TkAYHNdNTENiHH0yf9jV1JwIXJShCI+b4aOdbJiIc1DwSGTCWaSdLF9zA4SxTZhh
	IHJrnuBmNWWcBu4CWMeiR9iZzpQ8V7QfkbgplLYEV0T2YSDNPoDZ0Oz9JsBfDrPOcC8l1diqyUm
	5hOCkcPtySHY44oI4Utoy5DjGDaKAA2IrBbLPBljvolGHppF43DoaAJFJpzBQcJlAaOPPK/Ipz4
	kdQOF6lZAMVKQpDoboTSQ4Em/jMc04k/NGcYcUD3j9Qk1HO1POwHPNPEml/JVlArKwB9DMQDvjB
	53QMvcL4+GCwrG5QNwCMjxL+LLl7/ufTc91nf2cNZTt69IJeNSngOHC9EuO9CIoS
X-Received: by 2002:a17:90b:1c01:b0:3b0:9a2e:b491 with SMTP id 98e67ed59e1d1-3b182f8c3e4mr721125a91.66.1794359239499;
        Tue, 10 Nov 2026 17:07:19 -0800 (PST)
Received: from fedora.lan (d173-183-236-7.abhsia.telus.net. [173.183.236.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b181f8fd59sm701711a91.1.2026.11.10.17.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 17:07:19 -0800 (PST)
From: Artem Novak <artem122novak@gmail.com>
To: ysato@users.sourceforge.jp,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	geert+renesas@glider.be
Cc: linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Artem Novak <artem122novak@gmail.com>
Subject: [PATCH v4 2/2] sh: sh7305: exclude from legacy CPG clock framework
Date: Tue, 10 Nov 2026 19:07:14 -0600
Message-ID: <20261111010714.227429-3-artem122novak@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111010714.227429-1-artem122novak@gmail.com>
References: <20261111010714.227429-1-artem122novak@gmail.com>
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

SH7305 now uses its own Common Clock Framework clock
implementation.

Exclude SH7305 from SH_CLK_CPG_LEGACY to prevent the
legacy CPG clock framework from being enabled for this
CPU subtype.

Signed-off-by: Artem Novak <artem122novak@gmail.com>
---
 arch/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5ce7df11c3ec..c5cc486eb1a3 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -536,7 +536,7 @@ config SH_CLK_CPG_LEGACY
 	def_bool y if !CPU_SUBTYPE_SH7785 && !ARCH_SHMOBILE && \
 		      !CPU_SHX3 && !CPU_SUBTYPE_SH7757 && \
 		      !CPU_SUBTYPE_SH7734 && !CPU_SUBTYPE_SH7264 && \
-		      !CPU_SUBTYPE_SH7269
+		      !CPU_SUBTYPE_SH7269 && !CPU_SUBTYPE_SH7305
 
 endmenu
 
-- 
2.56.0

