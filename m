From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 15 Mar 2012 09:51:11 +0000
Subject: Re: [PATCH/RFC] spi: sh-msiof: per-transaction runtime PM
Message-Id: <20120315095111.C1B3F3E0899@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1203141828230.30291@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1203141828230.30291@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, spi-devel-general@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

On Wed, 14 Mar 2012 18:35:58 +0100 (CET), Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Currently the spi-sh-msiof driver implements a runtime PM scheme, based on
> chipselect toggling. However, this is largely inefficient, since SPI
> client drivers are allowed to keep the chipselect active for long periods
> of time. This patch allows the driver to runtime-suspend the controller
> between SPI transfers. While moving runtime-PM hooks this patch also 
> removes manual PM clock manipulation.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Marked as RFC, because I'm actually not sure, whether suspending after 
> each transfer is actually allowed. This seems to bring problems with 
> mmc-spi at least. Some commands return errors, but a retry recovers. More 
> investigation is required. Any hints concerning why this is not perfectly 
> functioning would be appreciated!

Suspending in the txrx function is fine since each bitbang instance gets its own
workqueue.  It's only the transfer() hook (which bitbang supplies for you) that
cannot sleep.

g.

