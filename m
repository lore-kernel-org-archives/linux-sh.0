From: Rob Landley <rob@landley.net>
Date: Wed, 19 Apr 2017 09:17:46 +0000
Subject: Why CONFIG_VSYSCALL?
Message-Id: <c606d524-8c8f-edd3-ea52-e8b3071cc8a2@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In arch/sh/mm/Kconfig there's a VSYSCALL config option. Other
architectures don't, so why does sh? (I see x86 added the ability to
_disable_ some vsyscall stuff in 2014, under CONFIG_EXPERT, although
that might just be some backwards compatibility code.)

I'm wondering why arch/sh is the only one that has a CONFIG_VSYSCALL you
need to enable to get the standard feature.

Rob
