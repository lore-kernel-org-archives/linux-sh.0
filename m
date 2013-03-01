From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 Mar 2013 01:13:44 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: r8a7740: Do not use early devices with DT reference
Message-Id: <20130301011344.GV11434@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 28, 2013 at 12:00:10PM -0600, Bastian Hecht wrote:
> Do not initialise any early devices when using the minimal DT
> reference code. Only the delay needs to be initialised.

Thanks this looks good to me.
I have added this to the topic/intc-of intc branch.

The reason that I have added this it and the other
Armadillo800EVA-reference
patches there is that I believe that they depend on the INTC DT bindings
which currently live in that topic branch.

If there is a way to remove that dependency please let me know.
