From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 04 Apr 2011 08:09:18 +0000
Subject: Re: [PATCH 2/2] ARM: mach-shmobile: rename mmc-ap4eb.h as mmc-ap4evb.h
Message-Id: <20110404080917.GC28208@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1301899522-20546-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1301899522-20546-3-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 04, 2011 at 03:45:22PM +0900, Simon Horman wrote:
> The convention is to use the name of the board printedon the PCB,
> in this case ap4evb. At the very least this is consistent with
> usage elsewhere in the code.
> 
> Reported-by: Magnus Damm <magnus.damm@gmail.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>

This one I'll hold off on given Linus' current push back against needless
churn in the mach dirs. We can revisit it at a later point once the dust
has settled.
