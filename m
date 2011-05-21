From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sat, 21 May 2011 12:08:28 +0000
Subject: [PATCH 0/3] Hibernate cleanups
Message-Id: <201105211408.28671.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Frank Hofmann <frank.hofmann@tomtom.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

Hi,

Following are three hibernate patches I didn't have the time to
work on before.

[1/3] - Update comments in kernel/power/hibernate.c
[2/3] - Remove arch_prepare_suspend()
[3/3] - Update kerneldoc comments in kernel/power/hibernate.c

Since they don't make any functional changes, I don't think it makes sense
to wait with them for the next merge window, so I'd like to push them
for 2.6.40 if no one objects.

Thanks,
Rafael

