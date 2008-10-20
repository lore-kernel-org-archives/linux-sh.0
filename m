From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Oct 2008 04:12:57 +0000
Subject: Re: [PATCH] serial: sh-sci: Add support SCIF of SH7723
Message-Id: <20081020041257.GB20044@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48E5D9CB.30408@renesas.com>
In-Reply-To: <48E5D9CB.30408@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 03, 2008 at 05:37:31PM +0900, Nobuhiro Iwamatsu wrote:
> SH7723 has two types of SCIF (SCIF and SCIFA).
> The current sh-sci driver supports only SCIFA, and calculation methods of SCBRR
> are different.
> This patch support this methods.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Ok, applied. I have a large rewrite of sh-sci pending, but there is no
harm in merging this for 2.6.28.
