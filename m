From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 10 Apr 2014 02:39:58 +0000
Subject: Re: Renesas clock clk-mstp updates for clock-indices
Message-Id: <87lhvd6h6k.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394196400-17112-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi all

These patches are very important for me.
But, could you please teach me currect status of these ??
Can I find these when -rc1 was released ?

> Mike, following the commit to add the clock-indices field, the following
> pair of commits updates the shmboile clk-mstp driver to uses these over
> the local variant.
> 
> Since this is involves two separte trees which are in development, the
> decision is that we will fixup the renesas trees once they are merged
> and the development cycle is complete. Once this is done, patch 2/2
> can be reverted (if people care about three lines of differrence)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
