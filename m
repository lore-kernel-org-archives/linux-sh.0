From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 20 Mar 2009 10:02:11 +0000
Subject: Re: [PATCH] sh: fix the HD64461 level-triggered interrupts handling
Message-Id: <20090320100211.GB13269@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090320020822.GA17555@rafazurita.homelinux.net>
In-Reply-To: <20090320020822.GA17555@rafazurita.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Mar 19, 2009 at 11:08:22PM -0300, Rafael Ignacio Zurita wrote:
> Rework the hd64461 demuxer code to fix the HD64461 level-triggered
> interrupts handling, using handle_level_irq() as needed.
> 
> Signed-off-by: Rafael Ignacio Zurita <rizurita@yahoo.com>

Applied, thanks.
