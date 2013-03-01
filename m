From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 01:13:16 +0000
Subject: Re: [PATCH v2 1/2] ARM: shmobile: Armadillo800EVA-reference: Remove usage of shmobile_timer
Message-Id: <20130301011315.GU11434@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1362074410-2960-1-git-send-email-hechtb+renesas@gmail.com>
In-Reply-To: <1362074410-2960-1-git-send-email-hechtb+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 28, 2013 at 12:00:09PM -0600, Bastian Hecht wrote:
> The struct sys_timer is gone since the patch "ARM: delete struct
> sys_timer". Since then we can't use shmobile_timer any longer. Setting
> .init_time directly to eva_earlytimer_init fixes the resulting compile
> error and makes the code shorter as well.

Thanks. I have added this to the topic/intc-of intc branch.

The reason that I have added this it and the other Armadillo800EVA-reference
patches there is that I believe that they depend on the INTC DT bindings
which currently live in that topic branch.

If there is a way to remove that dependency please let me know.
