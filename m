From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 19 Apr 2012 22:09:08 +0000
Subject: [PATCH 0/3] mmc: sh-mmcif: clock management updates
Message-Id: <Pine.LNX.4.64.1204192351190.2110@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201101604130.530@axis700.grange>
 <Pine.LNX.4.64.1202022256580.13860@axis700.grange>
 <CANqRtoQ7o=_9uRa3F=4pkNvDWS2g2wZU6oBipttfGuFv4irpzA@mail.gmail.com>
 <Pine.LNX.4.64.1202031156020.6211@axis700.grange>
 <Pine.LNX.4.64.1204191215430.2110@axis700.grange>
 <CANqRtoTq1e7_g82FGZS3S8yb0j7MgCYNhiH7E=a+nHkTWiOgLQ@mail.gmail.com>
In-Reply-To: <CANqRtoTq1e7_g82FGZS3S8yb0j7MgCYNhiH7E=a+nHkTWiOgLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org

Hi all

On Thu, 19 Apr 2012, Magnus Damm wrote:

> Would be be possible to do the initial implementation on the MMCIF 
> driver?

Following my recent attempts to improve clock handling in (sh-mobile) MMC 
drivers, I'm proposing a patch-series for sh-mmcif. The first of the 3 
patches is just some trivial (subjective) stylistic improvements (feel 
free to disagree;-)), the second one fixes clock enable / disable usage, 
as discussed earlier, and the 3rd one re-reads the clock frequency every 
time the clock is re-enabled. Comments welcome:-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
