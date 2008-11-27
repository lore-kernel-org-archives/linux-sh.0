From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 27 Nov 2008 20:13:30 +0000
Subject: Re: [PATCH] sh: RSK+ 7201 board support
Message-Id: <20081127201329.GB3364@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <492EA011.40707@mpc-data.co.uk>
In-Reply-To: <492EA011.40707@mpc-data.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 27, 2008 at 01:26:41PM +0000, Peter Griffin wrote:
> From: Peter Griffin <pgriffin@mpc-data.co.uk>
> 
> sh: RSK+ 7201 board support
> 
> This patch adds support for the SH7201 processor subtype and RSK+ 7201 
> board.
> 
> Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>

Just a couple minor nits. I would prefer if you would send the CPU and
the board support separately, so I don't have to try and split the patch
up manually. Additionally, as far as new boards go, you should also
provide a reasonable defconfig so that we can tie it in to the nightly
builds and make sure no one ends up breaking it.
