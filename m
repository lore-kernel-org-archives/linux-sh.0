From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Sep 2008 04:54:49 +0000
Subject: Re: [PATCH v2] sh: ap325rxa: create CPLD data area in mtd
Message-Id: <20080924045449.GB6516@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48D9AA18.2070803@renesas.com>
In-Reply-To: <48D9AA18.2070803@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 24, 2008 at 11:46:48AM +0900, Nobuhiro Iwamatsu wrote:
> AP320 and AP325RXA has CPLD data in NOR Flash.
> If this area erased, this board can not boot.
> This patch create CPLD data area and set writeable mask bit.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
