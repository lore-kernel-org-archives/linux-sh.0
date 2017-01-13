From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 09:45:34 +0000
Subject: [PATCH 0/3] sh/intc: Fine-tuning for register_intc_controller()
Message-Id: <4d37c4d8-d28b-bd98-968b-f544d6a213eb@users.sourceforge.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 10:42:10 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use kcalloc()
  Combine substrings for a message
  Add a space character for better code readability

 drivers/sh/intc/core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.11.0

