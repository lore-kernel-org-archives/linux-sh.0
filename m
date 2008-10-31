From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 31 Oct 2008 07:12:56 +0000
Subject: Re: [PATCH] sh: Add sci_rxd_in of SH4-202
Message-Id: <20081031071256.GE26928@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4907E7A9.6080202@renesas.com>
In-Reply-To: <4907E7A9.6080202@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2008 at 01:33:45PM +0900, Nobuhiro Iwamatsu wrote:
> SH4-202 doesn't have SCSXX1. But it is treated so that there is SCSPTR1 in
> current code. This patch add sci_rxd_in of SH4-202.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

On Wed, Oct 29, 2008 at 01:34:50PM +0900, Nobuhiro Iwamatsu wrote:
> This change a name of SCSPTR used in sci_rxd_in of SH5-101.
> SCSPTR is not declared and will become the error.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
