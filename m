From: Gon Solo <gonsolo@gmail.com>
Date: Mon, 16 Dec 2019 10:35:21 +0000
Subject: [PATCH 0/1] Fix SH config error.
Message-Id: <20191216103522.32215-1-gonsolo@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Gon Solo <gonsolo@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This fixes an error reported at 
http://kisskb.ellerman.id.au/kisskb/buildresult/14067948.

On SH4 it was possible to configure NUMA without SMP.

Gon Solo (1):
  Fix undefined reference to 'node_reclaim_distance'.

 arch/sh/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.20.1
