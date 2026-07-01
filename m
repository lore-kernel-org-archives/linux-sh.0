Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE8638E8AB
	for <linux-sh@vger.kernel.org>; Wed,  1 Jul 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782926355; cv=none; b=cL/adeLOQ+ytHGixtpGtm7YOWJQCX1n6qpUtk5gaYBNGH5C8IDLbtUBYHoLJGOTsw8lmuAESGemxJO5BdI9JhOIx4dHUGhK3gRvbnujfmuil+tLKQ3Qis6bJ6GT4QSP64GwAT09Rj5RrAzNYT38WX9pCOef7MEsk/uCTQE1EjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782926355; c=relaxed/simple;
	bh=fJw3Kzl9q84XLSiaTk5SPS5D2dM+Vl8FRhyKh6B/k7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkv/rKG9d7WH0kBLbNkZDWzDt9kDRupH8O57x3hc7aittdRqK3AoTLJ6wmWbPiHp6T6ZHZf6s1lDxlIbzAgtmLejl1u4YdIudVv+g+mpkUWSpS0fMPipgt0A+4wCuWRMpLfHSk0lkwZcmcR7qcav5YhdRercLTSyd/N5dV72KNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgzkFD2a; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgzkFD2a"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-845b6d9bf39so582151b3a.1
        for <linux-sh@vger.kernel.org>; Wed, 01 Jul 2026 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782926353; x=1783531153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEAivEsfeo8Fq0sNWZpHlLBA/MD5F/SkLxOz2gsFyHM=;
        b=CgzkFD2aCsek6aGGFf6J6Pqf0aKL9zfAHDi15jUNeFqQi4zddFtLMTbeN+BhceBcJK
         lJmIMb/KK6Wl/k8fbWFtp7tkOIDfkDmfwRJviAzpzcJ+cj9BlSz1sROH1OkQhvrk/K6q
         4jpfaVLyN5PvnQtWO+s3gwUs8SI0kAUd4+gmL3epm6NPkNY9WF/qOPfq5N6siJzuHXS6
         Pt7l9uyDuuCIdQu+2+6Z8jWhf0670ydTTjQK4g4ac8dfCwPMBrV3x7vlxIncdJhNiPYL
         BiVUxFWop4LZjijDtUfH5AnHccC9bTAYr+liW7YWKRFIMg5HaO+Yf4b6aUpHhPH6MpCG
         xItg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782926353; x=1783531153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xEAivEsfeo8Fq0sNWZpHlLBA/MD5F/SkLxOz2gsFyHM=;
        b=iHa/w9G/XL5sghgI88Ohr6KTpLEdEbCIsmt/Ny+3Ma8rl02Ja4GbyMqKwE+yK5nggI
         hvlrKeJSPPneOh7Vt/KoydtzT/HLrsFWd25l2LieQ3DLMPGxdC+i+mVjz9dJG9BlI6p4
         MSL/Eka++yq53C33PZ8/S19qLz07KFUnu1rjS8hiN6m9/AxiteP/oGZpucTekBC/712D
         GhV/dFnlSYKsb+yQnIGVZWV+E5S/4+tLRSbMw+U2QKx5Lzcp/GvEJPM6Wr5s9Ji1o944
         Govjp5dQcjvGVA6Bbi4pOUPcn7Zu/eOjaProCIzMDl26OD9HP6tv6dxBMoXGQzfNw9fu
         y14Q==
X-Forwarded-Encrypted: i=1; AFNElJ9rct/auTV0JcjgwRWnmNe3eEg4q2fU0SrJK9fzJVUyEQ9kAQMUCwSeUvvwkCl+Wo46KFQIQ8HpMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5eC2UKX1TFZFqtTy14VHOoPEElF7wI2I6GKQMoj++V3KFIcGY
	vCkZOdTLxHQ3Mu6m3ULjduDPGUgmodEJ3aSXIiBjX3HkDxD0m6y6ValM
X-Gm-Gg: AfdE7cmuv1i0Vj1or9cCCZIuaiEOFYXH/nUl07G79E1+6y/cMm+3QBGlY7vgHNvhpCK
	FkzvZIgZ1+tEc/GtFyLHQ0UN5igzp+tBDwRHMYr2aj8y5eo8D5jOY2mNZkX78X4gBEHsSUUVp/j
	8Z90zx9Idrw3PA46N7gtQ3hjJHETIRpdatuWMU6gP5sn2oJutaqeSeAQFbWpTEE6o40bo/Lq4/j
	SsCQm/gIQlA5nWiJ4D9ODxtPutdaRjAC5WU0jaPkhdp7C4a2JvRm/UQggppYp5Lqp61doR5W2+l
	sKL3uI2qSiO0JaU4MP4Ntl6dSaQ9SSUyXZPg6kltjtVeBM2B5z82ZqPy7D+c4go6oSFgXG1wqtM
	K3yk1O5zS5xhC03e2llDjdAaaeqaAtek3/1pEKadvXQ+4nv/kKGrqGqDD2SF6DsLTKctpApxVjb
	9SnpsuhgI=
X-Received: by 2002:a05:6a00:1910:b0:845:a390:fed6 with SMTP id d2e1a72fcca58-847bf944a71mr2486907b3a.17.1782926353391;
        Wed, 01 Jul 2026 10:19:13 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb94ab79sm105719b3a.31.2026.07.01.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 10:19:12 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: akpm@linux-foundation.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-mm@kvack.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vlastimil Babka <vbabka@kernel.org>,
	Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/4] sh: set node_possible_map in do_init_bootmem()
Date: Thu,  2 Jul 2026 02:18:49 +0900
Message-ID: <20260701171851.2447626-3-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701171851.2447626-1-ekffu200098@gmail.com>
References: <20260701171851.2447626-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unlike other NUMA architectures, sh never sets node_possible_map.
do_init_bootmem() marks node 0 online and plat_mem_setup() marks the
rest online, after which node_online_map does not change, so set
node_possible_map from node_online_map.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/sh/mm/init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 110308bdef01..13954d7bbdae 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -227,6 +227,8 @@ static void __init do_init_bootmem(void)
 	node_set_online(0);
 
 	plat_mem_setup();
+
+	node_possible_map = node_online_map;
 }
 
 static void __init early_reserve_mem(void)
-- 
2.43.0

