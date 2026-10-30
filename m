Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349492;
	b=eXkq+hWd0RG6cowXQHq+bV7eErY1YEL2cMB10GnQFaYjmLqSZoX6pfZl8ci+jaHM+Iq7
	 hnrSSonqgiTiMHiu1NazS2ChULb0DIthKDgjMdjgf5ZHOwvwZwSKLJFN8MCo7VqDzDm+G
	 kqndQ1MqRkcx7DeMM1kxDnXLL7hFlWI2Vd+Wym72WWtxi/C/9v0ViIdzUPoff3Hn06H2w
	 Kf7pRZjYnf29KkWBLU2PRtMUFXRSLrPq/XX6L9OlA5pficJ+HWoh7hxP4k6WrM8HCr+O6
	 qnmgeRfJhGuN395mRtXXZ+jepNvI5L0ixuE43Cgl5dMeTzre6LMnGyaPqS1R3NhNKrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
	b=oskdiR+oCXsw3NUOzD30Me2Pm7w77i4hYEBhDNuo25oIkpYcpN+21Ixz/58qSRf+NxWO
	 gIUcm+OWCpniikCOnsw8j9FMZlXTYpEDuPPJ5+MYvzTnL1CVKRWrSPvyjHQp5q2T294lE
	 T+w7NJXPxlo1fsoEnk/gE6cGtUX0/KQoAyqldkjic+Rd/9g+mwun35hUv6zS9h5jZUTY6
	 Hv5yuWD6RnAlYTQ9/888zT/t+VpZryJ9mZxgCNq6U8d4DpcXCmsX/zjIBz6kU1eHu0Lyx
	 BkDmat9gwszMEGPsx6tvDjq1nVXGiGYiIf78JvomvjpeSW9LWmSJS9FsuR+DSYvNb7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ROqGPh0D;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5D0606A31A
	for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 08:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E5D0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=ROqGPh0D
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd623dfe420so302365a12.0
        for <linux-sh@vger.kernel.org>; Fri, 30 Oct 2026 01:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793349491; x=1793954291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=ROqGPh0Dfs9ymZb9Fa5fNeIZ5nxMYmihFo58e+rX/JsIhGhE2CqGZR7C6FqQo3PZg7
         Ke07UpBXkh71IWJ41Ll2Yd8zKQ8rWqx5KxSeVE+rmHGd9HDpIMsV5lg5/5d4GAHdH9iB
         J6lqtiidZ2+gjOMryZ0UzzwKPDyo2iDBuArbaChfUwbmaZEpKt4u+DlMlCTZQPZlGu6V
         u5Gh6vEoWY5mG6soD4Uu8rZPNZCOt/fzv8C7nP/j/L3roGHwFir3M59q6cBgLasowhcA
         va/vZcubcPXPvLqiUxXouOh/t3xp7EoZizdb5indrmCS281/fLjQ+0t17LmvACxIPc8Y
         rR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793349491; x=1793954291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ml5g8GJyiKqZW7cPKgtShDnwVwZ+S7TeGUyvRqBFqBI=;
        b=abfq5xK3DYR11ibl2/G3K30+ZBB0oEO3RDUUH3jXbKy2S0cbd81F1l6IhCzQhlCHUH
         QRXaprTpu0ROYGSYVraos8tKNHfYF0O+ZXK2PjMKWHo7zDZP5y8px7qWtgJk8l6wyzRN
         3XUUX5D2HwnOLxrQttJH54C/K9uxTn/m9bRF7SfS/+1B++2SxWN9TCHJ3Fmm95whmZj5
         aAF99Ly8HR1qPPWFex2rtivUB5CcLnvmunw018G8CoaOLIxA3tFqVmo0W+Q9GJwTKo4M
         mrSyfMKsIwqN5b08E81uC+Nr19XWyA2zuCkmbvt7wFyiwUTHUIMOVJXU1XeFzHyJATLz
         EqBw==
X-Forwarded-Encrypted: i=1; AKwUvBz6GCkX+rtaGhURuc+NYELOz0EAX7f50eJckikb3PsYaUg6+5XVjMEcCAYFgLZAgduP9rWXEZZdQA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIjJ/jgl7vILylIrfvzXSt+CTUkV+9vJXCEgGtmaDJex0aCcG8k
	av+AE2wdDbVzHCNLfjvDdz9sbQnLJAPW9Yv1pIeQMxF4rTxE45sJCJ0XVfdacLX6N+o=
X-Gm-Gg: AYBFou3ywjMgiAt/lc3mlW37rexramENBh71zkNSTpZzkTZDRhr2lmH/gGPg0mXmoNa
	ZXrPBwjvubqAvwJQGN3plYkKAXIRE2DLH8Fx2s4vzwOik8NzBhUwGNufedCJfGjCBN8EwfTQPMj
	8c3ZGOosARqpzI0LsWrEqRacr8UXV9lM1LGvWVro/ZvEdpXB4iBAgFSSyZNB1FgrEtAxlN67BlO
	6pCfIYIkfPbeA1EJAiC57eulNHF15drjewxk82PbwDglWFpgVtIp2nbqEVVmIBlGLkeizqzvZAf
	xoGJEcZlKz1LR7+G2ny1unh8FpUT1o/DDW7fOIXBWPBoTdxj81y8LnE+eraGH1NWfWsxbIJOB+H
	PKhqT8P+aW1BWVz07HZh0/Mo/TK6rCuaxxyqyk+kdNS0cc7+axmFP9eNovz+d8mYvtpauA5HYqm
	OnmtHr2LrDx7CbG665iQlxk8SmryUgRCO5cwwTvUPFzs7LCosgCvs7qLRJYQg4+Tm0Nd6k965lx
	3WK9QvVhTk5hZSqeRR9DlhegFbWvCh5lWkpm5iKrc/d3qX88nPDwAXWZRqDlaeQQM/nWk38hWrp
	n0KwXodFtPxof/k1MfbvBgVi4AljLKm30WBWGzL5pQRKe9zG3p4=
X-Received: by 2002:a17:90b:5147:b0:3ac:97bc:4c7b with SMTP id 98e67ed59e1d1-3ae897c7c28mr1424866a91.14.1793349491405;
        Fri, 30 Oct 2026 01:38:11 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.100])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9b1506sm7542122a91.15.2026.10.30.01.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 01:38:10 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Muchun Song <muchun.song@linux.dev>
Subject: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Date: Fri, 30 Oct 2026 16:37:58 +0800
Message-ID: <20261030083800.599152-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
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

This is a follow-up cleanup to the page-table teardown fixes [1].

pagetable_free() now invokes pagetable_dtor() for constructed page tables.
This makes pagetable_dtor_free() redundant and leaves explicit destructor
calls immediately before pagetable_free() duplicating lifecycle handling.

Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
then remove the remaining redundant pagetable_dtor() calls. This keeps the
destructor decision in the common free path. No functional change is
intended.

[1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com

Muchun Song (2):
  mm: remove pagetable_dtor_free()
  mm: remove redundant pagetable_dtor() calls

 arch/m68k/include/asm/mcf_pgalloc.h    |  5 ++---
 arch/m68k/mm/motorola.c                |  2 +-
 arch/powerpc/mm/book3s64/mmu_context.c |  1 -
 arch/powerpc/mm/book3s64/pgtable.c     |  1 -
 arch/powerpc/mm/pgtable-frag.c         |  2 --
 arch/s390/include/asm/pgalloc.h        |  4 ----
 arch/s390/mm/pgalloc.c                 |  4 ++--
 arch/sh/mm/pgtable.c                   |  2 +-
 arch/sparc/mm/init_64.c                |  1 -
 arch/x86/mm/pat/set_memory.c           | 10 +---------
 arch/x86/mm/pgtable.c                  |  5 ++---
 include/asm-generic/pgalloc.h          | 12 ++++++------
 include/asm-generic/tlb.h              |  2 +-
 include/linux/mm.h                     |  6 ------
 14 files changed, 16 insertions(+), 41 deletions(-)


base-commit: 9c449f885765cf8d80b2c60b1971e774bba51a3f
-- 
2.54.0

