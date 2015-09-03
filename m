From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 03 Sep 2015 23:12:37 +0000
Subject: [PATCH 0/3] VIN: call g std() method as requested by Hans
Message-Id: <6015647.cjLjRfTWc7@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: g.liakhovetski@gmx.de, mchehab@osg.samsung.com, linux-media@vger.kernel.org, lars@metafoo.de
Cc: linux-sh@vger.kernel.org

Hello.

   Here are 3 patches against the 'fixes' branch of the 'media_tree.git' repo
plus the VIN driver patch to propagate querystd() error. First we add support
for the g_std() video method to the ADV7180 and ML86V7667 I2C drivers which
is needed for the full 'soc_camera' compliance, then we replace the quesrystd()
video method call with g_std() in the R-Car VIN driver; 2 former patches are
pre-requisites for the 3rd, otherwise that patch would break the frame capture.

[1/3] adv7180: implement g_std() method
[2/3] ml86v7667-implement-g_std-method
[3/3/] rcar_vin: call g_std() instead of querystd()

MBR, Sergei

