From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 28 May 2014 07:44:35 +0000
Subject: [PATCH 00/11] i2c: rcar: cleanup series
Message-Id: <1401263086-13720-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Here are some patches to let the rcar driver have a diet without losing
functionality. IMO the code becomes more readable, too, although mileages may
vary about this or that change. Bus-free handling is improved, too. Tested with
renesas-devel-v3.15-rc7-20140526 on a Lager and Koelsch board. The git tree can
be found here, including one proof-of-concept enablement patch:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rcar-cleanup

Please test, review, comment.

Thanks,

   Wolfram


Wolfram Sang (11):
  i2c: rcar: not everything needs to be a function
  i2c: rcar: no need to store irq number
  i2c: rcar: refactor bus state machine
  i2c: rcar: refactor irq state machine
  i2c: rcar: check bus free before first message
  i2c: rcar: refactor setting up msg
  i2c: rcar: refactor status bit handling
  i2c: rcar: remove spinlock
  i2c: rcar: reuse status bits as enable bits
  i2c: rcar: janitorial cleanup after refactoring
  i2c: rcar: update copyright and license information

 drivers/i2c/busses/i2c-rcar.c | 252 ++++++++----------------------------------
 1 file changed, 48 insertions(+), 204 deletions(-)

-- 
2.0.0.rc2

