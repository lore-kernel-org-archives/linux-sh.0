From: Nguyen Viet Dung <nv-dung@jinso.co.jp>
Date: Wed, 13 Nov 2013 06:16:05 +0000
Subject: LCDC failure of the stable v3.12 kernel for armadillo800-eva
Message-Id: <52831925.8030903@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent-san,

I have tested the stable v3.12 kernel for armadillo800-eva board.
And it had a error relates LCDC.

error detail:
-----------------
can not display a bitmap image on LCD screen.
when boot the board,boot log is can not display on LCD screen too.

Cause:
---------
kernel that had above error:up tream v3.12-rc1....stable v2.12.0
Error is generated in the following patch.
[d58226a ARM: shmobile: armadillo800eva: Add backlight support]

Please consider this error if you have time.

Best regards,
Nguyen Viet Dung

