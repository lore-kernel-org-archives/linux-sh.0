From: Takanari Hayama <taki@igel.co.jp>
Date: Thu, 27 Nov 2014 01:25:00 +0000
Subject: [PATCH v2 0/2] v4l: vsp1: crop and a single input issues
Message-Id: <1417051502-30169-1-git-send-email-taki@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Hi,

I've updated patches to reflect comments from Geert and Sergei.
Hope this version could be given a go.

Takanari Hayama (2):
  v4l: vsp1: Reset VSP1 RPF source address
  v4l: vsp1: Always enable virtual RPF when BRU is in use

 drivers/media/platform/vsp1/vsp1_rpf.c  | 15 +++++++++++++++
 drivers/media/platform/vsp1/vsp1_rwpf.h |  2 ++
 drivers/media/platform/vsp1/vsp1_wpf.c  | 11 ++++++-----
 3 files changed, 23 insertions(+), 5 deletions(-)

Best Regards,
Takanari Hayama
-- 
1.8.0

