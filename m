From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 15 Aug 2009 04:03:00 +0000
Subject: Re: [PATCH] sh: Runtime PM pdev hwblk - kfr2r09 LCDC
Message-Id: <20090815040300.GB17061@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090815030208.8312.1837.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090815030208.8312.1837.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 15, 2009 at 12:02:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch simply adds LCDC hwblk_id data for the kfr2r09 board.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Suitable for the sh/hwblk topic branch, but also depends on the
>  kfr2r09 LCDC patch. I suppose the sh/hwblk stuff needs a rebase?
> 
No, a rebase would make a mess of things given that the topic branch
began life from Rafael's tree. A merge is sufficient in this case, which
is what I've done. This is now applied, you may wish to make sure nothing
else has broken in sh/hwblk.
