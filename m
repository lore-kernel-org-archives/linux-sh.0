From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Date: Sun, 28 Oct 2012 10:57:18 +0000
Subject: Re: [PATCH 12/12] ARM: mach-shmobile: Use DT_MACHINE for mackerel
Message-Id: <20121028115718.7b8ae52b@skate>
List-Id: <linux-sh.vger.kernel.org>
References: <1351391173-32379-1-git-send-email-horms@verge.net.au>
 <1351391173-32379-13-git-send-email-horms@verge.net.au>
 <20121028103711.4e89deb3@skate>
 <20121028104438.GC10073@verge.net.au>
In-Reply-To: <20121028104438.GC10073@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Simon,

On Sun, 28 Oct 2012 19:44:38 +0900, Simon Horman wrote:

> shmobile is very much in the transition phase and we are, patch by patch,
> working towards full(er) DT support for boards, SoCs and drivers. I am not
> sure that now is the right time to jump to a approach similar to that taken
> by mach-kirkwood/board-dt.c.

Ok, I understand that for transition needs, each SoC family may need a
different method. My comment was more a general comment to make sure
that the right final direction is being taken. For sure the
intermediate steps may be different.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
