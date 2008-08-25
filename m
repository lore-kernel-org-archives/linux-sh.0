From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Aug 2008 06:30:34 +0000
Subject: Re: [PATCH] sh: ap325rxa: create CPLD data area in mtd
Message-Id: <20080825063033.GC19834@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48B24FF8.6060009@renesas.com>
In-Reply-To: <48B24FF8.6060009@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 25, 2008 at 03:23:52PM +0900, Nobuhiro Iwamatsu wrote:
> AP320 and AP325RXA has CPLD data in NOR Flash.
> If this area erased, this board can not boot.
> This patch create CPLD data area and set writeable mask bit.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
