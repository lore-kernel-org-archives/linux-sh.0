From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 13 Jun 2012 01:37:25 +0000
Subject: Re: [PATCH] sh: Kill off last dead UBC header
Message-Id: <20120613013724.GL10170@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1339188557.30984.10.camel@x61.thuisdomein>
In-Reply-To: <1339188557.30984.10.camel@x61.thuisdomein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jun 08, 2012 at 10:49:17PM +0200, Paul Bolle wrote:
> Commit 7025bec9125b0a02edcaf22c2dce753bf2c95480 ("sh: Kill off dead UBC
> headers.") skipped arch/sh/include/cpu-sh2a/cpu/ubc.h. Since nothing is
> using that header either, kill it off too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

Applied, thanks.
