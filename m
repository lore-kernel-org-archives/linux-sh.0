From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Date: Wed, 07 Mar 2018 11:15:12 +0000
Subject: [PATCH 0/2] sh: use put_device() instead of kfree()
Message-Id: <cover.1520420267.git.arvind.yadav.cs@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Never directly free @dev after calling device_register(), even
if it returned an error! Always use put_device() to give up the
reference initialized.

Arvind Yadav (2):
  [PATCH 1/2] sh: maple: use put_device() instead of kfree()
  [PATCH 2/2] sh: superhyway: use put_device() if device_register fail

 drivers/sh/maple/maple.c           |  3 ++-
 drivers/sh/superhyway/superhyway.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

-- 
1.9.1

