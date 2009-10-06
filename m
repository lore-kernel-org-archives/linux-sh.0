From: ivy kim <ibkim63@gmail.com>
Date: Tue, 06 Oct 2009 03:42:18 +0000
Subject: SH ATAPI IDE Driver
Message-Id: <32390a840910052042t64346e53w1bfb3473c7b2284b@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi there.

It seems that there is no atapi driver for SH7724.
I'm writing this atapi driver for our company's own SH7724 platform
called 'REVE'.
I've wrote one driver, ide-sh.c based on ide-platform.c and succeeded
in IDE disk chip ID reading.
And ide_host_add() returns success, so I could find some entries on
hda in /proc/ide/hda.
My question/problem is as follows;

1. There is no /dev/hda entry after ide_host_add() success.
        Should I make one by hand using mknod?
2. The ide-gd.c driver is required also? If I add ide-gd,
        I have some more /proc/ide/hda entries such as capacity  geometry etc.

Actually I'm new to linux device driver(linux, to be honest). So I'm
not sure if using ide-platform.c as my code base is correct.
When I use ide-gd.c, this code does not 'probe' the IDE drive...

My feeling on writing this type of driver shall be trivial, but my
code is getting complicated. I think I'm lost.
It seems that there is no document on 'Writing IDE device driver'...also.

My code base is kernel 'sh-2.6-2009-06-08-ms7724se-2.6.30-rc6'

Thanks.
BR..
