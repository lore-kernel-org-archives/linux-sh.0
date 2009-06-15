From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 15 Jun 2009 03:20:03 +0000
Subject: Re: [PATCH] sh: Remove mask variable
Message-Id: <20090615032003.GB31902@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4A35BDA6.1030600@renesas.com>
In-Reply-To: <4A35BDA6.1030600@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 15, 2009 at 12:19:02PM +0900, Nobuhiro Iwamatsu wrote:
> The mask variable was deleted from irqaction structure from 2.6.31.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
> CC: Magnus Damm <magnus.damm@gmail.com>

Already gone in current git, as well as for the other clocksource
drivers.
