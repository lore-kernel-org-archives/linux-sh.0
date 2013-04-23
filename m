From: Katsuya Matsubara <matsu@igel.co.jp>
Date: Tue, 23 Apr 2013 10:51:34 +0000
Subject: [PATCH 0/3] Fix some bugs in the sh_veu driver
Message-Id: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, Katsuya Matsubara <matsu@igel.co.jp>

Hi Guennadi,

This patch set fixes some small bugs in the sh_veu driver.
They have been tested on the Mackerel board.

Thanks,

Katsuya Matsubara (3):
  [media] sh_veu: invoke v4l2_m2m_job_finish() even if a job has been
    aborted
  [media] sh_veu: keep power supply until the m2m context is released
  [media] sh_veu: fix the buffer size calculation

 drivers/media/platform/sh_veu.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

---
Katsuya Matsubara / IGEL Co., Ltd
