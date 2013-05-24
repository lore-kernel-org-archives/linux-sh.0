From: Tejun Heo <tj@kernel.org>
Date: Fri, 24 May 2013 02:34:15 +0000
Subject: Re: [PATCH] libata: do not limit R-Car SATA driver to shmobile
Message-Id: <CAOS58YNvK=8v_fYTz-oLTxQZJ-PtYA1FWOMbXFEUnDom38FNHg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369361159-20724-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1369361159-20724-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-ide <linux-ide@vger.kernel.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Fri, May 24, 2013 at 11:05 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The motivation for this is to allow the driver to be
> used with the r8a7790 SoC.
>
> I believe that rather than adding another SoC to the list of allowed SoCs
> it is better to simply remove the dependency of the driver on shmobile all
> together.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Applied to libata/for-3.11.

Thanks.

--
tejun
