Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD42E2663
	for <linux-sh@vger.kernel.org>; Sat, 26 Sep 2026 18:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790447970; cv=none; b=CLBXzz3FCESOAjdcyEkhGR2WL9BBoeXLPc8RyP1KRp0PhHpqNmrL5FjXrJZGb0mfC3CZUIhfb/5aa6zpOa9ysriEbibLcOeAaSpbOeVUk/uZO8TaOkvGcdBH4HD3qRe07KoCcxofbrZknkptzLGsXVwksGEfuIfxfA31u4avubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790447970; c=relaxed/simple;
	bh=l0Xyu0t7fZH3pbxaEjct938LlOec4HZEkRRf1F/wvxw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ntA/cUAclGbRGy7Q6Qmw7x+DuZKXlPLAx0jQVOQzr6sxeOUb/sJaKkqmwMOJRZn/lnPOCvIh9Ct5e/X0oh3czN3ccHhqFUGnsx3OaySjwfT5QMMGKAD89Cw9Q+Yd4sT3ZUj/l4zFDnBdI6yMrjdeJHR8mXHgTeBMy5146RBA54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gb/iWfI5; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gb/iWfI5"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso1423263f8f.0
        for <linux-sh@vger.kernel.org>; Sat, 26 Sep 2026 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790447966; x=1791052766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7jles6kOLK/nYoY3nT9JUOZhy6Cidsz25VDFnXK9X6A=;
        b=Gb/iWfI5hD9UuZhUAYxBCYyq2Uhn0RTNpohBv12zAC3jbk/4EyxP98LNeWIQxeNusm
         3fENxun9BeoGfHbpFXCWPntI/YaOH0RE3u/hWhPQi6TPP8NQpqk/lutHeQPInqnFK1oZ
         /yvkxly71nyCvLr/3muqfH2+lXIN7aN2S/+XTFaYL2kb+0SHEcOMr0uYpiQJBtbCTKgU
         rx+jmOXYwo4n7NiKlTDPjJAXJRjIq1mOWW9nn/z9g7EWxYkfJwOAdenUpz7O8cjl/MSO
         wtJ82rDK9ECA6MvYPeWVEIB2lWQ6EJ65gFlO44UoNeXJtl0xGFkOztlq7qokJm9XmxrB
         YBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790447966; x=1791052766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7jles6kOLK/nYoY3nT9JUOZhy6Cidsz25VDFnXK9X6A=;
        b=FGdmwgyVfigZeeE68DbkDK75trrrtWM99Naosob3rdQ9Fw723VQImwYR3b6QEONl9U
         p9L3ku2WpDriZ1zikMA1iAAFQxZz/OukJG+azD99oCkRZgFbWg53d3DnH6FijCoEzF3L
         xI2WnZkz8ZD2+pKzybCDpXdneQ4r5LG8LOc5Yyok2dwAhLrcATkllpzUmjjvUoPGr439
         RwAeii+WDTeiF3XU2I9Zyad7bWQzxX71jMYKVrBXescmnEgx+ngJhHQ0ROTeu642zb4W
         ouDElxOoJqBXTy1fheE7WauTuNNuPiiSB4nsGjmfJYk8YbXGOeLAAcdvi9Yl7vtqmk4d
         i0jA==
X-Gm-Message-State: AFq9FYIWJJrd8cd1aK/JRV6QGfQzs621dxNSs/dkj3u44UB7S1g3fnev
	8/qBKbwNeZuEHbpYzPTZRO6txF5HT0KA2R3OvQLdTOYJlFLjyJ2RpM0g
X-Gm-Gg: AYBFou1d11nWdsBgyycOlzF9/GK6x3av6cXw6cBXVrT3kcG+kZdOFa1Ai28LBriH0Tc
	f43Cf1J/VuFLkY+EN3XIkG32NXcbOJYEc3zA8bgKKMAIvA0snOklfU4IqH/g0SWOoJ8DmZ4edOr
	5ckTZoHxRN0PSXS5GYcjhOndiFQMvbfRPVoUwnfH0SpT9NUolc8T0vZUZsvzimEwqw/qEuO3YIr
	DSt5wSuEjAwyKF7MrCxH5suHCHf5znGZ1B6+XLYRrp1QN4k8bmniHk65p744Ms4M2emLViINwz6
	eJGkEO7N+AthcSlVglO04A3kyL7OLjb9W2juaVoUX8+h/MW0uyKx0hHH5ish4g9d9clziMzCweH
	bYZTg3vRJw0+WjRw6L+OR2G4QUH46O24CBqDfIVI0dNegg0MkauqSuw4UYpGkDLoAArCN6417yP
	mm1K1k46Ko3NsYsYQaKsHxBz94YTRqj/bxVAptrGiwbzPqZeMzvIJPIQdBxotgrEnFTVTYKhU/z
	AcZafdSECuKK2/sh7DT8nFV3rC5c1I8c6Seh643MU1GIaCcjua+G+bOjaEAmRaALxYwIGtv810X
	5xTOD6AoXCiSP8G39g9BXJpsVxgEBnooOMNk6BybxJr6hjm3KmY4k0/YCY4onRlWdrKeuwiSEB9
	J2Q==
X-Received: by 2002:a05:6000:4707:b0:488:5fcd:c1e with SMTP id ffacd0b85a97d-48872a72594mr14913212f8f.18.1790447966239;
        Sat, 26 Sep 2026 11:39:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a648895sm15430376f8f.28.2026.09.26.11.39.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 11:39:25 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 0/2] sh: mm: fix hugetlb on SH-4
Date: Sat, 26 Sep 2026 20:39:02 +0200
Message-Id: <20260926183904.76186-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Muchun Song noted in the review of the Arm hugetlb alignment fix [1]
that SuperH has the same arch_get_unmapped_area() gap. Reproducing it
in QEMU turned up a second, older bug that corrupts memory once the
mappings are aligned.

Patch 1 fixes the page size in hugetlb PTEs. pte_mkhuge() ORs the huge
size into the base page size bits, so 64 KiB huge pages over 4 KiB
pages are loaded into the TLB as 1 MiB pages. User writes then land in
unrelated kernel memory. This dates back to the start of git history.

Patch 2 aligns hugetlb mappings to the huge page size. Without it
mmap(MAP_HUGETLB) can return an address that is not aligned to the huge
page size, and process exit hits the BUG_ON() in
__unmap_hugepage_range(). This is a 6.13
regression.

Patch 1 goes first because patch 2 alone makes the corruption reachable
through a plain mmap(). Both are marked for stable.

Tested on QEMU r2d (SH7751R, rts7751r2dplus_defconfig plus HUGETLBFS
with 64 KiB huge pages, gcc 15.2) on top of fddfc3ec3179. A test init
maps two huge pages with the default and legacy layouts and with
MAP_FIXED, writes and reads back every 4 KiB, mprotect()s the mapping
read-only and back, and checks a COW write in a forked child:

  kernel          MAP_FIXED       default/legacy mmap
  base            memory corrupt  misaligned, BUG at mm/hugetlb.c:5215
  patch 1         pass            misaligned, BUG
  patches 1+2     pass            pass

SH-X2 (X2TLB) is only build tested (r7785rp_defconfig with 64 KiB huge
pages).

QEMU's SH-4 TLB emulation flushes only the first 4 KiB of a 64 KiB or
1 MiB entry when the entry is dropped [2]. Keep that in mind when
testing hugetlb on QEMU.

[1] https://lore.kernel.org/r/5AB6FE85-4CB9-41EF-A700-BC5E071F29F5@linux.dev
[2] https://gitlab.com/qemu-project/qemu/-/issues/4598

Karl Mehltretter (2):
  sh: mm: replace the page size bits in pte_mkhuge()
  sh: mm: align hugetlb mappings to the huge page size

 arch/sh/include/asm/pgtable_32.h |  7 +++++--
 arch/sh/mm/mmap.c                | 11 +++++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)


base-commit: fddfc3ec31799a932bb92f1b8a84cb3d1f963be9
-- 
2.39.5 (Apple Git-154)

