From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Apr 2009 00:27:30 +0000
Subject: Re: [PATCH] clocksource: sh_cmt clocksource support
Message-Id: <20090422002730.GA23986@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090417052631.8114.81559.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090417052631.8114.81559.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 17, 2009 at 02:26:31PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Add clocksource support to the sh_cmt driver. With this in
> place we can do tickless with a single CMT channel.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  This patch depends on the following -mm patches:
>   clocksource-add-enable-and-disable-callbacks.patch
>   clocksource-pass-clocksource-to-read-callback.patch
> 
Now that these are in.. applied to the 2.6.31 queue, thanks!
