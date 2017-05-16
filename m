From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 17:29:13 +0000
Subject: [PATCH 0/2] sh-clk: Adjustments for two function implementations
Message-Id: <db01c452-5817-db62-bbde-c4c5cd232a3a@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 19:24:56 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Improve a size determination in sh_clk_fsidiv_register()
  Delete an error message for a failed memory allocation in two functions

 drivers/sh/clk/cpg.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

-- 
2.13.0

