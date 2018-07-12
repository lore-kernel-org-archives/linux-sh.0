From: Rob Landley <rob@landley.net>
Date: Thu, 12 Jul 2018 14:53:03 +0000
Subject: Re: Random warning dump during init.
Message-Id: <77d0c286-c358-70dc-14e7-112958cd4480@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <b4645807-bc6f-9578-20c2-798654c593a2@landley.net>
In-Reply-To: <b4645807-bc6f-9578-20c2-798654c593a2@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/11/2018 01:17 PM, Rob Landley wrote:
> Building commit d0fbad0aec1d (from July 2) I hit this, and I confirmed today's
> pull is still doing it. (It's my mkroot sh4 target built with musl-cross-make,
> booting under qemu.)

I bisected it to:

commit 128227e7fe4087b60f1bd31f762e61237eb23790
Author: Matthew Wilcox <mawilcox@microsoft.com>
Date:   Thu Jun 7 17:05:13 2018 -0700

    slab: __GFP_ZERO is incompatible with a constructor

    __GFP_ZERO requests that the object be initialised to all-zeroes, while
    the purpose of a constructor is to initialise an object to a particular
    pattern.  We cannot do both.  Add a warning to catch any users who
    mistakenly pass a __GFP_ZERO flag when allocating a slab with a
    constructor.

Rob
