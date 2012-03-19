From: Simon Horman <horms@verge.net.au>
Date: Mon, 19 Mar 2012 01:01:33 +0000
Subject: Re: [PATCH 2/2] sh: dma: Collect up CHCR of SH7763, SH7764, SH7780 and SH7785
Message-Id: <20120319010133.GB8307@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1331865086-20880-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1331865086-20880-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Mon, Mar 19, 2012 at 09:57:44AM +0900, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> Simon Horman さんは書きました:
> >Hi Iwamatsu-san,
> >
> >On Fri, Mar 16, 2012 at 11:31:26AM +0900, Nobuhiro Iwamatsu wrote:
> >>CHCR of SH7763, SH7764, SH7780 and SH7785 is constitution same as SH7757.
> >
> >Is it intentional that this patch changes the definition of
> >CHCR_TS_HIGH_MASK and CHCR_TS_HIGH_SHIFT for sh7763, sh7764, sh7780 and
> >sh7785 ?
> >
> 
> Yes, I checked this change with manual of Japanese and English.

Thanks

Reviewed-by:  Simon Horman <horms@verge.net.au>
