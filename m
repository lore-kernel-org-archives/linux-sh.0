From: Simon Horman <horms@verge.net.au>
Date: Mon, 19 Mar 2012 00:56:48 +0000
Subject: Re: [PATCH 1/2] sh: dma: Collect up CHCR of SH7723 and SH7730
Message-Id: <20120319005647.GC7122@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1331865086-20880-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1331865086-20880-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Mon, Mar 19, 2012 at 09:54:12AM +0900, Nobuhiro Iwamatsu wrote:
> Hi,
> 
> Simon Horman さんは書きました:
> >Hi Iwamatsu-san,
> >
> >On Fri, Mar 16, 2012 at 11:31:25AM +0900, Nobuhiro Iwamatsu wrote:
> >>CHCR of SH7723 and SH7730 is constitution same as SH7724.
> >
> >Can I confirm that it is intentional that this patch changes the
> >CHCR_TS_HIGH_MASK and CHCR_TS_HIGH_SHIFT values for sh7723 and
> >sh7730?
> 
> Yes, you can check only sh7730.
> I think that sh7724 cannot be checked.
> Because the manual of sh7724 is not exhibited.
> 
> I checked this change with manual of japanese and english.

Hi Nobuhiro,

thanks for confirming the intention of the change.

Reviewed-by: Simon Horman <horms@verge.net.au>
