From: David Howells <dhowells@redhat.com>
Date: Wed, 31 Jul 2013 10:03:03 +0000
Subject: Re: [PATCH] sh: include: asm: include "linux/sched.h" in "ptrace.h"
Message-Id: <24122.1375264983@warthog.procyon.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <51F8D08A.8000502@asianux.com>
In-Reply-To: <51F8D08A.8000502@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Chen Gang <gang.chen@asianux.com> wrote:

> Need include "linux/sched.h" in "ptrace.h", or 'allmodconfig' can not
> pass compiling.

You can't do that.  linux/sched.h #includes asm/ptrace.h already.

David
