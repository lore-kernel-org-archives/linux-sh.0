From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 07 Aug 2011 23:25:34 +0000
Subject: LCDC problem after commit 794d78fea51504bad3880d14f354a9847f318f25
Message-Id: <201108080125.34329.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Unfortunately, after commit 794d78fea51504bad3880d14f354a9847f318f25
(drivers: sh: late disabling of clocks V2) the LCDC screen on my
Mackerel board goes off (late) during boot and cannot be turned on
by any way AFAICS (the backlight remains on, though).

It looks like the late disabling of clocks interacts badly with the
clock management done by PM domains.

Thanks,
Rafael
