From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 11 Apr 2014 01:07:41 +0000
Subject: [PATCH 0/2]: sh-pfc: r8a7791: Add sound pin support
Message-Id: <87sipkoeqj.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Laurent
Cc Geert, Magnus

These are r8a7791 sound pin support patches

Kuninori Morimoto (2):
      sh-pfc: r8a7791: Add SSI pin support
      sh-pfc: r8a7791: Add Audio pin support

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  375 ++++++++++++++++++++++++++++++++++
 1 file changed, 375 insertions(+)
