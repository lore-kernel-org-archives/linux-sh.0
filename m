From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Sat, 28 Dec 2013 12:09:07 +0000
Subject: [PATCH V2 0/2] clk: shmobile: clk-mstp fixes
Message-Id: <1388232549-6740-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This fixes a number of issues with CPG MSTP clock array handling.

Changes in V2:
* removed brackets from the one-line for loop

Valentine Barshak (2):
  clk: shmobile: Fix MSTP clock index
  clk: shmobile: Fix MSTP clock array initialization

 drivers/clk/shmobile/clk-mstp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
1.8.3.1

