From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Dec 2019 01:20:46 +0000
Subject: [PATCH v2 0/3] sh: fixup strncpy()
Message-Id: <87woatyutt.wl-kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Karl Nasrallah <knnspeed@aol.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>


Hi Sato-san, Rich

These are strncpy() fixup patches, but using different solutions.
Karl's patches are updating current strncpy(), but using 2 patterns.
Kuninori's patch is using generic strncpy().

We don't know which is the best, but we can follow
SH maintainer's selection.

Karl Nasrallah (2):
      sh: fixup strncpy() warning and add missing padding
      sh: fixup strncpy() warning and add missing padding

Kuninori Morimoto (4):
      sh: use generic strncpy()

Thank you for your help !!
Best regards
---
Kuninori Morimoto
