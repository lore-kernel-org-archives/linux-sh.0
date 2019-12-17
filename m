From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 17 Dec 2019 14:21:48 +0000
Subject: [PATCH 0/2] sh: get rid of __ARCH_USE_5LEVEL_HACK
Message-Id: <20191217142150.10392-1-rppt@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

These patches update the SuperH page table folding/unfolding to take into
account the 5th level.

Mike Rapoport (2):
  sh: drop __pXd_offset() macros that duplicate pXd_index() ones
  sh: add support for folded p4d page tables

 arch/sh/include/asm/pgtable-2level.h |  1 -
 arch/sh/include/asm/pgtable-3level.h |  1 -
 arch/sh/include/asm/pgtable_32.h     |  5 ++---
 arch/sh/include/asm/pgtable_64.h     |  5 ++---
 arch/sh/kernel/io_trapped.c          |  7 ++++++-
 arch/sh/mm/cache-sh4.c               |  4 +++-
 arch/sh/mm/cache-sh5.c               |  7 ++++++-
 arch/sh/mm/fault.c                   | 26 +++++++++++++++++++++++---
 arch/sh/mm/hugetlbpage.c             | 28 ++++++++++++++++++----------
 arch/sh/mm/init.c                    | 15 +++++++++++----
 arch/sh/mm/kmap.c                    |  2 +-
 arch/sh/mm/tlbex_32.c                |  6 +++++-
 arch/sh/mm/tlbex_64.c                |  7 ++++++-
 13 files changed, 83 insertions(+), 31 deletions(-)

-- 
2.24.0
