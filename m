From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 27 Dec 2013 18:06:37 +0000
Subject: [PATCH 0/2] clk: shmobile: clk-mstp fixes
Message-Id: <1388167599-23525-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This fixes a number of issues with CPG MSTP clock array handling.

Valentine Barshak (2):
  clk: shmobile: Fix MSTP clock index
  clk: shmobile: Fix MSTP clock array initialization

 drivers/clk/shmobile/clk-mstp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

-- 
1.8.3.1

