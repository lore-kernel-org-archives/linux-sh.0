From: Jann Horn <jannh@google.com>
Date: Tue, 28 Apr 2020 03:27:42 +0000
Subject: [PATCH 2/5] coredump: Fix handling of partial writes in dump_emit()
Message-Id: <20200428032745.133556-3-jannh@google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200428032745.133556-1-jannh@google.com>
In-Reply-To: <20200428032745.133556-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, "Eric W . Biederman" <ebiederm@xmission.com>

After a partial write, we have to update the input buffer pointer.

Fixes: 2507a4fbd48a ("make dump_emit() use vfs_write() instead of banging at ->f_op->write directly")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/coredump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coredump.c b/fs/coredump.c
index 408418e6aa131..047f5a11dbee7 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -833,6 +833,7 @@ int dump_emit(struct coredump_params *cprm, const void *addr, int nr)
 		cprm->written += n;
 		cprm->pos += n;
 		nr -= n;
+		addr += n;
 	}
 	return 1;
 }
-- 
2.26.2.303.gf8c07b1a785-goog
