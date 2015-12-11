From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 11 Dec 2015 16:04:50 +0000
Subject: [PATCH 0/3] adv7604: .g_crop and .cropcap support
Message-Id: <1449849893-14865-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org, linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, hans.verkuil@cisco.com, ian.molton@codethink.co.uk, lars@metafoo.de, william.towle@codethink.co.uk, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Hi!

The rcar_vin driver relies on these methods.  The third patch makes sure
that they return up-to-date data if the input signal has changed since
initialization.

CU
Uli


Ulrich Hecht (3):
  media: adv7604: implement g_crop
  media: adv7604: implement cropcap
  media: adv7604: update timings on change of input signal

 drivers/media/i2c/adv7604.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

-- 
2.6.3

