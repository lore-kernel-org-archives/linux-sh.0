From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 18:52:58 +0000
Subject: [PATCH 0/2] sh/intc: Adjustments for add_virq_to_pirq()
Message-Id: <e24933d7-b887-e443-af74-327a2d37d6fa@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 20:42:10 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve a size determination
  Delete an error message for a failed memory allocation

 drivers/sh/intc/virq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

-- 
2.13.0

