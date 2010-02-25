From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 25 Feb 2010 07:50:44 +0000
Subject: Re: [PATCH] sh: ms7724: Add sh_sir support
Message-Id: <20100225075044.GC3227@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uaauzv5g4.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uaauzv5g4.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 23, 2010 at 05:19:14PM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-se/7724/setup.c |   26 ++++++++++++++++++++++++++
>  1 files changed, 26 insertions(+), 0 deletions(-)

On Wed, Feb 24, 2010 at 09:16:47AM +0900, Kuninori Morimoto wrote:
> KEYSC::SCN register of SH7724 is 3bit.
> Thus, scan_timing should be 0 - 7 here.

On Wed, Feb 24, 2010 at 09:32:28AM +0900, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> ---
>  arch/sh/boards/mach-ecovec24/setup.c |   27 +++++++++++++++++++++++++++
>  1 files changed, 27 insertions(+), 0 deletions(-)

Applied, thanks.
