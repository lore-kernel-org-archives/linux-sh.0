From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 08 May 2011 21:20:56 +0000
Subject: [RFC][PATCH 0/5] PM: Support for generic I/O power domains (v2)
Message-Id: <201105082320.57185.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201104290154.12966.rjw@sisk.pl>
In-Reply-To: <201104290154.12966.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, MyungJoo Ham <myungjoo.ham@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Friday, April 29, 2011, Rafael J. Wysocki wrote:
Hi,

This is an update of the patchset adding support for generic I/O power domains.
The first patch and the last two patches have been posted already and
discussed, the remaining two are new.
 
The patches are on top of the branch at:
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6.git power-domains

[1/5] - Add support for generic I/O power domains (runtime PM).
[2/5] - Introduce generic prepare and complete callbacks for system-wide
        power transitions.
[3/5] - Add PM sleep support to the generic I/O power domains code introduced
        in [1/5]
[4/5] - Use the new code to add support for I/O power domains on the SH7372 SoC.
[5/5] - Add support for power domain A4MP on SH7372.

Please let me know what you think.

Thanks,
Rafael
