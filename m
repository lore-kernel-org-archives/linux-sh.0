From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 20 Jan 2009 03:20:49 +0000
Subject: Re: [PATCH] sh: fix sh-sci / early printk build on sh7723
Message-Id: <20090120032049.GB12965@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090116055102.10290.84974.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090116055102.10290.84974.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 16, 2009 at 02:51:02PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch adds the SCSPTR register to the sh-sci driver in
> the case of sh7723 to make sure early printk builds properly.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
