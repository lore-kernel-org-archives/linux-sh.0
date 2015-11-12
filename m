From: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 12 Nov 2015 14:31:45 +0000
Subject: [PATCH v2 00/10] i2c: rcar: tackle race conditions in the driver
Message-Id: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hello RCar Fans!

So, here is V2 of this series. Thanks to Geert's MSTP clock manipulation
series, I could finally reproduce something which looks like the issues Laurent
was seeing with his Koelsch board. The outcome is Patch 1/10 which fixes also
issues reported by Morimoto-san using a Salvator board. I tested these patches
with my Lager and Salvator board (latter one with scope) and Magnus' Koelsch
via remote connection. A branch for testing can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/rcar-i2c-rework-v2

Changes since V1:
* new patch 1/10 to ensure clock is always on
* rebased patch 2/10 to the new patch
* some patch descriptions slightly reworded

Please test, test, test :)

   Wolfram

Here is the description of the V1 series for those who missed it:

Two issues people have seen with the i2c-rcar driver was:

a) immediately restarted messages after NACK from client
b) duplicated data bytes in messages

Some people already worked on those and had a tough time because it was hard to
reproduce these issues on non-customer setup. Luckily, I somewhen had a state
where the first transfer after boot would always show the above issues on a
plain Renesas Lager board. When measuring, I found a third issue thanks to my
new tool 'i2ctransfer' (and thanks to projects like sigrok and OpenLogicSniffer,
of course. Thank you very much!):

c) after read message, no repeated start was sent, but stop + start.

Due to some unlucky design choices in the IP core, it has some race windows
which can cause problems if interrupts get delayed. Also, for every new message
in one transfer, context switches between interrupt and process were needed.

So I refactored the driver to setup new messages in interrupt context, too.
This avoids the race for b) because we are now setting up the new message
before we release the i2c bus clock (before we released the clock and set up
the message in process context). c) is also fixed, this was not a race but a
bug in the state handling. a) however is not fixed 100% :( We have the race
window as small as possible now when utilizing interrupts, so it is an
improvement and worked for my test cases well. There were experiments by me and
Renesas engineers to use polling to prevent the issue but this caused other
side effects, sadly. So, let's improve the situation now and let's see where we
get.

I did quite some lab testing here and also verified that slave support does not
suffer from these changes. However, I'd really appreciate if people could give
this real-world-testing which is always different.

Please have a look, a test, etc...

Thanks,

   Wolfram

Wolfram Sang (10):
  i2c: rcar: make sure clocks are on when doing clock calculation
  i2c: rcar: rework hw init
  i2c: rcar: remove unused IOERROR state
  i2c: rcar: remove spinlock
  i2c: rcar: refactor setup of a msg
  i2c: rcar: init new messages in irq
  i2c: rcar: don't issue stop when HW does it automatically
  i2c: rcar: check master irqs before slave irqs
  i2c: rcar: revoke START request early
  i2c: rcar: clean up after refactoring

 drivers/i2c/busses/i2c-rcar.c | 218 +++++++++++++++++-------------------------
 1 file changed, 87 insertions(+), 131 deletions(-)

-- 
2.1.4

