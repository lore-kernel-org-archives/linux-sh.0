From: Simon Horman <horms@verge.net.au>
Date: Tue, 10 Apr 2012 07:48:58 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <20120410074854.GA10420@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 06, 2012 at 01:26:54AM -0700, kuninori.morimoto.gx@renesas.com wrote:
> 
> Hi Rafael, Magnus
> Cc Simon, nakai-san, Saneyoshi-san
> 
> These are v2 of basic R8A7740 A1 Armadillo800eva baord support patch set.
> These are based on linus/master branch.

Hi Morimoto-san,

unfortunately I seem to be having a lot of trouble reliably booting using
these patches. I am using tftpboot as follows:

hermit>  tftpboot 10.3.3.147 10.3.3.135 --kernel=armadillo/uImage

Sometimes the kernel boots bot mostly it doesn't.

Are you also using tftpboot?
Also, could you let me know which compiler you are using?


